Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CA9C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 23:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEDED20854
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 23:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfD3XMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 19:12:18 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34884 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfD3XMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 19:12:18 -0400
Received: by mail-oi1-f195.google.com with SMTP id w197so12717625oia.2;
        Tue, 30 Apr 2019 16:12:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Kaz0HzSce5UNE/bdT7lOJbyMWjOGQSNQhXNQdmqdS0=;
        b=cQ5IywG2uJhiQCfZqVl1eYsmJJItNOjy9Dqoz5hB5W1qlOwglUCYXp7ZEiV+fxg6Qi
         3qN7Q5GPv1zFuhuBrA58BvPCak6tr1qsYO9S9aL2qz3ooU/z4N4zwvRP3kgrnRbn0L2A
         0thuzqHRY6ewMzet2ivXajl1UrrF43Oo4T/C4RnIRsVcnSnXXtybJr0dFavzeVWzGL9m
         W+mejUJSIZ4PC8fio4ShzdrBw4SPVxDFJ/yJl7sUvQv0ZYaDHqOtcCGjJXcKuzFpa4To
         xZOdgdhk5mx3OSFsAFIcSb4j8/p1oAJpvqRWAqXWD/vDrAirGsuF4eD1W+XUc8NU7qZF
         rpvQ==
X-Gm-Message-State: APjAAAVzssXweaZvLvy5skCpRK9/UEOG7wVlQk0/4Zd+u0MOr0PrCSYI
        r9C15YpjU16tBxVbjkdeM1qic0QTAzk=
X-Google-Smtp-Source: APXvYqzmU7J8Jyis0/HpmPawqrY+cd6LELrQPuOHWXXTQ7fuZCaHzNCH9tMw56lzVdYSKIKHoo0hEA==
X-Received: by 2002:aca:f4cf:: with SMTP id s198mr4598529oih.153.1556665937217;
        Tue, 30 Apr 2019 16:12:17 -0700 (PDT)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com. [209.85.167.182])
        by smtp.gmail.com with ESMTPSA id p8sm17018925oib.9.2019.04.30.16.12.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 16:12:16 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id y64so7167440oia.7;
        Tue, 30 Apr 2019 16:12:16 -0700 (PDT)
X-Received: by 2002:aca:4e83:: with SMTP id c125mr4539473oib.13.1556665936485;
 Tue, 30 Apr 2019 16:12:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190430051723.31345-1-yinbo.zhu@nxp.com>
In-Reply-To: <20190430051723.31345-1-yinbo.zhu@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Tue, 30 Apr 2019 18:12:05 -0500
X-Gmail-Original-Message-ID: <CADRPPNQ4RYhe5n_ZA_xrhG8VARsvV3cwVgnuinedb2VHKkDzbQ@mail.gmail.com>
Message-ID: <CADRPPNQ4RYhe5n_ZA_xrhG8VARsvV3cwVgnuinedb2VHKkDzbQ@mail.gmail.com>
Subject: Re: [PATCH v1] mmc: dt: add DT bindings for ls1028a eSDHC host controller
To:     Yinbo Zhu <yinbo.zhu@nxp.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Xiaobo Xie <xiaobo.xie@nxp.com>, "Y.b. Lu" <yangbo.lu@nxp.com>,
        Jiafei Pan <jiafei.pan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 12:16 AM Yinbo Zhu <yinbo.zhu@nxp.com> wrote:
>
> From: Yinbo Zhu <yinbo.zhu@nxp.com>

The patch title better to be "dt-bindings: mmc: ..."
>
> Add "fsl,ls1028a-esdhc" bindings for ls1028a eSDHC host controller
>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
> ---
>  .../devicetree/bindings/mmc/fsl-esdhc.txt          |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> index 99c5cf8..a7250b9 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> +++ b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> @@ -21,6 +21,7 @@ Required properties:
>         "fsl,ls1043a-esdhc"
>         "fsl,ls1046a-esdhc"
>         "fsl,ls2080a-esdhc"
> +       "fsl,ls1028a-esdhc"

Better to be alphabetical order.

>    - clock-frequency : specifies eSDHC base clock frequency.
>
>  Optional properties:
> --
> 1.7.1
>
