Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5ADC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8411218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="bmgH12mW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfGDIME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 04:12:04 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:2842 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725882AbfGDIME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 04:12:04 -0400
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x648BGat020295;
        Thu, 4 Jul 2019 03:12:02 -0500
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2052.outbound.protection.outlook.com [104.47.46.52])
        by mx0a-00010702.pphosted.com with ESMTP id 2thcnk8716-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 04 Jul 2019 03:12:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxFMZN5yUSeBdmrJ6vGJsSqs3zPafx1S+efLq4WuXD8=;
 b=bmgH12mWi87udvnojBWenUHNOB806XBv9TZK5kGrBSubQ+z7VneBN1OjuHjyfMK+gXXVwgcGNfTD4V8uWldjY8uDkHWxY1XuzX6RKV7I7Vy8xcWbdl9MbgJ7p2AkystQFMs1/lZJmVsaymsSX6LiCWV19Bd6xlQU9msyxDpRkq4=
Received: from MN2PR04MB5920.namprd04.prod.outlook.com (20.179.21.161) by
 MN2PR04MB6238.namprd04.prod.outlook.com (20.178.249.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.17; Thu, 4 Jul 2019 08:12:00 +0000
Received: from MN2PR04MB5920.namprd04.prod.outlook.com
 ([fe80::7ca2:1dbc:355d:64c7]) by MN2PR04MB5920.namprd04.prod.outlook.com
 ([fe80::7ca2:1dbc:355d:64c7%5]) with mapi id 15.20.2052.010; Thu, 4 Jul 2019
 08:12:00 +0000
From:   Je Yen Tam <je.yen.tam@ni.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH 1/2] serial/8250: Add support for
 NI-Serial PXI/PXIe+485 devices.
Thread-Index: AQHVMIWbCP+HEZ5Oukas+L+0Z4rj1qa5J7EAgAD27MA=
Date:   Thu, 4 Jul 2019 08:12:00 +0000
Message-ID: <MN2PR04MB592081EEAF8F663E445C5D36B7FA0@MN2PR04MB5920.namprd04.prod.outlook.com>
References: <20190702032323.28967-1-je.yen.tam@ni.com>
 <20190703172554.GA27719@kroah.com>
In-Reply-To: <20190703172554.GA27719@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [130.164.75.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15cbd5ff-c2df-44bc-7af8-08d700574a64
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR04MB6238;
x-ms-traffictypediagnostic: MN2PR04MB6238:
x-microsoft-antispam-prvs: <MN2PR04MB62384123A6F28416FCDF610CB7FA0@MN2PR04MB6238.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(39860400002)(366004)(346002)(189003)(199004)(486006)(6436002)(186003)(76176011)(71190400001)(71200400001)(33656002)(99286004)(53936002)(6916009)(25786009)(6506007)(476003)(8936002)(14454004)(6246003)(478600001)(68736007)(256004)(11346002)(2906002)(446003)(6116002)(3846002)(102836004)(66556008)(229853002)(66946007)(66066001)(5660300002)(66476007)(66446008)(64756008)(7696005)(74316002)(54906003)(52536014)(4326008)(81166006)(86362001)(26005)(8676002)(55016002)(81156014)(305945005)(76116006)(73956011)(9686003)(316002)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6238;H:MN2PR04MB5920.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UIRu5pTmsJ3ameg0HwaEkeAtBhTkfNP5BqEYqSUtyPFxZPIdnkFCVoCqUVdweCqsylvlkUFfpnijaSjjSehZDAGtEoUCMCDlGhFY38jJIosRfP0PvXcJg75LfRve0SmXP+pt2+WLSbYNAzRWWc/LUExtzLP5ITCivql+tBV5CsotTFs/0WlZPJygnlaMEvCLhBp90wQp0atC+u1Islf+zqzAL6YQ5HH9+GgT+L5MXP80ot+tNXPE0g8xdycJ4aqz6ewfoQ5BwgVWTnJE5DiBTeJIj5zvWkGVATEKoLuRaKZMyg6Rf+eSBDcOobq+VtdmkT4ZCJnCfMm+TBavgrFLnkmVH03uHyTWO/Jpz6ah7aePapRJabr7RC0tWPv/nvMWuAw3LUcOWm75h3fUau7MloXBoPv6ib6NLdnpn6mvtjY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15cbd5ff-c2df-44bc-7af8-08d700574a64
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 08:12:00.5558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: je.yen.tam@ni.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6238
Subject: RE: Re: [PATCH 1/2] serial/8250: Add support for NI-Serial PXI/PXIe+485
 devices.
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-04_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907040107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Jul 01, 2019 at 08:23:23PM -0700, jeyentam wrote:
> > Add support for NI-Serial PXIe-RS232, PXI-RS485 and PXIe-RS485 devices.
> >
> > Signed-off-by: jeyentam <je.yen.tam@ni.com>
> > ---
> >  drivers/tty/serial/8250/8250_pci.c | 879 +++++++++++++++++++----------
> >  1 file changed, 582 insertions(+), 297 deletions(-)
> >
> > diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/82=
50/8250_pci.c
> > index df41397de478..0a711b895b33 100644
> > --- a/drivers/tty/serial/8250/8250_pci.c
> > +++ b/drivers/tty/serial/8250/8250_pci.c
> > @@ -1,10 +1,10 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /*
> > - *  Probe module for 8250/16550-type PCI serial ports.
> > + *	Probe module for 8250/16550-type PCI serial ports.
> >   *
> > - *  Based on drivers/char/serial.c, by Linus Torvalds, Theodore Ts'o.
> > + *	Based on drivers/char/serial.c, by Linus Torvalds, Theodore Ts'o.
> >   *
> > - *  Copyright (C) 2001 Russell King, All Rights Reserved.
> > + *	Copyright (C) 2001 Russell King, All Rights Reserved.
> >   */
>=20
> Why are you changing comments for no reason?

These changes are not intended, I believe the editor I used messed up the
spacing, will remove it and resubmit the patch.
