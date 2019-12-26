Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA01C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 22:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7578B206CB
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 22:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfLZWbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 17:31:04 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:51430 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfLZWbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 17:31:04 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ikbei-0000SB-TR; Thu, 26 Dec 2019 22:30:57 +0000
Date:   Thu, 26 Dec 2019 22:30:56 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     john.johansen@canonical.com, jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] security: apparmor: Fix a possible
 sleep-in-atomic-context bug in find_attach()
Message-ID: <20191226223056.GQ4203@ZenIV.linux.org.uk>
References: <20191217131220.11613-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217131220.11613-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 09:12:20PM +0800, Jia-Ju Bai wrote:
> The kernel may sleep while holding a RCU lock.
> The function call path (from bottom to top) in Linux 4.19 is:
> 
> security/apparmor/domain.c, 331: 
> 	vfs_getxattr_alloc(GFP_KERNEL) in aa_xattrs_match
> security/apparmor/domain.c, 425: 
> 	aa_xattrs_match in __attach_match
> security/apparmor/domain.c, 485: 
> 	__attach_match in find_attach
> security/apparmor/domain.c, 484:
>     rcu_read_lock in find_attach
> 
> vfs_getxattr_alloc(GFP_KERNEL) can sleep at runtime.
> 
> To fix this possible bug, GFP_KERNEL is replaced with GFP_ATOMIC for
> vfs_getxattr_alloc().
> 
> This bug is found by a static analysis tool STCheck written by myself. 
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  security/apparmor/domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
> index 9be7ccb8379e..60b54ce57d1f 100644
> --- a/security/apparmor/domain.c
> +++ b/security/apparmor/domain.c
> @@ -325,7 +325,7 @@ static int aa_xattrs_match(const struct linux_binprm *bprm,
>  
>  	for (i = 0; i < profile->xattr_count; i++) {
>  		size = vfs_getxattr_alloc(d, profile->xattrs[i], &value,
> -					  value_size, GFP_KERNEL);
> +					  value_size, GFP_ATOMIC);

<stares>

How can that possibly make any sense?  We are, by the look of it, trying
to read extended attributes of some sort here.  How the hell can that
possibly hope to be non-blocking?

<goes to read>
Yup, vfs_getxattr_alloc() does call xattr ->get() method, which certainly
can cause IO.  GFP_ATOMIC affects only the allocation done in
vfs_getxattr_alloc() itself, ->get() call doesn't even see it.

AFAICS, that "fix" is pure cargo-culting; if that code *can* be called in
non-blocking context, we are fucked, GFP_ATOMIC or no GFP_ATOMIC.

Let's look at your call chain...  find_attach() calls __attach_match()
under rcu_read_lock().  Yes, it does, and by the look of the function
itself it does expect to be called thus.

Call of aa_xattrs_match() in there.  Present, no obvious dropping/regaining
rcu_read_lock() around it.  Conditional upon perm & MAY_EXEC, but that
doesn't seem to be provably excludable by the arguments of this particular
call.  And yes, aa_xattrs_match() is very obviously blocking.

So you've caught a real bug, but the "fix" doesn't fix anything whatsoever;
reading xattrs *does* block, no matter what.

By the look at git blame, we have commit 8e51f9087f4024d20f70f4d9831e1f45d8088331
Author: Matthew Garrett <mjg59@google.com>
Date:   Thu Feb 8 12:37:19 2018 -0800

    apparmor: Add support for attaching profiles via xattr, presence and value
    
    Make it possible to tie Apparmor profiles to the presence of one or more
    extended attributes, and optionally their values. An example usecase for
    this is to automatically transition to a more privileged Apparmor profile
    if an executable has a valid IMA signature, which can then be appraised
    by the IMA subsystem.
    
    Signed-off-by: Matthew Garrett <mjg59@google.com>
    Signed-off-by: John Johansen <john.johansen@canonical.com>

to thank for that.  And by the time of that commit the call chain already
existed, complete with rcu_read_lock().

AFAICS, it really is buggered by design - you can't read xattrs in such
context.  Again, GFP_ATOMIC is useless here - the problem is not in
allocation, it's IO, possibly over network, etc. 

Morever, *anything* that passes GFP_ATOMIC to vfs_getxattr_alloc() is
deeply suspect - it's almost certainly cargo-culting in attempt to
do inherently blocking operation in non-blocking context.  <greps>
No GFP_ATOMIC (thankfully), but there's a bunch of GFP_NOFS and
I really wonder if _those_ make any sense here...
