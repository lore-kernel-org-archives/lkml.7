Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38B2C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A943A2186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwUObCh1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731277AbfDEOO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:14:56 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34374 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfDEOO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:14:56 -0400
Received: by mail-lf1-f67.google.com with SMTP id y18so4558339lfe.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 07:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gxU2FY2kZ8IsLt8owqYy3xpE4ENl/vxpPA7w2YZ5iPg=;
        b=SwUObCh1N1Bxlh+eEHR9ZJbj45Db8uU5E9zsW87h1TdeWKKynRCY188vlrklaYJ3ox
         EKrUxi3R+3z+oeY+/v5G2xWIF9Mo5c5LGacdnX4X4Ejl+MWuYzyvNs14GsiOAmxCWVog
         lvJbwGyoLORrDruEYS1JhScbrUJFRzT7TltaNthxYp0J7HnaFiKVgUnn3RnJ7D7ohw3e
         mkbDHsBti2OiathRL/amX+ePlV7V+kCNUDNjHkAdIrPDJYb0NUBQW+B4bE3HNVttlFnA
         Tb40CAsPx6z34+oR96CEqywEFAuUtuSlKCsRTFba2hwjfKtMPTUDWkoGPqHh6Y87NCb7
         g03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gxU2FY2kZ8IsLt8owqYy3xpE4ENl/vxpPA7w2YZ5iPg=;
        b=Dns0QG6ihukrz+R1JA1wBTxAxvqL9rdP3t95N7/JTsv1uaB4kDNJYcX9A1aVS11UAv
         xK5k5m/rRnxpmkhYjqiIODRUN6ev3Q0AOpLdygbuapQm3EJ/4jyoRZZxKLLUtypSRTtV
         vB2ZnSwKqQCbX9ohqAjHg2tQwV+q90B/J2esYPBdDX9TWg1ODLUg3yyZIqyTE7ptafd/
         4YloxBwOGZ69p8vCQquk5C/9BTUcMe8IWW/GIiO8AUBxEy5gJp8IcmIjvWj+O9luHBww
         fDzatWXs6NwJ3AtfyUUakyTU+DtNc96K92inIPHBAm3cNiMtKGsH4wqTtHsYY+4/NcCZ
         QkPA==
X-Gm-Message-State: APjAAAVm/NVjSsE3QPyB2yJjTWPJQ1ioDFsrPJhPMekxxg/cYrq3qMfq
        nYDfH1lNtMWC4fWfN1iTCZI6IhoKI1oLx+p56Q8=
X-Google-Smtp-Source: APXvYqy67c/xCT1LxgPkzlAwXvOKs07xkVo/+jjCvrgjRJNfbfqCsVA+128xjwQ+hjCzgVtO4DUPgVq+FsRxlBPI8Bo=
X-Received: by 2002:a19:40c8:: with SMTP id n191mr6852582lfa.22.1554473693916;
 Fri, 05 Apr 2019 07:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190401022413.6682-1-andrew.smirnov@gmail.com> <20190401022413.6682-4-andrew.smirnov@gmail.com>
In-Reply-To: <20190401022413.6682-4-andrew.smirnov@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 5 Apr 2019 11:14:42 -0300
Message-ID: <CAOMZO5Cfx8-aQ8kauEBtBMzQLCfJZWN6cRjaCgsbo51gtFeuLg@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] arm64: dts: imx8mq: Combine PCIE power domains
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 11:25 PM Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
>
> According to NXP's FAE feedback and a comment in ATF firmware, PCIE1
> and PCIE2 power domains can't really be used independently. Due to
> shared reset line both power domains have to be turned on at the same
> time. Account for that quirk by combining PCIE power domains into a
> single 'pgc_pcie' power domain.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
