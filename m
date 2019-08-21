Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E66C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03E222D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qNUYZ3ay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbfHUQkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 12:40:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41180 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729380AbfHUQkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 12:40:03 -0400
Received: by mail-pf1-f193.google.com with SMTP id 196so1774518pfz.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 09:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VUVIcvKRAxchzzIboABzY4R0ISYxco2N8kvTRtaX2No=;
        b=qNUYZ3ayTlf/+efR18tsC2cdgYlaL+V64+bHpwBKeAOvUI02sHoSgR9WQ8Ndc6QwuZ
         qX7mv+wHlSrKxF8S48uzMfYMzp+1x5EtPKNuSZFj2GaEwfDZ9ILYpf8PaUwlxinG6vEC
         n+TEXB6jCJPemwoDI+JzRsitP8jtHNO0JACKuMZ9gyHRadCl4kqtPhau02Jx96LDLsW0
         aT6gDNIPoQ4asedEhowXd03uvdJVk9ycdLTekzxhbRamYUgSH27n8D6psoMw/96X8toL
         VgUWELVs8RBmBu0SlA7rqY0ZOdljucwYL0q2/E838xRQ1UvdR1JpgcMIas1wDj3AmoD6
         0UHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VUVIcvKRAxchzzIboABzY4R0ISYxco2N8kvTRtaX2No=;
        b=a3HjzwDPDddXudxA8OyqcJGkyxsN7vqyJQb1i1kFWOR786vs4M591yP25Qi9wzzKRG
         fMxTvxt8CPbKZeq5bmvFZAWMPL07tqhY5Yr/RJdod4HtYZWnIOSrsK1NpCfpjku9x3cT
         84Juy3wz93RfmgSBmd+4t4u69GGWEvXPg3wXSEfXHhuMmTf+meFyo4t1+e5Gdei/KX+v
         h2aqGyXVUwQOj9lCWcKZaZOqQ9WynfHuBq8lavzBUHTY0egk1si+adv0bmyvTE/RsBgB
         VYnwozDHHC6gr2djsPqvAPUX6MkbERrVSuoxYY6z+eQ889oQs9gAjDz+Puupwy+k1hzn
         gNOg==
X-Gm-Message-State: APjAAAWg3v5/SCYoJdDN5ThmPe53M3wvFSdWhe1p1ZrtnypgAu+sSBTb
        esr9qD16GaH3g8uUiAVcw8bEr40LtpLXhGeUwJiZHaJQEQPsvA==
X-Google-Smtp-Source: APXvYqxObByY71HuxPnyU08sUAGGvZX2iThJJB5iiD03WIZb1eORrogkr5nLL2kPV/CD4qzWueFyCPez88tPXcYIJ6E=
X-Received: by 2002:a65:4b8b:: with SMTP id t11mr29817121pgq.130.1566405602118;
 Wed, 21 Aug 2019 09:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <Pine.LNX.4.44L0.1908211218550.1816-100000@iolanthe.rowland.org> <00000000000040fec90590a33230@google.com>
In-Reply-To: <00000000000040fec90590a33230@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 21 Aug 2019 18:39:50 +0200
Message-ID: <CAAeHK+xhxhdJecq=HMLbZySTxzT_JTvMWdXojTnCdJ+OU2w4Ew@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in hidraw_ioctl
To:     syzbot <syzbot+ded1794a717e3b235226@syzkaller.appspotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 6:38 PM syzbot
<syzbot+ded1794a717e3b235226@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot has tested the proposed patch and the reproducer did not trigger
> crash:
>
> Reported-and-tested-by:
> syzbot+ded1794a717e3b235226@syzkaller.appspotmail.com
>
> Tested on:
>
> commit:         e96407b4 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git
> kernel config:  https://syzkaller.appspot.com/x/.config?x=792eb47789f57810
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=126b9da6600000
>
> Note: testing is done by a robot and is best-effort only.

Let's dup this bug into the other one:

#syz dup: KASAN: slab-out-of-bounds Read in hidraw_ioctl
