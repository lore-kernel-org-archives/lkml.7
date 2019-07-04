Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBBBC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FBC8218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="LuLfuFOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfGDIRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 04:17:46 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:2328 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727119AbfGDIRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 04:17:43 -0400
Received: from pps.filterd (m0098778.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x648FgwR017332;
        Thu, 4 Jul 2019 03:17:41 -0500
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2059.outbound.protection.outlook.com [104.47.44.59])
        by mx0b-00010702.pphosted.com with ESMTP id 2tg8maeq02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 04 Jul 2019 03:17:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCuAG5wNuXyOtjv2v97Vzo8UxQj4yRTV9KSjck026io=;
 b=LuLfuFOLWWMIRMflMy1OaF/UwIubK9xBHFuTrG1qXz/tMnQ4jRwAQ14hrQkGhX49AlCZLiBE2CaI53gHgTobAITWfphCrr0lB3IzhQZcuCP+s8VwDco1VRODvjaf7g7hylxzPegzPHIwTgUoOKPaQ8FVQ+9sLeVJ2m1Dzxha09Y=
Received: from MN2PR04MB5920.namprd04.prod.outlook.com (20.179.21.161) by
 MN2PR04MB6014.namprd04.prod.outlook.com (20.178.249.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Thu, 4 Jul 2019 08:17:38 +0000
Received: from MN2PR04MB5920.namprd04.prod.outlook.com
 ([fe80::7ca2:1dbc:355d:64c7]) by MN2PR04MB5920.namprd04.prod.outlook.com
 ([fe80::7ca2:1dbc:355d:64c7%5]) with mapi id 15.20.2052.010; Thu, 4 Jul 2019
 08:17:38 +0000
From:   Je Yen Tam <je.yen.tam@ni.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: Re: [PATCH V2 2/2] PCI: Add NI-Serial
 PXI/PXIe+485 device IDs
Thread-Index: AQHVMkDDhpivmOB0MEO3DKqmDzUg26a6HTRw
Date:   Thu, 4 Jul 2019 08:17:38 +0000
Message-ID: <MN2PR04MB5920DFD232850F4F2CB28C47B7FA0@MN2PR04MB5920.namprd04.prod.outlook.com>
References: <20190703072516.34199-1-je.yen.tam@ni.com>
 <20190703083605.GA8996@kroah.com>
 <MN2PR04MB5920BB86A99B1ABF946B2373B7FA0@MN2PR04MB5920.namprd04.prod.outlook.com>
 <20190704081615.GB6438@kroah.com>
In-Reply-To: <20190704081615.GB6438@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [130.164.75.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cdf4dd9c-98ae-403a-fb4b-08d700581409
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR04MB6014;
x-ms-traffictypediagnostic: MN2PR04MB6014:
x-microsoft-antispam-prvs: <MN2PR04MB60146522BE1FA78C6FC9D4C2B7FA0@MN2PR04MB6014.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(39860400002)(136003)(199004)(189003)(13464003)(81156014)(9686003)(55016002)(478600001)(256004)(99286004)(53936002)(71200400001)(86362001)(6916009)(8676002)(7696005)(71190400001)(2906002)(52536014)(25786009)(4326008)(68736007)(14454004)(81166006)(5660300002)(8936002)(6506007)(316002)(66946007)(66476007)(76116006)(7736002)(6246003)(186003)(3846002)(64756008)(53546011)(66556008)(66446008)(76176011)(54906003)(229853002)(6436002)(11346002)(476003)(73956011)(26005)(6116002)(446003)(33656002)(102836004)(66066001)(74316002)(486006)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6014;H:MN2PR04MB5920.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vZK497JzoLVsMtMihc0leEn1nwm3NFm39RrTtn2q7b+j2vSKsARODjOP+5WLFarKkaHhluedPTxuoLdX+FmydbP0NE3SKvhNg/BDHN5mU8R9HwHFyuDyan5bp9DR5ETQJUpOH/14PvgQvVi7eluf4J8ZRf3B1TrwN0BHkG2kkE0gb9kT/37fWEsb7HhlmgGZ0+wD1GJYWy8lgJOTOSE1yJP1Roqxkb0Clhaqf5CGSzM/zuoN/kTTgQI9DqDSCr+9EoFC3lUYoRVgLs+uC+yjO0xzdbaLcVVoscUy/SeXPVRGZRu6+SCwN/QUMqYfoqBsSAlfWWGXm6xUMxgwxroOC+K0XcuRigEAG1JUSwBmkbS4GYCNzeyIJiOO7RKogt+c85iDgJkNjpcmN/AtvyHvAf/2Kan6SbbU01/S26RSCYc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf4dd9c-98ae-403a-fb4b-08d700581409
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 08:17:38.7995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: je.yen.tam@ni.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6014
Subject: RE: Re: Re: [PATCH V2 2/2] PCI: Add NI-Serial PXI/PXIe+485 device IDs
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-04_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907040108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Thursday, July 4, 2019 4:16 PM
> To: Je Yen Tam <je.yen.tam@ni.com>
> Cc: linux-serial@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [EXTERNAL] Re: Re: [PATCH V2 2/2] PCI: Add NI-Serial PXI/PXIe+48=
5 device
> IDs
>=20
> On Thu, Jul 04, 2019 at 06:58:39AM +0000, Je Yen Tam wrote:
> > > On Wed, Jul 03, 2019 at 12:25:16AM -0700, jeyentam wrote:
> > > > Add NI PXIe-RS232, PXI-RS485 and PXIe-RS485 device IDs.
> > > >
> > > > Signed-off-by: jeyentam <je.yen.tam@ni.com>
> > > > ---
> > > >  include/linux/pci_ids.h | 12 ++++++++++++
> > > >  1 file changed, 12 insertions(+)
> > >
> > > You have read the comment at the top of this file, right?  If so, why
> > > are you adding these entries?
> >
> > Yes, but I think these entries should be added in because the NI-Serial=
 PXI
> > (RS232) device IDs already been defined in this file originally, so now=
 I'm
> > adding the newly supported NI-Serial PXI (RS485), PXIe (RS232) and PXIe
> > (RS485) device IDs into here as they are the same product.
>=20
> No, do not add new device ids to this file, only put them in the single
> file that needs it.  This file is for device ids that are shared across
> multiple drivers/files.
>=20
> You should not need to touch this file at all.

Ok, understood. Will do so.

>=20
> thanks,
>=20
> greg k-h

Thank you,
Je Yen
