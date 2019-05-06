Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768CDC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 13:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D1A20675
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 13:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kalray.eu header.i=@kalray.eu header.b="Lyg2tqnp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfEFNlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 09:41:04 -0400
Received: from zimbra2.kalray.eu ([92.103.151.219]:33120 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfEFNlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 09:41:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 5E1B227E59D7;
        Mon,  6 May 2019 15:41:02 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 981cAAX-GEZG; Mon,  6 May 2019 15:41:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id DB8E327E59D8;
        Mon,  6 May 2019 15:41:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu DB8E327E59D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1557150061;
        bh=OADeaGAz0uYT8nrQHJE7xV25+MHIPpYEzjS7hX9kLgY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Lyg2tqnpiCgnNQPY5WQX+w281rq8W9T6Z47Chu1wjA3B+x/tjR7GSa6oSQH1Fkjl6
         OEhgnaZhtJnOJOktCEQj0k77/nl6hI1svSvjuTt5LaYrT4uo3eaMMPFLYbk3U0RTwN
         lSOv4j5zpQJC3OrXftYJkglhWDjeAsMNcIKCGxes=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FLou36KQFGDv; Mon,  6 May 2019 15:41:01 +0200 (CEST)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id BB7B827E59D7;
        Mon,  6 May 2019 15:41:01 +0200 (CEST)
Date:   Mon, 6 May 2019 15:40:57 +0200
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] usb: dwc2: Force 8bit UTMI width for Samsung Exynos SoCs
Message-ID: <20190506134057.wdkq4owexgzi4r2h@tellis.lin.mbt.kalray.eu>
References: <20190503204958.GA12532@kozik-lap>
 <CGME20190506130052eucas1p25afd4e15648e9efc6fd011e46081fbea@eucas1p2.samsung.com>
 <20190506130046.20898-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506130046.20898-1-m.szyprowski@samsung.com>
User-Agent: NeoMutt/20180716-1557-a6ba22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 06, 2019 at 03:00:46PM +0200, Marek Szyprowski wrote:
> Samsung Exynos SoCs require to force UTMI width to 8bit, otherwise the
> host side of the shared USB2 PHY doesn't work.
> 
> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
> Fixes: 707d80f0a3c5 ("usb: dwc2: gadget: Replace phyif with phy_utmi_width")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/usb/dwc2/params.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
> index 6900eea57526..9ece4affb9d4 100644
> --- a/drivers/usb/dwc2/params.c
> +++ b/drivers/usb/dwc2/params.c
> @@ -76,6 +76,7 @@ static void dwc2_set_s3c6400_params(struct dwc2_hsotg *hsotg)
>  	struct dwc2_core_params *p = &hsotg->params;
>  
>  	p->power_down = 0;
> +	p->phy_utmi_width = 8;

Nice catch.

I though that 8bits would be the default value, I am curious to know why it's not ny default at 8.

Thanks.


---
Jules

>  }
>  
>  static void dwc2_set_rk_params(struct dwc2_hsotg *hsotg)
> -- 
> 2.17.1
> 
