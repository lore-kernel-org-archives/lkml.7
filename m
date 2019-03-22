Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6335AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33448218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wIHxYFyQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbfCVOT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:19:59 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60980 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbfCVOT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:19:58 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2MEJmgp101820;
        Fri, 22 Mar 2019 09:19:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553264388;
        bh=UiaBTGs4Q86cxaqJOhZJ2bjFLSbe/pXqA11QhKJr5Ac=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=wIHxYFyQ4AUC3UsNP/HWQUYRWvdDtLcI3rOFas79SxmO+e5h2GT1cw9/Iieov8w2c
         3pFeQMDgtdZDf9Tg+4FJlTocArv8K+iCmYJ2NOS5vnfcD3VOw1NRm1pfFnCo2jQIFB
         IDvX2sNZR9gg+FFrbXd16WW0hyE7mnBOWXNr6cBU=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2MEJm8f058180
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Mar 2019 09:19:48 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 22
 Mar 2019 09:19:48 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Fri, 22 Mar 2019 09:19:47 -0500
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2MEJj5W016426;
        Fri, 22 Mar 2019 09:19:46 -0500
Subject: Re: [PATCH -next] mmc: sdhci-omap: Make sdhci_omap_reset static
To:     Yue Haibing <yuehaibing@huawei.com>, <adrian.hunter@intel.com>,
        <kishon@ti.com>, <ulf.hansson@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
References: <20190322141138.19244-1-yuehaibing@huawei.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <95463a45-6069-a186-dca0-28a1ab3f8e35@ti.com>
Date:   Fri, 22 Mar 2019 19:49:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190322141138.19244-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22/03/19 7:41 PM, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fix sparse warning:
> 
> drivers/mmc/host/sdhci-omap.c:788:6: warning:
>  symbol 'sdhci_omap_reset' was not declared. Should it be static?
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Faiz Abbas <faiz_abbas@ti.com>

Thanks,
Faiz
