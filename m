Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4B2C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962A82077B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgAGOtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 09:49:49 -0500
Received: from foss.arm.com ([217.140.110.172]:58672 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727944AbgAGOts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 09:49:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAA5531B;
        Tue,  7 Jan 2020 06:49:47 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C70A73F703;
        Tue,  7 Jan 2020 06:49:46 -0800 (PST)
Date:   Tue, 7 Jan 2020 14:49:40 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Zeng Tao <prime.zeng@hisilicon.com>
Cc:     linuxarm@huawei.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpu-topology: Skip the exist but not possible cpu nodes
Message-ID: <20200107144940.GA47473@bogus>
References: <1577935489-25245-1-git-send-email-prime.zeng@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577935489-25245-1-git-send-email-prime.zeng@hisilicon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2020 at 11:24:49AM +0800, Zeng Tao wrote:
> When CONFIG_NR_CPUS is smaller than the cpu nodes defined in the device
> tree, the cpu node parsing will fail. And this is not reasonable for a
> legal device tree configs.
> In this patch, skip such cpu nodes rather than return an error.
> 
> Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
> ---
>  drivers/base/arch_topology.c | 35 ++++++++++++++++++++++++++---------
>  1 file changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 5fe44b3..4cddfeb 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -250,20 +250,34 @@ core_initcall(free_raw_capacity);
>  #if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
>  static int __init get_cpu_for_node(struct device_node *node)
>  {
> -	struct device_node *cpu_node;
> +	struct device_node *cpu_node, *t;
>  	int cpu;
> +	bool found = false;
>  
>  	cpu_node = of_parse_phandle(node, "cpu", 0);
>  	if (!cpu_node)
> -		return -1;
> +		return -EINVAL;
> +
> +	for_each_of_cpu_node(t)
> +		if (t == cpu_node) {
> +			found = true;
> +			break;
> +		}
> +
> +	if (!found) {
> +		pr_crit("Unable to find CPU node for %pOF\n", cpu_node);
> +		return -EINVAL;
> +	}
>

The whole extra logic added above sounds redundant, details below...

>  	cpu = of_cpu_node_to_id(cpu_node);
>  	if (cpu >= 0)
>  		topology_parse_cpu_capacity(cpu_node, cpu);
> -	else
> -		pr_crit("Unable to find CPU node for %pOF\n", cpu_node);
> +	else {
> +		pr_warn("CPU node for %pOF exist but the possible cpu range is :%*pbl\n",
> +			cpu_node, cpumask_pr_args(cpu_possible_mask));
> +		cpu = -ENODEV;

.. of_cpu_node_to_id returns -ENODEV anyways so above assignment is also
redundant. All you achieved is explicit error message. I think we should
be fine combining them. Just extend existing error log with both message.

> +	}
>  
> -	of_node_put(cpu_node);
>  	return cpu;
>  }
>  
> @@ -287,10 +301,13 @@ static int __init parse_core(struct device_node *core, int package_id,
>  				cpu_topology[cpu].core_id = core_id;
>  				cpu_topology[cpu].thread_id = i;
>  			} else {
> -				pr_err("%pOF: Can't get CPU for thread\n",
> -				       t);
> +				if (cpu != -ENODEV)
> +					pr_err("%pOF: Can't get CPU for thread\n",
> +					       t);
> +				else
> +					cpu = 0;

I would rather use another variable instead of reusing 'cpu'

>  				of_node_put(t);
> -				return -EINVAL;
> +				return cpu;

Shouldn't we continue here if cpu == -ENODEV instead of returning 0 ?

>  			}
>  			of_node_put(t);
>  		}
> @@ -307,7 +324,7 @@ static int __init parse_core(struct device_node *core, int package_id,
>  
>  		cpu_topology[cpu].package_id = package_id;
>  		cpu_topology[cpu].core_id = core_id;
> -	} else if (leaf) {
> +	} else if (leaf && cpu != -ENODEV) {

I am still not sure on the approach, it is based on -ENODEV as valid
error and allow to continue. It may be fine, I just need to make sure.

--
Regards,
Sudeep
