Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF83C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2282B218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="NwwvKMfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfGDIUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 04:20:48 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:33052 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726908AbfGDIUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 04:20:48 -0400
Received: from pps.filterd (m0098779.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x648KWZV011573;
        Thu, 4 Jul 2019 03:20:46 -0500
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2052.outbound.protection.outlook.com [104.47.44.52])
        by mx0b-00010702.pphosted.com with ESMTP id 2thdc0g2vx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 04 Jul 2019 03:20:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRcis37n7+dLs3PX9tKud5OqsphzZwKzbDOpYLBUhs4=;
 b=NwwvKMfFScqmZJT8WMlaSbgAhN46vIx2z94Bwzc54zUNi3ATV4oiuLtDwz4GZvvPnSb2nuHZGwNt1eT2Igsp9p4j7tilMQXOjZP0vcX9cIfCJj84UAdZQVQpsZbX060GRAVZeraR2ydbAaP2zjEcwRXFc6JQDxnRWybI39hCnb0=
Received: from MN2PR04MB5920.namprd04.prod.outlook.com (20.179.21.161) by
 MN2PR04MB6014.namprd04.prod.outlook.com (20.178.249.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Thu, 4 Jul 2019 08:20:44 +0000
Received: from MN2PR04MB5920.namprd04.prod.outlook.com
 ([fe80::7ca2:1dbc:355d:64c7]) by MN2PR04MB5920.namprd04.prod.outlook.com
 ([fe80::7ca2:1dbc:355d:64c7%5]) with mapi id 15.20.2052.010; Thu, 4 Jul 2019
 08:20:44 +0000
From:   Je Yen Tam <je.yen.tam@ni.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: Re: [PATCH V2 1/2] serial/8250: Add support for
 NI-Serial PXI/PXIe+485 devices
Thread-Index: AQHVMkCXqHv3rulWzk6DDrimdUTooaa6Hg0g
Date:   Thu, 4 Jul 2019 08:20:44 +0000
Message-ID: <MN2PR04MB59200003FF168C024B90C3F0B7FA0@MN2PR04MB5920.namprd04.prod.outlook.com>
References: <20190703072435.34152-1-je.yen.tam@ni.com>
 <20190703084220.GD8996@kroah.com>
 <MN2PR04MB59207BEC9DBAB5E69656DD42B7FA0@MN2PR04MB5920.namprd04.prod.outlook.com>
 <20190704081500.GA6438@kroah.com>
In-Reply-To: <20190704081500.GA6438@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [130.164.75.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70edffc9-eb2c-489c-4859-08d7005882c5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR04MB6014;
x-ms-traffictypediagnostic: MN2PR04MB6014:
x-microsoft-antispam-prvs: <MN2PR04MB6014A8F00CBE226149CB65B8B7FA0@MN2PR04MB6014.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(396003)(346002)(376002)(366004)(13464003)(189003)(199004)(53546011)(66556008)(64756008)(229853002)(54906003)(76176011)(66446008)(66476007)(76116006)(66946007)(316002)(6506007)(8936002)(186003)(6246003)(3846002)(7736002)(102836004)(486006)(74316002)(305945005)(66066001)(73956011)(476003)(11346002)(6436002)(33656002)(26005)(446003)(6116002)(8676002)(6916009)(2906002)(71190400001)(7696005)(9686003)(55016002)(81156014)(86362001)(71200400001)(256004)(478600001)(53936002)(99286004)(81166006)(14454004)(68736007)(5660300002)(52536014)(4326008)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6014;H:MN2PR04MB5920.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NxWlbkXA4//fhErZunFpwSaLWrYDNP3w2SdqWd58kyOZEWnMp8NR8fOSFaM3M32mS635+atK5ILL45dQYZKoAIp1JpkcOYinnHgN28yJ/z/elKqJvg2Wo7Sd4xjAljQ4IvxblswBmS4DZb6cKHoL68ivhF5EnSGVWG+jfigr0ysckNr3EbP+Z/Ea/QTa3bBcxTW6HyKNDnHALfEpDw7QUxX5vxYVDJn60Cdys9z+chG68uUzhxZlQLKy50CyaGtEywsS+LU/poGTlVJNQV8tRFYJd67GrlUPeEHZ4VVJHTOURR+nlkh2v9nX0rTkWSCH0gZtphWLf83O/2bRWpZZ8dQscq/a3Bql/pg3vcoymj1vBoVuSnz2AdaeQ2YQjoe8WXUshdCjD0kw5AHUODNqyiZ9MJ/4TasyrnRnMWwLx5A=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70edffc9-eb2c-489c-4859-08d7005882c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 08:20:44.6404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: je.yen.tam@ni.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6014
Subject: RE: Re: Re: [PATCH V2 1/2] serial/8250: Add support for NI-Serial
 PXI/PXIe+485 devices
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-04_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907040109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Thursday, July 4, 2019 4:15 PM
> To: Je Yen Tam <je.yen.tam@ni.com>
> Cc: linux-serial@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [EXTERNAL] Re: Re: [PATCH V2 1/2] serial/8250: Add support for N=
I-Serial
> PXI/PXIe+485 devices
>=20
> On Thu, Jul 04, 2019 at 07:55:33AM +0000, Je Yen Tam wrote:
> > > On Wed, Jul 03, 2019 at 12:24:35AM -0700, jeyentam wrote:
> > > > Add support for NI-Serial PXIe-RS232, PXI-RS485 and PXIe-RS485 devi=
ces.
> > > >
> > > > Signed-off-by: jeyentam <je.yen.tam@ni.com>
> > >
> > > I need a "full" name here please.
> >
> > Ok, will do so.
> >
> > >
> > > Also, this patch breaks the build, which is not allowed, and makes me=
 wonder
> how
> > > you tested it :(
> >
> > I've tested my changes with the steps as follows, it did not break.
> >
> > 1. Clone the Linux repo, check out the source and work on my project.
> > 2. Compile the kernel source with "make j4".
> > 3. Build the kernel modules with "make modules_install".
> > 4. Install the kernel with "make install".
> > 5. Reboot into the newly built kernel.
> > 6. The kernel worked well and able to fit my needs.
> >
> > Noted that my source is checked out from the latest Linux kernel 5.2.0-=
rc6.
> >
> > Also, I checked my patch using checkpatch.pl, it did not show any error=
s and
> > warnings too.
> >
> > May I know what do you mean by breaking the build?
>=20
> If you only apply patch 1/2, the build breaks as you add new device ids
> in the second patch.  At every individual patch, you can not break the
> build.

Understood, will move the #defines into this file which needed it.

>=20
> thanks,
>=20
> greg k-h
