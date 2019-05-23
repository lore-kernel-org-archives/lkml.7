Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB926C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 17:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68DD92186A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 17:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="atEA2SB8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731387AbfEWRx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 13:53:56 -0400
Received: from mail-eopbgr70085.outbound.protection.outlook.com ([40.107.7.85]:28352
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730899AbfEWRx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 13:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xjf5SFKB5ODXOe4Q8/8+7+jabJoQJfJuPLFXDrRa4c=;
 b=atEA2SB8JMK9gKyZuKFl4Wf7S24+ks6ItyeAk6nuUL8NTtXXT0Ip+ZOF529pGEOHOUghZR4pbOf3bMguqyfSgd18iky6Dz8r3nSbAnh3s8ukyZIq5cUz+l/9bAkp9KtF9iFdE7N6Ei1Gy5k2e8cdyX0Az0biqfA9UaHtEJXB3jc=
Received: from AM0PR0402MB3476.eurprd04.prod.outlook.com (52.133.50.141) by
 AM0PR0402MB3889.eurprd04.prod.outlook.com (52.133.38.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Thu, 23 May 2019 17:53:51 +0000
Received: from AM0PR0402MB3476.eurprd04.prod.outlook.com
 ([fe80::1cc6:b168:7419:aa48]) by AM0PR0402MB3476.eurprd04.prod.outlook.com
 ([fe80::1cc6:b168:7419:aa48%6]) with mapi id 15.20.1900.020; Thu, 23 May 2019
 17:53:51 +0000
From:   Horia Geanta <horia.geanta@nxp.com>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] swiotlb: sync buffer when mapping FROM_DEVICE
Thread-Topic: [PATCH] swiotlb: sync buffer when mapping FROM_DEVICE
Thread-Index: AQHVEG7XwyI2zYKLCECD0q7/YpNC2Q==
Date:   Thu, 23 May 2019 17:53:51 +0000
Message-ID: <AM0PR0402MB3476A633E03202C26D15CB5698010@AM0PR0402MB3476.eurprd04.prod.outlook.com>
References: <20190522072018.10660-1-horia.geanta@nxp.com>
 <20190522123243.GA26390@lst.de>
 <6cbe5470-16a6-17e9-337d-6ba18b16b6e8@arm.com>
 <20190522130921.GA26874@lst.de>
 <fdfd7318-7999-1fe6-01b6-ae1fb7ba8c30@arm.com>
 <20190522133400.GA27229@lst.de>
 <CGME20190522135556epcas2p34e0c14f2565abfdccc7035463f60a71b@epcas2p3.samsung.com>
 <ed26de5e-aee4-4e19-095c-cc551012d475@arm.com>
 <0c79721a-11cb-c945-5626-3d43cc299fe6@samsung.com>
 <20190523164332.GA22245@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com; 
x-originating-ip: [94.69.234.123]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 356fd88b-93bd-4e45-1136-08d6dfa79dce
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR0402MB3889;
x-ms-traffictypediagnostic: AM0PR0402MB3889:
x-microsoft-antispam-prvs: <AM0PR0402MB3889F5FB4AC0350355A655AE98010@AM0PR0402MB3889.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 00462943DE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(136003)(376002)(39860400002)(189003)(199004)(53936002)(4326008)(53546011)(8936002)(6506007)(316002)(7736002)(305945005)(110136005)(3846002)(74316002)(6246003)(6116002)(5660300002)(66946007)(4744005)(33656002)(76116006)(64756008)(66476007)(66446008)(66556008)(186003)(73956011)(8676002)(476003)(52536014)(66066001)(81166006)(14444005)(81156014)(26005)(9686003)(256004)(102836004)(6436002)(55016002)(99286004)(486006)(229853002)(86362001)(14454004)(446003)(7696005)(44832011)(2906002)(54906003)(25786009)(71200400001)(68736007)(71190400001)(478600001)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3889;H:AM0PR0402MB3476.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wCx6scCvRm17hTEpxIFGhx9za4I/XyE2oi0K623SOfPjgthZYXIQppRIqqTwgq26MNuYAiJ1JJcNxC/y81FIwF1I7ZUrBXPlzXqBw2wp0i1/Ic98GPluZSIt1jcu//4NbBjFNIs++RDT1oJRooeUuJk/pDxTPGVOxtO4M/t2aK6FD1GNH0SP81LELMhx+4JqcMybP0+IIfsfwVF53+IdlIl2tEq8WEjjVtDkGc5qJcldAMzudttOOKxSzE55oc75n1Zs/L3GahSerGCtPvNUN3NUb5/921j4tvSjJ2JVPQj/tw1jq4PkU3GHeoYDrEAcILqpyssDdTDflC7yRWlgVV6yDRGz/4zxWOFyiMx/8YxAW3HG43vyeLoQLmKut+jAHiYzmqcENb+Q0NS6cw+pEpxMA2dMu0aTyFgckHIO9PU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 356fd88b-93bd-4e45-1136-08d6dfa79dce
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2019 17:53:51.7974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3889
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/2019 7:43 PM, Christoph Hellwig wrote:=0A=
> On Thu, May 23, 2019 at 07:35:07AM +0200, Marek Szyprowski wrote:=0A=
>> Don't we have DMA_BIDIRECTIONAL for such case?=0A=
> =0A=
> Not sure if it was intended for that case, but it definitively should=0A=
> do the right thing for swiotlb, and it should also do the right thing=0A=
> in terms of cache maintainance.=0A=
> =0A=
>> Maybe we should update =0A=
>> documentation a bit to point that DMA_FROM_DEVICE expects the whole =0A=
>> buffer to be filled by the device?=0A=
> =0A=
> Probably. Horia, can you try to use DMA_BIDIRECTIONAL?=0A=
> =0A=
This works, but at the cost of performance - all the cache lines being writ=
ten=0A=
back to memory, just to be overwritten by the device.=0A=
=0A=
Thanks,=0A=
Horia=0A=
