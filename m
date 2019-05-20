Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A727DC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 16:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CEF321479
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 16:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F+HMqxhI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389492AbfETQWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 12:22:18 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:55635 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388740AbfETQWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 12:22:18 -0400
Received: by mail-it1-f193.google.com with SMTP id g24so644735iti.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 09:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Jyop9aOTWhGoxrKszcrsGhBXPGe9/8ZYTtSmTaeB9hQ=;
        b=F+HMqxhI0R0WFM4bdO1GZOAtFBETFupacaZFPkpQB8E3VI/+3VlNHnpbSvjfjJLNdi
         MzUNhBlWqF65g77aNWvZeJ57Cxb9UboOlcS+SRMzR09mJgEs4LITbD3OmBaSMs7nbSZR
         Zy0WWmJi/DqzhgPpIiZW8ONe6I7kpmJ8nKyVvcc2VgK5NGWJnxc1pKWGaoDL9qG+6Zkx
         WBbdOHdPiH5TYIRNQqRxFj07xFLlwCWkquQ+LrND908WH/8Pj6jLVtZTb3HPRfDyRJu9
         kHubP/cdK8uQzRa+kOBy+dtWnKRnxE9WPAsh+ooQj+jVmCOO1Fd9dmnk4wG/RO/GmaAS
         YyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Jyop9aOTWhGoxrKszcrsGhBXPGe9/8ZYTtSmTaeB9hQ=;
        b=DAdUVXcKXEmBqJxENnsigGvhtt6Fnb1IWCK3TPyFVQiDlbp9RWGJ82IUXB1NPUGy5G
         3/UHJjTnp3PCm0bGTuYdh1kar+lb8vW35g9XauuKrrNygheXN86SwMjVvgk4f0v2E94h
         HNqoCwEq2RpVuohjSdwOFEpr5ATLAyDmlaUw0MIbynDTxGHkXHMN/Hc/Jbx/mASdJJuO
         8WxLVpRNYDI2UB58O5F1aTl5JfagNfBAQts0MukJGJYIS/RQabIiUx13BQdhk9Odj84o
         SabK3BG27kd0EUC+7vRfELooU626sMF9WoCvMl9g1e7qDZd4udzqd1mwaz8wlUuZgGPj
         ZQqA==
X-Gm-Message-State: APjAAAWcwsWxSDN0qq26kmP0Kyha2nJ6aQMuoiKSFy2vV0k9Az8qNQ5r
        HcPhop7WwGKnLIm5dUj5p8tF2gO+U8eC9eH9jGlqPQ==
X-Google-Smtp-Source: APXvYqzzfmVwcwjVX9oHFpxEtRbMLNTMqBMA6Yy6xsux+EaRmCyEgUxSjvoWh/lFer0cz7Hrs629Fo5e2hM+RNn4Gz4=
X-Received: by 2002:a24:c204:: with SMTP id i4mr28404690itg.83.1558369337205;
 Mon, 20 May 2019 09:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000014285d05765bf72a@google.com> <0000000000000eaf23058912af14@google.com>
 <20190517134850.GG17978@ZenIV.linux.org.uk> <CACT4Y+Z8760uYQP0jKgJmVC5sstqTv9pE6K6YjK_feeK6-Obfg@mail.gmail.com>
 <CACT4Y+bQ+zW_9a3F4jY0xcAn_Hdk5yAwX2K3E38z9fttbF0SJA@mail.gmail.com>
 <20190518162142.GH17978@ZenIV.linux.org.uk> <20190518201843.GD14277@mit.edu>
In-Reply-To: <20190518201843.GD14277@mit.edu>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 20 May 2019 18:22:05 +0200
Message-ID: <CACT4Y+Z8gfJC1a9_WMPRE4Z+qF2wfANkkXCqD3D7YFbkES8XPQ@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel paging request in do_mount
To:     "Theodore Ts'o" <tytso@mit.edu>, Al Viro <viro@zeniv.linux.org.uk>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+73c7fe4f77776505299b@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, sabin.rapan@gmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 18, 2019 at 10:19 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Sat, May 18, 2019 at 05:21:42PM +0100, Al Viro wrote:
> > IOW, Dan's fix folded into the offending commit.  And that kind of
> > pattern is not rare; I would argue that appending Dan's patch at
> > the end of queue and leaving the crap in between would be a fucking
> > bad idea - it would've left a massive bisection hazard *and* made
> > life much more unpleasant when the things got to merging into the
> > mainline (or reviewing, for that matter).
>
> When this happens in the ext4 git tree, I usually don't worry about
> giving credit to whatever system finds the problem, whether coming
> from it's Coverity, or someone running sparse, or syzbot, etc.
>
> There will always be issues where there are no way to clear out the
> syzbot report via a commit description --- for example, when a patch
> gets dropped entirely from linux-next.  With Coverity, the report gets
> dropped automatically.  With syzbot, it will have closed out by hand.
>
> > What would you prefer to happen in such situations?  Commit summaries
> > modified enough to confuse CI tools into *NOT* noticing that those
> > are versions of the same patch?  Some kind of metadata telling the
> > same tools that such-and-such commits got folded in (and they might
> > have been split in process, with parts folded into different spots
> > in the series, at that)?
> >
> > Because "never fold in, never reorder, just accumulate patches in
> > the end of the series" is not going to fly.  For a lot of reasons.
>
> As far as I'm concerned, this is the tools problem; I don't think it's
> worth it for developers to feel they need to twist themselves into
> knots just to try to make the CI tools' life easier.
>
>                                         - Ted


I've added docs re linux-next handling:
https://github.com/google/syzkaller/blob/master/docs/syzbot.md#linux-next
In the end it's still just adding a tag. And it's not so much about
crediting or making somebody's life easier, this is mainly about
making Linux less buggy and higher-quality.
