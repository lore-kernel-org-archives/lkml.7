Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295A0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 05:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC78E20811
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 05:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ffz2YTlR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfCZFVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 01:21:19 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]:37254 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfCZFVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 01:21:19 -0400
Received: by mail-qt1-f181.google.com with SMTP id z16so13196696qtn.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 22:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MG9Vuccji97pBaK+2+LScrYML+yUtZuNzJj7SYuYcOM=;
        b=Ffz2YTlRoY/koxP05ABhTVLsed/t4LLoEbUtbbZcJFjQjR3DIgp2/ISiDJOmpBNmb2
         68+2fK2/JjQrz+yhE6OYVid+9/uGPzjaxiEUerGOuaEfcgTpM8WCuykOfDe9ThJx+E6T
         /Zti5N+nfqC0hZ0jAbHvOp58+ezgNy5aWeX9RfoCoH5/TO+WsqwqzAY/1j2OldTI6P0w
         ZfROOUILlYxQ3N8QfUdnyiknHD2BESUE4X4gCJ4eYM+OGAMcWtcFs3JasaTxie/3OfJy
         AufZbw+MYn2RWKSj0CByjJYZ2eTV39H6ThRJ2wDnUnlhTe0e60cXPyTAl1tEKkVqnLbi
         DDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MG9Vuccji97pBaK+2+LScrYML+yUtZuNzJj7SYuYcOM=;
        b=CS2NvlnOil1fISp9UEfbb+ryiwHKtr3B34RvxFn+79NRiIdzPGUQMgR9YG7GJVo1n6
         e4MmKxO8Ir9331bBs9Emgfa3K8HuXvMXN1SJP2BYq6EOQ4f2jjsN5Ko7GcokE3COVDCj
         2mrJL0+53jxFzrkM1Xao26jpr7YFeRn+AtQVJpbhCF90YdFir3HUnbdewH95X+ryrtMj
         DARte71M6QaI1Si6WslsNGKF+DYXUUsiUYWT8ICNo8jt6byDtn/GhGNTAkqMZ9BrbSTM
         ZGVgKKmkM/hbrOrkxKT88qyUWooSw3rbb0vHz9XSuzJ9cCTTSeP/lU5HwJkUXOCLhs88
         zF6Q==
X-Gm-Message-State: APjAAAVb5kmlElAph9m18X2waW+JUEd+aunuEewBMO84D87G7Ly5UIjq
        5UVlwnn6zhEys/72Jv2YSiJ/3QAb8a1fTcA1rAHfWw==
X-Google-Smtp-Source: APXvYqyVYpNtfr8A+h3UJy8Z+X6SJZJZS1x3274RwnQq7MNyAUm5z7u3J8wLCiHDQGM/rnAeEL+N3vMJJMxnhx+OETc=
X-Received: by 2002:ac8:464b:: with SMTP id f11mr24632616qto.276.1553577677909;
 Mon, 25 Mar 2019 22:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com> <20190325212450.25865-1-joe@perches.com>
In-Reply-To: <20190325212450.25865-1-joe@perches.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 26 Mar 2019 10:51:06 +0530
Message-ID: <CAP245DWGYZW_vnO=vAGrGJ1dUbq_Y-znpgfO=oR6m1qRoRu+Ww@mail.gmail.com>
Subject: Re: Bad file pattern in MAINTAINERS section 'ARM/QUALCOMM SUPPORT'
To:     Joe Perches <joe@perches.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 2:54 AM Joe Perches <joe@perches.com> wrote:
>
> A file pattern line in this section of the MAINTAINERS file in linux-next
> does not have a match in the linux source files.
>
> This could occur because a matching filename was never added, was deleted
> or renamed in some other commit.
>
> The commits that added and if found renamed or removed the file pattern
> are shown below.
>
> Please fix this defect appropriately.

<snip>

>         2008    F:      drivers/mfd/ssbi.c
>         2009    F:      drivers/mmc/host/mmci_qcom*
> -->     2010    F:      drivers/mmc/host/sdhci_msm.c

> No commit with file pattern 'drivers/mmc/host/sdhci_msm.c' was found

I've sent a patch to fix the typo in the filename. Thanks for reporting.

Regards,
Amit
