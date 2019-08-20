Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E40DC3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 02:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C6F22CE8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 02:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbfHTCaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 22:30:17 -0400
Received: from mga06.intel.com ([134.134.136.31]:17866 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728719AbfHTCaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 22:30:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 19:30:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,407,1559545200"; 
   d="scan'208";a="178050474"
Received: from genxtest-ykzhao.sh.intel.com (HELO [10.239.143.71]) ([10.239.143.71])
  by fmsmga008.fm.intel.com with ESMTP; 19 Aug 2019 19:30:14 -0700
Subject: Re: [RFC PATCH 15/15] drivers/acrn: add the support of offline SOS
 cpu
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Jason Chen CJ <jason.cj.chen@intel.com>
References: <1565922356-4488-1-git-send-email-yakui.zhao@intel.com>
 <1565922356-4488-16-git-send-email-yakui.zhao@intel.com>
 <20190819103417.GD4451@kadam>
From:   "Zhao, Yakui" <yakui.zhao@intel.com>
Message-ID: <18360e11-22af-8f14-21ad-3fa0e8d23210@intel.com>
Date:   Tue, 20 Aug 2019 10:23:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190819103417.GD4451@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019年08月19日 18:34, Dan Carpenter wrote:
> On Fri, Aug 16, 2019 at 10:25:56AM +0800, Zhao Yakui wrote:
>> diff --git a/drivers/staging/acrn/acrn_dev.c b/drivers/staging/acrn/acrn_dev.c
>> index 0602125..6868003 100644
>> --- a/drivers/staging/acrn/acrn_dev.c
>> +++ b/drivers/staging/acrn/acrn_dev.c
>> @@ -588,6 +588,41 @@ static const struct file_operations fops = {
>>   #define SUPPORT_HV_API_VERSION_MAJOR	1
>>   #define SUPPORT_HV_API_VERSION_MINOR	0
>>   
>> +static ssize_t
>> +offline_cpu_store(struct device *dev,
>> +			struct device_attribute *attr,
>> +			const char *buf, size_t count)
>> +{
>> +#ifdef CONFIG_X86
>> +	u64 cpu, lapicid;
>> +
>> +	if (kstrtoull(buf, 0, &cpu) < 0)
>> +		return -EINVAL;
> 

Thanks for the review.

Make sense.
The error code will be preserved.

> Preserve the error code.
> 
> 	ret = kstrtoull(buf, 0, &cpu);
> 	if (ret)
> 		return ret;


> 
>> +
>> +	if (cpu_possible(cpu)) {
> 
> You can't pass unchecked cpu values to cpu_possible() or it results in
> an out of bounds read if cpu is >= than nr_cpu_ids.
> 

OK. It will add the check of "cpu < num_possibles_cpu()" to avoid the 
out of bounds.

> regards,
> dan carpenter
> 
