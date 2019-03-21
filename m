Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97E7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714FB218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="tqKHolOd";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="JfhmwQV1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbfCUKIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 06:08:48 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:34426 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728253AbfCUKIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 06:08:46 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2LA6dWD000508;
        Thu, 21 Mar 2019 03:08:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=7xOCRpQzGQvWQstaXFlyd3aFOcq3d1Gn43JKhexcxEk=;
 b=tqKHolOdCRMn160NhIAshxL+PcEimp3+J3gEYMSqNnqlrFEU3i963bLjBZ5jrVVU/mrF
 tpe7tlcxCcKB2mRI3/rxq/lobh7RFbeBP6XV4zOuE3/g9+1IDbD8grQUn0K1FWnSw6zj
 YhjbyCber/gqQCD5O/FwWj9IjtoxM/LAa9YiEgLU+EfcnKWTmv9ecxTKaNmUm8fo8Fli
 J67tiEptk3v/pFdVF07gms9LG1XgUN52H6BbW4d6UD2XOkaAVTUKHNzyfsBxQqC6ruro
 ENs3qBSWitWyaBQFsSd/VvYvBu0VKJpPrc/APObA7WT3wA5GkeE9s14YcPdxsfSh3LeY SA== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2rc051h76n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 21 Mar 2019 03:08:29 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 21 Mar
 2019 03:08:27 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.59) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 21 Mar 2019 03:08:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xOCRpQzGQvWQstaXFlyd3aFOcq3d1Gn43JKhexcxEk=;
 b=JfhmwQV1jn2yLRCHXaJYbhNWLibR9nIRW3MNId1Kv+Kq2mfFP9ghYFOcoqKmTXlN2+Qj35Pnh7TbjFiVVYshGib634CFf9wF9sok0iLkc8HDfSpzjC1AMuEwEbrvOYaxvCAJhQo4/PoSHj0XKFA2vbpyTUs8/98e16FZ4BhoIb0=
Received: from BL0PR18MB2305.namprd18.prod.outlook.com (52.132.30.25) by
 BL0PR18MB2147.namprd18.prod.outlook.com (52.132.29.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Thu, 21 Mar 2019 10:08:25 +0000
Received: from BL0PR18MB2305.namprd18.prod.outlook.com
 ([fe80::d42:95e4:7e1c:76b6]) by BL0PR18MB2305.namprd18.prod.outlook.com
 ([fe80::d42:95e4:7e1c:76b6%5]) with mapi id 15.20.1709.017; Thu, 21 Mar 2019
 10:08:25 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Marcin Benka <mbenka@marvell.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
Subject: Re: [PATCH v2] efi: Unify dmi setup code over architectures
 arm/arm64, io64 and x86
Thread-Topic: [PATCH v2] efi: Unify dmi setup code over architectures
 arm/arm64, io64 and x86
Thread-Index: AQHU384FzBwbE8UY+UOKBFLx5lrsVA==
Date:   Thu, 21 Mar 2019 10:08:25 +0000
Message-ID: <20190321100819.ok3uuojjvegjjlpg@rric.localdomain>
References: <20190320130502.16667-1-rrichter@marvell.com>
 <20190320131607.vgst3r7ynha55ikw@rric.localdomain>
 <20190320152240.2eun63wqkbqmuqkg@rric.localdomain>
 <CAKv+Gu8HKUQPr7TaUm7EwdVFasUitAPBJFotpG43nNAKMBvxdA@mail.gmail.com>
 <20190321093920.beng2d3tbfvydbud@rric.localdomain>
 <CAKv+Gu899a5FpMqOzF5EVgsHRk37_PBxW8kVicgc8ST3=R_VUA@mail.gmail.com>
In-Reply-To: <CAKv+Gu899a5FpMqOzF5EVgsHRk37_PBxW8kVicgc8ST3=R_VUA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P191CA0044.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:7f::21) To BL0PR18MB2305.namprd18.prod.outlook.com
 (2603:10b6:207:43::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.183.166.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 365ccd3b-99e9-4047-63c3-08d6ade52823
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BL0PR18MB2147;
x-ms-traffictypediagnostic: BL0PR18MB2147:
x-microsoft-antispam-prvs: <BL0PR18MB214751684652940546E58668D9420@BL0PR18MB2147.namprd18.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(39860400002)(376002)(346002)(189003)(199004)(52314003)(5660300002)(26005)(86362001)(476003)(486006)(81166006)(8676002)(81156014)(102836004)(4326008)(25786009)(6506007)(97736004)(105586002)(53936002)(386003)(99286004)(106356001)(53546011)(14454004)(478600001)(8936002)(1076003)(6246003)(76176011)(93886005)(52116002)(71200400001)(71190400001)(7416002)(229853002)(6486002)(66066001)(305945005)(6436002)(6916009)(316002)(54906003)(186003)(3846002)(446003)(6116002)(7736002)(11346002)(256004)(9686003)(6512007)(68736007)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR18MB2147;H:BL0PR18MB2305.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: H0A3tvHvOMDl7ONtlYFsOREjSbObV4gUQDppskbsjr0V3pUCUgzxgjuMmcpEdjjjXHi1qubPF9VEbkuwhU7FmNhchVOaoa1rwoj4JQn1ZSVHVIL+ZkJ88V/hr7+qT3e9JuHfAFkcpU3r17AME8K7cmwfggwl32twEEk4xPHcKUism9GkNZF67Ah6QLmTTV8rH7E1EihxurssSCCsQcZhPh66LttFN6CnkP8yNcQctNhuAk3TmQ3fSk+wljWP89fvV+8HyiUZ6Or8+lsOYYc6YfJqGtawnv2VgRXz+DNHPoslN5k9+F/laf1efX28np+rermkCJiR5LT8JgcvNG5azHVAakcW5hQdCebOCjdjbwFYE61LPq21ZceQA6GJDoPM0ihsNOxQs/CBsEzJ0zAapSU6D5TqZw9DHis0BtzHk3M=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C3DAC4D774E94246893AB20092FA57FC@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 365ccd3b-99e9-4047-63c3-08d6ade52823
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 10:08:25.5130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR18MB2147
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-21_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.03.19 10:51:34, Ard Biesheuvel wrote:
> On Thu, 21 Mar 2019 at 10:39, Robert Richter <rrichter@marvell.com> wrote=
:
> >
> > On 20.03.19 23:02:09, Ard Biesheuvel wrote:
> > > On Wed, 20 Mar 2019 at 16:23, Robert Richter <rrichter@marvell.com> w=
rote:
> > > >
> > > > On 20.03.19 14:16:07, Robert Richter wrote:
> > > > > On 20.03.19 13:05:37, Robert Richter wrote:
> > > > > > @@ -167,6 +167,7 @@ static int __init arm_dmi_init(void)
> > > > > >      * itself, depends on dmi_scan_machine() having been called=
 already.
> > > > > >      */
> > > > > >     dmi_scan_machine();
> > > > > > +   dmi_memdev_walk();
> > > > > >     if (dmi_available)
> > > > > >             dmi_set_dump_stack_arch_desc();
> > > > > >     return 0;
> > > > >
> > > > > After
> > > > >
> > > > >  [PATCH] efi/arm: Show SMBIOS bank/device location in cper and
> > > > >   ghes error logs
> > > > >
> > > > > wents in for arm/arm64, we can unify the code. See patch below.
> > > >
> > > > V2 with the fix in arm_dmi_init() below.
> > > >
> > > > -Robert
> > > >
> > > >
> > > > -- >8 --
> > > > From: Robert Richter <rrichter@marvell.com>
> > > > Subject: [PATCH v2] efi: Unify dmi setup code over architectures ar=
m/arm64,
> > > >  io64 and x86
> > > >
> > > > All architectures (arm/arm64, io64 and x86) do the same here, so un=
ify
> > > > the code.
> > > >
> > > > Note: We do not need to call dump_stack_set_arch_desc() in case of
> > > > !dmi_available. Both strings, dmi_ids_string and dump_stack_arch_
> > > > desc_str are initialized zero and thus nothing would change.
> > > >
> > >
> > > I don't understand the last sentence - we do not need to call
> > > dump_stack_set_arch_desc() when !dmi_available, but we do so anyway,
> > > right? Doesn't that wipe the arch description we set based on the DT
> > > machine name?
> >
> > No, in dmi_setup() we exit early when !dmi_available. So for arm/arm64
> > nothing changed. But for x86 and ia64 we no longer call dump_stack_
> > set_arch_desc() in this case. This is ok since both strings,
> > dmi_ids_string and dump_stack_arch_desc_str, are initialized zero and
> > copying one to the other does not change anything.
> >
>=20
> Ah, of course. Apologies for not reading more carefully.
>=20
> I'll take this patch via the EFI tree.
>=20
> It seems to me though that the previous patch makes the memdev_walk()
> call unconditional for ARM, and this change subsequently makes it
> dependent on dmi_available. Should we fix that?

The first patch has the check in memdev_walk(). So that is looking
good. The check is then moved to dmi_setup() in the 2nd patch.

Thanks for handling this.

-Robert

>=20
> > >
> > > > Signed-off-by: Robert Richter <rrichter@marvell.com>
> > > > ---
> > > >  arch/ia64/kernel/setup.c           |  4 +---
> > > >  arch/x86/kernel/setup.c            |  6 ++----
> > > >  drivers/firmware/dmi_scan.c        | 28 +++++++++++++++-----------=
--
> > > >  drivers/firmware/efi/arm-runtime.c |  7 ++-----
> > > >  include/linux/dmi.h                |  8 ++------
> > > >  5 files changed, 22 insertions(+), 31 deletions(-)
> > > >
> > > > diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
> > > > index 583a3746d70b..c9cfa760cd57 100644
> > > > --- a/arch/ia64/kernel/setup.c
> > > > +++ b/arch/ia64/kernel/setup.c
> > > > @@ -1058,9 +1058,7 @@ check_bugs (void)
> > > >
> > > >  static int __init run_dmi_scan(void)
> > > >  {
> > > > -       dmi_scan_machine();
> > > > -       dmi_memdev_walk();
> > > > -       dmi_set_dump_stack_arch_desc();
> > > > +       dmi_setup();
> > > >         return 0;
> > > >  }
> > > >  core_initcall(run_dmi_scan);
> > > > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > > > index 3d872a527cd9..3773905cd2c1 100644
> > > > --- a/arch/x86/kernel/setup.c
> > > > +++ b/arch/x86/kernel/setup.c
> > > > @@ -1005,13 +1005,11 @@ void __init setup_arch(char **cmdline_p)
> > > >         if (efi_enabled(EFI_BOOT))
> > > >                 efi_init();
> > > >
> > > > -       dmi_scan_machine();
> > > > -       dmi_memdev_walk();
> > > > -       dmi_set_dump_stack_arch_desc();
> > > > +       dmi_setup();
> > > >
> > > >         /*
> > > >          * VMware detection requires dmi to be available, so this
> > > > -        * needs to be done after dmi_scan_machine(), for the boot =
CPU.
> > > > +        * needs to be done after dmi_setup(), for the boot CPU.
> > > >          */
> > > >         init_hypervisor_platform();
> > > >
> > > > diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_sca=
n.c
> > > > index 099d83e4e910..fae2d5c43314 100644
> > > > --- a/drivers/firmware/dmi_scan.c
> > > > +++ b/drivers/firmware/dmi_scan.c
> > > > @@ -416,11 +416,8 @@ static void __init save_mem_devices(const stru=
ct dmi_header *dm, void *v)
> > > >         nr++;
> > > >  }
> > > >
> > > > -void __init dmi_memdev_walk(void)
> > > > +static void __init dmi_memdev_walk(void)
> > > >  {
> > > > -       if (!dmi_available)
> > > > -               return;
> > > > -
> > > >         if (dmi_walk_early(count_mem_devices) =3D=3D 0 && dmi_memde=
v_nr) {
> > > >                 dmi_memdev =3D dmi_alloc(sizeof(*dmi_memdev) * dmi_=
memdev_nr);
> > > >                 if (dmi_memdev)
> > > > @@ -614,7 +611,7 @@ static int __init dmi_smbios3_present(const u8 =
*buf)
> > > >         return 1;
> > > >  }
> > > >
> > > > -void __init dmi_scan_machine(void)
> > > > +static void __init dmi_scan_machine(void)
> > > >  {
> > > >         char __iomem *p, *q;
> > > >         char buf[32];
> > > > @@ -769,15 +766,20 @@ static int __init dmi_init(void)
> > > >  subsys_initcall(dmi_init);
> > > >
> > > >  /**
> > > > - * dmi_set_dump_stack_arch_desc - set arch description for dump_st=
ack()
> > > > + *     dmi_setup - scan and setup DMI system information
> > > >   *
> > > > - * Invoke dump_stack_set_arch_desc() with DMI system information s=
o that
> > > > - * DMI identifiers are printed out on task dumps.  Arch boot code =
should
> > > > - * call this function after dmi_scan_machine() if it wants to prin=
t out DMI
> > > > - * identifiers on task dumps.
> > > > + *     Scan the DMI system information. This setups DMI identifier=
s
> > > > + *     (dmi_system_id) for printing it out on task dumps and prepa=
res
> > > > + *     DIMM entry information (dmi_memdev_info) from the SMBIOS ta=
ble
> > > > + *     for using this when reporting memory errors.
> > > >   */
> > > > -void __init dmi_set_dump_stack_arch_desc(void)
> > > > +void __init dmi_setup(void)
> > > >  {
> > > > +       dmi_scan_machine();
> > > > +       if (!dmi_available)
> > > > +               return;
> > > > +
> > > > +       dmi_memdev_walk();
> > > >         dump_stack_set_arch_desc("%s", dmi_ids_string);
> > > >  }
> > > >
> > > > @@ -841,7 +843,7 @@ static bool dmi_is_end_of_table(const struct dm=
i_system_id *dmi)
> > > >   *     returns non zero or we hit the end. Callback function is ca=
lled for
> > > >   *     each successful match. Returns the number of matches.
> > > >   *
> > > > - *     dmi_scan_machine must be called before this function is cal=
led.
> > > > + *     dmi_setup must be called before this function is called.
> > > >   */
> > > >  int dmi_check_system(const struct dmi_system_id *list)
> > > >  {
> > > > @@ -871,7 +873,7 @@ EXPORT_SYMBOL(dmi_check_system);
> > > >   *     Walk the blacklist table until the first match is found.  R=
eturn the
> > > >   *     pointer to the matching entry or NULL if there's no match.
> > > >   *
> > > > - *     dmi_scan_machine must be called before this function is cal=
led.
> > > > + *     dmi_setup must be called before this function is called.
> > > >   */
> > > >  const struct dmi_system_id *dmi_first_match(const struct dmi_syste=
m_id *list)
> > > >  {
> > > > diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/=
efi/arm-runtime.c
> > > > index 4a0dfe4ab829..e2ac5fa5531b 100644
> > > > --- a/drivers/firmware/efi/arm-runtime.c
> > > > +++ b/drivers/firmware/efi/arm-runtime.c
> > > > @@ -162,14 +162,11 @@ void efi_virtmap_unload(void)
> > > >  static int __init arm_dmi_init(void)
> > > >  {
> > > >         /*
> > > > -        * On arm64/ARM, DMI depends on UEFI, and dmi_scan_machine(=
) needs to
> > > > +        * On arm64/ARM, DMI depends on UEFI, and dmi_setup() needs=
 to
> > > >          * be called early because dmi_id_init(), which is an arch_=
initcall
> > > >          * itself, depends on dmi_scan_machine() having been called=
 already.
> > > >          */
> > > > -       dmi_scan_machine();
> > > > -       dmi_memdev_walk();
> > > > -       if (dmi_available)
> > > > -               dmi_set_dump_stack_arch_desc();
> > > > +       dmi_setup();
> > > >         return 0;
> > > >  }
> > > >  core_initcall(arm_dmi_init);
> > > > diff --git a/include/linux/dmi.h b/include/linux/dmi.h
> > > > index c46fdb36700b..8de8c4f15163 100644
> > > > --- a/include/linux/dmi.h
> > > > +++ b/include/linux/dmi.h
> > > > @@ -102,9 +102,7 @@ const struct dmi_system_id *dmi_first_match(con=
st struct dmi_system_id *list);
> > > >  extern const char * dmi_get_system_info(int field);
> > > >  extern const struct dmi_device * dmi_find_device(int type, const c=
har *name,
> > > >         const struct dmi_device *from);
> > > > -extern void dmi_scan_machine(void);
> > > > -extern void dmi_memdev_walk(void);
> > > > -extern void dmi_set_dump_stack_arch_desc(void);
> > > > +extern void dmi_setup(void);
> > > >  extern bool dmi_get_date(int field, int *yearp, int *monthp, int *=
dayp);
> > > >  extern int dmi_get_bios_year(void);
> > > >  extern int dmi_name_in_vendors(const char *str);
> > > > @@ -122,9 +120,7 @@ static inline int dmi_check_system(const struct=
 dmi_system_id *list) { return 0;
> > > >  static inline const char * dmi_get_system_info(int field) { return=
 NULL; }
> > > >  static inline const struct dmi_device * dmi_find_device(int type, =
const char *name,
> > > >         const struct dmi_device *from) { return NULL; }
> > > > -static inline void dmi_scan_machine(void) { return; }
> > > > -static inline void dmi_memdev_walk(void) { }
> > > > -static inline void dmi_set_dump_stack_arch_desc(void) { }
> > > > +static inline void dmi_setup(void) { }
> > > >  static inline bool dmi_get_date(int field, int *yearp, int *monthp=
, int *dayp)
> > > >  {
> > > >         if (yearp)
> > > > --
> > > > 2.20.1
> > > >
