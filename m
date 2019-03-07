Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD32C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA0C2087C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="dsEIyU5H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfCGRun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:50:43 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33427 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbfCGRul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:50:41 -0500
Received: by mail-lf1-f68.google.com with SMTP id z23so12347987lfe.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 09:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nZoviCFVsTrCX9IAb32HfyhhfC36KNP7zZS1oreaM4w=;
        b=dsEIyU5HeO9ZMz1GCrF7yggqbQtLDND6+HjB3ncGRNtiHMUWJZwmGnKgbZ8sIutHcR
         dskHBpHMPXa2sSYmZEnkX0gS96MiVZJiRTIdPlyWMMQU37mfsWhpqPqWcZhcLWE1PMLZ
         s1zprCq/IXOTT3hyPthhx1cUgeSpE4Qp4aiqemSZVn7Cg8L2RNM2pxx9HtP77T+C5EBC
         Q9nO9hSyonc4uEdkiEY7d5CKbhC+OCGAFmC5EgI29oh+Vg2jT4A/6Z5nzXq/XpBwXIvV
         IEKs6gz35mlMXED+kdBcuv6DXarPEhdZqdxWhIaPHTlItk1pYrQGxqbwcLpmSI8ZHAhp
         p9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=nZoviCFVsTrCX9IAb32HfyhhfC36KNP7zZS1oreaM4w=;
        b=Vl4RIFJqziMnYV41+tukZ91oDL8no9XYbchOJFMfXVAnOQRP4HrtYd/54ei6FPakiE
         LPSCdBvtQZ45uvzqYjyp5L752YqhrxMgptLklqilBdzm6w+nyeXQ/7DaoeTINVwY9U8C
         QJMYxthZYGTw1c12oZPGeytJJNBheBxMmOQ2IxsTBtYwnV9fzGwQ2TqhCIKGokjF6aoK
         kcTfFmaJ62iGBz4UCIqkKQBmTorzOohRUliMohAEBbuMct33OcdwqgEtEyleughGm5UG
         Zhr81fY+hkbs5BBUW/3bseEWCeScgqq80doYHFyTiYBCIc2I5drfWMLD8pYJgM4aI5Ws
         EtiQ==
X-Gm-Message-State: APjAAAUs0qlBL6tjQ4Zs6swhwnvDiHXTFYokS6gox6Mn7Q0n9VIMbLCT
        JZMmkjUSiHq1ZZlznPQPtdtwaA==
X-Google-Smtp-Source: APXvYqwUfdL2B64HMbbv5KUItpYvJNq/QxaitnDeZpbDUyRlf6uJr2ZbbBn53anXL8Fkun1YIUI7qQ==
X-Received: by 2002:a19:4d08:: with SMTP id a8mr7725404lfb.14.1551981039808;
        Thu, 07 Mar 2019 09:50:39 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.80.179])
        by smtp.gmail.com with ESMTPSA id z22sm958466lfb.66.2019.03.07.09.50.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 09:50:39 -0800 (PST)
Subject: Re: [PATCH v8 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
To:     Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, bbrezillon@kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
References: <1548658158-5460-1-git-send-email-masonccyang@mxic.com.tw>
 <1548658158-5460-2-git-send-email-masonccyang@mxic.com.tw>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <0c54ee2c-016a-bc8e-33ae-fbd04191cc49@cogentembedded.com>
Date:   Thu, 7 Mar 2019 20:50:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1548658158-5460-2-git-send-email-masonccyang@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 01/28/2019 09:49 AM, Mason Yang wrote:

> Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
[...]
> diff --git a/drivers/spi/spi-renesas-rpc.c b/drivers/spi/spi-renesas-rpc.c
> new file mode 100644
> index 0000000..ea12017
> --- /dev/null
> +++ b/drivers/spi/spi-renesas-rpc.c
> @@ -0,0 +1,804 @@
[...]
> +static void rpc_spi_hw_init(struct rpc_spi *rpc)
> +{
> +	//
> +	// NOTE: The 0x260 are undocumented bits, but they must be set.
> +	//	RPC_PHYCNT_STRTIM is strobe timing adjustment bit,
> +	//	0x0 : the delay is biggest,
> +	//	0x1 : the delay is 2nd biggest,
> +	//	On H3 ES1.x, the value should be 0, while on others,
> +	//	the value should be 6.
> +	//
> +	regmap_write(rpc->regmap, RPC_PHYCNT, RPC_PHYCNT_CAL |
> +				  RPC_PHYCNT_STRTIM(6) | 0x260);
> +
> +	//
> +	// NOTE: The 0x1511144 are undocumented bits, but they must be set
> +	//       for RPC_PHYOFFSET1.
> +	//	 The 0x31 are undocumented bits, but they must be set
> +	//	 for RPC_PHYOFFSET2.
> +	//
> +	regmap_write(rpc->regmap, RPC_PHYOFFSET1, RPC_PHYOFFSET1_DDRTMG(3) |
> +		     0x1511144);
> +	regmap_write(rpc->regmap, RPC_PHYOFFSET2, 0x31 |
> +		     RPC_PHYOFFSET2_OCTTMG(4));
> +	regmap_write(rpc->regmap, RPC_SSLDR, RPC_SSLDR_SPNDL(7) |
> +		     RPC_SSLDR_SLNDL(7) | RPC_SSLDR_SCKDL(7));
> +	regmap_write(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD | RPC_CMNCR_SFDE |
> +		     RPC_CMNCR_MOIIO_HIZ | RPC_CMNCR_IOFV_HIZ |
> +		     RPC_CMNCR_BSZ(0));
> +}

   We clearly need runtime PM get/put() calls around this code. Otherwise,
we're dependant on U-Boot leaving the clocks enabled...

[...]

MBR, Sergei
