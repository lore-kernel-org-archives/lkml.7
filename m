Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB81C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 16:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E71F2075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 16:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="fAazJZIj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbfECQqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 12:46:15 -0400
Received: from mail-eopbgr750083.outbound.protection.outlook.com ([40.107.75.83]:46613
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726468AbfECQqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 12:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyeKXjuLVx4N3byCKRmz6/xpeVmn9stm0hlwtFtwJ38=;
 b=fAazJZIjQnYDfWZ0OVyUF0MZ8bUu3ni6qCeF2wB6JNuQLDfYts8MnvCA2P+x1nw8W43Tf+0Uv2owYZ85K5yHrlJ0akmPMMeLkVRrFswa0lvifQgd6uyYasK1bQguWkQXvTcBJTjO8T6qu94XF2P2W7l/uIVVE/TERYhTne7MwyA=
Received: from BL0PR02MB5681.namprd02.prod.outlook.com (20.177.241.92) by
 BL0PR02MB5554.namprd02.prod.outlook.com (20.177.241.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.15; Fri, 3 May 2019 16:46:12 +0000
Received: from BL0PR02MB5681.namprd02.prod.outlook.com
 ([fe80::6cde:f726:b36e:752d]) by BL0PR02MB5681.namprd02.prod.outlook.com
 ([fe80::6cde:f726:b36e:752d%5]) with mapi id 15.20.1856.012; Fri, 3 May 2019
 16:46:12 +0000
From:   Dragan Cvetic <draganc@xilinx.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "arnd@arndb.de" <arnd@arndb.de>, Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Derek Kiernan <dkiernan@xilinx.com>
Subject: RE: [PATCH V3 04/12] misc: xilinx_sdfec: Add open, close and ioctl
Thread-Topic: [PATCH V3 04/12] misc: xilinx_sdfec: Add open, close and ioctl
Thread-Index: AQHU/UVLGOE4w/2X+U+k4o4ho4ebiKZYHQyAgAGHpkA=
Date:   Fri, 3 May 2019 16:46:12 +0000
Message-ID: <BL0PR02MB568178214B7789431977E91BCB350@BL0PR02MB5681.namprd02.prod.outlook.com>
References: <1556402706-176271-1-git-send-email-dragan.cvetic@xilinx.com>
 <1556402706-176271-5-git-send-email-dragan.cvetic@xilinx.com>
 <20190502172345.GC1874@kroah.com>
In-Reply-To: <20190502172345.GC1874@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=draganc@xilinx.com; 
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b40228e-8ec4-4a49-2613-08d6cfe6da03
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BL0PR02MB5554;
x-ms-traffictypediagnostic: BL0PR02MB5554:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BL0PR02MB55545B0DEE28FC221B76E5D8CB350@BL0PR02MB5554.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0026334A56
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(136003)(346002)(396003)(189003)(199004)(13464003)(6916009)(7736002)(6506007)(53546011)(316002)(4744005)(9686003)(76116006)(76176011)(66946007)(186003)(6246003)(66066001)(73956011)(102836004)(26005)(256004)(7696005)(14444005)(55016002)(4326008)(99286004)(6306002)(66476007)(5660300002)(305945005)(478600001)(8936002)(71190400001)(54906003)(476003)(74316002)(486006)(33656002)(53936002)(8676002)(68736007)(11346002)(86362001)(71200400001)(107886003)(229853002)(52536014)(14454004)(81156014)(6436002)(81166006)(66556008)(2906002)(3846002)(6116002)(64756008)(966005)(25786009)(66446008)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB5554;H:BL0PR02MB5681.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kDgpFwzbaFdpn54ECrAxppV6QyF54Rk/HpcCdlGrSd6I4Run4EalxQLK43hj1hRVRUjhYWxpBZ/y9YDN77izkxzls5GKhlMYRQvvmkwhWRQ1OY5VBlXQW9R9iSKGHaCxqoMiUyGehnrTaC6pmNxLenBZwQwlub9EO6JTgYwQzSEM0n4lILmv/NKOKx+MgQmzHBaxRE9nV86wcfdf5MX39empKw5d2kaHUrej2KhadxJK9biL5MWIeYkfN8SYB6/oSDS1uBaZxOO74faAkQfKqNXiMRhRcdRObnoSmP9QngtBnDuGfLUvFA69gbrKCo/eZCdJEshs1OlMsWtS+frGi7t7V+EW3y8/+cBkGOPomtuSPbGk8na0dwd4DGscsx+1E7SlTynydEoGgv4tIt0yLDM8S0VCcYd0+cYv7QMbObs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b40228e-8ec4-4a49-2613-08d6cfe6da03
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2019 16:46:12.5121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5554
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Thursday 2 May 2019 18:24
> To: Dragan Cvetic <draganc@xilinx.com>
> Cc: arnd@arndb.de; Michal Simek <michals@xilinx.com>; linux-arm-kernel@li=
sts.infradead.org; robh+dt@kernel.org;
> mark.rutland@arm.com; devicetree@vger.kernel.org; linux-kernel@vger.kerne=
l.org; Derek Kiernan <dkiernan@xilinx.com>
> Subject: Re: [PATCH V3 04/12] misc: xilinx_sdfec: Add open, close and ioc=
tl
>=20
> On Sat, Apr 27, 2019 at 11:04:58PM +0100, Dragan Cvetic wrote:
> > Add char device interface per DT node present and support
> > file operations:
> > - open(),
> > - close(),
> > - unlocked_ioctl(),
> > - compat_ioctl().
>=20
> Why do you need compat_ioctl() at all?  Any "new" driver should never
> need it.  Just create your structures properly.

This was a comment from Arnd, see https://lkml.org/lkml/2019/3/19/377.
Please advise.

>=20
> thanks,
>=20
> greg k-h
