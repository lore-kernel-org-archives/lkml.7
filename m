Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101FAC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 19:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC32420715
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 19:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GXYdncFE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfLBTrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 14:47:17 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:39521 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbfLBTrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 14:47:16 -0500
Received: by mail-vs1-f67.google.com with SMTP id p21so680964vsq.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 11:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dTDlDLYFwo3Nx72IY3yCLrp/gh4RgiENTOqbYTMpn+0=;
        b=GXYdncFEycoZDrHM6TPpdWKKM/FHfXfFGVmI9/7sCxhIKmcnXjPeM3aVuN2UwxvA1+
         PuOteytEQQiRdT8fTpMuH9rJZJkqjBZaEANGEnd7GJb2DBR6cl0ZHkg92ff3gRonv2bX
         BITpWwSf6iYjIr1l4Itkppfmi4KDBFzBo7n8boT0Sr+HkI79Knz/PeDq0SvjNsUUquw5
         V4JIRF81yr7L+kFezKizm+nrbeHtyINkB4kK2CMvNW1aLtxNAFipN5KcKExIoxRwFMqM
         LC6Br2PYs/B7QxYADtijCNd/OyNPM5l7sXZjqtefh2HEBtHMI/lAUtJhU5jTajfQdtxy
         joCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dTDlDLYFwo3Nx72IY3yCLrp/gh4RgiENTOqbYTMpn+0=;
        b=adQgDhxVFzBaPhLwVfBpzageXAyQr+VQ0hJyA81ILabsuELf583BZ8WRVb6Dxt6HoY
         CdMZ39211fpihMz5A9Mn+Vqs7I2a3HDXTmQvm7n0LQI2W8vmUX1nvxOwCeoEE41/OU4J
         vedMzgFhVGThkdBC2JQj9trN3YPeS0meZZ/1eRHaFbzx6eozmXP0BEKd4wRaADrUzloc
         tP0cowhQQ94M/KpwVk5qLJRkMNUANDKszMLDUGOPOkQZY7H5J9uUJk3drhw69AYiXR7I
         aObRW5I11dKCVV0PfKj/Tjzuh1KPbmD4GISP3EINlwN4v8YYiE6ZQm2H5kOFqovvtTPP
         6j5A==
X-Gm-Message-State: APjAAAVBqZLKzCnGW+pKhzzONIz+N8XLoaop8deox+e7Lqqg6Ukqgcub
        Hh/SMD+bBhWHZ5vAPs7wuq2XvBb/Gr9fSSp0azVSuA==
X-Google-Smtp-Source: APXvYqyQeejDq3ZdV2SiSvWtrdO4LDq7TkGx+VuFqHR03bTCbJ7Cpm2VCo+dfyIXYiC1uW7EJT/X4jUgpDVa0+NX464=
X-Received: by 2002:a67:c99a:: with SMTP id y26mr401485vsk.213.1575316032887;
 Mon, 02 Dec 2019 11:47:12 -0800 (PST)
MIME-Version: 1.0
References: <20191126163630.17300-1-roman.sudarikov@linux.intel.com> <20191126163630.17300-2-roman.sudarikov@linux.intel.com>
In-Reply-To: <20191126163630.17300-2-roman.sudarikov@linux.intel.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 2 Dec 2019 11:47:01 -0800
Message-ID: <CABPqkBQ0Ukn3RXB2516Qpz3_hGEzOgUA-JcFwBcdDfPPj4bVNQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] perf x86: Infrastructure for exposing an Uncore unit
 to PMON mapping
To:     roman.sudarikov@linux.intel.com
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 8:36 AM <roman.sudarikov@linux.intel.com> wrote:
>
> From: Roman Sudarikov <roman.sudarikov@linux.intel.com>
>
> Intel=C2=AE Xeon=C2=AE Scalable processor family (code name Skylake-SP) m=
akes significant
> changes in the integrated I/O (IIO) architecture. The new solution introd=
uces
> IIO stacks which are responsible for managing traffic between the PCIe do=
main
> and the Mesh domain. Each IIO stack has its own PMON block and can handle=
 either
> DMI port, x16 PCIe root port, MCP-Link or various built-in accelerators.
> IIO PMON blocks allow concurrent monitoring of I/O flows up to 4 x4 bifur=
cation
> within each IIO stack.
>
> Software is supposed to program required perf counters within each IIO st=
ack
> and gather performance data. The tricky thing here is that IIO PMON repor=
ts data
> per IIO stack but users have no idea what IIO stacks are - they only know=
 devices
> which are connected to the platform.
>
> Understanding IIO stack concept to find which IIO stack that particular I=
O device
> is connected to, or to identify an IIO PMON block to program for monitori=
ng
> specific IIO stack assumes a lot of implicit knowledge about given Intel =
server
> platform architecture.
>
> This patch set introduces:
>     An infrastructure for exposing an Uncore unit to Uncore PMON mapping =
through sysfs-backend
>     A new --iiostat mode in perf stat to provide I/O performance metrics =
per I/O device
>
> Current version supports a server line starting Intel=C2=AE Xeon=C2=AE Pr=
ocessor Scalable
> Family and introduces mapping for IIO Uncore units only.
> Other units can be added on demand.
>
> Usage example:
>     /sys/devices/uncore_<type>_<pmu_idx>/platform_mapping
>
> Each Uncore unit type, by its nature, can be mapped to its own context, f=
or example:
>     CHA - each uncore_cha_<pmu_idx> is assigned to manage a distinct slic=
e of LLC capacity
>     UPI - each uncore_upi_<pmu_idx> is assigned to manage one link of Int=
el UPI Subsystem
>     IIO - each uncore_iio_<pmu_idx> is assigned to manage one stack of th=
e IIO module
>     IMC - each uncore_imc_<pmu_idx> is assigned to manage one channel of =
Memory Controller
>
> Implementation details:
>     Two callbacks added to struct intel_uncore_type to discover and map U=
ncore units to PMONs:
>         int (*get_topology)(struct intel_uncore_type *type)
>         int (*set_mapping)(struct intel_uncore_type *type)
>
>     IIO stack to PMON mapping is exposed through
>         /sys/devices/uncore_iio_<pmu_idx>/platform_mapping
>         in the following format: domain:bus
>
> Details of IIO Uncore unit mapping to IIO PMON:
> Each IIO stack is either a DMI port, x16 PCIe root port, MCP-Link or vari=
ous
> built-in accelerators. For Uncore IIO Unit type, the platform_mapping fil=
e
> holds bus numbers of devices, which can be monitored by that IIO PMON blo=
ck
> on each die.
>
> For example, on a 4-die Intel Xeon=C2=AE server platform:
>     $ cat /sys/devices/uncore_iio_0/platform_mapping
>     0000:00,0000:40,0000:80,0000:c0
>
> Which means:
> IIO PMON block 0 on die 0 belongs to IIO stack located on bus 0x00, domai=
n 0x0000
> IIO PMON block 0 on die 1 belongs to IIO stack located on bus 0x40, domai=
n 0x0000
> IIO PMON block 0 on die 2 belongs to IIO stack located on bus 0x80, domai=
n 0x0000
> IIO PMON block 0 on die 3 belongs to IIO stack located on bus 0xc0, domai=
n 0x0000
>
You are just looking at one die (package). How does your enumeration
help figure out
is the iio_0 is on socket0 of socket1 and then figure out which
bus/domain in on which
socket.

And how does that help map actual devices (using the output of lspci)
to the IIO?
You need to show how you would do that, which is really what people
want, with what you
have in your patch right now.

>
> Signed-off-by: Roman Sudarikov <roman.sudarikov@linux.intel.com>
> Co-developed-by: Alexander Antonov <alexander.antonov@intel.com>
> Signed-off-by: Alexander Antonov <alexander.antonov@intel.com>
> ---
>  arch/x86/events/intel/uncore.c       |  61 +++++++++++-
>  arch/x86/events/intel/uncore.h       |  13 ++-
>  arch/x86/events/intel/uncore_snbep.c | 144 +++++++++++++++++++++++++++
>  3 files changed, 214 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncor=
e.c
> index 86467f85c383..0f779c8fcc05 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -18,6 +18,11 @@ struct list_head pci2phy_map_head =3D LIST_HEAD_INIT(p=
ci2phy_map_head);
>  struct pci_extra_dev *uncore_extra_pci_dev;
>  static int max_dies;
>
> +int get_max_dies(void)
> +{
> +       return max_dies;
> +}
> +
>  /* mask of cpus that collect uncore events */
>  static cpumask_t uncore_cpu_mask;
>
> @@ -816,6 +821,16 @@ static ssize_t uncore_get_attr_cpumask(struct device=
 *dev,
>
>  static DEVICE_ATTR(cpumask, S_IRUGO, uncore_get_attr_cpumask, NULL);
>
> +static ssize_t platform_mapping_show(struct device *dev,
> +                               struct device_attribute *attr, char *buf)
> +{
> +       struct intel_uncore_pmu *pmu =3D dev_get_drvdata(dev);
> +
> +       return snprintf(buf, PAGE_SIZE - 1, "%s\n", pmu->platform_mapping=
 ?
> +                      (char *)pmu->platform_mapping : "0");
> +}
> +static DEVICE_ATTR_RO(platform_mapping);
> +
>  static struct attribute *uncore_pmu_attrs[] =3D {
>         &dev_attr_cpumask.attr,
>         NULL,
> @@ -825,6 +840,15 @@ static const struct attribute_group uncore_pmu_attr_=
group =3D {
>         .attrs =3D uncore_pmu_attrs,
>  };
>
> +static struct attribute *platform_attrs[] =3D {
> +       &dev_attr_platform_mapping.attr,
> +       NULL,
> +};
> +
> +static const struct attribute_group uncore_platform_discovery_group =3D =
{
> +       .attrs =3D platform_attrs,
> +};
> +
>  static int uncore_pmu_register(struct intel_uncore_pmu *pmu)
>  {
>         int ret;
> @@ -905,11 +929,27 @@ static void uncore_types_exit(struct intel_uncore_t=
ype **types)
>                 uncore_type_exit(*types);
>  }
>
> +static void uncore_type_attrs_compaction(struct intel_uncore_type *type)
> +{
> +       int i, j;
> +
> +       for (i =3D 0, j =3D 0; i < UNCORE_MAX_NUM_ATTR_GROUP; i++) {
> +               if (!type->attr_groups[i])
> +                       continue;
> +               if (i > j) {
> +                       type->attr_groups[j] =3D type->attr_groups[i];
> +                       type->attr_groups[i] =3D NULL;
> +               }
> +               j++;
> +       }
> +}
> +
>  static int __init uncore_type_init(struct intel_uncore_type *type, bool =
setid)
>  {
>         struct intel_uncore_pmu *pmus;
>         size_t size;
>         int i, j;
> +       int ret;
>
>         pmus =3D kcalloc(type->num_boxes, sizeof(*pmus), GFP_KERNEL);
>         if (!pmus)
> @@ -922,8 +962,10 @@ static int __init uncore_type_init(struct intel_unco=
re_type *type, bool setid)
>                 pmus[i].pmu_idx =3D i;
>                 pmus[i].type    =3D type;
>                 pmus[i].boxes   =3D kzalloc(size, GFP_KERNEL);
> -               if (!pmus[i].boxes)
> +               if (!pmus[i].boxes) {
> +                       ret =3D -ENOMEM;
>                         goto err;
> +               }
>         }
>
>         type->pmus =3D pmus;
> @@ -940,8 +982,10 @@ static int __init uncore_type_init(struct intel_unco=
re_type *type, bool setid)
>
>                 attr_group =3D kzalloc(struct_size(attr_group, attrs, i +=
 1),
>                                                                 GFP_KERNE=
L);
> -               if (!attr_group)
> +               if (!attr_group) {
> +                       ret =3D -ENOMEM;
>                         goto err;
> +               }
>
>                 attr_group->group.name =3D "events";
>                 attr_group->group.attrs =3D attr_group->attrs;
> @@ -954,6 +998,17 @@ static int __init uncore_type_init(struct intel_unco=
re_type *type, bool setid)
>
>         type->pmu_group =3D &uncore_pmu_attr_group;
>
> +       /*
> +        * Exposing mapping of Uncore units to corresponding Uncore PMUs
> +        * through /sys/devices/uncore_<type>_<idx>/platform_mapping
> +        */
> +       if (type->get_topology && type->set_mapping)
> +               if (!type->get_topology(type) && !type->set_mapping(type)=
)
> +                       type->platform_discovery =3D &uncore_platform_dis=
covery_group;
> +
> +       /* For optional attributes, we can safely remove embedded NULL at=
tr_groups elements */
> +       uncore_type_attrs_compaction(type);
> +
>         return 0;
>
>  err:
> @@ -961,7 +1016,7 @@ static int __init uncore_type_init(struct intel_unco=
re_type *type, bool setid)
>                 kfree(pmus[i].boxes);
>         kfree(pmus);
>
> -       return -ENOMEM;
> +       return ret;
>  }
>
>  static int __init
> diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncor=
e.h
> index bbfdaa720b45..ce3727b9f7f8 100644
> --- a/arch/x86/events/intel/uncore.h
> +++ b/arch/x86/events/intel/uncore.h
> @@ -43,6 +43,8 @@ struct intel_uncore_box;
>  struct uncore_event_desc;
>  struct freerunning_counters;
>
> +#define UNCORE_MAX_NUM_ATTR_GROUP 5
> +
>  struct intel_uncore_type {
>         const char *name;
>         int num_counters;
> @@ -71,13 +73,19 @@ struct intel_uncore_type {
>         struct intel_uncore_ops *ops;
>         struct uncore_event_desc *event_descs;
>         struct freerunning_counters *freerunning;
> -       const struct attribute_group *attr_groups[4];
> +       const struct attribute_group *attr_groups[UNCORE_MAX_NUM_ATTR_GRO=
UP];
>         struct pmu *pmu; /* for custom pmu ops */
> +       void *platform_topology;
> +       /* finding Uncore units */
> +       int (*get_topology)(struct intel_uncore_type *type);
> +       /* mapping Uncore units to PMON ranges */
> +       int (*set_mapping)(struct intel_uncore_type *type);
>  };
>
>  #define pmu_group attr_groups[0]
>  #define format_group attr_groups[1]
>  #define events_group attr_groups[2]
> +#define platform_discovery attr_groups[3]
>
>  struct intel_uncore_ops {
>         void (*init_box)(struct intel_uncore_box *);
> @@ -99,6 +107,7 @@ struct intel_uncore_pmu {
>         int                             pmu_idx;
>         int                             func_id;
>         bool                            registered;
> +       void                            *platform_mapping;
>         atomic_t                        activeboxes;
>         struct intel_uncore_type        *type;
>         struct intel_uncore_box         **boxes;
> @@ -490,6 +499,8 @@ static inline struct intel_uncore_box *uncore_event_t=
o_box(struct perf_event *ev
>         return event->pmu_private;
>  }
>
> +int get_max_dies(void);
> +
>  struct intel_uncore_box *uncore_pmu_to_box(struct intel_uncore_pmu *pmu,=
 int cpu);
>  u64 uncore_msr_read_counter(struct intel_uncore_box *box, struct perf_ev=
ent *event);
>  void uncore_mmio_exit_box(struct intel_uncore_box *box);
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel=
/uncore_snbep.c
> index b10a5ec79e48..92ce9fbafde1 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -273,6 +273,28 @@
>  #define SKX_CPUNODEID                  0xc0
>  #define SKX_GIDNIDMAP                  0xd4
>
> +/*
> + * The CPU_BUS_NUMBER MSR returns the values of the respective CPUBUSNO =
CSR
> + * that BIOS programmed. MSR has package scope.
> + * |  Bit  |  Default  |  Description
> + * | [63]  |    00h    | VALID - When set, indicates the CPU bus
> + *                       numbers have been initialized. (RO)
> + * |[62:48]|    ---    | Reserved
> + * |[47:40]|    00h    | BUS_NUM_5 =E2=80=94 Return the bus number BIOS =
assigned
> + *                       CPUBUSNO(5). (RO)
> + * |[39:32]|    00h    | BUS_NUM_4 =E2=80=94 Return the bus number BIOS =
assigned
> + *                       CPUBUSNO(4). (RO)
> + * |[31:24]|    00h    | BUS_NUM_3 =E2=80=94 Return the bus number BIOS =
assigned
> + *                       CPUBUSNO(3). (RO)
> + * |[23:16]|    00h    | BUS_NUM_2 =E2=80=94 Return the bus number BIOS =
assigned
> + *                       CPUBUSNO(2). (RO)
> + * |[15:8] |    00h    | BUS_NUM_1 =E2=80=94 Return the bus number BIOS =
assigned
> + *                       CPUBUSNO(1). (RO)
> + * | [7:0] |    00h    | BUS_NUM_0 =E2=80=94 Return the bus number BIOS =
assigned
> + *                       CPUBUSNO(0). (RO)
> + */
> +#define SKX_MSR_CPU_BUS_NUMBER         0x300
> +
>  /* SKX CHA */
>  #define SKX_CHA_MSR_PMON_BOX_FILTER_TID                (0x1ffULL << 0)
>  #define SKX_CHA_MSR_PMON_BOX_FILTER_LINK       (0xfULL << 9)
> @@ -3580,6 +3602,9 @@ static struct intel_uncore_ops skx_uncore_iio_ops =
=3D {
>         .read_counter           =3D uncore_msr_read_counter,
>  };
>
> +static int skx_iio_get_topology(struct intel_uncore_type *type);
> +static int skx_iio_set_mapping(struct intel_uncore_type *type);
> +
>  static struct intel_uncore_type skx_uncore_iio =3D {
>         .name                   =3D "iio",
>         .num_counters           =3D 4,
> @@ -3594,6 +3619,8 @@ static struct intel_uncore_type skx_uncore_iio =3D =
{
>         .constraints            =3D skx_uncore_iio_constraints,
>         .ops                    =3D &skx_uncore_iio_ops,
>         .format_group           =3D &skx_uncore_iio_format_group,
> +       .get_topology           =3D skx_iio_get_topology,
> +       .set_mapping            =3D skx_iio_set_mapping,
>  };
>
>  enum perf_uncore_iio_freerunning_type_id {
> @@ -3780,6 +3807,123 @@ static int skx_count_chabox(void)
>         return hweight32(val);
>  }
>
> +static inline u8 skx_iio_topology_byte(void *platform_topology,
> +                                       int die, int idx)
> +{
> +       return *((u8 *)(platform_topology) + die * sizeof(u64) + idx);
> +}
> +
> +static inline bool skx_iio_topology_valid(u64 msr_value)
> +{
> +       return msr_value & ((u64)1 << 63);
> +}
> +
> +static int skx_msr_cpu_bus_read(int cpu, int die)
> +{
> +       int ret =3D rdmsrl_on_cpu(cpu, SKX_MSR_CPU_BUS_NUMBER,
> +                               ((u64 *)skx_uncore_iio.platform_topology)=
 + die);
> +
> +       if (!ret) {
> +               if (!skx_iio_topology_valid(*(((u64 *)skx_uncore_iio.plat=
form_topology) + die)))
> +                       ret =3D -1;
> +       }
> +       return ret;
> +}
> +
> +static int skx_iio_get_topology(struct intel_uncore_type *type)
> +{
> +       int ret, cpu, die, current_die;
> +       struct pci_bus *bus =3D NULL;
> +
> +       while ((bus =3D pci_find_next_bus(bus)) !=3D NULL)
> +               if (pci_domain_nr(bus)) {
> +                       pr_info("Mapping of I/O stack to PMON ranges is n=
ot supported for multi-segment topology\n");
> +                       return -1;
> +               }
> +
> +       /* Size of SKX_MSR_CPU_BUS_NUMBER is 8 bytes, the MSR has package=
 scope.*/
> +       type->platform_topology =3D
> +               kzalloc(get_max_dies() * sizeof(u64), GFP_KERNEL);
> +       if (!type->platform_topology)
> +               return -ENOMEM;
> +
> +       /*
> +        * Using cpus_read_lock() to ensure cpu is not going down between
> +        * looking at cpu_online_mask.
> +        */
> +       cpus_read_lock();
> +       /* Invalid value to start loop.*/
> +       current_die =3D -1;
> +       for_each_online_cpu(cpu) {
> +               die =3D topology_logical_die_id(cpu);
> +               if (current_die =3D=3D die)
> +                       continue;
> +               ret =3D skx_msr_cpu_bus_read(cpu, die);
> +               if (ret)
> +                       break;
> +               current_die =3D die;
> +       }
> +       cpus_read_unlock();
> +
> +       if (ret)
> +               kfree(type->platform_topology);
> +       return ret;
> +}
> +
> +static int skx_iio_set_mapping(struct intel_uncore_type *type)
> +{
> +       /*
> +        * Each IIO stack (PCIe root port) has its own IIO PMON block, so=
 each
> +        * platform_mapping holds bus number(s) of PCIe root port(s), whi=
ch can
> +        * be monitored by that IIO PMON block.
> +        *
> +        * For example, on a 4-die Xeon platform with up to 6 IIO stacks =
per die
> +        * and, therefore, 6 IIO PMON blocks per die, the platform_mappin=
g of IIO
> +        * PMON block 0 holds "0000:00,0000:40,0000:80,0000:c0":
> +        *
> +        * $ cat /sys/devices/uncore_iio_0/platform_mapping
> +        * 0000:00,0000:40,0000:80,0000:c0
> +        *
> +        * Which means:
> +        * IIO PMON block 0 on the die 0 belongs to PCIe root port locate=
d on bus 0x00, domain 0x0000
> +        * IIO PMON block 0 on the die 1 belongs to PCIe root port locate=
d on bus 0x40, domain 0x0000
> +        * IIO PMON block 0 on the die 2 belongs to PCIe root port locate=
d on bus 0x80, domain 0x0000
> +        * IIO PMON block 0 on the die 3 belongs to PCIe root port locate=
d on bus 0xc0, domain 0x0000
> +        */
> +
> +       int ret =3D 0;
> +       int die, i;
> +       char *buf;
> +       struct intel_uncore_pmu *pmu;
> +       const int template_len =3D 8;
> +
> +       for (i =3D 0; i < type->num_boxes; i++) {
> +               pmu =3D type->pmus + i;
> +               /* Root bus 0x00 is valid only for die 0 AND pmu_idx =3D =
0. */
> +               if (skx_iio_topology_byte(type->platform_topology, 0, pmu=
->pmu_idx) || (!pmu->pmu_idx)) {
> +                       pmu->platform_mapping =3D
> +                               kzalloc(get_max_dies() * template_len + 1=
, GFP_KERNEL);
> +                       if (pmu->platform_mapping) {
> +                               buf =3D (char *)pmu->platform_mapping;
> +                               for (die =3D 0; die < get_max_dies(); die=
++)
> +                                       buf +=3D snprintf(buf, template_l=
en + 1, "%04x:%02x,", 0,
> +                                               skx_iio_topology_byte(typ=
e->platform_topology,
> +                                                                     die=
, pmu->pmu_idx));
> +
> +                               *(--buf) =3D '\0';
> +                       } else {
> +                               for (; i >=3D 0; i--)
> +                                       kfree((type->pmus + i)->platform_=
mapping);
> +                               ret =3D -ENOMEM;
> +                               break;
> +                       }
> +               }
> +       }
> +
> +       kfree(type->platform_topology);
> +       return ret;
> +}
> +
>  void skx_uncore_cpu_init(void)
>  {
>         skx_uncore_chabox.num_boxes =3D skx_count_chabox();
> --
> 2.19.1
>
