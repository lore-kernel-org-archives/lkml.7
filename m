Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D102C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 19:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D9F121835
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 19:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgABTTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 14:19:13 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43453 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbgABTTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 14:19:12 -0500
Received: from static-50-53-33-191.bvtn.or.frontiernet.net ([50.53.33.191] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <john.johansen@canonical.com>)
        id 1in5zw-00088v-DJ; Thu, 02 Jan 2020 19:19:08 +0000
Subject: Re: [PATCH] security: apparmor: Fix a possible
 sleep-in-atomic-context bug in find_attach()
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191217131220.11613-1-baijiaju1990@gmail.com>
 <20191226223056.GQ4203@ZenIV.linux.org.uk>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
Message-ID: <a5f44aac-7eec-96da-23fc-9d6fce2aca3b@canonical.com>
Date:   Thu, 2 Jan 2020 11:19:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191226223056.GQ4203@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/26/19 2:30 PM, Al Viro wrote:
> On Tue, Dec 17, 2019 at 09:12:20PM +0800, Jia-Ju Bai wrote:
>> The kernel may sleep while holding a RCU lock.
>> The function call path (from bottom to top) in Linux 4.19 is:
>>
>> security/apparmor/domain.c, 331: 
>> 	vfs_getxattr_alloc(GFP_KERNEL) in aa_xattrs_match
>> security/apparmor/domain.c, 425: 
>> 	aa_xattrs_match in __attach_match
>> security/apparmor/domain.c, 485: 
>> 	__attach_match in find_attach
>> security/apparmor/domain.c, 484:
>>     rcu_read_lock in find_attach
>>
>> vfs_getxattr_alloc(GFP_KERNEL) can sleep at runtime.
>>
>> To fix this possible bug, GFP_KERNEL is replaced with GFP_ATOMIC for
>> vfs_getxattr_alloc().
>>
>> This bug is found by a static analysis tool STCheck written by myself. 
>>
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>> ---
>>  security/apparmor/domain.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
>> index 9be7ccb8379e..60b54ce57d1f 100644
>> --- a/security/apparmor/domain.c
>> +++ b/security/apparmor/domain.c
>> @@ -325,7 +325,7 @@ static int aa_xattrs_match(const struct linux_binprm *bprm,
>>  
>>  	for (i = 0; i < profile->xattr_count; i++) {
>>  		size = vfs_getxattr_alloc(d, profile->xattrs[i], &value,
>> -					  value_size, GFP_KERNEL);
>> +					  value_size, GFP_ATOMIC);
> 
> <stares>
> 
> How can that possibly make any sense?  We are, by the look of it, trying
> to read extended attributes of some sort here.  How the hell can that
> possibly hope to be non-blocking?
> 

it can't

> <goes to read>
> Yup, vfs_getxattr_alloc() does call xattr ->get() method, which certainly
> can cause IO.  GFP_ATOMIC affects only the allocation done in
> vfs_getxattr_alloc() itself, ->get() call doesn't even see it.
> 
> AFAICS, that "fix" is pure cargo-culting; if that code *can* be called in
> non-blocking context, we are fucked, GFP_ATOMIC or no GFP_ATOMIC.
> 
> Let's look at your call chain...  find_attach() calls __attach_match()
> under rcu_read_lock().  Yes, it does, and by the look of the function
> itself it does expect to be called thus.
> 
> Call of aa_xattrs_match() in there.  Present, no obvious dropping/regaining
> rcu_read_lock() around it.  Conditional upon perm & MAY_EXEC, but that
> doesn't seem to be provably excludable by the arguments of this particular
> call.  And yes, aa_xattrs_match() is very obviously blocking.
> 

yep this is broken. this needs to either break the rcu_read_lock or be switched
to a lock that can sleep.

> So you've caught a real bug, but the "fix" doesn't fix anything whatsoever;
> reading xattrs *does* block, no matter what.
> 
> By the look at git blame, we have commit 8e51f9087f4024d20f70f4d9831e1f45d8088331
> Author: Matthew Garrett <mjg59@google.com>
> Date:   Thu Feb 8 12:37:19 2018 -0800
> 
>     apparmor: Add support for attaching profiles via xattr, presence and value
>     
>     Make it possible to tie Apparmor profiles to the presence of one or more
>     extended attributes, and optionally their values. An example usecase for
>     this is to automatically transition to a more privileged Apparmor profile
>     if an executable has a valid IMA signature, which can then be appraised
>     by the IMA subsystem.
>     
>     Signed-off-by: Matthew Garrett <mjg59@google.com>
>     Signed-off-by: John Johansen <john.johansen@canonical.com>
> 
> to thank for that.  And by the time of that commit the call chain already
> existed, complete with rcu_read_lock().
> 
> AFAICS, it really is buggered by design - you can't read xattrs in such
> context.  Again, GFP_ATOMIC is useless here - the problem is not in
> allocation, it's IO, possibly over network, etc. 
> 

indeed, below is a first pass at breaking the rcu_read_lock done against 5.5-rc4

> Morever, *anything* that passes GFP_ATOMIC to vfs_getxattr_alloc() is
> deeply suspect - it's almost certainly cargo-culting in attempt to
> do inherently blocking operation in non-blocking context.  <greps>
> No GFP_ATOMIC (thankfully), but there's a bunch of GFP_NOFS and
> I really wonder if _those_ make any sense here...
> 

---

commit b5b26347adae89f45a871f30f53d4f17b37cf2d4
Author: John Johansen <john.johansen@canonical.com>
Date:   Thu Jan 2 05:31:22 2020 -0800

    apparmor: fix aa_xattrs_match() may sleep while holding a RCU lock
    
    aa_xattrs_match() is unfortunately calling vfs_getxattr_alloc() from a
    context protected by an rcu_read_lock. This can not be done as
    vfs_getxattr_alloc() may sleep regardles of the gfp_t value being
    passed to it.
    
    Fix this by breaking the rcu_read_lock on the policy search when the
    xattr match feature is requested and restarting the search if policy
    changes occur.
    
    Fixes: 8e51f9087f40 ("apparmor: Add support for attaching profiles via xattr, presence and value")
    Reported-by: Jia-Ju Bai <baijiaju1990@gmail.com>
    Reported-by: Al Viro <viro@zeniv.linux.org.uk>
    Signed-off-by: John Johansen <john.johansen@canonical.com>

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 09996f2552ee..47aff8700547 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -623,7 +623,7 @@ static __poll_t ns_revision_poll(struct file *file, poll_table *pt)
 
 void __aa_bump_ns_revision(struct aa_ns *ns)
 {
-	ns->revision++;
+	WRITE_ONCE(ns->revision, ns->revision + 1);
 	wake_up_interruptible(&ns->wait);
 }
 
diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 9be7ccb8379e..6ceb74e0f789 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -317,6 +317,7 @@ static int aa_xattrs_match(const struct linux_binprm *bprm,
 
 	if (!bprm || !profile->xattr_count)
 		return 0;
+	might_sleep();
 
 	/* transition from exec match to xattr set */
 	state = aa_dfa_null_transition(profile->xmatch, state);
@@ -361,10 +362,11 @@ static int aa_xattrs_match(const struct linux_binprm *bprm,
 }
 
 /**
- * __attach_match_ - find an attachment match
+ * find_attach - do attachment search for unconfined processes
  * @bprm - binprm structure of transitioning task
- * @name - to match against  (NOT NULL)
+ * @ns: the current namespace  (NOT NULL)
  * @head - profile list to walk  (NOT NULL)
+ * @name - to match against  (NOT NULL)
  * @info - info message if there was an error (NOT NULL)
  *
  * Do a linear search on the profiles in the list.  There is a matching
@@ -374,12 +376,11 @@ static int aa_xattrs_match(const struct linux_binprm *bprm,
  *
  * Requires: @head not be shared or have appropriate locks held
  *
- * Returns: profile or NULL if no match found
+ * Returns: label or NULL if no match found
  */
-static struct aa_profile *__attach_match(const struct linux_binprm *bprm,
-					 const char *name,
-					 struct list_head *head,
-					 const char **info)
+static struct aa_label *find_attach(const struct linux_binprm *bprm,
+				    struct aa_ns *ns, struct list_head *head,
+				    const char *name, const char **info)
 {
 	int candidate_len = 0, candidate_xattrs = 0;
 	bool conflict = false;
@@ -388,6 +389,8 @@ static struct aa_profile *__attach_match(const struct linux_binprm *bprm,
 	AA_BUG(!name);
 	AA_BUG(!head);
 
+	rcu_read_lock();
+restart:
 	list_for_each_entry_rcu(profile, head, base.list) {
 		if (profile->label.flags & FLAG_NULL &&
 		    &profile->label == ns_unconfined(profile->ns))
@@ -413,16 +416,32 @@ static struct aa_profile *__attach_match(const struct linux_binprm *bprm,
 			perm = dfa_user_allow(profile->xmatch, state);
 			/* any accepting state means a valid match. */
 			if (perm & MAY_EXEC) {
-				int ret;
+				int ret = 0;
 
 				if (count < candidate_len)
 					continue;
 
-				ret = aa_xattrs_match(bprm, profile, state);
-				/* Fail matching if the xattrs don't match */
-				if (ret < 0)
-					continue;
-
+				if (bprm && profile->xattr_count) {
+					long rev = READ_ONCE(ns->revision);
+
+					if (!aa_get_profile_not0(profile))
+						goto restart;
+					rcu_read_unlock();
+					ret = aa_xattrs_match(bprm, profile,
+							      state);
+					rcu_read_lock();
+					aa_put_profile(profile);
+					if (rev !=
+					    READ_ONCE(ns->revision))
+						/* policy changed */
+						goto restart;
+					/*
+					 * Fail matching if the xattrs don't
+					 * match
+					 */
+					if (ret < 0)
+						continue;
+				}
 				/*
 				 * TODO: allow for more flexible best match
 				 *
@@ -445,43 +464,28 @@ static struct aa_profile *__attach_match(const struct linux_binprm *bprm,
 				candidate_xattrs = ret;
 				conflict = false;
 			}
-		} else if (!strcmp(profile->base.name, name))
+		} else if (!strcmp(profile->base.name, name)) {
 			/*
 			 * old exact non-re match, without conditionals such
 			 * as xattrs. no more searching required
 			 */
-			return profile;
+			candidate = profile;
+			goto out;
+		}
 	}
 
-	if (conflict) {
-		*info = "conflicting profile attachments";
+	if (!candidate || conflict) {
+		if (conflict)
+			*info = "conflicting profile attachments";
+		rcu_read_unlock();
 		return NULL;
 	}
 
-	return candidate;
-}
-
-/**
- * find_attach - do attachment search for unconfined processes
- * @bprm - binprm structure of transitioning task
- * @ns: the current namespace  (NOT NULL)
- * @list: list to search  (NOT NULL)
- * @name: the executable name to match against  (NOT NULL)
- * @info: info message if there was an error
- *
- * Returns: label or NULL if no match found
- */
-static struct aa_label *find_attach(const struct linux_binprm *bprm,
-				    struct aa_ns *ns, struct list_head *list,
-				    const char *name, const char **info)
-{
-	struct aa_profile *profile;
-
-	rcu_read_lock();
-	profile = aa_get_profile(__attach_match(bprm, name, list, info));
+out:
+	candidate = aa_get_newest_profile(candidate);
 	rcu_read_unlock();
 
-	return profile ? &profile->label : NULL;
+	return &candidate->label;
 }
 
 static const char *next_name(int xtype, const char *name)
