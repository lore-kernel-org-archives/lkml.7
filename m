Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A595C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C6A520850
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="fIxpnoH/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfFNQLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 12:11:12 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15947 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfFNQLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:11:11 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d03c71f0000>; Fri, 14 Jun 2019 09:11:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 14 Jun 2019 09:11:11 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 14 Jun 2019 09:11:11 -0700
Received: from [10.19.65.14] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 14 Jun
 2019 16:11:08 +0000
Subject: Re: [PATCH V1 1/2] mailbox: tegra: hsp: add noirq resume
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
References: <1560515734-2085-1-git-send-email-bbiswas@nvidia.com>
 <20190614155041.GB26922@ulmo>
From:   Bitan Biswas <bbiswas@nvidia.com>
Message-ID: <ff0b9ae6-c964-4eed-3d06-40a11ec72415@nvidia.com>
Date:   Fri, 14 Jun 2019 09:11:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614155041.GB26922@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560528671; bh=U1G5/chSX76jJebfU8fFuPn83smOgYAa1oniljWF5KA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=fIxpnoH/l3viomNBG2W4wQaHrLGYdOqN9YcNmewVeOORmayP7o7acSPqoFa7e6pIa
         Ow+MJQqvamONiC41Z07WVU6tbYmPgE3YfxdoICsYAgYWlsFW8u00yh0VVYalCGGlq3
         Lpz5eCxD69SitQaADLBFti0VsYFqD76/qqN/G37Xvl31D2wvi0AUQHb91llpGNlXZk
         gIfop4oIYxLAN0lHn/lqc6lBo0g0436My9vGRTzPcLDRdNORHPd+m0OtrZlWHxpO2S
         WAh7eCHMAfjptYYZeMDhUmSLRM4hbNX+lLcgXGv7Ml2rV+yQ+LC8c84kG4uZ7XXERJ
         SRlBQIaUNluew==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/14/19 8:50 AM, Thierry Reding wrote:
> On Fri, Jun 14, 2019 at 05:35:33AM -0700, Bitan Biswas wrote:
>> Add noirq resume instead of resume callback for Tegra HSP. Tegra HSP
>> resume needs tegra_hsp_doorbell_startup() call to fix timeout error for
>> tegra_bpmp_transfer() during genpd resume noirq on jetson-tx2.
> 
> s/jetson-tx2/Jetson TX2/?
I shall replace the string "jetson-tx2" in commit description with 
"Jetson TX2".

> 
>>
>> Signed-off-by: Bitan Biswas <bbiswas@nvidia.com>
>> ---
>>   drivers/mailbox/tegra-hsp.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
>> index 91f1a0c..f147374 100644
>> --- a/drivers/mailbox/tegra-hsp.c
>> +++ b/drivers/mailbox/tegra-hsp.c
>> @@ -771,10 +771,16 @@ static int tegra_hsp_probe(struct platform_device *pdev)
>>   	return 0;
>>   }
>>   
>> -static int __maybe_unused tegra_hsp_resume(struct device *dev)
>> +static int __maybe_unused tegra_hsp_noirq_resume(struct device *dev)
> 
> Maybe call this tegra_hsp_resume_noirq() to match the naming of the
> dev_pm_ops callback?
I shall rename tegra_hsp_noirq_resume back to tegra_hsp_resume.

> 
>>   {
>>   	struct tegra_hsp *hsp = dev_get_drvdata(dev);
>>   	unsigned int i;
>> +	struct tegra_hsp_doorbell *db;
>> +
>> +	list_for_each_entry(db, &hsp->doorbells, list) {
>> +		if (db && db->channel.chan)
>> +			tegra_hsp_doorbell_startup(db->channel.chan);
>> +	}
>>   
>>   	for (i = 0; i < hsp->num_sm; i++) {
>>   		struct tegra_hsp_mailbox *mb = &hsp->mailboxes[i];
>> @@ -786,7 +792,9 @@ static int __maybe_unused tegra_hsp_resume(struct device *dev)
>>   	return 0;
>>   }
>>   
>> -static SIMPLE_DEV_PM_OPS(tegra_hsp_pm_ops, NULL, tegra_hsp_resume);
>> +static const struct dev_pm_ops tegra_hsp_pm_ops = {
>> +	.resume_noirq   = tegra_hsp_noirq_resume,
> 
> There seems to be two extra spaces before that =.
Missed extra spaces. Shall fix.

-Thanks,
  Bitan
