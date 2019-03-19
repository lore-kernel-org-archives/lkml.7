Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9719C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1F320857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TXqenXZv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfCSIE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 04:04:57 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:58788 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfCSIE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 04:04:56 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2J84sKO008815;
        Tue, 19 Mar 2019 03:04:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552982694;
        bh=aDmDzSrSExDnBwdH4otc2PbhgMjCC4qlDyEBRwy+iNk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=TXqenXZvsBw/lJLeD4wrhx4EVIA+oXCX4DlNKmHhS05O62slOwIWEI8GvaPRmPItP
         Ek9QQmSX8d10y6h1Fc2c2LA0iSOaT8iFQOk23/IZCwnJXjPHcS0u+6g74FpTO6yMzP
         A7LIigrdJayoUqImUJme16aBnv+wqYf0XD+owrRU=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2J84sms053474
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Mar 2019 03:04:54 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 19
 Mar 2019 03:04:53 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Tue, 19 Mar 2019 03:04:53 -0500
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2J84p7l002182;
        Tue, 19 Mar 2019 03:04:52 -0500
Subject: Re: [PATCH v3 1/2] mmc: sdhci: Make sdhci_send_command() public
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>
References: <20190319063533.12171-1-faiz_abbas@ti.com>
 <20190319063533.12171-2-faiz_abbas@ti.com>
 <53872d7f-9339-b288-4e48-a6164ee463c5@ti.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <1d9d2953-596c-f42f-10e0-dec94ccfda52@ti.com>
Date:   Tue, 19 Mar 2019 13:34:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <53872d7f-9339-b288-4e48-a6164ee463c5@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

On 19/03/19 1:28 PM, Kishon Vijay Abraham I wrote:
> Hi Faiz,
> 
> On 19/03/19 12:05 PM, Faiz Abbas wrote:
>> Make sdhci_send_command() public so that it can be called from platform
>> drivers.
> 
> This should be sdhci_finish_command here and also in subject
> How about using "mmc: sdhci: Export sdhci_finish_command()"?
>

My bad. Will update to "mmc: sdhci: Export sdhci_finish_command()" in
next version.

Thanks,
Faiz


