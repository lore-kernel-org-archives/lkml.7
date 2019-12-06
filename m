Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EA1C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 21:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB9424679
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 21:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575667397;
	bh=hwE3SK6fpB7hachHghZiNMwBgfWyDvEZA/GsueZNn+w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=e4EXvG6LkR50NrT18U2HHleo84ZRej/lsHvPVHHJkSm+T6iI3hAcfD9Td/kY+a2hI
	 ZlGDPo8ySw21YT505tG1V0Fq7H4g2DUlGpdRLZQDLwFPV/pR+QCdCQMoIlCIQqOD0N
	 NUU0FBapYpdK44IrVJVg4UAPe1dbwYAS44z2m3pY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfLFVXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 16:23:15 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35003 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfLFVXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 16:23:15 -0500
Received: by mail-lf1-f65.google.com with SMTP id 15so6335316lfr.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 13:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=33UvPPPikXdBo5UqVXIO9fOcJEfCIytsFl6Vq5hgbDY=;
        b=QbFw/8XlQT2pipRqdCg9I+rSe4FLl6AknneKlqx43cRU3CNqoWkLozz28r7O2ZmCOz
         zOYuDWbSSWb74gksR4qXilyw7QCfb4OvPTYw4S4vAvWvrq1NQPfh+Tc+iCjJF5j5Az70
         Pw4O4duHeBe9zR9bdDicQDvbEQwD9fNNlNPMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=33UvPPPikXdBo5UqVXIO9fOcJEfCIytsFl6Vq5hgbDY=;
        b=ZHrKz23QQHOLpT7puX7W9AYxBSioMtikgVBjCSJdHPVlyHYuwZ97AVlp/GdkfqvPzw
         CsuVBcEbCQw1xRbPgr+y8ehJumol2SeuZ8ffuG+rlhWev41v0dpMcu1Q7xEX7UulsB1L
         lbDwyM6rPUyuQbaJ7pu8lnNJV/S4XCHQkGV9U4hOT+rpryx9WSNUoFXYHs8RTHMzNhKq
         B0OCIWhBMtYvPEzTSLrlO3zslFGnAJfUGDEQER0MeWyfc+LVHaj9HqTb/kzgAsX5aEaS
         0i4NuZZM5v0/LrYMiygRqiKic7sNPin4nVdwGIt5rNfmWPc3URAIF5I3SYnZHrb0p1oo
         eZ9A==
X-Gm-Message-State: APjAAAUFzXlZ8oyXgPUNO+htfaIgnxw3Qttplm8Xrt0J+t1zyRIzWJdQ
        Hl8qClve1ILVNh5RCzFWVrvWWPNCx+8=
X-Google-Smtp-Source: APXvYqwXCz76vldvQyNCeNj5i6c4RnymJgjx1v6A4bFEvKXi211IhotIpf93KNdRHRkIg86KeJ5qrQ==
X-Received: by 2002:a19:3f51:: with SMTP id m78mr9592287lfa.70.1575667393031;
        Fri, 06 Dec 2019 13:23:13 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id d24sm7059839lja.82.2019.12.06.13.23.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 13:23:12 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id j6so9184803lja.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 13:23:11 -0800 (PST)
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr5352792ljj.97.1575667391454;
 Fri, 06 Dec 2019 13:23:11 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.9999.1912040050430.56420@viisi.sifive.com>
 <CAAhSdy2id0FoLBxWwN7WHEk5Am770BizkK=sZO0-G54MtYa6DQ@mail.gmail.com>
 <9044bad02aa6553cdb2523294500b50fccf3fd2a.camel@wdc.com> <alpine.DEB.2.21.9999.1912041128400.186402@viisi.sifive.com>
 <81530734312456aab8b9625d7e9bb071c43db1c5.camel@wdc.com> <alpine.DEB.2.21.9999.1912041644170.206929@viisi.sifive.com>
 <84c4ee600c0dd235a0fcc257115807af7207b5f6.camel@wdc.com> <alpine.DEB.2.21.9999.1912051435130.239155@viisi.sifive.com>
 <99bbf5710da82c8b52e59ad5fc4e44471573ecd3.camel@wdc.com> <3286a00cb9c8033872f533ec3e7f3db3e652c30c.camel@wdc.com>
 <CADnnUqe-=yTAFbwin_Lti6mQKqO2ABVYMa1XgTv_J=usT5w2gg@mail.gmail.com> <CAAhSdy0BXtkZPbav3QRtdMN9GcYG0SuxBDpwjFC8B_pr35s+Kg@mail.gmail.com>
In-Reply-To: <CAAhSdy0BXtkZPbav3QRtdMN9GcYG0SuxBDpwjFC8B_pr35s+Kg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Dec 2019 13:22:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjGqZk7XcmtqJ7J0Em_XP1ECYU4CDBwFuMOjLrBH0-AHw@mail.gmail.com>
Message-ID: <CAHk-=wjGqZk7XcmtqJ7J0Em_XP1ECYU4CDBwFuMOjLrBH0-AHw@mail.gmail.com>
Subject: Re: [GIT PULL] Second set of RISC-V updates for v5.5-rc1
To:     Anup Patel <anup@brainfault.org>
Cc:     Carlos Eduardo de Paula <me@carlosedp.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 6, 2019 at 1:15 PM Anup Patel <anup@brainfault.org> wrote:
>
> Better approach is to have a fragmented .config for extra DEBUG options.

Guys, stop this silly thread already.

The fact is, defconfig is useful for basic smoke testing - automated
compile and boot testing, and getting perhaps random people to test
something.

But it is not appropriate for a distro to use. Anybody who makes that
argument is wrong. If you actually know what you are doing, the
defconfig is entirely irrelevant, and no, trying to make special debug
fragments isn't going to make it more so.

So if you are a RISC-V distro: stop using the defconfig. You shouldn't
have used it in the first place. It's not meant to be a usable one.

And no, don't start making "more defconfigs". We've had that mess too.
It's broken too.

If you are a distro maintainer and you cannot be bothered to make your
own config file, then you should just stop being a distro maintainer,
and maybe take up farming instead.

Right now you guys are just wasting everybody elses time. Stop it.

Or at least remove me from the cc, because I'm  not interested in this
whiny "I'm too lazy to maintain my own config, and I _insist_ that the
defconfig is meant only for me".

             Linus
