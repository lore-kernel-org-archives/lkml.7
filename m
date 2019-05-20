Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194A0C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFFFB216C4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NEh5IhEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388171AbfETOMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:12:19 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:37211 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733122AbfETOMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:12:17 -0400
Received: by mail-it1-f196.google.com with SMTP id m140so23350874itg.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YU2Hk+oQzPQtUHiv1l161xo5DuGg7ti6IldSS88QBWw=;
        b=NEh5IhEsz1G82YNK42ntz4UQRVBbHjehpTlIHUBmVwOm5nopRST3U8a8Nnu5ozfEjy
         IdbQ0F0odZUIKx6adbHEgmM/5qxF57n84LoJkxl3QnhCrUJS72qw5A8VYp1CFxgjcCHG
         7umzINnbdZBp9v+xH3Yd0jI+ffN18QPeE5eMnJlGuRY7OTDschEOgC8ikexhEG9bKdVb
         +eGWmugkuKP1VmisOezHEWvjKGbs6mDdFTqdu8kG75MTQid/67WueSa/nmeuO+1zXIZw
         PaEhpuMmOGbfvNKCdbberg5gUAxryfut7IAYavNh1Shj1whXtKzi0o/f9M9nPeylnqhP
         xd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YU2Hk+oQzPQtUHiv1l161xo5DuGg7ti6IldSS88QBWw=;
        b=FA/a8tV3kDYPKlTatVmA9CW5U1mg/dZO018I93TOc0MVGSkSyHOPVU91WXEULcCDdk
         5zVSxOJ2/wc8KodxvcJiVehsnXiT/4UHHKwvGopsn1SaXvvKV5i3lsY0BskLmDBz2GDB
         J1aon8bs+oV4xqnkBr5CB3GZjBMVvFcV3DSxwpICJGR9Ay1/JAVsVc5UG6A5eJ8Qsh0V
         9KTpG3dU01WwWruzEA7S30K1jef+PX9ZNGBpUVrdu/WNd7MMtxqQJhAu8b4jVpR8/n/2
         UWBFdWocVnZiqLt79zY85BvZDHBlfdqLPwFHbYsQxWEwlRlaqwW7TH/LeQ9gFSwctfdp
         oCwQ==
X-Gm-Message-State: APjAAAUsUz9/7770jPnYGkKg+m/BMIADRMuLsso8zai3faYT089ADd5y
        bZkJ3+1DPvURWkv1eqW72raXcrgxmMozXHJ9A7xv7A==
X-Google-Smtp-Source: APXvYqxlCe+++Lk7vYe+F5tBuGoqXcVwC6IRvGv7VG8UyrBCiED8+5J5QK8VurvmgLZLcQkrw1L50j7vXQpHsiwUW20=
X-Received: by 2002:a24:c204:: with SMTP id i4mr27878219itg.83.1558361536256;
 Mon, 20 May 2019 07:12:16 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000014285d05765bf72a@google.com> <0000000000000eaf23058912af14@google.com>
 <20190517134850.GG17978@ZenIV.linux.org.uk> <CACT4Y+Z8760uYQP0jKgJmVC5sstqTv9pE6K6YjK_feeK6-Obfg@mail.gmail.com>
 <CACT4Y+bQ+zW_9a3F4jY0xcAn_Hdk5yAwX2K3E38z9fttbF0SJA@mail.gmail.com> <20190518162142.GH17978@ZenIV.linux.org.uk>
In-Reply-To: <20190518162142.GH17978@ZenIV.linux.org.uk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 20 May 2019 16:12:03 +0200
Message-ID: <CACT4Y+bYfyKDi3ARkV6O-MaBJmxbOB5qdcuwG_r5-UHfxRcwjQ@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel paging request in do_mount
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     syzbot <syzbot+73c7fe4f77776505299b@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, sabin.rapan@gmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.On Sat, May 18, 2019 at 6:21 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sat, May 18, 2019 at 05:00:39PM +0200, Dmitry Vyukov wrote:
> > On Fri, May 17, 2019 at 4:08 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > On Fri, May 17, 2019 at 3:48 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > >
> > > > On Fri, May 17, 2019 at 03:17:02AM -0700, syzbot wrote:
> > > > > This bug is marked as fixed by commit:
> > > > > vfs: namespace: error pointer dereference in do_remount()
> > > > > But I can't find it in any tested tree for more than 90 days.
> > > > > Is it a correct commit? Please update it by replying:
> > > > > #syz fix: exact-commit-title
> > > > > Until then the bug is still considered open and
> > > > > new crashes with the same signature are ignored.
> > > >
> > > > Could somebody explain how the following situation is supposed to
> > > > be handled:
> > > >
> > > > 1) branch B1 with commits  C1, C2, C3, C4 is pushed out
> > > > 2) C2 turns out to have a bug, which gets caught and fixed
> > > > 3) fix is folded in and branch B2 with C1, C2', C3', C4' is
> > > > pushed out.  The bug is not in it anymore.
> > > > 4) B1 is left mouldering (or is entirely removed); B2 is
> > > > eventually merged into other trees.
> > > >
> > > > This is normal and it appears to be problematic for syzbot.
> > > > How to deal with that?  One thing I will *NOT* do in such
> > > > situations is giving up on folding the fixes in.  Bisection
> > > > hazards alone make that a bad idea.
> > >
> > > linux-next creates a bit of a havoc.
> > >
> > > The ideal way of handling this is including Tested-by: tag into C2'.
> > > Reported-by: would work too, but people suggested that Reported-by: is
> > > confusing in this situation because it suggests that the commit fixes
> > > a bug in some previous commit. Technically, syzbot now accepts any
> > > tag, so With-inputs-from:
> > > syzbot+73c7fe4f77776505299b@syzkaller.appspotmail.com would work too.
> > >
> > > At this point we obvious can't fix up C2'. For such cases syzbot
> > > accepts #syz fix command to associate bugs with fixes. So replying
> > > with "#syz fix: C2'-commit-title" should do.
> >
> > What is that C2'?
>
> In this case?  Take a look at
>
> commit fd0002870b453c58d0d8c195954f5049bc6675fb
> Author: David Howells <dhowells@redhat.com>
> Date:   Tue Aug 28 14:45:06 2018 +0100
>
>     vfs: Implement a filesystem superblock creation/configuration context
>
> and compare with
>
> commit f18edd10d3c7d6127b1fa97c8f3299629cf58ed5
> Author: David Howells <dhowells@redhat.com>
> Date:   Thu Nov 1 23:07:25 2018 +0000
>
>     vfs: Implement a filesystem superblock creation/configuration context
>
> There might have been intermediate forms, but that should illustrate what
> happened.  Diff of those two contains (among other things) this:
> @@ -985,6 +989,9 @@
>  +      fc = vfs_new_fs_context(path->dentry->d_sb->s_type,
>  +                              path->dentry, sb_flags, MS_RMT_MASK,
>  +                              FS_CONTEXT_FOR_RECONFIGURE);
> ++      err = PTR_ERR(fc);
> ++      if (IS_ERR(fc))
> ++              goto err;
>  +
>  +      err = parse_monolithic_mount_data(fc, data, data_size);
>  +      if (err < 0)
>
> IOW, Dan's fix folded into the offending commit.  And that kind of
> pattern is not rare; I would argue that appending Dan's patch at
> the end of queue and leaving the crap in between would be a fucking
> bad idea - it would've left a massive bisection hazard *and* made
> life much more unpleasant when the things got to merging into the
> mainline (or reviewing, for that matter).
>
> What would you prefer to happen in such situations?  Commit summaries
> modified enough to confuse CI tools into *NOT* noticing that those
> are versions of the same patch?  Some kind of metadata telling the
> same tools that such-and-such commits got folded in (and they might
> have been split in process, with parts folded into different spots
> in the series, at that)?
>
> Because "never fold in, never reorder, just accumulate patches in
> the end of the series" is not going to fly.  For a lot of reasons.

I don't advocate for stopping folding/amending/rebasing patches in any
way. I understand this is required to get sane commits.

But what I said in the previous email still applies:
 - either include the tag into the first commit version that fixes the
reported bug
 - or link report and the fixing commit manually using the final commit title

As far as I understand in this case it would be adding Tested-by (or
some other tag) to f18edd10d3c7d6127b1fa97c8f3299629cf58ed5.
We can't do this now, so this should work:

#syz fix:
vfs: Implement a filesystem superblock creation/configuration context
