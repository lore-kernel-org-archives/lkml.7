Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B55C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C9D20663
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZbQ2S5yw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbfHLMEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 08:04:10 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44259 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfHLMEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:04:09 -0400
Received: by mail-pl1-f194.google.com with SMTP id t14so47762892plr.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 05:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FIFevxOQtejENIKXPw7Is4Q/QJpdaof9XvfR5if/hlM=;
        b=ZbQ2S5ywhnWZ9VGkBs5RSNIxxulgtRILYMiJXBeaSZSdFMfiq2nW9MFU0nAfRgYk3l
         x4UwOBmE/VoMnZr+z4Rwj1uIbLi+Akbcv/GnJdOoxvofvG8oWIJq2pOzfHViIP7txhud
         6oKvWyqoeT6u+Ig3IXYnAG0zER9ge5R96HRrswYJyltCh8VWPCdGNvFtcYmoNfj7p3/G
         Sot3TFKWLL1lbbjCvojO1527uzVTbRQjhtaH4JGlU8/BSMVQAaPzlNmdawHBerPgczyF
         si5qYNwMRgWdbME3mEtR4EEkXbbMGGhEBLY7FLP/PU8C432j2ykiB6LkIZgeC3aooQG+
         XFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FIFevxOQtejENIKXPw7Is4Q/QJpdaof9XvfR5if/hlM=;
        b=FSiWaxXnTuyPCJMZNK/DYMuZLucYK+EH7ORBPPsD+gZe/rY8xqYC4prLnz/XSAuZ5F
         inmYGF9nnz2+JcP/aKZoSb5LWs6omLGrU2lot4gLBDIVwh8I/poZYpktqmb0nbQrcvzN
         u4LUA108LjPEsG5PqrOUYbKx5gFOb8QkbkXWzF5ByEk1Uq6wUdvB0Qz8hn0mqLo7Kjge
         FuAuSWmZTPE2Ki1HBlxp5gshCVGQCPR/HoH/WDmx5Od9Bsvz3IRZcYQZb2plQe5zGcig
         7vh9jUQrrItgbH8EGgtufju4iJ/hpYPVOUpynOX212sxYttaF+VduXMASu8PkFNKGOXn
         bxsQ==
X-Gm-Message-State: APjAAAXXW+ZCHAQQNxK4j0Us5Fv9kS3Ke3cGD3xl2gvHmlKjlqt88O98
        kKIS4DibzRpDJumQfTvxT918SMQb0RUb9mpjtVQW9A==
X-Google-Smtp-Source: APXvYqwbQ5EK3raAtGV2QgalD22x83zsfNv7FwCakquHaWGun3+qLY7nAY6Govoxf/EQzc3zZik3ZAzgehe7BEW0Pfw=
X-Received: by 2002:a17:902:8649:: with SMTP id y9mr5338163plt.252.1565611448967;
 Mon, 12 Aug 2019 05:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000007e2e84058fb46c49@google.com> <Pine.LNX.4.44L0.1908091646230.1630-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1908091646230.1630-100000@iolanthe.rowland.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 12 Aug 2019 14:03:57 +0200
Message-ID: <CAAeHK+ztV==ojaqueEzM4O5Bq_qdxVKhg8stvgT-VdMEs8GBtw@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in usb_kill_urb
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+22ae4e3b9fcc8a5c153a@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 10:52 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Fri, 9 Aug 2019, syzbot wrote:
>
> > Hello,
> >
> > syzbot has tested the proposed patch and the reproducer did not trigger
> > crash:
> >
> > Reported-and-tested-by:
> > syzbot+22ae4e3b9fcc8a5c153a@syzkaller.appspotmail.com
> >
> > Tested on:
> >
> > commit:         e96407b4 usb-fuzzer: main usb gadget fuzzer driver
> > git tree:       https://github.com/google/kasan.git
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=cfa2c18fb6a8068e
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > patch:          https://syzkaller.appspot.com/x/patch.diff?x=173f2d2c600000
> >
> > Note: testing is done by a robot and is best-effort only.
>
> This shows that this bug is a duplicate of extid=30cf45ebfe0b0c4847a1.

Let's mark it as one:

#syz dup: KASAN: use-after-free Read in ld_usb_release

I'll also mark all bugs that involve ldusb as duplicates, as they all
likely are.

> This fact is also visible in the console logs; both have lines saying
> something like:
>
> [  549.416341][   T22] sysfs: cannot create duplicate filename '/class/usbmisc/ldusb0'
>
> and
>
> [  549.958755][   T22] ldusb 1-1:0.28: Not able to get a minor for this device.
>
> preceding the invalid access.
>
> Alan Stern
>
