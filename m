Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45E3C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 21:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7CD21655
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 21:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="n+owhPuD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgABVCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 16:02:01 -0500
Received: from mail-mw2nam12on2084.outbound.protection.outlook.com ([40.107.244.84]:61408
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725783AbgABVCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 16:02:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDdI1SOwq4FsBHMhljtCh8ShUhhS8wr9geWjlFktxKbWu2hPccms3iOTGeW9Tu8cobTrPSg66QcA6LcEkdiFAuwMkjY0VdjlwGNcRfoFKtzNzta2zwey7/VzX92RaotsS6K+cEwMK6fF/eYmNNADNXEzwrzejIBAS/IAikweafu2XmrI3LuXH4nIGEIsCVhJrqrJeN2mYoWuFsm2N+6oxy33/8FyHoS51Q+814/qnSSXCp84dm4//d2igN7KIcElK5ELoEoEVAK4ZwEVX8JZIj10PvsHmKsOaf/suJUlOfzzA3mWhyTZelUpmAlkWrgzFQAQ2Cngifjvz4/pkVgfDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oghFSQSAIMjgHUV5V8r916IZPMm815GOssLB6Bzt3Co=;
 b=ObXAeP6EPMQsB2rIcRYKS6U3LhyqWkr4Q+wjmaqMEXD8OQydlUqfWQJJKKdHXS2n+n/BBCEofaX9OwEmOmetLHHMUcdvZbZ3GIpHo1hbN42oQzT+BuH9P+JIQSifqO4pl1BDdVbRq72bQacUmyFZKu1q19wMv+5CpYmiGlp7k3TPXZwbKiQT4yrjMOn5qK4Us1m7mquRjGGBUtgRPEfah/Bariz+FJot+CeD7vGwMwi83/5jviRnhAN2igJ7oiQrNYiYmGJ5LjTjW95nrRj3KxBLWN2YFVJ6jqxD4fxOeVzycyOmivjAhn9J/qXF4amvwDRU4zRGuT7fUxDoDzNCzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oghFSQSAIMjgHUV5V8r916IZPMm815GOssLB6Bzt3Co=;
 b=n+owhPuDgPOLfLrDE7xZHnPhS9QjEcO11BVmml1tB50epeMFu2a3Q2pi1xbiZvY7KOlVpV4QOIHAoSSjmA9jfLnvReaV5MHEjPLMMLSWGZG1IkZRoc3q57Qb/q2g+qkB5xGFF69D1yeX7HiY0e+PiS3lnLGgVmOvFgQ/0lLnzRw=
Received: from BYAPR02MB5992.namprd02.prod.outlook.com (20.179.89.80) by
 BYAPR02MB4438.namprd02.prod.outlook.com (52.135.237.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11; Thu, 2 Jan 2020 21:01:58 +0000
Received: from BYAPR02MB5992.namprd02.prod.outlook.com
 ([fe80::f5fd:4723:4a89:3ed9]) by BYAPR02MB5992.namprd02.prod.outlook.com
 ([fe80::f5fd:4723:4a89:3ed9%7]) with mapi id 15.20.2602.010; Thu, 2 Jan 2020
 21:01:58 +0000
From:   Jolly Shah <JOLLYS@xilinx.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        Michal Simek <michals@xilinx.com>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/5] firmware: xilinx: Add xilinx specific sysfs interface
Thread-Topic: [PATCH 0/5] firmware: xilinx: Add xilinx specific sysfs
 interface
Thread-Index: AQHVqvq1JwhYL7MFCk+eRE7vaPSY36fADb6AgBf7GVA=
Date:   Thu, 2 Jan 2020 21:01:58 +0000
Message-ID: <BYAPR02MB5992099D8B87745DB7661C13B8200@BYAPR02MB5992.namprd02.prod.outlook.com>
References: <1575502159-11327-1-git-send-email-jolly.shah@xilinx.com>
 <20191218144555.GA12525@bogus>
In-Reply-To: <20191218144555.GA12525@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b2df98db-32fd-491a-c643-08d78fc70193
x-ms-traffictypediagnostic: BYAPR02MB4438:|BYAPR02MB4438:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB44389D88A4865B0932117D4FB8200@BYAPR02MB4438.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0270ED2845
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(13464003)(51914003)(189003)(199004)(52536014)(54906003)(81166006)(81156014)(8936002)(4326008)(55016002)(8676002)(186003)(316002)(5660300002)(2906002)(9686003)(86362001)(76116006)(6916009)(66476007)(66946007)(6506007)(66556008)(71200400001)(478600001)(64756008)(66446008)(7416002)(53546011)(33656002)(26005)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4438;H:BYAPR02MB5992.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xm0r8FZ1y7HV1YF+ssTCmBd2VRHwRiLBkSMo/DO9dZ8UlMHYmAJVluDSD3UHu3lUDPt16P18mf1LMpBcSDN5s5ylnkzAwPc9nK3Ww7TwP+/YFbw2EYjTgJ3CwAn0RCqwi8mBshEFXflZds5DmHuBN/k3RAndi8RODi8jlg1Qt5uw4cnLCVd+u2IIIMJoXiZ3akw8Saee55Hglhify0CYYeEmhLTQ0kf9YGH5Gj9Vwevsk1s0+yKCeKYTOTsloFJeF08FhOZWozAdi0OsGo+cOxPmIdOYCAwjtL4SnnWXqMfHvP7oNZQf1gwgtGK3QWca552GKiODWbw54EtCcnNF3agkINmuZ5+gaTPn9I8nV6eouQ+Ciz6DM8TyPzvyBdpTddCWNuzBelo60wUX+6hWiibbetRoRNWr2HPGpZizjeYhp2PhjPHVJE0JT2JCEuW+bzWTQ1gVNgAB59Kw7V1sQ2lhuOV+mqmqzVKNuj/KzF0rHqptyirkwz5btqSyVec0u5oY20gvHUiW/E8nYXANlw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2df98db-32fd-491a-c643-08d78fc70193
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2020 21:01:58.1781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N2quDRw4iZJ2ZDXi0Q2jsW1Nt9IuI6AKo+/yKnGruqAy3ekVY+fZgxyxYG05oGLSc8md98NwnFAmQB+fGIc/BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4438
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

Thanks for the review.

> -----Original Message-----
> From: Sudeep Holla <sudeep.holla@arm.com>
> Sent: Wednesday, December 18, 2019 6:46 AM
> To: Jolly Shah <JOLLYS@xilinx.com>
> Cc: ard.biesheuvel@linaro.org; mingo@kernel.org;
> gregkh@linuxfoundation.org; matt@codeblueprint.co.uk;
> hkallweit1@gmail.com; keescook@chromium.org;
> dmitry.torokhov@gmail.com; Michal Simek <michals@xilinx.com>; Rajan Vaja
> <RAJANV@xilinx.com>; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; Sudeep Holla <sudeep.holla@arm.com>
> Subject: Re: [PATCH 0/5] firmware: xilinx: Add xilinx specific sysfs inte=
rface
>=20
> On Wed, Dec 04, 2019 at 03:29:14PM -0800, Jolly Shah wrote:
> > This patch series adds xilinx specific sysfs interface for below
> > purposes:
> > - Register access
> > - Set shutdown scope
> > - Set boot health status bit
>=20
> This series defeats the whole abstraction EEMI provides. By providing
> direct register accesses, you are allowing user-space to do whatever it
> wants. I had NACKed this idea before. Has anything changed ?
>

Firmware checks for allowed accesses only and rejects rest.=20
=20
> If you need it for testing firmware, better put them in debugfs which is
> off on production builds.

Sure. Will reanalyze use cases and move to debugfs only if that suffices.

Thanks,
Jolly Shah


>=20
> --
> Regards,
> Sudeep
