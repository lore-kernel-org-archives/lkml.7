Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08D5C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 22:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC9F21019
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 22:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="mS+iM9kz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfCOWjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 18:39:18 -0400
Received: from mail-eopbgr680090.outbound.protection.outlook.com ([40.107.68.90]:26431
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726130AbfCOWjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 18:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47EaxmveNyBYGMWYVIEfDovV1FbA+ktZcNuqUEqqiQw=;
 b=mS+iM9kzLz7uMi3lkDQ0bzmIFxB2+dCFCMx8ldhVI0FJVsCZbd/BF4rHEwheOtR7ivRjwLgNuik+bWLxH8EmrPZdq7ORo6EahxEuHvwNm/hpKdzCKd8S1ZFZcW+1IICFczqvq7B9BicXULTLueIOHdxvUbDSl9QyNdgSEKj6to4=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1213.namprd22.prod.outlook.com (10.174.161.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Fri, 15 Mar 2019 22:39:13 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018%3]) with mapi id 15.20.1709.011; Fri, 15 Mar 2019
 22:39:13 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Paul Burton <pburton@wavecomp.com>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jan Kara <jack@suse.cz>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Remove custom MIPS32 __kernel_fsid_t type
Thread-Topic: [PATCH] MIPS: Remove custom MIPS32 __kernel_fsid_t type
Thread-Index: AQHU2oz8biJKb9VnB02dJhiRtaA496YNSreA
Date:   Fri, 15 Mar 2019 22:39:12 +0000
Message-ID: <MWHPR2201MB1277D4B4E3CE45B3AC1870F3C1440@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190314173900.25454-1-paul.burton@mips.com>
In-Reply-To: <20190314173900.25454-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:a03:180::32) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 905d3472-5029-49f7-065a-08d6a9970c03
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1213;
x-ms-traffictypediagnostic: MWHPR2201MB1213:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR2201MB12138F3ED5E1C3E23C07DCF9C1440@MWHPR2201MB1213.namprd22.prod.outlook.com>
x-forefront-prvs: 09778E995A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(396003)(376002)(346002)(136003)(366004)(52314003)(189003)(199004)(55016002)(14444005)(7736002)(256004)(8676002)(7696005)(74316002)(305945005)(71200400001)(446003)(5660300002)(11346002)(81156014)(76176011)(71190400001)(81166006)(9686003)(53936002)(25786009)(229853002)(52116002)(6246003)(99286004)(6306002)(68736007)(478600001)(966005)(6436002)(52536014)(106356001)(8936002)(102836004)(26005)(42882007)(2906002)(44832011)(4326008)(6862004)(14454004)(66066001)(97736004)(476003)(486006)(54906003)(105586002)(316002)(3846002)(6116002)(386003)(33656002)(186003)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1213;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JDFRGvGkVVDQk1TdFewiNXZ0lahcN2CL4FdzwWscZTELIRVQwcaQ4VG7zRRSKsUbJfJC6KQ64N0UHL7HQ21phJzAcTO2t+8sBnXc/9vFwWQQwkL+ZUKDJevhLmBRZbEfSU59/A3ajS0ATXwQvR+dqulA3zcF3zZ9zS4WvSDLsMFmL5/Ob0zTv3PNggmRKuyafEwGMkMu7nHLAyvC6eEKfiPvZTlIn9QWsm0Ep0YW6eDcil9hBmuu/XU4+UDnZqm/Lsv57Y5Ra0Eoc4AmvXcdC7ASd4dfuGWj9Dn9x1zspREERdYZPOoR1I04On6PiTT6fvX7Y4o4bAEB3NLCNob0U4k5iAPcjZAI/7CgWic7PiGnyNpHCACuDMQU+BiSLxTXRbAo8+hN7BG7ILfsRfFIqoGa1Ifi5ETZqB6QBNJgtMs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 905d3472-5029-49f7-065a-08d6a9970c03
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 22:39:13.0157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1213
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Paul Burton wrote:
> For MIPS32 kernels we have a custom definition of __kernel_fsid_t. This
> differs from the asm-generic version used by all other architectures &
> MIPS64 in one way - it declares the val field as an array of long,
> rather than an array of int. Since int & long have identical size &
> alignment when targeting MIPS32 anyway, this makes little sense.
>=20
> Beyond the pointlessness this causes problems for code which prints
> entries from the val array, for example the fanotify_encode_fid()
> function [1]. If such code uses a format specified suited to an int then
> it encounters compiler warnings when building for MIPS32, such as:
>=20
> In file included from include/linux/kernel.h:14:0,
> from include/linux/list.h:9,
> from include/linux/preempt.h:11,
> from include/linux/spinlock.h:51,
> from include/linux/fdtable.h:11,
> from fs/notify/fanotify/fanotify.c:3:
> fs/notify/fanotify/fanotify.c: In function 'fanotify_encode_fid':
> include/linux/kern_levels.h:5:18: warning: format '%x' expects argument
> of type 'unsigned int', but argument 2 has type 'long int' [-Wformat=3D]
>=20
> Remove the custom __kernel_fsid_t definition & make use of the
> asm-generic version which will have an identical layout in memory
> anyway, in order to remove the inconsistency with other architectures.
>=20
> One possible regression this could cause if is any code is attempting to
> print entries from the val array with a long-sized format specifier, in
> which case it would begin seeing compiler warnings when built against
> kernel headers including this change. Since such code is exceedingly
> rare, and would have to be MIPS32-specific to expect a long, this seems
> to be a problem that it's extremely unlikely anyone will encounter.
>=20
> [1] https://lore.kernel.org/linux-mips/CAOQ4uxiEkczB7PNCXegFC-eYb9zAGaio_=
o=3DOgHAJHFd7eavBxA@mail.gmail.com/T/#mb43103277c79ef06b884359209e817db1c13=
6140
>=20
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mips@vger.kernel.org

Applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
