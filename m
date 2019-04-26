Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DE9C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC70920B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556295908;
	bh=ABJsl1OYlXo5oCrplPjx0+jERPR8tTNV1AQiWovjWOg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=nJlC4eusTmBn6a3MCxkNVnVcNwvgx5eumFkNJN4EIg4Tcrta5wAHJyG0zG91MsL2k
	 lqsXrXzlwB2NyX3UNAOgtkoqLorIrs58R5AFCeiv/U6M8tkoZFxb2AlT+VWX8O3wEH
	 3O0xXcLnJU5VQwuaxKOi1CdoT6x8juxg69p6sp5c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfDZQZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:25:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbfDZQZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 12:25:07 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C5D0206C1;
        Fri, 26 Apr 2019 16:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556295905;
        bh=ABJsl1OYlXo5oCrplPjx0+jERPR8tTNV1AQiWovjWOg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=E7WogDTQJ/CejPyf/P2WtArMhSks8Zkyu19xQRxYVOzvd5CQQ9M7FTB65m5XOS1T8
         sIb0bnBFThjdRLk4B0MkSw/PONEHIL5oJ46LCOyH68+Q1qELPaEg5qSlpM+vtBpemv
         iFN4Zr0f7WR2qL7snikqaI3I80X4mS2AQ7hcSzzM=
Message-ID: <86674e79e9f24e81feda75bc3c0dd4215604ffa5.camel@kernel.org>
Subject: Re: [GIT PULL] Ceph fixes for 5.1-rc7
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Date:   Fri, 26 Apr 2019 12:25:03 -0400
In-Reply-To: <20190425200941.GW2217@ZenIV.linux.org.uk>
References: <20190425174739.27604-1-idryomov@gmail.com>
         <CAHk-=wgPBx9xPWY7obK60=RTnOF3Ln0j9XkhYbekML=Fi3bFXg@mail.gmail.com>
         <342ef35feb1110197108068d10e518742823a210.camel@kernel.org>
         <20190425200941.GW2217@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-04-25 at 21:09 +0100, Al Viro wrote:
> On Thu, Apr 25, 2019 at 02:23:59PM -0400, Jeff Layton wrote:
> 
> > I took a quick look at the dcache code to see if we had something like
> > that before I did this, but I guess I didn't look closely enough. Those
> > routines do look nicer than my hand-rolled version.
> > 
> > I'll look at spinning up a patch to switch that over in the near future.
> 
> Jeff asked to put the name length in there; looking at the existing users,
> it does make sense.  I propose turning struct name_snapshot into
> 
> struct name_snapshot {
>         struct qstr name;
>         unsigned char inline_name[DNAME_INLINE_LEN];
> };
> 
> with
> void take_dentry_name_snapshot(struct name_snapshot *name, struct dentry *dentry)
> {
>         spin_lock(&dentry->d_lock);
> 	name->name = dentry->d_name;
>         if (unlikely(dname_external(dentry))) {
>                 struct external_name *p = external_name(dentry);
>                 atomic_inc(&p->u.count);
>         } else {
>                 memcpy(name->inline_name, dentry->d_iname,
>                        dentry->d_name.len + 1);
>                 name->name.name = name->inline_name;
>         }
> 	spin_unlock(&dentry->d_lock);
> }
> 
> and callers adjusted, initially simply by turning snapshot.name into
> snapshot.name.name.  Next step: overlayfs call site becoming
>         take_dentry_name_snapshot(&name, real);
>         this = lookup_one_len(name.name.name, connected, name.name.len);
> Next: snotify stuff switched to passing struct qstr * - fsnotify_move()
> first, then fsnotify().  That one would
> 	* leave callers passing NULL alone
> 	* have the callers passing snapshot.name.name pass &snapshot.name
> 	* fsnotify_dirent() pass the entire &dentry->d_name, not just
> dentry->d_name.name (that's dependent upon parent being held exclusive;
> devpts plays fast and loose here, relying upon the lack of any kind of
> renames, explicit or implicit, in that fs)
> 	* ditto for remaining call in fsnotify_move() (both parents
> are locked in all callers, thankfully)
> 	* ditto for fsnotify_link()
> 	* kernfs callers in kernfs_notify_workfn() would grow strlen().
> Next: send_to_group() and ->handle_event() instances switched to passing
> struct qstr *.
> Next: inotify_handle_event() doesn't need to bother with strlen().
> Next: audit_update_watch() and audit_compare_dname_path() switched to
> struct qstr *.  Callers in __audit_inode_child() pass the entire
> &dentry->d_name.  strlen() inside audit_compare_dname_path() goes away.
> 
> Objections?

I have some patches that do what you lay out above. They build but I
haven't ran them through much testing yet.

It turns out though that using name_snapshot from ceph is a bit more
tricky. In some cases, we have to call ceph_mdsc_build_path to build up
a full path string. We can't easily populate a name_snapshot from there
because struct external_name is only defined in fs/dcache.c.

I could add some routines to do this, but it feels a lot like I'm
abusing internal dcache interfaces. I'll keep thinking about it though.

While we're on the subject though:

struct external_name {
        union {
                atomic_t count;
                struct rcu_head head;
        } u;
        unsigned char name[];
};

Is it really ok to union the count and rcu_head there?

I haven't trawled through all of the code yet, but what prevents someone
from trying to access the count inside an RCU critical section, after
call_rcu has been called on it?

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>

