Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09781C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 13:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C44EA21479
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 13:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="X8XA47k/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfEINYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 09:24:45 -0400
Received: from mail-eopbgr730086.outbound.protection.outlook.com ([40.107.73.86]:38299
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726192AbfEINYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 09:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwdgdbBjIlUqjveA77m91csMkiU8CycMHUbz3zGIzz8=;
 b=X8XA47k/dHpakSol4r4PPYa+oOFlhlwUuAkLebzZx9xkQdUx3/orZ0TLL8YTc+gDfOR66P4DTpz392IP4P9QThStpg7HEXiBtJb1I2zVXhFuwZghxhUEtcZ8IcOQNkyj3vliFp2SkSYNTZ7Z7f4UHfAH8bT1n/WhvIWMhf4SPVA=
Received: from SN6PR12MB2734.namprd12.prod.outlook.com (52.135.107.25) by
 SN6PR12MB2701.namprd12.prod.outlook.com (52.135.103.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.21; Thu, 9 May 2019 13:24:02 +0000
Received: from SN6PR12MB2734.namprd12.prod.outlook.com
 ([fe80::e104:f933:eac3:17e1]) by SN6PR12MB2734.namprd12.prod.outlook.com
 ([fe80::e104:f933:eac3:17e1%3]) with mapi id 15.20.1856.016; Thu, 9 May 2019
 13:24:01 +0000
From:   "Kirkendall, Garrett" <Garrett.Kirkendall@amd.com>
To:     "nstange@suse.de" <nstange@suse.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "luto@kernel.org" <luto@kernel.org>,
        "natechancellor@gmail.com" <natechancellor@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: arch/x86/kernel/apic/apic.c: calibrate_APIC_clock() soft hangs when
 PIC is not configured by BIOS before kernel is launched.
Thread-Topic: arch/x86/kernel/apic/apic.c: calibrate_APIC_clock() soft hangs
 when PIC is not configured by BIOS before kernel is launched.
Thread-Index: AdUGZ4c7BUF+pyITRvC/KjOnIn2XoQAAqFTg
Date:   Thu, 9 May 2019 13:24:01 +0000
Message-ID: <SN6PR12MB2734B49FDFEAC6CE5D93687185330@SN6PR12MB2734.namprd12.prod.outlook.com>
References: <SN6PR12MB2734813FB27C43E06F5B4E3D85330@SN6PR12MB2734.namprd12.prod.outlook.com>
In-Reply-To: <SN6PR12MB2734813FB27C43E06F5B4E3D85330@SN6PR12MB2734.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Garrett.Kirkendall@amd.com; 
x-originating-ip: [135.26.38.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 681aad6b-7b36-46d3-d65e-08d6d4819a0b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2701;
x-ms-traffictypediagnostic: SN6PR12MB2701:
x-ms-exchange-purlcount: 19
x-microsoft-antispam-prvs: <SN6PR12MB27015F7610335B3582E64DE085330@SN6PR12MB2701.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 003245E729
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(366004)(396003)(376002)(39860400002)(346002)(136003)(189003)(199004)(2906002)(4326008)(5660300002)(186003)(26005)(102836004)(478600001)(446003)(11346002)(53936002)(966005)(72206003)(476003)(14454004)(6306002)(9686003)(2501003)(486006)(25786009)(3846002)(8676002)(81156014)(81166006)(6116002)(68736007)(99286004)(71190400001)(2201001)(6436002)(110136005)(33656002)(7736002)(305945005)(74316002)(55016002)(76116006)(2940100002)(8936002)(86362001)(316002)(71200400001)(64756008)(66556008)(66476007)(76176011)(73956011)(66946007)(66446008)(6506007)(256004)(52536014)(7696005)(66066001)(18886065003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2701;H:SN6PR12MB2734.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: T1Y87jiccy3yYqk4/GWrDxa2212h34SQIezwTDYaorap94PZH+Z1L9T79pimWeAeS3j7cTSUnvb59cypxoWojecJLfGmuUj6UWllPaH9k2KOA54mMkBcH7vatoSILrSGCtPXBFpugs55+VSOeyLmiSUc90+I+x9eCmraHKtnyiQrjXzxFcG2Og++P8DjTjCIBg8BEt8LLAecnrWL3jZ9e5mrAo22aLFi32WzJrsmOv4S7x0ZGqY/107TkDri7HN8TENEUPwpA/DeojJwXSIKZNRTfqPh/RuM4/3gB2aoQjFqdTnKwPrIO64/JzaSRrDdGVv7NYWQr8e3HFYEaIlTPJqUUOSI+W1QJ3UzsQNR2tpSmS0T1gCa/mwgu1pDavodfKqxPSbCbgzQ2S2nj9NxqlWMoq44gd+GhV62QOeOGkg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 681aad6b-7b36-46d3-d65e-08d6d4819a0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2019 13:24:01.8849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2701
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, resending as plain text for linux-kernel@vger.kernel.org

I am trying to boot a UEFI BIOS with minimal legacy hardware support.=A0 Th=
e Linux kernel soft hangs when the PIC is not configured by the BIOS becaus=
e it is using IOAPIC.=A0 Hopefully, this provides enough information.

Observed under Ubuntu Server Linux 18.04 LTS with kernel 4.15.0, and with k=
ernel compiled from source tag v5.0

Where it hangs:
Soft hang occurs in calibrate_APIC_clock(): https://github.com/torvalds/lin=
ux/blob/v5.0/arch/x86/kernel/apic/apic.c#L805
specific location of soft hang waiting for interrupts: https://github.com/t=
orvalds/linux/blob/v5.0/arch/x86/kernel/apic/apic.c#L854


How it gets to the hang:
If 8259A PIC is not configured before kernel is launched, HPET IRQ 0 regist=
ration fails because probe_8259A returns PIC as not available and therefore=
 interrupt descriptors 0-15 are not allocated.=A0 This happens when BIOS do=
es not configure 8259A PIC because it uses IOAPIC.

This sequence prevents allocating interrupts 0-15 unless PIC is configured =
before kernel starts.=A0 legacy_pic.init =3D init_8259A is not called befor=
e early_irq_init():
=A0 early_irq_init(): https://github.com/torvalds/linux/blob/v5.0/init/main=
.c#L642
=A0=A0=A0 initcnt =3D arch_probe_nr_irqs(): https://github.com/torvalds/lin=
ux/blob/v5.0/kernel/irq/irqdesc.c#L512
=A0=A0=A0=A0=A0 return legacy_pic->probe(): https://github.com/torvalds/lin=
ux/blob/v5.0/arch/x86/kernel/apic/vector.c#L656
=A0=A0=A0=A0=A0=A0=A0 default_legacy_pic.probe: https://github.com/torvalds=
/linux/blob/v5.0/arch/x86/kernel/i8259.c#L418
=A0=A0=A0=A0=A0=A0=A0=A0=A0 probe_8259A(): https://github.com/torvalds/linu=
x/blob/v5.0/arch/x86/kernel/i8259.c#L301
=A0=A0=A0 interrupt 0-15 descriptors not allocated and prevents IOAPIC inte=
rrupts 0-15:=A0 https://github.com/torvalds/linux/blob/v5.0/kernel/irq/irqd=
esc.c#L525

In this call is where init_8259A is called and PIC is initialized.=A0 Howev=
er, interrupt descriptors for 0-15 were not allocated in early_irq_init() s=
equence, so descriptors are not available later.
=A0 init_IRQ() : https://github.com/torvalds/linux/blob/v5.0/init/main.c#L6=
43

This sequence tries to register the HPET to irq0, but irq0 descriptor is no=
t allocated by early_irq_init() sequence:
=A0 late_time_init(): https://github.com/torvalds/linux/blob/v5.0/init/main=
.c#L703
=A0=A0=A0 late_time_init =3D x86_late_time_init: https://github.com/torvald=
s/linux/blob/v5.0/arch/x86/kernel/time.c#L107
=A0=A0=A0=A0=A0 x86_init.timers.timer_init(): https://github.com/torvalds/l=
inux/blob/v5.0/arch/x86/kernel/time.c#L92
=A0=A0=A0 =A0=A0=A0=A0x86_init.timers.timer_init =3D hpet_time_init: https:=
//github.com/torvalds/linux/blob/v5.0/arch/x86/kernel/x86_init.c#L75
=A0=A0=A0=A0=A0=A0=A0=A0=A0 setup_default_timer_irq(): https://github.com/t=
orvalds/linux/blob/v5.0/arch/x86/kernel/time.c#L83
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (setup_irq(0, &irq0)): https://github.=
com/torvalds/linux/blob/v5.0/arch/x86/kernel/time.c#L78

This gets called at some point after the above sequences, I couldn't track =
it all the way back to main.c easily:
=A0 x86_init.timers.setup_percpu_clockev =3D setup_boot_APIC_clock: https:/=
/github.com/torvalds/linux/blob/v5.0/arch/x86/kernel/x86_init.c#L74
=A0=A0 =A0https://github.com/torvalds/linux/blob/v5.0/arch/x86/kernel/apic/=
apic.c#L961
=A0=A0=A0=A0=A0 *** soft hang in calibrate_APIC_clock(): https://github.com=
/torvalds/linux/blob/v5.0/arch/x86/kernel/apic/apic.c#L854



Why I directly emailed people:
$ perl scripts/get_maintainer.pl arch/x86/kernel/i8259.c:
Nicolai Stange <mailto:nstange@suse.de> (commit_signer:1/1=3D100%,authored:=
1/1=3D100%,added_lines:1/1=3D100%)
Thomas Gleixner <mailto:tglx@linutronix.de> (commit_signer:1/1=3D100%)

$ perl scripts/get_maintainer.pl arch/x86/kernel/time.c
Thomas Gleixner <mailto:tglx@linutronix.de> (commit_signer:4/4=3D100%,autho=
red:2/4=3D50%,added_lines:22/24=3D92%)
Andy Lutomirski <mailto:luto@kernel.org> (commit_signer:2/4=3D50%)
Nathan Chancellor <mailto:natechancellor@gmail.com> (commit_signer:1/4=3D25=
%,authored:1/4=3D25%,removed_lines:1/1=3D100%)
Nicolai Stange <mailto:nstange@suse.de> (commit_signer:1/4=3D25%,authored:1=
/4=3D25%)

GARRETT KIRKENDALL
SMTS Firmware Engineer | CTE
7171 Southwest Parkway, Austin, TX 78735 USA=20
AMD=A0=A0 https://www.facebook.com/AMD=A0 |=A0 http://www.amd.com/

