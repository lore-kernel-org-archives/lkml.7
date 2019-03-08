Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB9AC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 11:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA6E20851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 11:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfCHLpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 06:45:17 -0500
Received: from foss.arm.com ([217.140.101.70]:57076 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbfCHLpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 06:45:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2318680D;
        Fri,  8 Mar 2019 03:45:16 -0800 (PST)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B83443F706;
        Fri,  8 Mar 2019 03:45:13 -0800 (PST)
Subject: Re: [PATCH v1] arch_topology: Make cpu_capacity sysfs node as
 ready-only
To:     Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        quentin.perret@arm.com, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org
Cc:     will.deacon@arm.com, catalin.marinas@arm.com,
        morten.rasmussen@arm.com, linux-arm-kernel@lists.infradead.org,
        jeremy.linton@arm.com, linux-kernel@vger.kernel.org
References: <20190306152254.GB19434@e105550-lin.cambridge.arm.com>
 <1551886073-16217-1-git-send-email-clingutla@codeaurora.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <df8c3952-b1ab-bc15-ccb7-e4a5d7d54bf8@arm.com>
Date:   Fri, 8 Mar 2019 12:45:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1551886073-16217-1-git-send-email-clingutla@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/19 4:27 PM, Lingutla Chandrasekhar wrote:

[...]

> @@ -51,37 +50,7 @@ static ssize_t cpu_capacity_show(struct device *dev,
>   static void update_topology_flags_workfn(struct work_struct *work);
>   static DECLARE_WORK(update_topology_flags_work, update_topology_flags_workfn);
>   
> -static ssize_t cpu_capacity_store(struct device *dev,
> -				  struct device_attribute *attr,
> -				  const char *buf,
> -				  size_t count)
> -{
> -	struct cpu *cpu = container_of(dev, struct cpu, dev);
> -	int this_cpu = cpu->dev.id;
> -	int i;
> -	unsigned long new_capacity;
> -	ssize_t ret;
> -
> -	if (!count)
> -		return 0;
> -
> -	ret = kstrtoul(buf, 0, &new_capacity);
> -	if (ret)
> -		return ret;
> -	if (new_capacity > SCHED_CAPACITY_SCALE)
> -		return -EINVAL;
> -
> -	mutex_lock(&cpu_scale_mutex);

Since we can't write to cpu_scale from here anymore, we could get rid of 
cpu_scale_mutex. 
topology_normalize_cpu_scale()->topology_set_cpu_scale() is now only 
called from:

[    0.202628]  topology_normalize_cpu_scale+0x28/0x30
[    0.207529]  init_cpu_topology+0x168/0x1e8
[    0.211644]  smp_prepare_cpus+0x2c/0x108
[    0.215585]  kernel_init_freeable+0x104/0x518
[    0.219963]  kernel_init+0x18/0x110
[    0.223469]  ret_from_fork+0x10/0x1c

for dts capacity-dmips-mhz properties

and

[    3.130180]  topology_normalize_cpu_scale.part.0+0xac/0xd0
[    3.135619]  init_cpu_capacity_callback+0x100/0x178
[    3.140459]  notifier_call_chain+0x5c/0xa0
[    3.144522]  blocking_notifier_call_chain+0x64/0x88
[    3.149363]  cpufreq_set_policy+0xd8/0x3c8
[    3.153427]  cpufreq_init_policy+0x78/0xc8

for cpufreq max frequency related adjustments to cpu capacity.

The mutex was introduced for the sysfs interface here: 
https://lore.kernel.org/lkml/1468932048-31635-8-git-send-email-juri.lelli@arm.com

> -	for_each_cpu(i, &cpu_topology[this_cpu].core_sibling)
> -		topology_set_cpu_scale(i, new_capacity);
> -	mutex_unlock(&cpu_scale_mutex);
> -
> -	schedule_work(&update_topology_flags_work);
> -
> -	return count;
> -}
> -
> -static DEVICE_ATTR_RW(cpu_capacity);
> +static DEVICE_ATTR_RO(cpu_capacity);
>   
>   static int register_cpu_capacity_sysctl(void)
>   {
> 

Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

on Arm64 Juno with v5.0
