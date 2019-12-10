Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEFBC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8270B207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfLJNzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 08:55:43 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7659 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727007AbfLJNzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 08:55:43 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E958DF45AE7025AA0D1E;
        Tue, 10 Dec 2019 21:55:36 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Tue, 10 Dec 2019
 21:55:29 +0800
Subject: Re: [PATCH] perf/smmuv3: Remove the leftover put_cpu() in error path
To:     Will Deacon <will@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1575974784-55046-1-git-send-email-guohanjun@huawei.com>
 <20191210132458.GA19183@willie-the-truck>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <d251a136-2722-93ba-1bea-0000bf257db2@huawei.com>
Date:   Tue, 10 Dec 2019 21:55:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20191210132458.GA19183@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/12/10 21:24, Will Deacon wrote:
> On Tue, Dec 10, 2019 at 06:46:24PM +0800, Hanjun Guo wrote:
>> In smmu_pmu_probe(), there is put_cpu() in the error path,
>> which is wrong because we use raw_smp_processor_id() to
>> get the cpu ID, not get_cpu(), remove it.
>>
>> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
>> ---
>>  drivers/perf/arm_smmuv3_pmu.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
>> index 773128f..fd1d46a 100644
>> --- a/drivers/perf/arm_smmuv3_pmu.c
>> +++ b/drivers/perf/arm_smmuv3_pmu.c
>> @@ -834,7 +834,6 @@ static int smmu_pmu_probe(struct platform_device *pdev)
>>  out_unregister:
>>  	cpuhp_state_remove_instance_nocalls(cpuhp_state_num, &smmu_pmu->node);
>>  out_cpuhp_err:
>> -	put_cpu();
>>  	return err;
> 
> Can we kill 'out_cpuhp_err' altogether then and just return err if we fail
> to add the hotplug instance?

Makes sense, but I think we can go further to kill both 'out_cpuhp_err' and
'out_register' as below [1], what do you think?

Thanks
Hanjun

[1]:
diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index fd1d46a..a5adaba 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -814,14 +814,15 @@ static int smmu_pmu_probe(struct platform_device *pdev)
        if (err) {
                dev_err(dev, "Error %d registering hotplug, PMU @%pa\n",
                        err, &res_0->start);
-           goto out_cpuhp_err;
+         return err;
        }

        err = perf_pmu_register(&smmu_pmu->pmu, name, -1);
        if (err) {
+         cpuhp_state_remove_instance_nocalls(cpuhp_state_num, &smmu_pmu->node);
                dev_err(dev, "Error %d registering PMU @%pa\n",
                        err, &res_0->start);
-           goto out_unregister;
+         return err;
        }

        dev_info(dev, "Registered PMU @ %pa using %d counters with %s filter settings\n",
@@ -830,11 +831,6 @@ static int smmu_pmu_probe(struct platform_device *pdev)
                 "Individual");

        return 0;
-
-out_unregister:
-   cpuhp_state_remove_instance_nocalls(cpuhp_state_num, &smmu_pmu->node);
-out_cpuhp_err:
-   return err;
 }

 static int smmu_pmu_remove(struct platform_device *pdev)

