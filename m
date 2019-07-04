Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF9BC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7DAD2133F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="i1G+7Xw/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfGDHwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 03:52:08 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:20626 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726087AbfGDHwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 03:52:08 -0400
X-Greylist: delayed 3204 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Jul 2019 03:52:07 EDT
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x646uvOj005162;
        Thu, 4 Jul 2019 01:58:41 -0500
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2050.outbound.protection.outlook.com [104.47.37.50])
        by mx0a-00010702.pphosted.com with ESMTP id 2thbqmg5ha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 04 Jul 2019 01:58:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tj0dlnp/PVorpElrc/fkekJ98Qvl7E5TOUrYYbxaI0Y=;
 b=i1G+7Xw/DX9pq1Rk2vjPPMcgv7I9BtNx7C3IgUjJsiR0j2E67jzswkbT4WuJ5o8E3vrXu35HzEU1Y6dJGJAyLKvltdtyyKsTM9sAxTbsq5d1Hv0LLZN1YWdfdRw570nvaB0I679ZppYhrOD+ADeB92qi/eCQu3KMLOCwkneWnh8=
Received: from MN2PR04MB5920.namprd04.prod.outlook.com (20.179.21.161) by
 MN2PR04MB5904.namprd04.prod.outlook.com (20.179.23.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Thu, 4 Jul 2019 06:58:39 +0000
Received: from MN2PR04MB5920.namprd04.prod.outlook.com
 ([fe80::7ca2:1dbc:355d:64c7]) by MN2PR04MB5920.namprd04.prod.outlook.com
 ([fe80::7ca2:1dbc:355d:64c7%5]) with mapi id 15.20.2052.010; Thu, 4 Jul 2019
 06:58:39 +0000
From:   Je Yen Tam <je.yen.tam@ni.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH V2 2/2] PCI: Add NI-Serial PXI/PXIe+485
 device IDs
Thread-Index: AQHVMXB865RUzFDHYki64KPD1/QjN6a4kdOAgAF0UiA=
Date:   Thu, 4 Jul 2019 06:58:39 +0000
Message-ID: <MN2PR04MB5920BB86A99B1ABF946B2373B7FA0@MN2PR04MB5920.namprd04.prod.outlook.com>
References: <20190703072516.34199-1-je.yen.tam@ni.com>
 <20190703083605.GA8996@kroah.com>
In-Reply-To: <20190703083605.GA8996@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [130.164.75.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65ff0b80-6cf0-4ccc-9fc4-08d7004d0b5d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR04MB5904;
x-ms-traffictypediagnostic: MN2PR04MB5904:
x-microsoft-antispam-prvs: <MN2PR04MB59041A4C708F4B9A33D768C1B7FA0@MN2PR04MB5904.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(376002)(346002)(39860400002)(189003)(199004)(26005)(76176011)(7696005)(99286004)(102836004)(6916009)(6436002)(186003)(6116002)(86362001)(6506007)(3846002)(68736007)(25786009)(229853002)(478600001)(14454004)(6246003)(55016002)(9686003)(4326008)(53936002)(54906003)(316002)(8936002)(81156014)(81166006)(8676002)(33656002)(66066001)(486006)(305945005)(7736002)(5660300002)(74316002)(52536014)(2906002)(71200400001)(256004)(11346002)(73956011)(64756008)(66556008)(66476007)(66946007)(66446008)(446003)(71190400001)(76116006)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5904;H:MN2PR04MB5920.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: URHkMACEs+yob06jTMlA1nupCCAmJc0pdfNJtOTaEtvCts86PJS7VqS3h0eoqwJpKDamT/sjUwPhd0yo3iaqY5svEK0t1E7wCcO5O8/3lpKLh+p7vUQqFQFUr1GVA7bIdBW6x28dXaZueLKYbPtZ504Q5Z1oIYlBDHoV2nup+7Sb7tvVbU8G+F8R70iqOBJLxMjn62sGZhalRsSqYpTTCwMfJhUV2bhRksNI8bTp07oy0XvrSfuui/EfPBVC/OkvIcUmGuOPnk1UhQtsxCkI97s0d66jNzj2Hc66x2pwPbjEO0UTt1UQWyU0PVG4CuaS7aX8VxtZXl6Xr3P/2gXKNJaXmfTnpO4hWuy9f0j6WpnumlnPQEY3fNZHvoRvayXPl8VrVfyPq6Y1pFMYxT1XCHXdI52Um2xJjAHopLaCBSE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ff0b80-6cf0-4ccc-9fc4-08d7004d0b5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 06:58:39.7862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: je.yen.tam@ni.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5904
Subject: RE: Re: [PATCH V2 2/2] PCI: Add NI-Serial PXI/PXIe+485 device IDs
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-04_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907040090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Jul 03, 2019 at 12:25:16AM -0700, jeyentam wrote:
> > Add NI PXIe-RS232, PXI-RS485 and PXIe-RS485 device IDs.
> >
> > Signed-off-by: jeyentam <je.yen.tam@ni.com>
> > ---
> >  include/linux/pci_ids.h | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
>=20
> You have read the comment at the top of this file, right?  If so, why=20
> are you adding these entries?

Yes, but I think these entries should be added in because the NI-Serial PXI=
=20
(RS232) device IDs already been defined in this file originally, so now I'm=
=20
adding the newly supported NI-Serial PXI (RS485), PXIe (RS232) and PXIe=20
(RS485) device IDs into here as they are the same product.

>=20
> > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h index=20
> > 70e86148cb1e..7fad4794789f 100644
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h
> > @@ -1027,7 +1027,9 @@
> >  #define PCI_DEVICE_ID_SUN_TOMATILLO	0xa801
> >  #define PCI_DEVICE_ID_SUN_CASSINI	0xabba
> >
> > +/* NI-Serial Device IDs */
> >  #define PCI_VENDOR_ID_NI		0x1093
>=20
> That's a vendor id, not a serial device id.

Yes, will change it to vendor id.

>=20
> thanks,
>=20
> greg k-h


Thank you.
Regards,
Je Yen Tam
Staff Software Engineer
National Instruments=A0
o=A0=A0 604-3776397
e=A0=A0 je.yen.tam@ni.com


