Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FF6C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C10320652
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfLJOCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:02:12 -0500
Received: from mga03.intel.com ([134.134.136.65]:34758 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbfLJOCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:02:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2019 06:02:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,299,1571727600"; 
   d="scan'208";a="387596027"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 10 Dec 2019 06:02:01 -0800
Received: from [10.251.18.12] (kliang2-mobl.ccr.corp.intel.com [10.251.18.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 150BC580104;
        Tue, 10 Dec 2019 06:02:00 -0800 (PST)
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v2_3/3=5d_perf_x86=3a_Exposing_an_Uncore_u?=
 =?UTF-8?Q?nit_to_PMON_for_Intel_Xeon=c2=ae_server_platform?=
To:     roman.sudarikov@linux.intel.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, bgregg@netflix.com, ak@linux.intel.com
Cc:     alexander.antonov@intel.com
References: <20191210091451.6054-1-roman.sudarikov@linux.intel.com>
 <20191210091451.6054-4-roman.sudarikov@linux.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <325fa799-d1ea-a499-55d9-97c2f6a75f00@linux.intel.com>
Date:   Tue, 10 Dec 2019 09:01:59 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191210091451.6054-4-roman.sudarikov@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/10/2019 4:14 AM, roman.sudarikov@linux.intel.com wrote:
> From: Roman Sudarikov <roman.sudarikov@linux.intel.com>
> 
> Current version supports a server line starting Intel® Xeon® Processor
> Scalable Family and introduces mapping for IIO Uncore units only.
> Other units can be added on demand.
> 
> IIO stack to PMON mapping is exposed through:
>      /sys/devices/uncore_iio_<pmu_idx>/platform_mapping
>      in the following format: domain:bus
> 
> For example, on a 4-die Intel Xeon® server platform:
>      $ cat /sys/devices/uncore_iio_0/platform_mapping
>      0000:00,0000:40,0000:80,0000:c0
> 
> Which means:
> IIO PMON block 0 on die 0 belongs to IIO stack on bus 0x00, domain 0x0000
> IIO PMON block 0 on die 1 belongs to IIO stack on bus 0x40, domain 0x0000
> IIO PMON block 0 on die 2 belongs to IIO stack on bus 0x80, domain 0x0000
> IIO PMON block 0 on die 3 belongs to IIO stack on bus 0xc0, domain 0x0000
> 
> Co-developed-by: Alexander Antonov <alexander.antonov@intel.com>
> Signed-off-by: Alexander Antonov <alexander.antonov@intel.com>
> Signed-off-by: Roman Sudarikov <roman.sudarikov@linux.intel.com>
> ---
>   arch/x86/events/intel/uncore.c       |   2 +-
>   arch/x86/events/intel/uncore.h       |   1 +
>   arch/x86/events/intel/uncore_snbep.c | 162 +++++++++++++++++++++++++++
>   3 files changed, 164 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index a05352c4fc01..d462b77aefc9 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -16,7 +16,7 @@ struct pci_driver *uncore_pci_driver;
>   DEFINE_RAW_SPINLOCK(pci2phy_map_lock);
>   struct list_head pci2phy_map_head = LIST_HEAD_INIT(pci2phy_map_head);
>   struct pci_extra_dev *uncore_extra_pci_dev;
> -static int max_dies;
> +int max_dies;
>   
>   /* mask of cpus that collect uncore events */
>   static cpumask_t uncore_cpu_mask;
> diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
> index 31008e5cea57..6bf8aa3fac42 100644
> --- a/arch/x86/events/intel/uncore.h
> +++ b/arch/x86/events/intel/uncore.h
> @@ -523,6 +523,7 @@ extern raw_spinlock_t pci2phy_map_lock;
>   extern struct list_head pci2phy_map_head;
>   extern struct pci_extra_dev *uncore_extra_pci_dev;
>   extern struct event_constraint uncore_constraint_empty;
> +extern int max_dies;
>   
>   /* uncore_snb.c */
>   int snb_uncore_pci_init(void);
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index b10a5ec79e48..88c2b0f94ed6 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -273,6 +273,30 @@
>   #define SKX_CPUNODEID			0xc0
>   #define SKX_GIDNIDMAP			0xd4
>   
> +/*
> + * The CPU_BUS_NUMBER MSR returns the values of the respective CPUBUSNO CSR
> + * that BIOS programmed. MSR has package scope.
> + * |  Bit  |  Default  |  Description
> + * | [63]  |    00h    | VALID - When set, indicates the CPU bus
> + *                       numbers have been initialized. (RO)
> + * |[62:48]|    ---    | Reserved
> + * |[47:40]|    00h    | BUS_NUM_5 — Return the bus number BIOS assigned
> + *                       CPUBUSNO(5). (RO)
> + * |[39:32]|    00h    | BUS_NUM_4 — Return the bus number BIOS assigned
> + *                       CPUBUSNO(4). (RO)
> + * |[31:24]|    00h    | BUS_NUM_3 — Return the bus number BIOS assigned
> + *                       CPUBUSNO(3). (RO)
> + * |[23:16]|    00h    | BUS_NUM_2 — Return the bus number BIOS assigned
> + *                       CPUBUSNO(2). (RO)
> + * |[15:8] |    00h    | BUS_NUM_1 — Return the bus number BIOS assigned
> + *                       CPUBUSNO(1). (RO)
> + * | [7:0] |    00h    | BUS_NUM_0 — Return the bus number BIOS assigned
> + *                       CPUBUSNO(0). (RO)
> + */
> +#define SKX_MSR_CPU_BUS_NUMBER		0x300
> +#define SKX_MSR_CPU_BUS_VALID_BIT	(1ULL << 63)
> +#define BUS_NUM_STRIDE			8
> +
>   /* SKX CHA */
>   #define SKX_CHA_MSR_PMON_BOX_FILTER_TID		(0x1ffULL << 0)
>   #define SKX_CHA_MSR_PMON_BOX_FILTER_LINK	(0xfULL << 9)
> @@ -3580,6 +3604,9 @@ static struct intel_uncore_ops skx_uncore_iio_ops = {
>   	.read_counter		= uncore_msr_read_counter,
>   };
>   
> +static int skx_iio_get_topology(struct intel_uncore_type *type);
> +static int skx_iio_set_mapping(struct intel_uncore_type *type);
> +
>   static struct intel_uncore_type skx_uncore_iio = {
>   	.name			= "iio",
>   	.num_counters		= 4,
> @@ -3594,6 +3621,8 @@ static struct intel_uncore_type skx_uncore_iio = {
>   	.constraints		= skx_uncore_iio_constraints,
>   	.ops			= &skx_uncore_iio_ops,
>   	.format_group		= &skx_uncore_iio_format_group,
> +	.get_topology		= skx_iio_get_topology,
> +	.set_mapping		= skx_iio_set_mapping,
>   };
>   
>   enum perf_uncore_iio_freerunning_type_id {
> @@ -3780,6 +3809,139 @@ static int skx_count_chabox(void)
>   	return hweight32(val);
>   }
>   
> +static inline int skx_msr_cpu_bus_read(int cpu, u64 *topology)
> +{
> +	u64 msr_value;
> +	int ret = rdmsrl_on_cpu(cpu, SKX_MSR_CPU_BUS_NUMBER, &msr_value);
> +
> +	if (!ret && !(msr_value & SKX_MSR_CPU_BUS_VALID_BIT))
> +		ret = -1;
> +	else
> +		*topology = msr_value;

If the rdmsrl fails, topology will still be set. It looks weird.
Can we do something as below?

	if (rdmsrl_on_cpu(cpu, SKX_MSR_CPU_BUS_NUMBER, &msr_value))
		return -1;

	if (!(msr_value & SKX_MSR_CPU_BUS_VALID_BIT))
		return -1;

	*topology = msr_value;

	return 0;

Thanks,
Kan
> +
> +	return ret;
> +}
> +
> +static int skx_iio_get_topology(struct intel_uncore_type *type)
> +{
> +	int ret, cpu, die, current_die;
> +	struct pci_bus *bus = NULL;
> +
> +	/*
> +	 * Verified single-segment environments only; disabled for multiple
> +	 * segment topologies for now.
> +	 */
> +	while ((bus = pci_find_next_bus(bus)) && !pci_domain_nr(bus))
> +		;
> +	if (bus) {
> +		pr_info("Non-supported topology\n");
> +		return -1;
> +	}
> +
> +	type->topology = kzalloc(max_dies * sizeof(u64), GFP_KERNEL);
> +	if (!type->topology)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Using cpus_read_lock() to ensure cpu is not going down between
> +	 * looking at cpu_online_mask.
> +	 */
> +	cpus_read_lock();
> +	/* Invalid value to start loop.*/
> +	current_die = -1;
> +	for_each_online_cpu(cpu) {
> +		die = topology_logical_die_id(cpu);
> +		if (current_die == die)
> +			continue;
> +		ret = skx_msr_cpu_bus_read(cpu, &type->topology[die]);
> +		if (ret) {
> +			kfree(type->topology);
> +			break;
> +		}
> +		current_die = die;
> +	}
> +	cpus_read_unlock();
> +
> +	return ret;
> +}
> +
> +static inline u8 skx_iio_stack_bus(struct intel_uncore_pmu *pmu, int die)
> +{
> +	return pmu->type->topology[die] >> (pmu->pmu_idx * BUS_NUM_STRIDE);
> +}
> +
> +static int skx_iio_set_box_mapping(struct intel_uncore_pmu *pmu)
> +{
> +	char *buf;
> +	int die = 0;
> +	/* Length of template "%04x:%02x," without null character. */
> +	const int template_len = 8;
> +
> +	/*
> +	 * Root bus 0x00 is valid only for die 0 AND pmu_idx = 0.
> +	 * Set "0" platform mapping for PMUs which have zero stack bus and
> +	 * non-zero index.
> +	 */
> +	if (!skx_iio_stack_bus(pmu, die) && pmu->pmu_idx) {
> +		pmu->mapping = kzalloc(2, GFP_KERNEL);
> +		if (!pmu->mapping)
> +			return -ENOMEM;
> +		sprintf(pmu->mapping, "0");
> +		return 0;
> +	}
> +
> +	pmu->mapping = kzalloc(max_dies * template_len + 1, GFP_KERNEL);
> +	if (!pmu->mapping)
> +		return -ENOMEM;
> +
> +	buf = (char *)pmu->mapping;
> +	for (; die < max_dies; die++) {
> +		buf += snprintf(buf, template_len + 1, "%04x:%02x,", 0,
> +				skx_iio_stack_bus(pmu, die));
> +	}
> +
> +	*(--buf) = '\0';
> +
> +	return 0;
> +}
> +
> +static int skx_iio_set_mapping(struct intel_uncore_type *type)
> +{
> +	/*
> +	 * Each IIO stack (PCIe root port) has its own IIO PMON block, so each
> +	 * platform_mapping holds bus number(s) of PCIe root port(s), which can
> +	 * be monitored by that IIO PMON block.
> +	 *
> +	 * For example, on 4-die Xeon platform with up to 6 IIO stacks per die
> +	 * and, therefore, 6 IIO PMON blocks per die, the platform_mapping
> +	 * of IIO PMON block 0 holds "0000:00,0000:40,0000:80,0000:c0":
> +	 *
> +	 * $ cat /sys/devices/uncore_iio_0/platform_mapping
> +	 * 0000:00,0000:40,0000:80,0000:c0
> +	 *
> +	 * Which means:
> +	 * IIO PMON 0 on die 0 belongs to PCIe RP on bus 0x00, domain 0x0000
> +	 * IIO PMON 0 on die 1 belongs to PCIe RP on bus 0x40, domain 0x0000
> +	 * IIO PMON 0 on die 2 belongs to PCIe RP on bus 0x80, domain 0x0000
> +	 * IIO PMON 0 on die 3 belongs to PCIe RP on bus 0xc0, domain 0x0000
> +	 */
> +
> +	int ret;
> +	struct intel_uncore_pmu *pmu = type->pmus;
> +
> +	for (; pmu - type->pmus < type->num_boxes; pmu++) {
> +		ret = skx_iio_set_box_mapping(pmu);
> +		if (ret) {
> +			for (; pmu->pmu_idx > 0; --pmu)
> +				kfree(pmu->mapping);
> +			break;
> +		}
> +	}
> +
> +	kfree(type->topology);
> +	return ret;
> +}
> +
>   void skx_uncore_cpu_init(void)
>   {
>   	skx_uncore_chabox.num_boxes = skx_count_chabox();
> 
