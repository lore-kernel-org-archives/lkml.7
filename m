Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A70C4CEC9
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 03:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C05A218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 03:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="U4MnfKVn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PQg7i8Ry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388575AbfISDNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 23:13:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49348 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfISDNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 23:13:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E1E536141B; Thu, 19 Sep 2019 03:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568862794;
        bh=5c4EEY9e496QRqcaNIUVj0fFt3RL7hscaClTX1tA/5A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U4MnfKVnZQn6cE6afDt7Mu7sg9Vo/0zyMkQo8/Q8BRLT0bqtLfJ0NSGrEHbfGgl8o
         fZ1UN8gzBPJnba5+e2NHWn1RP7h42x0Dp6/L0s/3x0kThvjAg3K7pBPpjhQwxeV5Wy
         KiWhpnkpupdBOFftXZeFd4iGaMNZrxxZLXE5YUUE=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id A0E7B6050D;
        Thu, 19 Sep 2019 03:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568862793;
        bh=5c4EEY9e496QRqcaNIUVj0fFt3RL7hscaClTX1tA/5A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PQg7i8Ry3nOvvVZQpC84trh2awQGzVz8UPG1tMskVpLBxYsKTykauLYjIZ8oJt+Ui
         zLzqH+gUpVogEESHfe0BPM6OVZf+HUDOHi1jXbH0kB5jWZ+ZiqqLHxeH6RJ8QtEc85
         eSQQBqtJeXem8t85fH4RyKniVhr4lFTRxkq0vngo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 19 Sep 2019 08:43:13 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Will Deacon <will@kernel.org>, bjorn.andersson@linaro.org,
        iommu@lists.linux-foundation.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCHv6 3/3] iommu: arm-smmu-impl: Add sdm845 implementation
 hook
In-Reply-To: <5d82d294.1c69fb81.23c8c.8c61@mx.google.com>
References: <cover.1568712606.git.saiprakash.ranjan@codeaurora.org>
 <1513424ecec891d19c1aa3c599ec67db7964b6b2.1568712606.git.saiprakash.ranjan@codeaurora.org>
 <5d82d294.1c69fb81.23c8c.8c61@mx.google.com>
Message-ID: <68913df77d45fc70f7cf475bfd0f558a@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-19 06:27, Stephen Boyd wrote:
> Quoting Sai Prakash Ranjan (2019-09-17 02:45:04)
>> diff --git a/drivers/iommu/arm-smmu-impl.c 
>> b/drivers/iommu/arm-smmu-impl.c
>> index 3f88cd078dd5..d62da270f430 100644
>> --- a/drivers/iommu/arm-smmu-impl.c
>> +++ b/drivers/iommu/arm-smmu-impl.c
>> @@ -9,7 +9,6 @@
>> 
>>  #include "arm-smmu.h"
>> 
>> -
>>  static int arm_smmu_gr0_ns(int offset)
>>  {
>>         switch(offset) {
> 
> Why is this hunk still around?

I remember correcting this in previous version but somehow slipped in 
this version. Will correct it.

> 
>> diff --git a/drivers/iommu/arm-smmu-qcom.c 
>> b/drivers/iommu/arm-smmu-qcom.c
>> new file mode 100644
>> index 000000000000..24c071c1d8b0
>> --- /dev/null
>> +++ b/drivers/iommu/arm-smmu-qcom.c
>> @@ -0,0 +1,51 @@
> [...]
>> +struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device 
>> *smmu)
>> +{
>> +       struct qcom_smmu *qsmmu;
>> +
>> +       qsmmu = devm_kzalloc(smmu->dev, sizeof(*qsmmu), GFP_KERNEL);
>> +       if (!qsmmu)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       qsmmu->smmu = *smmu;
>> +
>> +       qsmmu->smmu.impl = &qcom_smmu_impl;
>> +       devm_kfree(smmu->dev, smmu);
> 
> This copy is interesting but OK I guess cavium does it.
> 

This is from nvidia impl since Robin pointed me at its implementation.

>> +
>> +       return &qsmmu->smmu;
>> +}

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
