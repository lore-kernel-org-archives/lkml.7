Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687C3C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 22:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34CFE20825
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 22:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="c8YCsFOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfEGWqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 18:46:45 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43058 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfEGWqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 18:46:44 -0400
Received: by mail-ed1-f67.google.com with SMTP id w33so17894468edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 15:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2SBXkPPsS90MxklCe6MIGlkttGdHW3kI9AU6dDeoWq0=;
        b=c8YCsFOL5XUurB/wLU01FUTlJ+LmbsoTAONIDSv6Ve2y9sfQIO00JcBoneTawrU37S
         ZxHXBrqZPJHAB7Y9fHXTTthRpBiTxbWYVk+FE08Jp0WYjYvYKAl5oBOeeH4MtBg/3L0C
         h0QAqHEOXzezLEUlvcU8JoSmAFNwDCBsNmcWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2SBXkPPsS90MxklCe6MIGlkttGdHW3kI9AU6dDeoWq0=;
        b=mNXOg1wAAelQ9yrK6KB8UfzuAjO0gZ+wg+bGVC3TxKTLsX+QrJBtPePUTNvDFLwaJq
         hQudmAka0VmC3r8XHq2IBfr6Kchqmv5nXZoEUbCx6QvWyHM7lUJ3ccsYPxqHu4MpVRTe
         9rRRFdWYV9odMOezf9+ogT6lr6EtDtMk9cDPqyS6PjvOynemyDuAb67hqbQ0R/C1Ktn2
         1+5QJuxhMAc43L1qWGBVmyjWlp9pKHPpUqRAvNJ2Ko4QdPVWDNqAQK7f9qNTArCKb2He
         wTr/aU4WlF1aguP0wqDcwPes7InzxS27GMje+Pml3mBcMSyJsRvTp5ZySvAYlQUda6QL
         kfnA==
X-Gm-Message-State: APjAAAVWHB/0AagJqm/fKIIV5Y6CfBHtMLLe3TOk0iKjT67o065dXPfD
        Dq5XsUn81IJ2SF/Zj13ZJLjXQBCABjOPEYsJ
X-Google-Smtp-Source: APXvYqyXCGYgKhd7HiuSIvjEImJkx/UgMafy843ubjLvtfYY0p7CumAUjx/69TyceblENiM727jj+g==
X-Received: by 2002:a50:c201:: with SMTP id n1mr35712206edf.244.1557269202927;
        Tue, 07 May 2019 15:46:42 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id s53sm4603529edb.20.2019.05.07.15.46.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 15:46:41 -0700 (PDT)
Subject: Re: [PATCH 2/2] mmc: sdhci-iproc: Set NO_HISPD bit to fix HS50 data
 hold time problem
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Trac Hoang <trac.hoang@broadcom.com>
References: <20190506170115.10840-1-scott.branden@broadcom.com>
 <20190506170115.10840-3-scott.branden@broadcom.com>
 <673b3d25-0256-9cd7-c89a-673546e69f3a@intel.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <293b4f12-c74f-35fe-80d7-fdb25405e499@broadcom.com>
Date:   Tue, 7 May 2019 15:46:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <673b3d25-0256-9cd7-c89a-673546e69f3a@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On 2019-05-06 11:31 p.m., Adrian Hunter wrote:
> On 6/05/19 8:01 PM, Scott Branden wrote:
>> From: Trac Hoang <trac.hoang@broadcom.com>
>>
>> The iproc host eMMC/SD controller hold time does not meet the
>> specification in the HS50 mode.  This problem can be mitigated
>> by disabling the HISPD bit; thus forcing the controller output
>> data to be driven on the falling clock edges rather than the
>> rising clock edges.
>>
>> Fixes: f5f968f2371c ("mmc: sdhci-iproc: suppress spurious interrupt with Multiblock read")
> Is this fixes tag correct, because it doesn't seem related.  Maybe explain
> that in the commit message.

I chose this tag to assist stable kernel maintainers so that the change 
does not produce merge conflicts backporting to older kernel versions.

In reality, the timing bug existed since the driver was first introduced 
but there is no need for this driver to be supported in kernel versions 
that old.

Do you want me to add such to the commit message?

>
>> Signed-off-by: Trac Hoang <trac.hoang@broadcom.com>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>> ---
>>   drivers/mmc/host/sdhci-iproc.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
>> index 9d4071c41c94..2feb4ef32035 100644
>> --- a/drivers/mmc/host/sdhci-iproc.c
>> +++ b/drivers/mmc/host/sdhci-iproc.c
>> @@ -220,7 +220,8 @@ static const struct sdhci_iproc_data iproc_cygnus_data = {
>>   
>>   static const struct sdhci_pltfm_data sdhci_iproc_pltfm_data = {
>>   	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
>> -		  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
>> +		  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 |
>> +		  SDHCI_QUIRK_NO_HISPD_BIT,
>>   	.quirks2 = SDHCI_QUIRK2_ACMD23_BROKEN,
>>   	.ops = &sdhci_iproc_ops,
>>   };
>>
