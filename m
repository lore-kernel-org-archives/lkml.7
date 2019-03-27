Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6776C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B26C82082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Xz8SyMxr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Hyikchul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbfC0QQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 12:16:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41456 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfC0QQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 12:16:06 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7A6BC60907; Wed, 27 Mar 2019 16:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553703365;
        bh=ViDg5KblFEnvcbIWohCXL6OR3rdU/9Zcm5Ox/rXAJAM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Xz8SyMxrOdD/hKvXdXXYuLTDX+j+0Rsoq7wxj/N80SUcG9v0TCkBs6lyWfpT9Zlik
         joEWwv5179L0mL9Dq/YA0ThuTIbkiUC0CPDcikoAjFxVfllukIx2QH2R9/5A5AnJ5I
         QzcvdPQe4TExxTjCs6gTJbs3C+WkLCGR4cU42yGQ=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 55E5C6079C;
        Wed, 27 Mar 2019 16:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553703363;
        bh=ViDg5KblFEnvcbIWohCXL6OR3rdU/9Zcm5Ox/rXAJAM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HyikchulBpMt7kP8kquuqyQK8V8CpJmgl3vEMHNoFklieUIX9jY1e4ltWWQD3j6xM
         05fgjY8FeXu6OgWSH3UmlBOyhUN4evGEyHrc/Uksa9eGIIl+JDMIvgc3Ds+S4a2UU+
         SidOkNmTNu8dWm6DT83gcl5AAAi1P+FgFqIICFUw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 55E5C6079C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v2] arch_topology: Make cpu_capacity sysfs node as
 ready-only
To:     Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        gregkh@linuxfoundation.org, quentin.perret@arm.com,
        sudeep.holla@arm.com, dietmar.eggemann@arm.com
Cc:     catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        jeremy.linton@arm.com, linux-arm-kernel@lists.infradead.org,
        juri.lelli@gmail.com
References: <20190327115722.7693-1-clingutla@codeaurora.org>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <53347bf2-e300-3e05-c840-f5a02fab6e68@codeaurora.org>
Date:   Wed, 27 Mar 2019 21:45:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190327115722.7693-1-clingutla@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/27/2019 5:27 PM, Lingutla Chandrasekhar wrote:
> If user updates any cpu's cpu_capacity, then the new value is going to
> be applied to all its online sibling cpus. But this need not to be correct
> always, as sibling cpus (in ARM, same micro architecture cpus) would have
> different cpu_capacity with different performance characteristics.
> So updating the user supplied cpu_capacity to all cpu siblings
s/So/So,
> is not correct.
>
> And another problem is, current code assumes that 'all cpus in a cluster
> or with same package_id (core_siblings), would have same cpu_capacity'.
> But with commit '5bdd2b3f0f8 ("arm64: topology: add support to remove
> cpu topology sibling masks")', when a cpu hotplugged out, the cpu
> information gets cleared in its sibling cpus. So user supplied
--
> cpu_capacity would be applied to only online sibling cpus at the time.
> After that, if any cpu hot plugged in, it would have different cpu_capacity

s/hot plugged/hotplugged

> than its siblings, which breaks the above assumption.
>
> So instead of mucking around the core sibling mask for user supplied
--
> value, use device-tree to set cpu capacity. And make the cpu_capacity
> node as read-only to know the assymetry between cpus in the system.
s/assymetry/asymmetry
> While at it, remove cpu_scale_mutex usage, which used for sysfs write
> protection.
>
> Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Tested-by: Quentin Perret <quentin.perret@arm.com>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> Reviewed-by: Quentin Perret <quentin.perret@arm.com>
> Signed-off-by: Lingutla Chandrasekhar <clingutla@codeaurora.org>
Please fix the commit text minor comments.
otherwise , looks good.

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
-Mukesh


>
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index edfcf8d982e4..1739d7e1952a 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -7,7 +7,6 @@
>    */
>   
>   #include <linux/acpi.h>
> -#include <linux/arch_topology.h>
>   #include <linux/cpu.h>
>   #include <linux/cpufreq.h>
>   #include <linux/device.h>
> @@ -31,7 +30,6 @@ void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
>   		per_cpu(freq_scale, i) = scale;
>   }
>   
> -static DEFINE_MUTEX(cpu_scale_mutex);
>   DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
>   
>   void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity)
> @@ -51,37 +49,7 @@ static ssize_t cpu_capacity_show(struct device *dev,
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
> @@ -141,7 +109,6 @@ void topology_normalize_cpu_scale(void)
>   		return;
>   
>   	pr_debug("cpu_capacity: capacity_scale=%u\n", capacity_scale);
> -	mutex_lock(&cpu_scale_mutex);
>   	for_each_possible_cpu(cpu) {
>   		pr_debug("cpu_capacity: cpu=%d raw_capacity=%u\n",
>   			 cpu, raw_capacity[cpu]);
> @@ -151,7 +118,6 @@ void topology_normalize_cpu_scale(void)
>   		pr_debug("cpu_capacity: CPU%d cpu_capacity=%lu\n",
>   			cpu, topology_get_cpu_scale(NULL, cpu));
>   	}
> -	mutex_unlock(&cpu_scale_mutex);
>   }
>   
>   bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
