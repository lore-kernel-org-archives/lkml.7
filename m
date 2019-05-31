Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E169DC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 17:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC13B26CCE
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 17:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RRh3soPn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfEaRGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 13:06:13 -0400
Received: from mail-eopbgr30073.outbound.protection.outlook.com ([40.107.3.73]:11438
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726518AbfEaRGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 13:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erj5BXKZmCrs/Bk6whxD2mtwcQ654jPz5QICLT+jH6w=;
 b=RRh3soPnpoxrC/onih4rEpm3fHmjTjig5/xZBFSUQYGR/O0sK4c2YWtVA6iZNvF6pAnoT1PAMH2JKRPMJuFaTDGHxZ5BtpbTgctGQKCrkVWz6Wa4ermhlucJcKytcPKfYLHYOtUjqEnj6jX2Z/HO2BUNh/gW3rrSGpG5yMTK/Xw=
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.50.159) by
 VI1PR04MB5374.eurprd04.prod.outlook.com (20.178.120.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Fri, 31 May 2019 17:06:07 +0000
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::8d0e:de86:9b49:b40]) by VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::8d0e:de86:9b49:b40%7]) with mapi id 15.20.1922.024; Fri, 31 May 2019
 17:06:07 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "marex@denx.de" <marex@denx.de>, Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "noring@nocrew.org" <noring@nocrew.org>,
        "JuergenUrban@gmx.de" <JuergenUrban@gmx.de>
Subject: RE: [PATCH v7 0/5] prerequisites for device reserved local mem rework
Thread-Topic: [PATCH v7 0/5] prerequisites for device reserved local mem
 rework
Thread-Index: AQHVFglQMB1lnLjYnE2Z8bn8+67UAKaB+N+AgAAA+wCAAClrAIADUJmAgAAFjIA=
Date:   Fri, 31 May 2019 17:06:07 +0000
Message-ID: <VI1PR04MB51345B1DD18AA4CB64BB086EEC190@VI1PR04MB5134.eurprd04.prod.outlook.com>
References: <20190529102843.13174-1-laurentiu.tudor@nxp.com>
 <20190529113427.GC11952@kroah.com> <20190529113758.GA9399@lst.de>
 <5b8164b3-74a3-9ba4-8c28-61a14ec57a39@nxp.com>
 <20190531164327.GB27525@lst.de>
In-Reply-To: <20190531164327.GB27525@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0cbb2c60-96c2-4ace-7f67-08d6e5ea45bf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5374;
x-ms-traffictypediagnostic: VI1PR04MB5374:
x-microsoft-antispam-prvs: <VI1PR04MB5374CB63F56581F49B11CF79EC190@VI1PR04MB5374.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(39860400002)(346002)(366004)(13464003)(189003)(199004)(48014003)(6916009)(68736007)(66946007)(73956011)(7736002)(316002)(2906002)(74316002)(55016002)(86362001)(66476007)(81166006)(229853002)(81156014)(33656002)(5660300002)(8676002)(8936002)(478600001)(305945005)(14454004)(99286004)(26005)(6436002)(4744005)(6116002)(4326008)(256004)(3846002)(186003)(9686003)(476003)(66556008)(76116006)(64756008)(44832011)(76176011)(7696005)(11346002)(66066001)(446003)(71190400001)(71200400001)(54906003)(25786009)(6246003)(102836004)(53936002)(52536014)(486006)(66446008)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5374;H:VI1PR04MB5134.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: o6MvLg5i3RLPCUR4x948Rr7UUYGljhzFSHlQLmM40n/54jaEup+1nzUwbLi4vlfTioAyLHPpkq4O5K6d3QnNrZ0FVgREQ3RL73wjMNi0rZ9bo5buhsJBl0EqslLsVtKgLQbyP7cwpWTKMFBmGYWVObdaCROj+6nhfmIuSPum2i+wT6iX2WPCRqTN37cdeM4Gu+XYA3JOtjJ28H94tEc2gcYaHmvhzTpPkgUrofIZDs0roAmv/g8Zs+jvnCVc8gsfZR+XRPBZkpi7FCsZyBKSwfF2H8Sq/qZolMiBW45G0ck2q2Ta/frhp6X3K1ioFvSS22JnYXBIhTqgaQxYXVyl+wTGf+EiQpr9T1B0WaASCxqWnphPLJg+slghaoldfNS6rEGza6ynj7DyWTCRrk1Xtykaw9sf1Jp0eiYxemVMc5M=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cbb2c60-96c2-4ace-7f67-08d6e5ea45bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 17:06:07.3820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: laurentiu.tudor@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5374
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Christoph Hellwig <hch@lst.de>
> Sent: Friday, May 31, 2019 7:43 PM
>=20
> On Wed, May 29, 2019 at 02:06:12PM +0000, Laurentiu Tudor wrote:
> > Thanks, hope this time everything is fine.
>=20
> I've applied it to the dma-mapping tree now.
>=20
> > When you get the time, please let me know your ideas on the next steps.
>=20
> I think the next step is to move the call to
> dma_alloc_from_dev_coherent from dma_alloc_attrs into the ->alloc
> instances.  The only onces that really need it for now are the
> generic and legacy arm dma-direct code, and drivers/iommu/dma-iommu.c
> as well as the ARM DMA API code, as those are the ones use for
> architectures that declare coherent regions.  The other iommus are
> not used on OF platforms (at least that's what my analysis said a while
> ago, feel free to double check it)

Thanks. I'll start looking into it starting next week. Keep in touch.

---
Best Regards, Laurentiu
