Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43565C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB882147A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRY8xu8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfDCK1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:27:07 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41088 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfDCK1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 06:27:07 -0400
Received: by mail-lf1-f68.google.com with SMTP id 10so11302120lfr.8;
        Wed, 03 Apr 2019 03:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gdpYw9WUhiqNplKTYsZUyrhhngHPm23lSFPPK3ykO+A=;
        b=dRY8xu8JalvRdJ8VPb/Zz7g5wXj6dgpNLy8Kc5O/QvacK0CFYwLMp2+WYOR7boCNZO
         rhTPAVl/ZkPmocER02k85JTRXjoWhO4l1OLQCFmaHw7E7IN8NhHNmA7qbCpuG3tndofR
         RyVe+Lru4jL1PnMDFHf0/MEh4ssHagKjHKz8aiTqmVUj2+b1RM0C1zRwXHG8tWezOJ3G
         pp1YcWS7evU3rDlTpM6+YUKts4Nz8Jq52PVrPXX6TK9TFcolIN67ah23/VVz93V/0FOG
         iLCagT/SOJHsVY/TWVAriz/dtdOn5gxjwZpvdYfAuzknVxtF01jFxjgNR9kZU1AyF2Mu
         dHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gdpYw9WUhiqNplKTYsZUyrhhngHPm23lSFPPK3ykO+A=;
        b=OX2jYjWeG7BWlNePxykcY2GJoXgBdZHf74i/KcbBeFzaQpcf+Nd9zEMbOZrX3VAcCz
         Xflpm9VrG1h3FYozhCUKp9niu40MOHdmk4GZf0pMVs//LO4EjTAOSThgBYC3+52gJaml
         NjEmIIubahnScsvRQi/Z51buoFAklUDHuGimW+d3SY72tpKByEoOeEk/NwjGClmCHNXH
         ljRe+O/spt9jmlSHwxsDJBU2yIPEd3UxpITmIGtUJIkATaGblZPdsM34II82GlZQ0ur9
         j+03LyVFeANTgSgbpyPVYCetC0C5fcjO/nTKCePswJT9tNlNR9fE/RG21+rKHo8BJmwD
         sopg==
X-Gm-Message-State: APjAAAX/Hm9Y0cmzk2rWUpb1Vy+oH/lc9OV06fTMOVojTQWbJqhPzKhs
        NdOW0KFXszNnv+jNKIxRbFeKgnWZ
X-Google-Smtp-Source: APXvYqyZxUwmO6uyLzEfmzElBLHF8A5bHeCVnoy59Sm5KpI+x0WZzeEnTbVVlkwtcPILAylIXwKW9g==
X-Received: by 2002:a19:ec14:: with SMTP id b20mr25367580lfa.55.1554287225038;
        Wed, 03 Apr 2019 03:27:05 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id z13sm3134227ljk.41.2019.04.03.03.27.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 03:27:04 -0700 (PDT)
Subject: Re: [PATCH v1 1/3] iommu/tegra-smmu: Fix invalid ASID bits on
 Tegra30/114
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190306225009.3391-1-digetx@gmail.com>
 <20190306225009.3391-2-digetx@gmail.com> <20190403084142.GA5238@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9e7af5f4-9da9-14f4-99a1-53188bebe34f@gmail.com>
Date:   Wed, 3 Apr 2019 13:27:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190403084142.GA5238@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

03.04.2019 11:41, Thierry Reding пишет:
> On Thu, Mar 07, 2019 at 01:50:07AM +0300, Dmitry Osipenko wrote:
>> Both Tegra30 and Tegra114 have 4 ASID's and the corresponding bitfield of
>> the TLB_FLUSH register differs from later Tegra generations that have 128
>> ASID's.
>>
>> In a result the PTE's are now flushed correctly from TLB and this fixes
>> problems with graphics (randomly failing tests) on Tegra30.
>>
>> Cc: stable <stable@vger.kernel.org>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/iommu/tegra-smmu.c | 25 ++++++++++++++++++-------
>>  1 file changed, 18 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
>> index 5182c7d6171e..8d30653cd13a 100644
>> --- a/drivers/iommu/tegra-smmu.c
>> +++ b/drivers/iommu/tegra-smmu.c
>> @@ -102,7 +102,6 @@ static inline u32 smmu_readl(struct tegra_smmu *smmu, unsigned long offset)
>>  #define  SMMU_TLB_FLUSH_VA_MATCH_ALL     (0 << 0)
>>  #define  SMMU_TLB_FLUSH_VA_MATCH_SECTION (2 << 0)
>>  #define  SMMU_TLB_FLUSH_VA_MATCH_GROUP   (3 << 0)
>> -#define  SMMU_TLB_FLUSH_ASID(x)          (((x) & 0x7f) << 24)
> 
> Given that the same operation is repeated three times below, it might
> have been worth to fold the conditional into the macro. That'd require
> the macro to take an smmu parameter, but would otherwise leave the
> individual instances shorter.

I had that variant initially and the result felt more clumsy to me.

> But either way, the fix is good, so:
> 
> Acked-by: Thierry Reding <treding@nvidia.com>
> 

Thanks
