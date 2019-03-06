Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC28EC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B7BB206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yKfLFYEG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbfCFKPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:15:09 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47150 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730122AbfCFKPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:15:08 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x26AF6dT100021;
        Wed, 6 Mar 2019 04:15:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551867306;
        bh=C35oYULDiTx/u26FO8eiZsUTeaNDy96uknmLuDnV7xo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=yKfLFYEGt3QOqFdXDPb67CZwidKBa70L+7cQv12xZh1AjDyolOc4VFy/ljcsQ6sgm
         BEcBfg2ko7mQ8am2JM6hEz7/GY4E+7pludtsASCo7IbGVKkvlMu4YZawYei/3BpFfz
         Xgd4yhFsYLswDPS8lrdzA9THNLBGBz22jXoFVwgk=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x26AF6lm112545
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Mar 2019 04:15:06 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 6
 Mar 2019 04:15:05 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 6 Mar 2019 04:15:05 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x26AF32a016239;
        Wed, 6 Mar 2019 04:15:04 -0600
Subject: Re: [PATCH v2 0/2] Fixes for command errors during tuning
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <kishon@ti.com>,
        <adrian.hunter@intel.com>
References: <20190301083824.23918-1-faiz_abbas@ti.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <e5fb69c2-72a4-4b82-ea65-e0b314fdf28f@ti.com>
Date:   Wed, 6 Mar 2019 15:48:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190301083824.23918-1-faiz_abbas@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01/03/19 2:08 PM, Faiz Abbas wrote:
> These patches fix the following error message in dra7xx boards:
> 
> [4.833198] mmc1: Got data interrupt 0x00000002 even though no data
> operation was in progress.
> 
> Tested with 100 times boot tests on dra71x-evm, dra72x-evm and
> dra7xx-evm.
> 
> v2:
> Added EXPORT_SYMBOL_GPL for sdhci_cmd_err and sdhci_send_command to fix
> errors when built as module.
> 
> Faiz Abbas (2):
>   mmc: sdhci: Add platform_cmd_err() to sdhci_ops
>   mmc: sdhci-omap: Don't finish_mrq() on a command error during tuning
> 
>  drivers/mmc/host/sdhci-omap.c | 24 +++++++++++++++++++++
>  drivers/mmc/host/sdhci.c      | 40 +++++++++++++++++++++++------------
>  drivers/mmc/host/sdhci.h      |  4 ++++
>  3 files changed, 54 insertions(+), 14 deletions(-)
>

Gentle ping.

Thanks,
Faiz

