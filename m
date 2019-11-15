Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6423C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5B22073B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jgtg2xpI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfKOKiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 05:38:50 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:35526 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbfKOKiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 05:38:50 -0500
Received: by mail-ua1-f67.google.com with SMTP id s14so2869995uad.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 02:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sZ++OTuPO6CZ+10/YPxexGs+9BN/3XmrfWtpRIF0DC4=;
        b=Jgtg2xpIT0dwdOdXRUAYtWgX6xEO5ERBK9nrN0ggu3CtBKZyQjYtKiHUsGK5GVzhTh
         eC2rddyP1BAGqiR9Dq9KmLE5Ags9wbKtnfehJDcokXym2kuAImlsKmvbIpFNh4k59CRk
         UDpOM5oNxENQNWJkLaTcA0OXRcQW2wxDUzgSMnUuwCY8+2OAt6aJbfS62hfAURhMZyF5
         FWoRZBubYKZqZZh5/ov9OO47V+5UrdQLbNSiuCr/qiYxpB+60w63W8ww7aZ0Gh+gNpKn
         nCpRGaYDRG1J5o5cubgni0VZshY747rWRrnGJ8JFkiGbi2pj96GMjOCNvMbiya9BfzD5
         aBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sZ++OTuPO6CZ+10/YPxexGs+9BN/3XmrfWtpRIF0DC4=;
        b=f91O34gPth4VxegLN81VTyclEl6gdo805dTrf4atlZy1CZ+0i5pMHAFzosJL6NZ2wX
         ftnA3dDpLCj3gCZag2Q1tgNKrztRltxI3G2KfDjzi+yg/q67/bF73cX7UvRT7Fglszcp
         TFosrkV/tcao9asCpi5JapGHtPQgUfZQNx/dZl0A16NU84LIxiv4ISNrwx1ws3X5Q7FG
         qij2r0NtMno9Mq2mtdJCfKSMoUZ6SJ2hxaK6QbWSY97AXIjQN97OS/5HTmCWvU5jtMXY
         LEs9a1e+eU3AAKjTPNK5se9/vUFd1Sd+HPqlgCgJZ+IUrmvZphCXmZtaI3I2W1wf1IEd
         Zr/w==
X-Gm-Message-State: APjAAAWKm0d60/NcHys9c0e6pjWeV8nDCHFa9jf76npJ2klMNIyZOIcQ
        8KimHy9GzBjHyVI49Rih3G4IHNul2VoGklFPTj1uuw==
X-Google-Smtp-Source: APXvYqzd+TcmESt8dSevMJ24MEo4z4LNvcbauV1r1Id1E9/CXrpU0GUvOEVQEubjkyM1dRFh2E5eGC5q2ua8YIMUFFg=
X-Received: by 2002:ab0:2042:: with SMTP id g2mr8430889ual.19.1573814328587;
 Fri, 15 Nov 2019 02:38:48 -0800 (PST)
MIME-Version: 1.0
References: <20191112134808.23546-1-erosca@de.adit-jv.com> <20191112204952.GA2976@kunai>
 <CAPDyKFq8oVk26ruNA_R8HDXhMGKhDeHnL0q82xi40g1aeo109A@mail.gmail.com>
 <20191114113743.GA19656@vmlxhi-102.adit-jv.com> <CAPDyKFp5iqrFDM1EWnYBwFmQAiAA5FADDLAyuVVBgMu4Sx=x5w@mail.gmail.com>
 <20191114201514.GA3058@kunai> <CAPDyKFpbu0tCWyUHRjVySRF3QR6Hzd8MXA+RhNeCjED1nPtkYg@mail.gmail.com>
 <20191115101205.GB2227@kunai>
In-Reply-To: <20191115101205.GB2227@kunai>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 15 Nov 2019 11:38:12 +0100
Message-ID: <CAPDyKFps4GbHYA7LkVXhhXyG_wUxH9U-2giap2Y1Qdk2ssfmWg@mail.gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi_internal_dmac: Add MMC_CAP_ERASE to
 Gen3 SoCs
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Harish Jenny K N <harish_kandiga@mentor.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2019 at 11:12, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>
> > I think using a workqueue for scheduling a reset work with a timeout
> > of 5 s, as in your case.
>
> Sorry, I didn't get it. You think what exactly? Is it good / bad / ok
> for now / ok in general?

Sorry.

It's good for now!

If/when you start implementing support for HW busy detection, then you
need to adjust to the timeout value according to cmd->busy_timeout
from the core.

Kind regards
Uffe
