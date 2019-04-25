Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7CFC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68ED20717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730956AbfDYUJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:09:45 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51480 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729918AbfDYUJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 16:09:45 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hJkgg-0006nb-4G; Thu, 25 Apr 2019 20:09:42 +0000
Date:   Thu, 25 Apr 2019 21:09:42 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Ceph fixes for 5.1-rc7
Message-ID: <20190425200941.GW2217@ZenIV.linux.org.uk>
References: <20190425174739.27604-1-idryomov@gmail.com>
 <CAHk-=wgPBx9xPWY7obK60=RTnOF3Ln0j9XkhYbekML=Fi3bFXg@mail.gmail.com>
 <342ef35feb1110197108068d10e518742823a210.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342ef35feb1110197108068d10e518742823a210.camel@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 02:23:59PM -0400, Jeff Layton wrote:

> I took a quick look at the dcache code to see if we had something like
> that before I did this, but I guess I didn't look closely enough. Those
> routines do look nicer than my hand-rolled version.
> 
> I'll look at spinning up a patch to switch that over in the near future.

Jeff asked to put the name length in there; looking at the existing users,
it does make sense.  I propose turning struct name_snapshot into

struct name_snapshot {
        struct qstr name;
        unsigned char inline_name[DNAME_INLINE_LEN];
};

with
void take_dentry_name_snapshot(struct name_snapshot *name, struct dentry *dentry)
{
        spin_lock(&dentry->d_lock);
	name->name = dentry->d_name;
        if (unlikely(dname_external(dentry))) {
                struct external_name *p = external_name(dentry);
                atomic_inc(&p->u.count);
        } else {
                memcpy(name->inline_name, dentry->d_iname,
                       dentry->d_name.len + 1);
                name->name.name = name->inline_name;
        }
	spin_unlock(&dentry->d_lock);
}

and callers adjusted, initially simply by turning snapshot.name into
snapshot.name.name.  Next step: overlayfs call site becoming
        take_dentry_name_snapshot(&name, real);
        this = lookup_one_len(name.name.name, connected, name.name.len);
Next: snotify stuff switched to passing struct qstr * - fsnotify_move()
first, then fsnotify().  That one would
	* leave callers passing NULL alone
	* have the callers passing snapshot.name.name pass &snapshot.name
	* fsnotify_dirent() pass the entire &dentry->d_name, not just
dentry->d_name.name (that's dependent upon parent being held exclusive;
devpts plays fast and loose here, relying upon the lack of any kind of
renames, explicit or implicit, in that fs)
	* ditto for remaining call in fsnotify_move() (both parents
are locked in all callers, thankfully)
	* ditto for fsnotify_link()
	* kernfs callers in kernfs_notify_workfn() would grow strlen().
Next: send_to_group() and ->handle_event() instances switched to passing
struct qstr *.
Next: inotify_handle_event() doesn't need to bother with strlen().
Next: audit_update_watch() and audit_compare_dname_path() switched to
struct qstr *.  Callers in __audit_inode_child() pass the entire
&dentry->d_name.  strlen() inside audit_compare_dname_path() goes away.

Objections?
