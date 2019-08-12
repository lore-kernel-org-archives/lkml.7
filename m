Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33032C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0181420820
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yaHiSpqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbfHLLAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 07:00:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36289 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbfHLLAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 07:00:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id r3so10430699wrt.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 04:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Se9XSbsfGDt4BhyzlQIMi1S9/MkvfhBPx11WicajSSg=;
        b=yaHiSpqBDdc2sT6zI2Dw8zIEtpSIuQSkOCCSmj9RJNlb1WEg3hBK3DieiAioZ8alKu
         AhP6xz8HC1xq2zeOzZD/CESJhRrdOgr9LS9ALNZnKZ7qQmpeLUV9bDwnT3EpLlwruIiP
         qw6Wfo9LBJzqQuQkLSFwdLolV8LwmnGKEdztwiHvhxo4Su+Amv+FnsR+5zM2D+cajBpc
         ylXscLIIU6eUjTydGSw0LQX8ETWkvZ56eeYt1TiS0+Pe7xUOVQiHuRDq1jqfF+s8ugmx
         Yb3gupA+zwYIsrVaxjBkVmzYbfHGadHGrRwNto9vTAoF1Gi8UzYRJPde3HbA0jbocbzQ
         ck9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Se9XSbsfGDt4BhyzlQIMi1S9/MkvfhBPx11WicajSSg=;
        b=EhRAUOx4kqJbyFlKfebM1kA61SJXi8UUUFLw0n2tQdX1fFPFd+oMF3itIBAjz/uLSv
         TpRkC4pKYeArIpabrbNozWOGm2vsLOrmLmppON9oekkedeH+9YFT+P9V2lCrA1lmrMmI
         m5N0UfiHqz1R3MYN4Jp9IhFr2VLRWdhOdp91InAgptqVxQSYrypzT4KOBWkHOD7Mn0n4
         0IDAExjmyL/XqGmVgU3J0oxegFH+tc3UFnuMxC+ez4rGbyfg3ohpxYBGEnByb9qGlbmN
         MsKHFNa1KDhCzhDiFVNj3oFUHqY9wCLpz2hhTVK2HBNaHtgaO2KtAJv/Z1czVQD8TbKx
         SZkA==
X-Gm-Message-State: APjAAAUDkJLITA3PCwkQKW/7xWy4w7Kj6Y70JkkhR1Y0n9Oi9Di9cMNi
        UHK6HWr9nt0AoXE8a+kLG6m5dw==
X-Google-Smtp-Source: APXvYqz8c1NJgqCLXi1ZOgbjqMY0Kt0jc3i39Y6I1YxE2q8hdoWNcdXIgZA0cAg94/5QZFrH+80nhg==
X-Received: by 2002:adf:dc51:: with SMTP id m17mr41748135wrj.256.1565607599334;
        Mon, 12 Aug 2019 03:59:59 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id a81sm5608087wma.3.2019.08.12.03.59.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 03:59:58 -0700 (PDT)
Date:   Mon, 12 Aug 2019 11:59:57 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Fontana <rfontana@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, srv_heupstream@mediatek.com
Subject: Re: [PATCH v4 02/10] mfd: mt6397: extract irq related code from core
 driver
Message-ID: <20190812105957.GP26727@dell>
References: <1564982518-32163-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1564982518-32163-3-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1564982518-32163-3-git-send-email-hsin-hsiung.wang@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Aug 2019, Hsin-Hsiung Wang wrote:

> In order to support different types of irq design, we decide to add
> separate irq drivers for different design and keep mt6397 mfd core
> simple and reusable to all generations of PMICs so far.
> 
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>  drivers/mfd/Makefile            |   3 +-
>  drivers/mfd/mt6397-core.c       | 146 --------------------------------
>  drivers/mfd/mt6397-irq.c        | 181 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/mt6397/core.h |   9 ++
>  4 files changed, 192 insertions(+), 147 deletions(-)
>  create mode 100644 drivers/mfd/mt6397-irq.c

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
