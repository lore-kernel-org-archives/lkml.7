Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2130DC43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 12:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73F6206BB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 12:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kGhXJihK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfEDMAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 08:00:21 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35769 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbfEDMAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 08:00:21 -0400
Received: by mail-lf1-f65.google.com with SMTP id j20so6176407lfh.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 05:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bVUZ/YdfIbEAyeXyxlZd8C1Dn3iXlSts8Rn7bzFJXgo=;
        b=kGhXJihKafot6irmobTIl6Oc/jaJTM7ilojeVby1fdeUoYY1bwyJyEkb/fkyPxsS4/
         kTevTY+CK++MYB+OpW/NTSerAKU2rgWWFs2K6XhP9dXhN1d/HGmybKLJb54DfeM3SNCx
         u5SOLWs3HwSZDiKzbJ55SvmB17Zv8nlf3Op6P6yDQrCi+QBLwRGAmG0iDB0AiJ3fAuNQ
         vJnkoCwP1yNvLBBUEDHEH8EnYehG045loHp7wED4F9xcYUCsy3gfmKlQyIluiAH3a/fq
         LbwWJC+sGQXQxYFKLltphezTZ18/M4FaSvSbsqUY2bIoFcpYuhOJ48I+nAR7W55F4pi2
         WSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bVUZ/YdfIbEAyeXyxlZd8C1Dn3iXlSts8Rn7bzFJXgo=;
        b=IwNVMi6qWTVAwMaXwgf8ChBHJUHycD2vX2Mpxe7NMEaGOlUvUM2vP+88w/K3f7RiLy
         2duRAg6IzMFZa7Lo+SY7i7XsreLc8bmhSgIYX07E9Pi7vFz/AXEbgkPRudO3UBcemX6n
         WGqD8xdgqWZv8LleKs6v6rb5sytqsk7lTJCfYv8TyGrDiTUTvzR8LsMuffEcFi8cTuF8
         Lp3/31txmwuEROB2n7DA8k0OrF4Kx20DTFlp88QdqrQrGMcJd5MTVPoNZovWGb7WpPTh
         9SJZDmSgQFP+dlG6U5tiwjIa1PSqos8+ZhnfXhVMB/j3olia1/artDo3sVHYTq0El4f0
         /qKg==
X-Gm-Message-State: APjAAAVz3RZFuC5xPcc39yn7SKyznFiHsCJTsYQDsemn1jpIsfcrotII
        sFSUtKC2SSUJBKJq2fN1IAB062Yzbi3+DvgCIsjB0w==
X-Google-Smtp-Source: APXvYqzHb3J2SQJgpBCRN+rySa3T5qo6CkgHRVTBI6q3LGfhjNT7Dye0M39QqMKy0La/eziTVGqnfSlDJ08oWBgpIEA=
X-Received: by 2002:ac2:51a1:: with SMTP id f1mr7143976lfk.129.1556971219802;
 Sat, 04 May 2019 05:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190504070318.56760-1-yuehaibing@huawei.com>
In-Reply-To: <20190504070318.56760-1-yuehaibing@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 4 May 2019 14:00:07 +0200
Message-ID: <CACRpkdaN+BeaKA91rvMJwJsSW2epEb1YJPzpvXoJ=+M=Ly-7tQ@mail.gmail.com>
Subject: Re: [PATCH -next] ARM: ixp4xx: Remove duplicated include from common.c
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Linus Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 4, 2019 at 8:53 AM YueHaibing <yuehaibing@huawei.com> wrote:

> Remove duplicated include.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Patch applied, thanks!

Yours,
Linus Walleij
