Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D99C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58CFF20C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437210AbfHIQap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 12:30:45 -0400
Received: from smtprelay0207.hostedemail.com ([216.40.44.207]:46645 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726556AbfHIQao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 12:30:44 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 4A2E98368EFA;
        Fri,  9 Aug 2019 16:30:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: part95_232f517601209
X-Filterd-Recvd-Size: 2195
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Fri,  9 Aug 2019 16:30:41 +0000 (UTC)
Message-ID: <dc0de0cd9a1e24477b20d563199e800b98d933f6.camel@perches.com>
Subject: Re: [PATCH v2 09/13] net: lpc-enet: fix printk format strings
From:   Joe Perches <joe@perches.com>
To:     Arnd Bergmann <arnd@arndb.de>, soc@kernel.org
Cc:     Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kbuild test robot <lkp@intel.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Date:   Fri, 09 Aug 2019 09:30:40 -0700
In-Reply-To: <20190809144043.476786-10-arnd@arndb.de>
References: <20190809144043.476786-1-arnd@arndb.de>
         <20190809144043.476786-10-arnd@arndb.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-09 at 16:40 +0200, Arnd Bergmann wrote:
> compile-testing this driver on other architectures showed
> multiple warnings:
> 
>   drivers/net/ethernet/nxp/lpc_eth.c: In function 'lpc_eth_drv_probe':
>   drivers/net/ethernet/nxp/lpc_eth.c:1337:19: warning: format '%d' expects argument of type 'int', but argument 4 has type 'resource_size_t {aka long long unsigned int}' [-Wformat=]
> 
>   drivers/net/ethernet/nxp/lpc_eth.c:1342:19: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'dma_addr_t {aka long long unsigned int}' [-Wformat=]
> 
> Use format strings that work on all architectures.
[]
> diff --git a/drivers/net/ethernet/nxp/lpc_eth.c b/drivers/net/ethernet/nxp/lpc_eth.c
[]
> @@ -1333,13 +1333,14 @@ static int lpc_eth_drv_probe(struct platform_device *pdev)
>  	pldat->dma_buff_base_p = dma_handle;
>  
>  	netdev_dbg(ndev, "IO address space     :%pR\n", res);
> -	netdev_dbg(ndev, "IO address size      :%d\n", resource_size(res));
> +	netdev_dbg(ndev, "IO address size      :%zd\n",
> +			(size_t)resource_size(res));

Ideally all these would use %zu not %zd


