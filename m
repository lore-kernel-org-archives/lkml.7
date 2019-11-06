Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C73C5DF64
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 04:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACBE22067B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 04:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573013833;
	bh=zsRfHQrQtnfc54A/CM8ZP89661pnhSCbCHe1FUEiTCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hS1sw5rlGiZ2XGl5ixKWwb3GFALuWuED7Su+muSS9j0o56fUcRDM9qdFlZpBN3UrO
	 YLml+OJ/ct+pL13uCd5P7Kpm+Rwo4EUDp1Y4RagM8tRdbmaogvCzPvqKQdEx5yVXi4
	 gaZDvvZGHLzypWMYPkD1USs+S5t86LSKAkP0TcrY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731239AbfKFERM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 23:17:12 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42065 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbfKFERM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 23:17:12 -0500
Received: by mail-ot1-f66.google.com with SMTP id b16so19691859otk.9;
        Tue, 05 Nov 2019 20:17:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pasjx8CSERkmvokF+MIWXBinQV2inOneX0DH/i8NKYE=;
        b=U+LJqdGjDkkNh+3qJ1z9xTR8oWWZJdxenpqDWaJpcBywxHrvKKcF5Jpt5jRd8jFLWU
         SUANNssHnY1UEXfH/4JuxBZ+ndX6Tcrz3nZ+4rqP9DzVKcrCZRXV0SEYq0a7uoH3UsqM
         ZM6p0xq4vqOffZn2gx7J6A/XqITbwgAT9YKiYzdXn/94Kixky+1HEqXEIx2DVhWRU+tA
         iAxl4ylykSA7kWo3Tkmvdrxf8zDkFZCqrrWTlEvAxfmLWknNihSd0auVBTORHrOCMtYp
         qxgnYrlfH8Y9XBbqGkFVbLC4Pxioox8rjHwFqVm0XEzPx2g4EepifuOd3zSCx612FGku
         QX4A==
X-Gm-Message-State: APjAAAVMXvtJpQOa1PBbpunGut38fyv/N4yJk2jRJ6QvyJeFVCu/bh6e
        nxAQ+Snb1sp98iHcFYjDDQ==
X-Google-Smtp-Source: APXvYqymW3STVwrnKyM7oB8B3KKofNBMHecjlu2u2+qn0yFU8UaxgzxpuvOLNAN28Z1FkkCBVB69Ew==
X-Received: by 2002:a05:6830:1e84:: with SMTP id n4mr262047otr.233.1573013829794;
        Tue, 05 Nov 2019 20:17:09 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e193sm837103oib.53.2019.11.05.20.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 20:17:09 -0800 (PST)
Date:   Tue, 5 Nov 2019 22:17:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chun-Hung Wu <chun-hung.wu@mediatek.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Pan Bian <bianpan2016@163.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wsd_upstream@mediatek.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] [3/3] dt-bindings: mmc: mediatek: Add document for
 mt6779
Message-ID: <20191106041708.GA26489@bogus>
References: <1572590582-11056-1-git-send-email-chun-hung.wu@mediatek.com>
 <1572590582-11056-3-git-send-email-chun-hung.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572590582-11056-3-git-send-email-chun-hung.wu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 02:43:02PM +0800, Chun-Hung Wu wrote:
> Add compatible node for mt6779 mmc
> 
> Change-Id: Id36a136a75e892c9360ec95c7f52db06f5b308a4
> CR-Id:
> Feature:

Remove these tags.

> Signed-off-by: Chun-Hung Wu <chun-hung.wu@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> index 8a532f4..0c9cf6a 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> @@ -12,6 +12,7 @@ Required properties:
>  	"mediatek,mt8173-mmc": for mmc host ip compatible with mt8173
>  	"mediatek,mt8183-mmc": for mmc host ip compatible with mt8183
>  	"mediatek,mt8516-mmc": for mmc host ip compatible with mt8516
> +	"mediatek,mt6779-mmc": for mmc host ip compatible with mt6779
>  	"mediatek,mt2701-mmc": for mmc host ip compatible with mt2701
>  	"mediatek,mt2712-mmc": for mmc host ip compatible with mt2712
>  	"mediatek,mt7622-mmc": for MT7622 SoC
> -- 
> 1.9.1
> 
