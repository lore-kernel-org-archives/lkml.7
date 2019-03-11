Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995F7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 667182075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="YJ2qOXYx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbfCKSOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:14:09 -0400
Received: from mail-eopbgr730103.outbound.protection.outlook.com ([40.107.73.103]:59965
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727153AbfCKSOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNW4ifN2aXcTZJfdpo2TpwVQ0NfI/T8UqCnSSGWQVdE=;
 b=YJ2qOXYxM4xbp0cQDJ0lJRIQxMzjVmkedWbTfacCJxjL7BrauggKx5H0yGfIpQmYC7y2S+FXBO/j3c2orCSTi7QIFxgALOA6HoVM1nqXIWuGMftHisHgaJEZiticRqfknb5LRPYEWnu2tnM6qR7d/PYN6Bl+ysiPxmUaWujrwng=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1374.namprd22.prod.outlook.com (10.174.160.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.21; Mon, 11 Mar 2019 18:14:04 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018%3]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 18:14:04 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Yasha Cherikovsky <yasha.che3@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Yasha Cherikovsky <yasha.che3@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH 1/1] MIPS: Ensure ELF appended dtb is relocated
Thread-Topic: [PATCH 1/1] MIPS: Ensure ELF appended dtb is relocated
Thread-Index: AQHU1a7JcwPZK+U8+0uc89l/lTqXu6YGwQsA
Date:   Mon, 11 Mar 2019 18:14:04 +0000
Message-ID: <MWHPR2201MB1277D1BEED433CCE675E5D98C1480@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190308125851.31806-2-yasha.che3@gmail.com>
In-Reply-To: <20190308125851.31806-2-yasha.che3@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR08CA0069.namprd08.prod.outlook.com
 (2603:10b6:a03:117::46) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72f51c6b-0e05-4ed9-73f6-08d6a64d57be
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1374;
x-ms-traffictypediagnostic: MWHPR2201MB1374:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR2201MB1374;23:ch1txFtvHUH92AR9zz4bM405gUwI9R8s0++tv?=
 =?iso-8859-1?Q?tuK+Spo/UgNcmWGjzQ4u+ewn6JLNGNIWsWJvbZ16mL77IGJorI06a5Cusb?=
 =?iso-8859-1?Q?xxnde4FxzSR5bAtC2YDPalchND1JD9fL1ye9WsLvFloK6HIqwLvd1LpmV5?=
 =?iso-8859-1?Q?UmFYin0zUwOE19cEwe9eACkL/eXdFUol8J2v2HAcspxNGFR9MQYDId5gSM?=
 =?iso-8859-1?Q?S6IRCn+YTzYiU+mxX/ohBv4KJeo892hHhVfznclvPTmZoFZk3IFhVk6kVA?=
 =?iso-8859-1?Q?rhBaIs30OMqwj1A7K//2IzvyJjyxxjL5hhbEFLCO3LL6U8KWJGOWW8ww0P?=
 =?iso-8859-1?Q?jNMzsZN8BgjVMn5LxAKUs0xTVG1ul9+i5ucIgDkH7p4X/3F1pGAcyC79Cc?=
 =?iso-8859-1?Q?XlS4LAj0Us3zYISEAfNlT5nCX7ruEnPzab/wWmimIjQ3zWA7K3BGCzpwF6?=
 =?iso-8859-1?Q?hSOlft1U2ge8te2IvcnGuFI7kfjliXiEBRkpEjQBZL7lhuNK98pI8VQ7Zj?=
 =?iso-8859-1?Q?mWfJ95W4Y/MCw3JIHnVv1YxKkztdppFVKMxQOGQiKy6R3r6ZLn+jiepfS9?=
 =?iso-8859-1?Q?vJW8qE4b7YCW8F4VXPn7VjviIHx7t8poaEvQQq2VS28CTkpgZNLhRF88rV?=
 =?iso-8859-1?Q?F91YeBuGQEJNwdD0XagbDPztWWJCde+XrClvlOjbRyubYYrrBbUPxQiTDN?=
 =?iso-8859-1?Q?ZANT654FGj0elW41+d3krj+TGtd+gEtLzJT1g2HSuoozBZEfBWKC766yXw?=
 =?iso-8859-1?Q?bcQeqZCjsMYi1E4l+sBJSMWlIOYTiT+6l+Za0ZfGmsn3BW6RvojLiV/ejb?=
 =?iso-8859-1?Q?khXryO7JawnsHxPqJi0+BVv4pONSbR0wkv8xd0byY/1GXuhvb1TYO+TQ+c?=
 =?iso-8859-1?Q?3mgOStRZcxVqvVxtPG03hB7i9DjQYj2Gn2VaZeUE+gS+QK0o6INPcpS6N6?=
 =?iso-8859-1?Q?MFwyVAn24srNBJF15DkZ6CYuSDj5HANMqzcoJYYW30cCdphHILN4wUSvJL?=
 =?iso-8859-1?Q?ikj9Rx+RhrlOFT4RM8fH5ZF9IATwkjDoz4F2PZYTgsKElSf6fudE8wDR3l?=
 =?iso-8859-1?Q?ozXXKpIgVRJ+TPznjpZZrAetjkoRSZ4NIp14sHdZ66haqW4xckre2b8Jq7?=
 =?iso-8859-1?Q?r5HQxwukKLUbafEc4mud700zTHzStmnaSy+qBJt3OPMFAe/jeOHSo3vh1R?=
 =?iso-8859-1?Q?hdHlfOigZWJ6QIF9rqqP6phZzrZPwexNT/+p0S6js+mAbHRWgzoFSmpWJi?=
 =?iso-8859-1?Q?UuZfGPyySSUJ/FSWNiI6srhe3g5Nuw1mYf3E4qer8j33bWHzkwD+3FrzUM?=
 =?iso-8859-1?Q?A/5Byb01FuV5MNV25AIO2adDp8y/+thxDHgsUPOOaIJZ9RA=3D=3D?=
x-microsoft-antispam-prvs: <MWHPR2201MB1374719D29068B585734EDCFC1480@MWHPR2201MB1374.namprd22.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(39850400004)(376002)(136003)(189003)(199004)(2906002)(55016002)(26005)(186003)(42882007)(11346002)(486006)(52536013)(476003)(44832011)(8676002)(5660300002)(7736002)(305945005)(478600001)(33656002)(99286004)(97736004)(446003)(8936002)(52116002)(7696005)(76176011)(68736007)(81166006)(54906003)(81156014)(6246003)(74316002)(106356001)(105586002)(14454004)(102836004)(6116002)(3846002)(6436002)(4326008)(25786009)(256004)(6506007)(386003)(6916009)(71190400001)(71200400001)(4744005)(316002)(66066001)(229853002)(53936002)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1374;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jUgdNj9rK06jbDIN3TMMuE+pL0Cig4pDBCeWka4BmEcmadiuUVlapKOhTK2FNXGjF35kXnLoWdfDz0BrF6pJAVS08hBGKdsO9CQ3gsR1kJXdxNo7+F+o0O+uDJ+Tjf+KeQ97bFD3o2X9igwHWGk3mrRuSJ05g7qBUYI62RsRmndT2rAKNB3RcmmWrSPuWgfp+KJY2vCRT7I1yKe9aMsaimUsM0hessdtYtmljBgsuQQFmrVpLAKfwwXDoccX01ZWIv0gzihBBBEZwP601Wotqxube4h2bwgSwywJYUvFxE6sEfArbFfOXYfsyab90W3Yl8wnV91myinqWvJc3EGGfGpxFDza0kJuhZ5ihQnZfxdQPXGlj2TMs0sO/eNhTOQUzUfQw7keNjg7tPFOStmHV7aFAWj9cn1JtTi38vaE46o=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f51c6b-0e05-4ed9-73f6-08d6a64d57be
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 18:14:04.1291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1374
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Yasha Cherikovsky wrote:
> This fixes booting with the combination of CONFIG_RELOCATABLE=3Dy
> and CONFIG_MIPS_ELF_APPENDED_DTB=3Dy.
>=20
> Sections that appear after the relocation table are not relocated
> on system boot (except .bss, which has special handling).
>=20
> With CONFIG_MIPS_ELF_APPENDED_DTB, the dtb is part of the
> vmlinux ELF, so it must be relocated together with everything else.
>=20
> Fixes: 069fd766271d ("MIPS: Reserve space for relocation table")
> Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: linux-mips@linux-mips.org
> Cc: linux-kernel@vger.kernel.org

Applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
