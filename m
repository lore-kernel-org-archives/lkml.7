Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6ACC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1496A2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="asNuK6NE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfFNQkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 12:40:55 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17406 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfFNQkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:40:55 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d03ce160000>; Fri, 14 Jun 2019 09:40:54 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 14 Jun 2019 09:40:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 14 Jun 2019 09:40:54 -0700
Received: from [10.19.65.14] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 14 Jun
 2019 16:40:51 +0000
Subject: Re: [PATCH V1] firmware: tegra: early resume bpmp
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        Sivaram Nair <sivaramn@nvidia.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1560515499-1015-1-git-send-email-bbiswas@nvidia.com>
 <20190614154827.GA26922@ulmo>
From:   Bitan Biswas <bbiswas@nvidia.com>
Message-ID: <577c405d-249b-00ce-221e-bff7cc9ed8b7@nvidia.com>
Date:   Fri, 14 Jun 2019 09:40:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614154827.GA26922@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560530454; bh=JXewWE1/k64Bh0+FBbmbCYEvsXTB95yMYrlVGc+MDwc=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=asNuK6NEBQdEkejjWhw9wKcCjS33xAOIuIBTbbjJW/RuFEQbz1P4ET7jPOuzCUMGo
         +EMTw5gLMXj0rmVyLwp6IpoWXWmIW7O0dB9GDoPm+3t0ZCtgI08qeYt8tcSLFElFDo
         f6+TxNrcTrIMlVg/ZU/YLTBQHRINn9qz5VCvfQwAUg0RrL7ETKmB370GJAopggyxTM
         zknI5sEZfH6+xX6t2aTmLXULQ+g05oJlJelOTT/CMjQlnRfWIRd4Ovtw95rnreeS19
         P+Z308rpYuT5CsbsijwZHDakeC+izWAaLuwUnFXIO3rmQdCHS/hjXCKyibC95tevXK
         YulTK3oy71V5Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/14/19 8:48 AM, Thierry Reding wrote:
> On Fri, Jun 14, 2019 at 05:31:39AM -0700, Bitan Biswas wrote:
>> Early resume Tegra bpmp to fix Xavier clock rate error as follows:
>> [  159.017101] of_serial 3110000.serial: calling platform_pm_resume+0x0/0x58 @ 317, parent: cbb
>> [  159.025501] of_serial 3110000.serial: platform_pm_resume+0x0/0x58 returned 0 after 14 usecs
>> [  159.033694] tegra-i2c 31c0000.i2c: calling platform_pm_resume+0x0/0x58 @ 317, parent: cbb
>> [  159.042254] tegra-i2c 31c0000.i2c: failed changing clock rate: -22
>> [  159.048216] PM: dpm_run_callback(): platform_pm_resume+0x0/0x58 returns -22
>> [  159.055553] tegra-i2c 31c0000.i2c: platform_pm_resume+0x0/0x58 returned -22 after 13072 usecs
>> [  159.063875] PM: Device 31c0000.i2c failed to resume: error -22
>>
>> Signed-off-by: Bitan Biswas <bbiswas@nvidia.com>
>> ---
>>   drivers/firmware/tegra/bpmp.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/firmware/tegra/bpmp.c b/drivers/firmware/tegra/bpmp.c
>> index dd775e8..de09036 100644
>> --- a/drivers/firmware/tegra/bpmp.c
>> +++ b/drivers/firmware/tegra/bpmp.c
>> @@ -811,7 +811,9 @@ static int __maybe_unused tegra_bpmp_resume(struct device *dev)
>>   		return 0;
>>   }
>>   
>> -static SIMPLE_DEV_PM_OPS(tegra_bpmp_pm_ops, NULL, tegra_bpmp_resume);
>> +const struct dev_pm_ops tegra_bpmp_pm_ops = {
>> +	.resume_early = tegra_bpmp_resume
>> +};
> 
> I've changed this to be static while applying to for-5.3/firmware.
Is this patch already part of some other patch? In that case I can 
abandon the patch.

Else, I shall add static keyword.


-regards,
  Bitan
