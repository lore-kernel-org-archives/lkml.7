Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42449C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 06:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C56321D6C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 06:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jabil.com header.i=@jabil.com header.b="RWwKHCaT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfKGGSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 01:18:06 -0500
Received: from mail-eopbgr750118.outbound.protection.outlook.com ([40.107.75.118]:19586
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725938AbfKGGSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 01:18:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOublqA6YkpgJ+U5AMskIRdVFlqTNGXyK93iBiq2mOlYlY/X0JvHm7ueEjwI65SI/eRn7fJneCArYk5nzpzy+i9eLmr2M6NxmtxgvSYMRCGJSdQ3feogxPPyUCDxs6VpCRw4cEbbfoPiPEbc62DwGMH3SPpYcuPf8gIUzsDJj/MX2Rh/OGVsoggBOHl31gSDdlRRnOVgNGsPcudP+/wH9glhaS+OLgU16UZ1/JmrGPXoxy6wHDarTggyQFnj9Ke1iv1zmiHefqtwFr6tz1Hg+LY5b863MvkByteieozMsm4VFCYn7RNSxlCioOc21zCDjU5B+NrOIAUdsOAhlgAang==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BFCCT6XEnTYKeCtcuqM9cpErYvZODX/95PTm7NRODg=;
 b=HfnQ9L8qeDut7FLZA1YGu6EPIIVoKHq/ajbJcnJDkAtjBD0mCVAxhjehSWYBDBvrYHEdoKL/nC7VJlMzpaPl3TbqTMfJqUazq9nGqMoLsD2efCGO7y+PzzY1ZfjmNW47C9D9XGpbr4k3XSAsQh/quduj3duZzJ6tnzegzwxBFfVJYcqF6fvZzKc8iUAzpgcM1LwbMysDYkBkKd8cM3z1Y/OCUhciD+M5Dcgb+2b1gSSpCp0f579L1iDpuw24DLOgM5k/Tjhgif8xoRTkZKJ9OO0VEgDkxT1DcEArkXZe598Fz99An84ky3QF/ENVKcJUA+Lnnqupms/pzT7/9N51Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jabil.com; dmarc=pass action=none header.from=jabil.com;
 dkim=pass header.d=jabil.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jabil.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BFCCT6XEnTYKeCtcuqM9cpErYvZODX/95PTm7NRODg=;
 b=RWwKHCaTAWHrNOJEWLQRz808uu39GxUC5mJfAE6FElBrI9JC0+NUYCFT/68wvBeOpLDG5N4Nmt8uYufglgiu7FFccw4L1EeBAoWTIBJ2hfH90/N9GS69EqCZQn8hRZkiXEL15ML6KzfCTR1GotLHbY1Rk0w2WKqlZJSaXXt+0iA=
Received: from MN2PR02MB6703.namprd02.prod.outlook.com (52.135.48.83) by
 MN2PR02MB7055.namprd02.prod.outlook.com (20.180.24.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.23; Thu, 7 Nov 2019 06:18:01 +0000
Received: from MN2PR02MB6703.namprd02.prod.outlook.com
 ([fe80::524:774a:6751:7177]) by MN2PR02MB6703.namprd02.prod.outlook.com
 ([fe80::524:774a:6751:7177%5]) with mapi id 15.20.2430.020; Thu, 7 Nov 2019
 06:18:01 +0000
From:   Rain Wang <Rain_Wang@Jabil.com>
To:     Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH] lm75: add lm75b detection
Thread-Topic: [PATCH] lm75: add lm75b detection
Thread-Index: AQHVi9TmDrxen4j80EuOn1QRxLtsQKdvHeCAgACzjQCAAdoIgIANoKcB
Date:   Thu, 7 Nov 2019 06:18:01 +0000
Message-ID: <MN2PR02MB67038B3F8DF699BD0C462C458D780@MN2PR02MB6703.namprd02.prod.outlook.com>
References: <20191026081049.GA16839@rainw-fedora28-jabil.corp.JABIL.ORG>
 <7a2ddf42-8bbe-59e0-dae8-85b184ea0da0@roeck-us.net>
 <20191028104618.5f21af38@endymion>,<82a0b331-daa0-af9a-a7d0-0f1b3246ea49@roeck-us.net>
In-Reply-To: <82a0b331-daa0-af9a-a7d0-0f1b3246ea49@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rain_Wang@Jabil.com; 
x-originating-ip: [180.167.230.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 021d2cd1-882a-4c20-7c21-08d7634a3e38
x-ms-traffictypediagnostic: MN2PR02MB7055:
x-microsoft-antispam-prvs: <MN2PR02MB7055666F1F322C26881604E38D780@MN2PR02MB7055.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(199004)(189003)(76116006)(91956017)(33656002)(7736002)(305945005)(66066001)(478600001)(81166006)(81156014)(8676002)(74316002)(446003)(76176011)(11346002)(7696005)(6436002)(66446008)(476003)(2906002)(64756008)(6506007)(66946007)(8936002)(316002)(66476007)(66556008)(486006)(99286004)(55016002)(229853002)(25786009)(3846002)(26005)(6116002)(14444005)(256004)(110136005)(54906003)(14454004)(186003)(80792005)(6246003)(5660300002)(71190400001)(71200400001)(9686003)(52536014)(102836004)(4326008)(86362001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR02MB7055;H:MN2PR02MB6703.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: Jabil.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rYr6JKRrNN6nwFIIO3c/qoMdJ8fIXYYJIr4cZei8T6cIxb4EMFWzz7htfnkYN1v23dgu+Z0/NeWCOqlmFIX1dbiX5/ENHJDonS0zAH7GCxwQSYd22odWLCY41l6NUn7b3r20+dOWXZ9uJMX8g2ZapWcxisu7Ad+RsvXRmTqKjgXrz+/oN9ufARNBum9e1HEib4oZgF8CV7GQ4pVyVOhEDf6rs2pRhg5MVEqEkkOVpGu9U1Z4EkhulV8KeYDxxG4xaVmkTQo/MayW092VXqiI/FFyDfU3ggeLz3Uif5X2kfOJsWPKQbYCyVogPzJCtxVUHBe+xi4VhY7VC3WC6J+grqji53anSwtbHdvi3FTUqUN3j+u1xjvAmstDj4ZjvZ/up8E6ZlXngSKVUCdRU2BMU552w4aPThcqmQPSBVqP0AaQ4CTzDQEg3Bnk8vlZRtG9
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: jabil.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 021d2cd1-882a-4c20-7c21-08d7634a3e38
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 06:18:01.7051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bc876b21-f134-4c12-a265-8ed26b7f0f3b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: laqCESImwgGadcHZTAjWoUWau/mJFBapHa3O0dTtXx7e6Xvl6RH4smIXnO8bnuZRPwVRQKPDMNDR0uDF+7iZgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7055
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for my late reply, =0A=
=0A=
>FWIW, I don't think there is anything to implement; I don't see any=0A=
>differences in functionality.=0A=
Yes, no functional difference but the detection=0A=
=0A=
>I am much more concerned about weakening the already weak detection even f=
urther:=0A=
>As written, each chip with register 0x07 !=3D 0xa1 will be identified as L=
M75B.=0A=
>Even if that was strengthened to actually check if the register value is 0=
xff,=0A=
>we have no idea what other vendors might implement in those registers. it =
would=0A=
>most certainly mis-identify LM75C as LM75B. Not that it really matters if=
=0A=
>the chip _is_ a LM75C, but who knows if other chips fit that identificatio=
n=0A=
>pattern.=0A=
Yes, that's also my concern on the code of detection. I don't have any othe=
r sensors as=0A=
LM75C to try, so thinking maybe some other guys can help extend it if neede=
d in future.=0A=
=0A=
>Overall, my suggestion is to add a small startup script to affected system=
s=0A=
>to instantiate the chip directly, and avoid weakening the detect function.=
=0A=
Understood, we can have the instantiating script but just don't want limit =
the detection.=0A=
Thanks!=
