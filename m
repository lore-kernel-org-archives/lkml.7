Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E007EC2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B755321D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Y5xdGVPB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbfLKNT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:19:59 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:46080 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbfLKNT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 08:19:59 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBBDJZFs022482;
        Wed, 11 Dec 2019 07:19:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576070375;
        bh=SneIKucDStL7XjaHAXLVsmrbsFw7S1ualygCTQqG1fo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Y5xdGVPBEo5iPg153EuG5jhN9vmr2Juf7963kINyY67/i81NE7smeYNzpxRDz/440
         zxBHnLZyCbPHdWxxB0wC7GKK3tuzpsqHxIQAnFA5szEYT/KYZXUrNQ5lZtjqxsyt22
         p8VG8ZQbaNUheItICIrwVl9m0ZDa8jLdsMO3r4+E=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBBDJZ25026852
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Dec 2019 07:19:35 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 11
 Dec 2019 07:19:35 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 11 Dec 2019 07:19:35 -0600
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBBDJV99040372;
        Wed, 11 Dec 2019 07:19:32 -0600
Subject: Re: [PATCH 1/2] net: ethernet: ti: select PAGE_POOL for switchdev
 driver
To:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>
CC:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20191211125643.1987157-1-arnd@arndb.de>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <571bfdbd-accc-d702-c1d0-1fd27cdffb47@ti.com>
Date:   Wed, 11 Dec 2019 15:19:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191211125643.1987157-1-arnd@arndb.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/12/2019 14:56, Arnd Bergmann wrote:
> The new driver misses a dependency:
> 
> drivers/net/ethernet/ti/cpsw_new.o: In function `cpsw_rx_handler':
> cpsw_new.c:(.text+0x259c): undefined reference to `__page_pool_put_page'
> cpsw_new.c:(.text+0x25d0): undefined reference to `page_pool_alloc_pages'
> drivers/net/ethernet/ti/cpsw_priv.o: In function `cpsw_fill_rx_channels':
> cpsw_priv.c:(.text+0x22d8): undefined reference to `page_pool_alloc_pages'
> cpsw_priv.c:(.text+0x2420): undefined reference to `__page_pool_put_page'
> drivers/net/ethernet/ti/cpsw_priv.o: In function `cpsw_create_xdp_rxqs':
> cpsw_priv.c:(.text+0x2624): undefined reference to `page_pool_create'
> drivers/net/ethernet/ti/cpsw_priv.o: In function `cpsw_run_xdp':
> cpsw_priv.c:(.text+0x2dc8): undefined reference to `__page_pool_put_page'
> 
> Other drivers use 'select' for PAGE_POOL, so do the same here.
> 
> Fixes: ed3525eda4c4 ("net: ethernet: ti: introduce cpsw switchdev based driver part 1 - dual-emac")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/net/ethernet/ti/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
> index a46f4189fde3..bf98e0fa7d8b 100644
> --- a/drivers/net/ethernet/ti/Kconfig
> +++ b/drivers/net/ethernet/ti/Kconfig
> @@ -63,6 +63,7 @@ config TI_CPSW_SWITCHDEV
>   	tristate "TI CPSW Switch Support with switchdev"
>   	depends on ARCH_DAVINCI || ARCH_OMAP2PLUS || COMPILE_TEST
>   	depends on NET_SWITCHDEV
> +	select PAGE_POOL
>   	select TI_DAVINCI_MDIO
>   	select MFD_SYSCON
>   	select REGMAP
> 

Thank you.
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
Best regards,
grygorii
