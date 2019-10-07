Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F8AC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6850320684
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="dKBl5br6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbfJGT3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 15:29:30 -0400
Received: from mail-eopbgr690069.outbound.protection.outlook.com ([40.107.69.69]:58951
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728187AbfJGT33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 15:29:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCmBR35CGz8h6hs7mAcgNq/RWFYRn8Umf8lvuChT7bQBtoeR6PTJzq1clAQigebO3IG3cl1BC6YxFw0mUxVQTeuZgzFN+8+8NCFLT9Y8gCrEd/q75UeAPvdLs/1MJkVtWcfSDEfVRY6l04aEVu/wIyDKB6vqFxQ+tkOQ6mPMRr/fYGQXoZnySps/JmzIljMs5xi9LsbZsDpcjw2DfiZU4O7pjXtOpmKGSxR9dsmspDEl96E6wgIeCCrEau9enZfAN0Tc0Uc4ePtETj+qARn/LGPBqRE4vGaHTxv55ODIEQxCbtoC/t2sbEPkpelvKgfojsUIFIfY3qOKC5wuCoKbwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONPJpe0AbrFj6+FCCIflefygHdTt0Cld+Qu7CYsUMwE=;
 b=ogd0k16FQE8KBPxk24GtN8JmCpV2kUBDaJ3L4+h8ynSzb9g7KCCXuzB+7OjeMiiXjYMWUFhANqcOe56zDZELyzuptZveEyGayI6Q5ZZvy+HLgnP1d9D2+aaxCkRPtzkBA7WtqpsCrDS2tcwo8EVZStDdB6/oDQdjVFtTXvm1b3V4r88i0OxKgFKs7e0DogskzWxktV+vzZ0/0U4dGRIy4yrOmsof/I+Nc3Z9Xo12cap4urmxaMqjY4pDhTklqNZayVULwtwGM/TnSs17B5TPgL2L5yDgKwjiGBBhR8FN1GxA6qaTwVlBOMbKmLN34m9zCivhZEes9UaPgMRm0p5hHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONPJpe0AbrFj6+FCCIflefygHdTt0Cld+Qu7CYsUMwE=;
 b=dKBl5br6TZIPafe2rGRaKDekti8Cy+6hweJPpzB/AVh3OgWRCOvjdVEh5gJWKfcTS/8kKJUwieV22peNEzhmTw6me6BVRdN6N120FFJmF/AX6U65TeEVupFxWKmg/1X26sgvnzuQu5AVCnJ4fqy68z2tcJE2HkraDSGBWZOMQM0=
Received: from MN2PR05MB6141.namprd05.prod.outlook.com (20.178.241.217) by
 MN2PR05MB6912.namprd05.prod.outlook.com (10.255.90.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.13; Mon, 7 Oct 2019 19:29:26 +0000
Received: from MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::286f:c413:5df1:4eb9]) by MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::286f:c413:5df1:4eb9%4]) with mapi id 15.20.2347.014; Mon, 7 Oct 2019
 19:29:26 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     Sami Tolvanen <samitolvanen@google.com>,
        Pv-drivers <Pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
CC:     "hpa@zytor.com" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] x86/cpu/vmware: use the full form of inl in VMWARE_PORT
Thread-Topic: [PATCH] x86/cpu/vmware: use the full form of inl in VMWARE_PORT
Thread-Index: AQHVfURwrG7JjV813kemwOGXD7IdVA==
Date:   Mon, 7 Oct 2019 19:29:25 +0000
Message-ID: <MN2PR05MB61419440A3C9FF9CB920BCD5A19B0@MN2PR05MB6141.namprd05.prod.outlook.com>
References: <20191007192129.104336-1-samitolvanen@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
x-originating-ip: [155.4.205.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8314af5d-5b1d-4eb9-afe3-08d74b5caa32
x-ms-traffictypediagnostic: MN2PR05MB6912:|MN2PR05MB6912:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR05MB69120503596FB5AA1B42395CA19B0@MN2PR05MB6912.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01834E39B7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(189003)(199004)(186003)(14444005)(102836004)(55016002)(7416002)(71200400001)(25786009)(4326008)(54906003)(110136005)(52536014)(99286004)(33656002)(53546011)(6506007)(316002)(476003)(71190400001)(6246003)(305945005)(74316002)(26005)(486006)(7696005)(5660300002)(256004)(4744005)(76176011)(7736002)(446003)(229853002)(81166006)(81156014)(478600001)(2906002)(86362001)(8676002)(76116006)(66066001)(66476007)(91956017)(14454004)(6436002)(3846002)(64756008)(66446008)(6116002)(8936002)(9686003)(66556008)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR05MB6912;H:MN2PR05MB6141.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sots98vnudO2iJgRJHKwklC+krB10B8BMcpTAt6BgYSZ50SxnKkGXvYfMLGG8C8YjsaHi3iFvLGcbLmlW2gZonyN3QrxFqqQWHKEzFWGrVVMd+OFZAXWdPQ/V1SqsbpofacWDst8CqC3e47KfdbfQR1QmXs8zIAzogCzFY3drgckPN+0Pp+/ZKsEqpPJL58jPBRTqYPirl6Wxy5jYYTdtYEop69Corm8tE3UNMbLnKc0LZGqNSF2pC54c3DjYS0wPF6UGYYzLWPl4HEgxcBs4PjV1sHfWXcOORpk+C12YAI0L2eRCWy+zpGusgbcXGlLJrqBjNk3gXCIci10vQOaFUWwaiv+AF97iQKnVHvlMP76HkZPZHIrokcbiC1Qv2IyN/iONDACrhngWplz7VhcPs4+Pa9++SEQDRs72YNOseI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8314af5d-5b1d-4eb9-afe3-08d74b5caa32
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2019 19:29:25.8468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V5etzFhNZZ2Wr/12WoULnQ+iOCMY5vynmCkPI5iSobh1Z3uvF1rox7eZJuVxBRzx3RoNIdIesHtLYrmOgitvDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6912
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/19 9:21 PM, Sami Tolvanen wrote:=0A=
> LLVM's assembler doesn't accept the short form inl (%%dx) instruction,=0A=
> but instead insists on the output register to be explicitly specified:=0A=
>=0A=
>   <inline asm>:1:7: error: invalid operand for instruction=0A=
>           inl (%dx)=0A=
>              ^=0A=
>   LLVM ERROR: Error parsing inline asm=0A=
>=0A=
> Use the full form of the instruction to fix the build.=0A=
>=0A=
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>=0A=
=0A=
Acked-by: Thomas Hellstrom <thellstrom@vmware.com>=0A=
=0A=
> ---=0A=
>  arch/x86/kernel/cpu/vmware.c | 2 +-=0A=
>  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
>=0A=
> diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c=
=0A=
> index 9735139cfdf8..46d732696c1c 100644=0A=
> --- a/arch/x86/kernel/cpu/vmware.c=0A=
> +++ b/arch/x86/kernel/cpu/vmware.c=0A=
> @@ -49,7 +49,7 @@=0A=
>  #define VMWARE_CMD_VCPU_RESERVED 31=0A=
>  =0A=
>  #define VMWARE_PORT(cmd, eax, ebx, ecx, edx)				\=0A=
> -	__asm__("inl (%%dx)" :						\=0A=
> +	__asm__("inl (%%dx), %%eax" :					\=0A=
>  		"=3Da"(eax), "=3Dc"(ecx), "=3Dd"(edx), "=3Db"(ebx) :		\=0A=
>  		"a"(VMWARE_HYPERVISOR_MAGIC),				\=0A=
>  		"c"(VMWARE_CMD_##cmd),					\=0A=
=0A=
=0A=
