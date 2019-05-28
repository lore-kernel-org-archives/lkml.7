Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19705C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2001208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BvlVraSU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfE1Ib7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 04:31:59 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54614 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfE1Ib6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 04:31:58 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4S8Vumh056178;
        Tue, 28 May 2019 03:31:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559032316;
        bh=gy0+MpIjsHBi+VjtC+KdgiXRcp0cL4FeX5nZ37esCuY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=BvlVraSUdGqPuKpKrzWv3wORwC80YMWEJC7yTYyNlcY5UlRHPWrb62NZxbyxMCMS5
         krf62cec1PNbzv78ssEV0dV81ZJ6UgS6bZ9QzGzVkf17dPCAbYUXp48apcwdWCQ/98
         MNnBcVhyiIvIpbgH2JUkLHusZ5HPFWU//r4rifm4=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4S8VuXb120052
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 May 2019 03:31:56 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 28
 May 2019 03:31:55 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 28 May 2019 03:31:55 -0500
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4S8Vp6d072132;
        Tue, 28 May 2019 03:31:52 -0500
Subject: Re: [PATCH v2 3/3] mmc: sdhci_am654: Fix SLOTTYPE write
To:     Adrian Hunter <adrian.hunter@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>
References: <20190510034228.32211-1-faiz_abbas@ti.com>
 <20190510034228.32211-4-faiz_abbas@ti.com>
 <0662a705-1991-e854-21a4-4ff6b5533f13@intel.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <68fd3e6e-666e-2ebf-04c9-8cb310f1404a@ti.com>
Date:   Tue, 28 May 2019 14:02:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0662a705-1991-e854-21a4-4ff6b5533f13@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On 10/05/19 11:28 AM, Adrian Hunter wrote:
> On 10/05/19 6:42 AM, Faiz Abbas wrote:
>> In the call to regmap_update_bits() for SLOTTYPE, the mask and value
>> fields are exchanged. Fix this. This didn't have any affect on the
>> driver because this was a NOP and it was taking the correct value from
>> the bootloader.
>>
>> Cc: stable <stable@vger.kernel.org>
> 
> Except that it doesn't apply to stable because of patch 1.  Maybe make this
> the first patch.
> 

Ok. Sending v3 with this as first patch.

Thanks,
Faiz
