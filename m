Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB12C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 07:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F7992086D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 07:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="KP/c8jaw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfGZHdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 03:33:32 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:62066 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726279AbfGZHdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 03:33:32 -0400
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6Q7V83P029926;
        Fri, 26 Jul 2019 02:33:30 -0500
Received: from nam03-by2-obe.outbound.protection.outlook.com (mail-by2nam03lp2058.outbound.protection.outlook.com [104.47.42.58])
        by mx0a-00010702.pphosted.com with ESMTP id 2tx62hkamg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 26 Jul 2019 02:33:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMcUIlOnj0P/FDvl7KFVC8WE3ylaj5bvcx9uLQcdgY3DuJ8mt6J6RdPek6NWRpSWN0t2d5NtWIktJfqlJmIrnbY3maZuCr8PhoTW0Mf6HkyLUpIN0EC3T5zRj/6MmymR4B1vKZbRZuGEAr5ZGbTY0lpxuKCg5WQ6ujfyCeT6kDKexSGSmYyzi5HP2aQHWfEmq0KWgShrIw5MuuhVH2/hxaHUBeqcmzRAi1cVVDQKfoo4gUX/vC/gaMj3dry44BjqAJryYReJVhb2AnY8JeuEGl2x8zR55PFjPPTM2efJCtj+9MQ4cVO8QzTVL9EikwZY50qZoEezxIXXHFOU7wPvEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mh0m9pnMu2mK/LBjR7/FEa1tGxPIBgiCrRG1cWHSxNU=;
 b=dXI4DBdD8tI5LaTXnWMQfKswiCyLDON5f4Ph5bsycekTjFoCo7xXsInl8jGol04rRUkZLQjJLcM04mdK5vtfOxqjKA4JYtlUO5Tpg5RrzE0IeR2tFZCmmjdnvzRO9ELBooP2AUDdLdsWSjxlneBJhNhPnG5l3qnUyiTkWP0CnVC3spz+7Lca2mifl6DJAMEk52rqv7wjSTUquw5X4T1yVqxPI/lO/2wCjvaZwB5NVtKM8d+RbUd7l2QIvqeg7FNLr0d5RYpkKdOmysrfqGgPg4cISUfBxbyFfseeLXlCJXUQHiKGKwaLfEIw4SSIhZPGcpkD/Qc43+Owijq4mrur0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=ni.com;dmarc=pass action=none header.from=ni.com;dkim=pass
 header.d=ni.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mh0m9pnMu2mK/LBjR7/FEa1tGxPIBgiCrRG1cWHSxNU=;
 b=KP/c8jaw6Xc2FrXbkHXF/u48LKRwlhIE4+yC9a+beI2gL2J0ON2dKA1ig0sf8aykyexL9PwJ9S8JxrBBJS51izYE3+Fpd3ZaM/Wo3Lksc1ml4+prumnkj1CTAjWZqn/8nIJv18AMPwR3g7q1ZlhuBVq826ZgMu5crdkFAi+KIPo=
Received: from MN2PR04MB5920.namprd04.prod.outlook.com (20.179.21.161) by
 MN2PR04MB5885.namprd04.prod.outlook.com (20.179.23.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Fri, 26 Jul 2019 07:33:28 +0000
Received: from MN2PR04MB5920.namprd04.prod.outlook.com
 ([fe80::584f:77e7:16ee:ba8]) by MN2PR04MB5920.namprd04.prod.outlook.com
 ([fe80::584f:77e7:16ee:ba8%7]) with mapi id 15.20.2115.005; Fri, 26 Jul 2019
 07:33:28 +0000
From:   Je Yen Tam <je.yen.tam@ni.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v6] serial/8250: Add support for NI-Serial
 PXI/PXIe+485 devices
Thread-Index: AQHVQ4L6voAo3xdn+Ua4BsjNkx+4eKbcgFWAgAABOkA=
Date:   Fri, 26 Jul 2019 07:33:28 +0000
Message-ID: <MN2PR04MB5920C0F55BE23BB4172F628EB7C00@MN2PR04MB5920.namprd04.prod.outlook.com>
References: <20190726072226.6357-1-je.yen.tam@ni.com>
 <20190726072811.GA3073@kroah.com>
In-Reply-To: <20190726072811.GA3073@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [130.164.74.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cdbde4d7-5353-475a-9c58-08d7119b8d59
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR04MB5885;
x-ms-traffictypediagnostic: MN2PR04MB5885:
x-microsoft-antispam-prvs: <MN2PR04MB5885FF8572348214FCA04407B7C00@MN2PR04MB5885.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 01106E96F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(366004)(136003)(396003)(199004)(189003)(316002)(229853002)(25786009)(186003)(8676002)(54906003)(486006)(305945005)(81156014)(7696005)(4744005)(9686003)(81166006)(52536014)(6116002)(5660300002)(446003)(7736002)(4326008)(256004)(74316002)(476003)(33656002)(11346002)(53936002)(3846002)(55016002)(71200400001)(6246003)(14454004)(8936002)(26005)(99286004)(86362001)(71190400001)(2906002)(102836004)(66476007)(66946007)(6436002)(64756008)(66556008)(76176011)(66446008)(68736007)(6506007)(76116006)(66066001)(478600001)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5885;H:MN2PR04MB5920.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: osv0T4GBx9Xi9iWM+POlmuMPxSR+Vg6GzZexdPooimaOL9U0zq9hCmYwy54UGIAZVrRIgGMBbjhwcIRHgseLqjDsI3GN+HW1RMDN8hheBTSjV5iCAdftKJiDmlKuM59/tp/8NgtFM6M3d8MyLho6qO2p5nKfK5r+G4ZPF1TXmgGsEDN8N+bTGiG9+hD0MQ1pwucrxLDI1rcw/Z3uB3KmXQVjPsePv3CDJSC2mzlgetZod8ZWiS8oLqPKmVd3kRRXJTKrBDW0jwCJ9FYblX0XmJirlqNZ0+09SC9spkVDjuFkl+jbI3cOUXvoObkp0nvnT0pkHY6i/1CcQnOm/BxwvuDYEkPX78V7wZhqmxbykOWz+usZaBM+Ggu1mfnJXhU6PsQIDA5oq50UMgr0WxVOnk53X5V/xXGknNIGDEnc91Y=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdbde4d7-5353-475a-9c58-08d7119b8d59
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2019 07:33:28.3318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: je.yen.tam@ni.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5885
Subject: RE: Re: [PATCH v6] serial/8250: Add support for NI-Serial PXI/PXIe+485
 devices
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-07-26_04:2019-07-26,2019-07-26 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30 clxscore=1015
 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-1906280000 definitions=main-1907260099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [EXTERNAL] Re: [PATCH v6] serial/8250: Add support for NI-Serial
> PXI/PXIe+485 devices
>=20
> On Fri, Jul 26, 2019 at 03:22:26PM +0800, jeyentam wrote:
> > Add support for NI-Serial PXIe-RS232, PXI-RS485 and PXIe-RS485 devices.
> >
> > Signed-off-by: Je Yen Tam <je.yen.tam@ni.com>
>=20
> "From:" name does not match the Signed-off-by: name :(

Change it in v7?

