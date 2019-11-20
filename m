Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEEFC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A5120674
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TxFswCAt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732675AbfKTQKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 11:10:31 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:55300 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbfKTQKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 11:10:31 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAKGANhS096851;
        Wed, 20 Nov 2019 10:10:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574266223;
        bh=PkkB/UusRqrX8cEGflPCrwq3y6YZdf6Bfo9p/9HiqKk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=TxFswCAt93kFi2CJS1A5NzMYEjDMwFAkyUVJwhs749XcaQ/Gl9tWPtK2WqDF2C1wu
         Xb7vo0Ok5f2J5H0urxjqeFL8vVNb3jf5EH5eqvVtbJ3dasf0X6KRu1eLEu2wEVdr/F
         42wUh1i0TS4SW+HSp7WnMoBk7kRtkU+EbHczBgG8=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAKGAN0S053552
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Nov 2019 10:10:23 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 20
 Nov 2019 10:10:23 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 20 Nov 2019 10:10:23 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAKGALiR007784;
        Wed, 20 Nov 2019 10:10:22 -0600
Subject: Re: [PATCH v2] mmc: sdhci_am654: Add Support for Command Queuing
 Engine to J721E
To:     Adrian Hunter <adrian.hunter@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>
References: <20191118073609.22921-1-faiz_abbas@ti.com>
 <ea458eb9-f9a8-ab39-2df9-6284fef02105@intel.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <1cdaf572-02ee-d3d8-beb3-c90e1cfd89fa@ti.com>
Date:   Wed, 20 Nov 2019 21:41:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ea458eb9-f9a8-ab39-2df9-6284fef02105@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian,

On 20/11/19 1:29 PM, Adrian Hunter wrote:
> On 18/11/19 9:36 AM, Faiz Abbas wrote:
>> Add Support for CQHCI (Command Queuing Host Controller Interface)
>> for each of the host controllers present in TI's J721E devices.
>> Add cqhci_ops and a .irq() callback to handle cqhci specific interrupts.
>>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>> Reported-by: kbuild test robot <lkp@intel.com>
> 
> That "Reported-by" should not be there.
> 

The robot asked me to add the tag in its reply to v1. Not sure where
they wanted me to add it.

Thanks,
Faiz
