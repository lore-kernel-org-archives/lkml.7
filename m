Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F492C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 08:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A2B02087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 08:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lsO3rgsE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733174AbfCAILj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 03:11:39 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52036 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbfCAILj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 03:11:39 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x218BYkV020508;
        Fri, 1 Mar 2019 02:11:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551427894;
        bh=RlHIViT63fHFLN7Kx1sLEZfBj4ytWCwufLaMNuXoYqw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=lsO3rgsEB3CxzfDRitGdbx0PLgmefKzBPqgY/S/r9VCgcNB+qNlWxtpIyTcPg/RZG
         huGoKe1HQ9kGshT5YYa81cxB1Nz48SVfY/wmFt4A+s1nezuIcEflWsY6MVWDHh1HqF
         Xr+a3ljJTN3XwslPbx3WLoHt8QGSqL/r2Wi1eXrI=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x218BYBW102431
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Mar 2019 02:11:34 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 1
 Mar 2019 02:11:33 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 1 Mar 2019 02:11:33 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x218BVGV026339;
        Fri, 1 Mar 2019 02:11:31 -0600
Subject: Re: [PATCH 2/2] mmc: sdhci-omap: Don't finish_mrq() on a command
 error during tuning
To:     kbuild test robot <lkp@intel.com>
CC:     <kbuild-all@01.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <ulf.hansson@linaro.org>, <kishon@ti.com>,
        <adrian.hunter@intel.com>
References: <20190226161606.18569-3-faiz_abbas@ti.com>
 <201903011552.lYOpBJe2%fengguang.wu@intel.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <caa90cb6-a862-a6da-04ed-386f96b1f4b9@ti.com>
Date:   Fri, 1 Mar 2019 13:44:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <201903011552.lYOpBJe2%fengguang.wu@intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01/03/19 12:52 PM, kbuild test robot wrote:
> Hi Faiz,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on ulf.hansson-mmc/next]
> [also build test ERROR on v5.0-rc8 next-20190228]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Faiz-Abbas/Fixes-for-command-errors-during-tuning/20190228-083200
> base:   git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git next
> config: ia64-allmodconfig (attached as .config)
> compiler: ia64-linux-gcc (GCC) 8.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=8.2.0 make.cross ARCH=ia64 
> 
> All errors (new ones prefixed by >>):
> 
>    ERROR: "ia64_delay_loop" [drivers/spi/spi-thunderx.ko] undefined!
>    ERROR: "__sw_hweight8" [drivers/net/wireless/mediatek/mt76/mt76.ko] undefined!
>    ERROR: "ia64_delay_loop" [drivers/net/phy/mdio-cavium.ko] undefined!
>>> ERROR: "sdhci_cmd_err" [drivers/mmc/host/sdhci-omap.ko] undefined!
>>> ERROR: "sdhci_finish_command" [drivers/mmc/host/sdhci-omap.ko] undefined!

Looks like EXPORT_SYMBOL_GPL is required here. Will add in v2.

Thanks,
Faiz
