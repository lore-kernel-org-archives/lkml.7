Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B897C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 22:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A4D206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 22:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GDTV36us"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfDZWhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 18:37:39 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:35915 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfDZWhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 18:37:39 -0400
Received: by mail-vk1-f193.google.com with SMTP id w140so1139568vkd.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 15:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qp2COoOzGcxdcXg+1vxxR4TSzk1B6a7b+NmLr2MP/+E=;
        b=GDTV36usGs9JvO3YlJf4bV518rXaI+FjHtyCnUnFNzinoMyt/IzuPD4xszpG3F8Yd0
         BQEmx1/r4zB2tO/kjez5Og1bYakqtkU8XWnmYLG8aIDdC+CmOg+BYU66TuLgLTxIVlMQ
         mOCtg0PvUrbfsqQf2tMJpGQrXlj3SGej5ZeHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qp2COoOzGcxdcXg+1vxxR4TSzk1B6a7b+NmLr2MP/+E=;
        b=CwyJ+FVv9AVq4kc9scsreXYXxyDpAfIUHnBf0Cbzyh/u+xt9ML+JsyfnkaoFKVWbqK
         OgRvhDwfLIWyjy3ccdMBu7kRJPmoxyk1sNL6MbQNpVcqt1vAXFYacAT9L5W4Ut1wJx3/
         LHJD65adTRKQnzxQbPf35qKIV+uE8l6vLYQS4iAEdVO2c1ljuY7FRt2iTgdSx0PL2rEf
         T9Zwfw77DN2J5JyM2yIoL3QD73b927GvwkIVdvQDorjg3wpf6N5P/KKizipMDINZtSCV
         lSPsHDsvBH8Pos3iA/TUhCM0by3a/ESlRtjegWbqWpShUTp6RCaB3CyQ17mfpgvhLyZs
         +CLg==
X-Gm-Message-State: APjAAAW60tXbSjx1QA5jBG4WWVu7HQ/mqEiqPQ3YewkdnmlonVt3cwGC
        bE0/Z/KMXaEzOToLzWaDI6UGrZ0QclA=
X-Google-Smtp-Source: APXvYqzNPoFnF3SwnuJsSDI2LLIqDigjJJkKFUI1ZHQ59eb1EAUzuBha/cV+wq7TtGuIyxhhqvmREw==
X-Received: by 2002:a1f:2ccb:: with SMTP id s194mr12338389vks.24.1556318258134;
        Fri, 26 Apr 2019 15:37:38 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id m23sm37202285vsl.24.2019.04.26.15.37.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 15:37:35 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id l17so1731724uar.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 15:37:35 -0700 (PDT)
X-Received: by 2002:ab0:4870:: with SMTP id c45mr2929546uad.21.1556318255153;
 Fri, 26 Apr 2019 15:37:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190423225959.43742-1-dianders@chromium.org>
In-Reply-To: <20190423225959.43742-1-dianders@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 26 Apr 2019 15:37:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W=JW_W0FsPoNOA_ZSDptC0AGLVAiTm=o2HH8bmFeNPaA@mail.gmail.com>
Message-ID: <CAD=FV=W=JW_W0FsPoNOA_ZSDptC0AGLVAiTm=o2HH8bmFeNPaA@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: errata: Workaround errata A12 857271 / A17 857272
To:     Russell King <linux@armlinux.org.uk>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Jose Salvador Climent Bayarri <Salva.Climent@arm.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Sonny Rao <sonnyrao@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        Bobby Batacharia <bbatacha@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 23, 2019 at 4:00 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> This adds support for working around errata A12 857271 / A17 857272.
> These errata were causing hangs on rk3288-based Chromebooks and it was
> confirmed that this workaround fixed the problems.  In the Chrome OS
> 3.14 kernel this was treated as two errata: ERRATA_FOOBAR [1] and
> ERRATA_CR711784 [2].  Apparently the two errata got lumped together at
> some point in time.
>
> Let's actually get the workaround landed.
>
> [1] https://crrev.com/c/342753
> [2] https://crbug.com/711784
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
> ---
>
> Changes in v2:
> - Squashed bits 10 and 11 into one errata.
>
>  arch/arm/Kconfig      | 18 ++++++++++++++++++
>  arch/arm/mm/proc-v7.S | 10 ++++++++++
>  2 files changed, 28 insertions(+)

Breadcrumbs: this has been submitted to RMK's patch tracking system.  See:

https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=8861/1

-Doug
