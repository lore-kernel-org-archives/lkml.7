Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A32C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848E320675
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbfLDSsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:48:38 -0500
Received: from mga01.intel.com ([192.55.52.88]:40068 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbfLDSsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:48:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 10:48:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,278,1571727600"; 
   d="scan'208";a="361659839"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 04 Dec 2019 10:48:36 -0800
Received: from [10.125.248.94] (rsudarik-mobl.ccr.corp.intel.com [10.125.248.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 62866580261;
        Wed,  4 Dec 2019 10:48:33 -0800 (PST)
Subject: Re: [PATCH 1/6] perf x86: Infrastructure for exposing an Uncore unit
 to PMON mapping
To:     Stephane Eranian <eranian@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bgregg@netflix.com,
        Andi Kleen <ak@linux.intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        alexander.antonov@intel.com
References: <20191126163630.17300-1-roman.sudarikov@linux.intel.com>
 <20191126163630.17300-2-roman.sudarikov@linux.intel.com>
 <CABPqkBQ0Ukn3RXB2516Qpz3_hGEzOgUA-JcFwBcdDfPPj4bVNQ@mail.gmail.com>
From:   "Sudarikov, Roman" <roman.sudarikov@linux.intel.com>
Message-ID: <ddd57e52-d7ab-d7d5-bcfa-5e68cf98ef76@linux.intel.com>
Date:   Wed, 4 Dec 2019 21:48:29 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CABPqkBQ0Ukn3RXB2516Qpz3_hGEzOgUA-JcFwBcdDfPPj4bVNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.12.2019 22:47, Stephane Eranian wrote:
> On Tue, Nov 26, 2019 at 8:36 AM <roman.sudarikov@linux.intel.com> wrote:
>> From: Roman Sudarikov <roman.sudarikov@linux.intel.com>
>>
>> Intel® Xeon® Scalable processor family (code name Skylake-SP) makes significant
>> changes in the integrated I/O (IIO) architecture. The new solution introduces
>> IIO stacks which are responsible for managing traffic between the PCIe domain
>> and the Mesh domain. Each IIO stack has its own PMON block and can handle either
>> DMI port, x16 PCIe root port, MCP-Link or various built-in accelerators.
>> IIO PMON blocks allow concurrent monitoring of I/O flows up to 4 x4 bifurcation
>> within each IIO stack.
>>
>> Software is supposed to program required perf counters within each IIO stack
>> and gather performance data. The tricky thing here is that IIO PMON reports data
>> per IIO stack but users have no idea what IIO stacks are - they only know devices
>> which are connected to the platform.
>>
>> Understanding IIO stack concept to find which IIO stack that particular IO device
>> is connected to, or to identify an IIO PMON block to program for monitoring
>> specific IIO stack assumes a lot of implicit knowledge about given Intel server
>> platform architecture.
>>
>> This patch set introduces:
>>      An infrastructure for exposing an Uncore unit to Uncore PMON mapping through sysfs-backend
>>      A new --iiostat mode in perf stat to provide I/O performance metrics per I/O device
>>
>> Current version supports a server line starting Intel® Xeon® Processor Scalable
>> Family and introduces mapping for IIO Uncore units only.
>> Other units can be added on demand.
>>
>> Usage example:
>>      /sys/devices/uncore_<type>_<pmu_idx>/platform_mapping
>>
>> Each Uncore unit type, by its nature, can be mapped to its own context, for example:
>>      CHA - each uncore_cha_<pmu_idx> is assigned to manage a distinct slice of LLC capacity
>>      UPI - each uncore_upi_<pmu_idx> is assigned to manage one link of Intel UPI Subsystem
>>      IIO - each uncore_iio_<pmu_idx> is assigned to manage one stack of the IIO module
>>      IMC - each uncore_imc_<pmu_idx> is assigned to manage one channel of Memory Controller
>>
>> Implementation details:
>>      Two callbacks added to struct intel_uncore_type to discover and map Uncore units to PMONs:
>>          int (*get_topology)(struct intel_uncore_type *type)
>>          int (*set_mapping)(struct intel_uncore_type *type)
>>
>>      IIO stack to PMON mapping is exposed through
>>          /sys/devices/uncore_iio_<pmu_idx>/platform_mapping
>>          in the following format: domain:bus
>>
>> Details of IIO Uncore unit mapping to IIO PMON:
>> Each IIO stack is either a DMI port, x16 PCIe root port, MCP-Link or various
>> built-in accelerators. For Uncore IIO Unit type, the platform_mapping file
>> holds bus numbers of devices, which can be monitored by that IIO PMON block
>> on each die.
>>
>> For example, on a 4-die Intel Xeon® server platform:
>>      $ cat /sys/devices/uncore_iio_0/platform_mapping
>>      0000:00,0000:40,0000:80,0000:c0
>>
>> Which means:
>> IIO PMON block 0 on die 0 belongs to IIO stack located on bus 0x00, domain 0x0000
>> IIO PMON block 0 on die 1 belongs to IIO stack located on bus 0x40, domain 0x0000
>> IIO PMON block 0 on die 2 belongs to IIO stack located on bus 0x80, domain 0x0000
>> IIO PMON block 0 on die 3 belongs to IIO stack located on bus 0xc0, domain 0x0000
>>
> You are just looking at one die (package). How does your enumeration
> help figure out
> is the iio_0 is on socket0 of socket1 and then figure out which
> bus/domain in on which
> socket.
>
> And how does that help map actual devices (using the output of lspci)
> to the IIO?
> You need to show how you would do that, which is really what people
> want, with what you
> have in your patch right now.
No. I'm enumerating all IIO PMUs for all sockets on the platform.

Let's take an 4 socket SKX as an example - sysfs exposes 6 instances of 
IIO PMU and each socket has its own instance of each IIO PMUs,
meaning that socket 0 has its own IIO PMU0, socket 1 also has its own 
IIO PMU0 and so on. Same apply for IIO PMUs 1 through 5.
Below is sample output:

$:/sys/devices# cat uncore_iio_0/platform_mapping
0000:00,0000:40,0000:80,0000:c0
$:/sys/devices# cat uncore_iio_1/platform_mapping
0000:16,0000:44,0000:84,0000:c4
$:/sys/devices# cat uncore_iio_2/platform_mapping
0000:24,0000:58,0000:98,0000:d8
$:/sys/devices# cat uncore_iio_3/platform_mapping
0000:32,0000:6c,0000:ac,0000:ec

Technically, the idea is as follows - kernel part of the feature is for 
locating IIO stacks and creating  IIO PMON to IIO stack mapping.
Userspace part of the feature is for locating IO devices connected to 
each IIO stack on each socket and configure only required IIO counters to
provide 4 IO performance metrics - Inbound Read, Inbound Write, Outbound 
Read, Outbound Write - attributed to each device.


Follow up patches show how users can benefit from the feature; see 
https://lkml.org/lkml/2019/11/26/451

Below is sample output:

1. show mode

./perf stat --iiostat=show

     S0-RootPort0-uncore_iio_0<00:00.0 Sky Lake-E DMI3 Registers>
     S1-RootPort0-uncore_iio_0<81:00.0 Ethernet Controller X710 for 10GbE SFP+>
     S0-RootPort1-uncore_iio_1<18:00.0 Omni-Path HFI Silicon 100 Series [discrete]>
     S1-RootPort1-uncore_iio_1<86:00.0 Ethernet Controller XL710 for 40GbE QSFP+>
     S1-RootPort1-uncore_iio_1<88:00.0 Ethernet Controller XL710 for 40GbE QSFP+>
     S0-RootPort2-uncore_iio_2<3d:00.0 Ethernet Connection X722 for 10GBASE-T>
     S1-RootPort2-uncore_iio_2<af:00.0 Omni-Path HFI Silicon 100 Series [discrete]>
     S1-RootPort3-uncore_iio_3<da:00.0 NVMe Datacenter SSD [Optane]>

For example, NIC at 81:00.0 is local to S1, connected to its RootPort0 and is covered by IIO PMU0 (on socket 1)

1. collector mode

   ./perf stat --iiostat -- dd if=/dev/zero of=/dev/nvme0n1 bs=1M oflag=direct
     357708+0 records in
     357707+0 records out
     375083606016 bytes (375 GB, 349 GiB) copied, 215.381 s, 1.7 GB/s

   Performance counter stats for 'system wide':

      device             Inbound Read(MB)    Inbound Write(MB)    Outbound Read(MB)   Outbound Write(MB)
     00:00.0                    0                    0                    0                    0
     81:00.0                    0                    0                    0                    0
     18:00.0                    0                    0                    0                    0
     86:00.0                    0                    0                    0                    0
     88:00.0                    0                    0                    0                    0
     3b:00.0                    3                    0                    0                    0
     3c:03.0                    3                    0                    0                    0
     3d:00.0                    3                    0                    0                    0
     af:00.0                    0                    0                    0                    0
     da:00.0               358559                   44                    0                   22

     215.383783574 seconds time elapsed

>
>> Signed-off-by: Roman Sudarikov <roman.sudarikov@linux.intel.com>
>> Co-developed-by: Alexander Antonov <alexander.antonov@intel.com>
>> Signed-off-by: Alexander Antonov <alexander.antonov@intel.com>
>> ---
>>   arch/x86/events/intel/uncore.c       |  61 +++++++++++-
>>   arch/x86/events/intel/uncore.h       |  13 ++-
>>   arch/x86/events/intel/uncore_snbep.c | 144 +++++++++++++++++++++++++++
>>   3 files changed, 214 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
>> index 86467f85c383..0f779c8fcc05 100644
>> --- a/arch/x86/events/intel/uncore.c
>> +++ b/arch/x86/events/intel/uncore.c
>> @@ -18,6 +18,11 @@ struct list_head pci2phy_map_head = LIST_HEAD_INIT(pci2phy_map_head);
>>   struct pci_extra_dev *uncore_extra_pci_dev;
>>   static int max_dies;
>>
>> +int get_max_dies(void)
>> +{
>> +       return max_dies;
>> +}
>> +
>>   /* mask of cpus that collect uncore events */
>>   static cpumask_t uncore_cpu_mask;
>>
>> @@ -816,6 +821,16 @@ static ssize_t uncore_get_attr_cpumask(struct device *dev,
>>
>>   static DEVICE_ATTR(cpumask, S_IRUGO, uncore_get_attr_cpumask, NULL);
>>
>> +static ssize_t platform_mapping_show(struct device *dev,
>> +                               struct device_attribute *attr, char *buf)
>> +{
>> +       struct intel_uncore_pmu *pmu = dev_get_drvdata(dev);
>> +
>> +       return snprintf(buf, PAGE_SIZE - 1, "%s\n", pmu->platform_mapping ?
>> +                      (char *)pmu->platform_mapping : "0");
>> +}
>> +static DEVICE_ATTR_RO(platform_mapping);
>> +
>>   static struct attribute *uncore_pmu_attrs[] = {
>>          &dev_attr_cpumask.attr,
>>          NULL,
>> @@ -825,6 +840,15 @@ static const struct attribute_group uncore_pmu_attr_group = {
>>          .attrs = uncore_pmu_attrs,
>>   };
>>
>> +static struct attribute *platform_attrs[] = {
>> +       &dev_attr_platform_mapping.attr,
>> +       NULL,
>> +};
>> +
>> +static const struct attribute_group uncore_platform_discovery_group = {
>> +       .attrs = platform_attrs,
>> +};
>> +
>>   static int uncore_pmu_register(struct intel_uncore_pmu *pmu)
>>   {
>>          int ret;
>> @@ -905,11 +929,27 @@ static void uncore_types_exit(struct intel_uncore_type **types)
>>                  uncore_type_exit(*types);
>>   }
>>
>> +static void uncore_type_attrs_compaction(struct intel_uncore_type *type)
>> +{
>> +       int i, j;
>> +
>> +       for (i = 0, j = 0; i < UNCORE_MAX_NUM_ATTR_GROUP; i++) {
>> +               if (!type->attr_groups[i])
>> +                       continue;
>> +               if (i > j) {
>> +                       type->attr_groups[j] = type->attr_groups[i];
>> +                       type->attr_groups[i] = NULL;
>> +               }
>> +               j++;
>> +       }
>> +}
>> +
>>   static int __init uncore_type_init(struct intel_uncore_type *type, bool setid)
>>   {
>>          struct intel_uncore_pmu *pmus;
>>          size_t size;
>>          int i, j;
>> +       int ret;
>>
>>          pmus = kcalloc(type->num_boxes, sizeof(*pmus), GFP_KERNEL);
>>          if (!pmus)
>> @@ -922,8 +962,10 @@ static int __init uncore_type_init(struct intel_uncore_type *type, bool setid)
>>                  pmus[i].pmu_idx = i;
>>                  pmus[i].type    = type;
>>                  pmus[i].boxes   = kzalloc(size, GFP_KERNEL);
>> -               if (!pmus[i].boxes)
>> +               if (!pmus[i].boxes) {
>> +                       ret = -ENOMEM;
>>                          goto err;
>> +               }
>>          }
>>
>>          type->pmus = pmus;
>> @@ -940,8 +982,10 @@ static int __init uncore_type_init(struct intel_uncore_type *type, bool setid)
>>
>>                  attr_group = kzalloc(struct_size(attr_group, attrs, i + 1),
>>                                                                  GFP_KERNEL);
>> -               if (!attr_group)
>> +               if (!attr_group) {
>> +                       ret = -ENOMEM;
>>                          goto err;
>> +               }
>>
>>                  attr_group->group.name = "events";
>>                  attr_group->group.attrs = attr_group->attrs;
>> @@ -954,6 +998,17 @@ static int __init uncore_type_init(struct intel_uncore_type *type, bool setid)
>>
>>          type->pmu_group = &uncore_pmu_attr_group;
>>
>> +       /*
>> +        * Exposing mapping of Uncore units to corresponding Uncore PMUs
>> +        * through /sys/devices/uncore_<type>_<idx>/platform_mapping
>> +        */
>> +       if (type->get_topology && type->set_mapping)
>> +               if (!type->get_topology(type) && !type->set_mapping(type))
>> +                       type->platform_discovery = &uncore_platform_discovery_group;
>> +
>> +       /* For optional attributes, we can safely remove embedded NULL attr_groups elements */
>> +       uncore_type_attrs_compaction(type);
>> +
>>          return 0;
>>
>>   err:
>> @@ -961,7 +1016,7 @@ static int __init uncore_type_init(struct intel_uncore_type *type, bool setid)
>>                  kfree(pmus[i].boxes);
>>          kfree(pmus);
>>
>> -       return -ENOMEM;
>> +       return ret;
>>   }
>>
>>   static int __init
>> diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
>> index bbfdaa720b45..ce3727b9f7f8 100644
>> --- a/arch/x86/events/intel/uncore.h
>> +++ b/arch/x86/events/intel/uncore.h
>> @@ -43,6 +43,8 @@ struct intel_uncore_box;
>>   struct uncore_event_desc;
>>   struct freerunning_counters;
>>
>> +#define UNCORE_MAX_NUM_ATTR_GROUP 5
>> +
>>   struct intel_uncore_type {
>>          const char *name;
>>          int num_counters;
>> @@ -71,13 +73,19 @@ struct intel_uncore_type {
>>          struct intel_uncore_ops *ops;
>>          struct uncore_event_desc *event_descs;
>>          struct freerunning_counters *freerunning;
>> -       const struct attribute_group *attr_groups[4];
>> +       const struct attribute_group *attr_groups[UNCORE_MAX_NUM_ATTR_GROUP];
>>          struct pmu *pmu; /* for custom pmu ops */
>> +       void *platform_topology;
>> +       /* finding Uncore units */
>> +       int (*get_topology)(struct intel_uncore_type *type);
>> +       /* mapping Uncore units to PMON ranges */
>> +       int (*set_mapping)(struct intel_uncore_type *type);
>>   };
>>
>>   #define pmu_group attr_groups[0]
>>   #define format_group attr_groups[1]
>>   #define events_group attr_groups[2]
>> +#define platform_discovery attr_groups[3]
>>
>>   struct intel_uncore_ops {
>>          void (*init_box)(struct intel_uncore_box *);
>> @@ -99,6 +107,7 @@ struct intel_uncore_pmu {
>>          int                             pmu_idx;
>>          int                             func_id;
>>          bool                            registered;
>> +       void                            *platform_mapping;
>>          atomic_t                        activeboxes;
>>          struct intel_uncore_type        *type;
>>          struct intel_uncore_box         **boxes;
>> @@ -490,6 +499,8 @@ static inline struct intel_uncore_box *uncore_event_to_box(struct perf_event *ev
>>          return event->pmu_private;
>>   }
>>
>> +int get_max_dies(void);
>> +
>>   struct intel_uncore_box *uncore_pmu_to_box(struct intel_uncore_pmu *pmu, int cpu);
>>   u64 uncore_msr_read_counter(struct intel_uncore_box *box, struct perf_event *event);
>>   void uncore_mmio_exit_box(struct intel_uncore_box *box);
>> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
>> index b10a5ec79e48..92ce9fbafde1 100644
>> --- a/arch/x86/events/intel/uncore_snbep.c
>> +++ b/arch/x86/events/intel/uncore_snbep.c
>> @@ -273,6 +273,28 @@
>>   #define SKX_CPUNODEID                  0xc0
>>   #define SKX_GIDNIDMAP                  0xd4
>>
>> +/*
>> + * The CPU_BUS_NUMBER MSR returns the values of the respective CPUBUSNO CSR
>> + * that BIOS programmed. MSR has package scope.
>> + * |  Bit  |  Default  |  Description
>> + * | [63]  |    00h    | VALID - When set, indicates the CPU bus
>> + *                       numbers have been initialized. (RO)
>> + * |[62:48]|    ---    | Reserved
>> + * |[47:40]|    00h    | BUS_NUM_5 — Return the bus number BIOS assigned
>> + *                       CPUBUSNO(5). (RO)
>> + * |[39:32]|    00h    | BUS_NUM_4 — Return the bus number BIOS assigned
>> + *                       CPUBUSNO(4). (RO)
>> + * |[31:24]|    00h    | BUS_NUM_3 — Return the bus number BIOS assigned
>> + *                       CPUBUSNO(3). (RO)
>> + * |[23:16]|    00h    | BUS_NUM_2 — Return the bus number BIOS assigned
>> + *                       CPUBUSNO(2). (RO)
>> + * |[15:8] |    00h    | BUS_NUM_1 — Return the bus number BIOS assigned
>> + *                       CPUBUSNO(1). (RO)
>> + * | [7:0] |    00h    | BUS_NUM_0 — Return the bus number BIOS assigned
>> + *                       CPUBUSNO(0). (RO)
>> + */
>> +#define SKX_MSR_CPU_BUS_NUMBER         0x300
>> +
>>   /* SKX CHA */
>>   #define SKX_CHA_MSR_PMON_BOX_FILTER_TID                (0x1ffULL << 0)
>>   #define SKX_CHA_MSR_PMON_BOX_FILTER_LINK       (0xfULL << 9)
>> @@ -3580,6 +3602,9 @@ static struct intel_uncore_ops skx_uncore_iio_ops = {
>>          .read_counter           = uncore_msr_read_counter,
>>   };
>>
>> +static int skx_iio_get_topology(struct intel_uncore_type *type);
>> +static int skx_iio_set_mapping(struct intel_uncore_type *type);
>> +
>>   static struct intel_uncore_type skx_uncore_iio = {
>>          .name                   = "iio",
>>          .num_counters           = 4,
>> @@ -3594,6 +3619,8 @@ static struct intel_uncore_type skx_uncore_iio = {
>>          .constraints            = skx_uncore_iio_constraints,
>>          .ops                    = &skx_uncore_iio_ops,
>>          .format_group           = &skx_uncore_iio_format_group,
>> +       .get_topology           = skx_iio_get_topology,
>> +       .set_mapping            = skx_iio_set_mapping,
>>   };
>>
>>   enum perf_uncore_iio_freerunning_type_id {
>> @@ -3780,6 +3807,123 @@ static int skx_count_chabox(void)
>>          return hweight32(val);
>>   }
>>
>> +static inline u8 skx_iio_topology_byte(void *platform_topology,
>> +                                       int die, int idx)
>> +{
>> +       return *((u8 *)(platform_topology) + die * sizeof(u64) + idx);
>> +}
>> +
>> +static inline bool skx_iio_topology_valid(u64 msr_value)
>> +{
>> +       return msr_value & ((u64)1 << 63);
>> +}
>> +
>> +static int skx_msr_cpu_bus_read(int cpu, int die)
>> +{
>> +       int ret = rdmsrl_on_cpu(cpu, SKX_MSR_CPU_BUS_NUMBER,
>> +                               ((u64 *)skx_uncore_iio.platform_topology) + die);
>> +
>> +       if (!ret) {
>> +               if (!skx_iio_topology_valid(*(((u64 *)skx_uncore_iio.platform_topology) + die)))
>> +                       ret = -1;
>> +       }
>> +       return ret;
>> +}
>> +
>> +static int skx_iio_get_topology(struct intel_uncore_type *type)
>> +{
>> +       int ret, cpu, die, current_die;
>> +       struct pci_bus *bus = NULL;
>> +
>> +       while ((bus = pci_find_next_bus(bus)) != NULL)
>> +               if (pci_domain_nr(bus)) {
>> +                       pr_info("Mapping of I/O stack to PMON ranges is not supported for multi-segment topology\n");
>> +                       return -1;
>> +               }
>> +
>> +       /* Size of SKX_MSR_CPU_BUS_NUMBER is 8 bytes, the MSR has package scope.*/
>> +       type->platform_topology =
>> +               kzalloc(get_max_dies() * sizeof(u64), GFP_KERNEL);
>> +       if (!type->platform_topology)
>> +               return -ENOMEM;
>> +
>> +       /*
>> +        * Using cpus_read_lock() to ensure cpu is not going down between
>> +        * looking at cpu_online_mask.
>> +        */
>> +       cpus_read_lock();
>> +       /* Invalid value to start loop.*/
>> +       current_die = -1;
>> +       for_each_online_cpu(cpu) {
>> +               die = topology_logical_die_id(cpu);
>> +               if (current_die == die)
>> +                       continue;
>> +               ret = skx_msr_cpu_bus_read(cpu, die);
>> +               if (ret)
>> +                       break;
>> +               current_die = die;
>> +       }
>> +       cpus_read_unlock();
>> +
>> +       if (ret)
>> +               kfree(type->platform_topology);
>> +       return ret;
>> +}
>> +
>> +static int skx_iio_set_mapping(struct intel_uncore_type *type)
>> +{
>> +       /*
>> +        * Each IIO stack (PCIe root port) has its own IIO PMON block, so each
>> +        * platform_mapping holds bus number(s) of PCIe root port(s), which can
>> +        * be monitored by that IIO PMON block.
>> +        *
>> +        * For example, on a 4-die Xeon platform with up to 6 IIO stacks per die
>> +        * and, therefore, 6 IIO PMON blocks per die, the platform_mapping of IIO
>> +        * PMON block 0 holds "0000:00,0000:40,0000:80,0000:c0":
>> +        *
>> +        * $ cat /sys/devices/uncore_iio_0/platform_mapping
>> +        * 0000:00,0000:40,0000:80,0000:c0
>> +        *
>> +        * Which means:
>> +        * IIO PMON block 0 on the die 0 belongs to PCIe root port located on bus 0x00, domain 0x0000
>> +        * IIO PMON block 0 on the die 1 belongs to PCIe root port located on bus 0x40, domain 0x0000
>> +        * IIO PMON block 0 on the die 2 belongs to PCIe root port located on bus 0x80, domain 0x0000
>> +        * IIO PMON block 0 on the die 3 belongs to PCIe root port located on bus 0xc0, domain 0x0000
>> +        */
>> +
>> +       int ret = 0;
>> +       int die, i;
>> +       char *buf;
>> +       struct intel_uncore_pmu *pmu;
>> +       const int template_len = 8;
>> +
>> +       for (i = 0; i < type->num_boxes; i++) {
>> +               pmu = type->pmus + i;
>> +               /* Root bus 0x00 is valid only for die 0 AND pmu_idx = 0. */
>> +               if (skx_iio_topology_byte(type->platform_topology, 0, pmu->pmu_idx) || (!pmu->pmu_idx)) {
>> +                       pmu->platform_mapping =
>> +                               kzalloc(get_max_dies() * template_len + 1, GFP_KERNEL);
>> +                       if (pmu->platform_mapping) {
>> +                               buf = (char *)pmu->platform_mapping;
>> +                               for (die = 0; die < get_max_dies(); die++)
>> +                                       buf += snprintf(buf, template_len + 1, "%04x:%02x,", 0,
>> +                                               skx_iio_topology_byte(type->platform_topology,
>> +                                                                     die, pmu->pmu_idx));
>> +
>> +                               *(--buf) = '\0';
>> +                       } else {
>> +                               for (; i >= 0; i--)
>> +                                       kfree((type->pmus + i)->platform_mapping);
>> +                               ret = -ENOMEM;
>> +                               break;
>> +                       }
>> +               }
>> +       }
>> +
>> +       kfree(type->platform_topology);
>> +       return ret;
>> +}
>> +
>>   void skx_uncore_cpu_init(void)
>>   {
>>          skx_uncore_chabox.num_boxes = skx_count_chabox();
>> --
>> 2.19.1
>>

