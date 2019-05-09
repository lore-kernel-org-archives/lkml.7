Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D57C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 14:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319E121479
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 14:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PDzwodQ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfEIOPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 10:15:35 -0400
Received: from mail-eopbgr740042.outbound.protection.outlook.com ([40.107.74.42]:28936
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727030AbfEIOPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 10:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hnNrO125lpzhiWvAaCGJSX638Z9131exPQBZHnDy4Q=;
 b=PDzwodQ92FB6mnvMt3ssV9V6wYAtM3aN98ZTum/9VbVdZ2649VxljnFLLzLiTp5HQwbDPDUufx10+D+tCX834/sRxTZ5CiutBCSGOpmtFXX2BG2xELeGMOJWV+u0uCr5+ewJOVRBg7OSd4XzIFQNKaS3GknYL4BeEnqXQaSolCo=
Received: from SN6PR12MB2734.namprd12.prod.outlook.com (52.135.107.25) by
 SN6PR12MB2814.namprd12.prod.outlook.com (52.135.107.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.21; Thu, 9 May 2019 14:15:16 +0000
Received: from SN6PR12MB2734.namprd12.prod.outlook.com
 ([fe80::e104:f933:eac3:17e1]) by SN6PR12MB2734.namprd12.prod.outlook.com
 ([fe80::e104:f933:eac3:17e1%3]) with mapi id 15.20.1856.016; Thu, 9 May 2019
 14:15:16 +0000
From:   "Kirkendall, Garrett" <Garrett.Kirkendall@amd.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "nstange@suse.de" <nstange@suse.de>,
        "luto@kernel.org" <luto@kernel.org>,
        "natechancellor@gmail.com" <natechancellor@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: arch/x86/kernel/apic/apic.c: calibrate_APIC_clock() soft hangs
 when PIC is not configured by BIOS before kernel is launched.
Thread-Topic: arch/x86/kernel/apic/apic.c: calibrate_APIC_clock() soft hangs
 when PIC is not configured by BIOS before kernel is launched.
Thread-Index: AdUGZ4c7BUF+pyITRvC/KjOnIn2XoQAAqFTgAABd0oAAANT3sA==
Date:   Thu, 9 May 2019 14:15:16 +0000
Message-ID: <SN6PR12MB2734370504CF4B89600C8FD885330@SN6PR12MB2734.namprd12.prod.outlook.com>
References: <SN6PR12MB2734813FB27C43E06F5B4E3D85330@SN6PR12MB2734.namprd12.prod.outlook.com>
 <SN6PR12MB2734B49FDFEAC6CE5D93687185330@SN6PR12MB2734.namprd12.prod.outlook.com>
 <alpine.DEB.2.21.1905091526440.3139@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1905091526440.3139@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Garrett.Kirkendall@amd.com; 
x-originating-ip: [135.26.38.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd755cc1-fb55-42b4-dd51-08d6d488c26f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2814;
x-ms-traffictypediagnostic: SN6PR12MB2814:
x-microsoft-antispam-prvs: <SN6PR12MB281493355832AC83359A877B85330@SN6PR12MB2814.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 003245E729
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(366004)(376002)(346002)(13464003)(189003)(199004)(76116006)(74316002)(72206003)(478600001)(14454004)(66556008)(64756008)(66446008)(66476007)(305945005)(66946007)(73956011)(66066001)(316002)(99286004)(256004)(81166006)(55016002)(6436002)(52536014)(26005)(186003)(476003)(11346002)(486006)(9686003)(446003)(2906002)(5660300002)(229853002)(54906003)(6116002)(3846002)(68736007)(71190400001)(71200400001)(6916009)(86362001)(8676002)(81156014)(7736002)(8936002)(4326008)(25786009)(7696005)(33656002)(76176011)(6506007)(53546011)(102836004)(53936002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2814;H:SN6PR12MB2734.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Azw1kkAiGzkHMLjIDSffPqU2NdYFIIJBukUX5y8sIGcd+hNk0Yx5H9eLpSqur4d70LqD8QP7Vc1PfDYTWpV6UrIALVIzvVELOT+IqDrB1r/S1h6fbKpP3blSwgg2nqy3MP0Od+lxAQnWb80c2wEX3jbmpkwEZQesK2XRCr5YQ3MMrjyCQ27SnR74jFFfA7rstxiqyOuKkvlifLswcHbdIcz4iwcax+URrsF5E/mYmzFGpkrzYWq21ArOXDAFPpIln5XaSHR3mtfQYSSwbmVWl+62QzD/51rOYoO9AUzMo5emb9gR8/w+K7KaQfH+h/6qArsJQXpZ+6npj0DQRbUeSFdOiZYZcZ5gKhVECUxnduvpeOXt+uyq6blD8Y26bWE+B0px2734Fck8rQOJlcaU2I4HCgDhcsKADCB7DRODKnc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd755cc1-fb55-42b4-dd51-08d6d488c26f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2019 14:15:16.1094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2814
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.  Is it correct to probe the 8259 before it is initialized by the kernel?=
  The 8259 will not respond properly to the probe unless it is properly ini=
tialized.
2.  Should IOAPIC interrupts 0-15 require the legacy PIC be available and i=
nitialized by the BIOS?
2.  The kernel will not boot if there is no legacy 8259 PIC even if all the=
 other factors stated are provided.

I want to understand why a preinitialized 8259 is a requirement for a syste=
m configured to use the IOAPIC?

GARRETT KIRKENDALL
SMTS Firmware Engineer | CTE
7171 Southwest Parkway, Austin, TX 78735 USA=20
AMD=A0=A0 facebook=A0 |=A0 amd.com

-----Original Message-----
From: Thomas Gleixner <tglx@linutronix.de>=20
Sent: Thursday, May 9, 2019 8:32 AM
To: Kirkendall, Garrett <Garrett.Kirkendall@amd.com>
Cc: nstange@suse.de; luto@kernel.org; natechancellor@gmail.com; x86@kernel.=
org; linux-kernel@vger.kernel.org
Subject: Re: arch/x86/kernel/apic/apic.c: calibrate_APIC_clock() soft hangs=
 when PIC is not configured by BIOS before kernel is launched.

[CAUTION: External Email]

On Thu, 9 May 2019, Kirkendall, Garrett wrote:
> I am trying to boot a UEFI BIOS with minimal legacy hardware support.
> The Linux kernel soft hangs when the PIC is not configured by the BIOS=20
> because it is using IOAPIC.  Hopefully, this provides enough information.
>
> Soft hang occurs in calibrate_APIC_clock():

...

> If 8259A PIC is not configured before kernel is launched, HPET IRQ 0=20
> registration fails because probe_8259A returns PIC as not available=20
> and therefore interrupt descriptors 0-15 are not allocated.  This=20
> happens when BIOS does not configure 8259A PIC because it uses IOAPIC.

Right. Works as designed.

There is not much we can do at that point, unless your platform has other m=
eans to provide the TSC frequency (cpuid or MSR) along with the bus frequen=
cy which is fed into the local apic timer.

Thanks,

        tglx
