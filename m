Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F48C4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B622218C5
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="mUAngV3x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbfGEJYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 05:24:36 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:2164 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726107AbfGEJYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 05:24:35 -0400
X-Greylist: delayed 3037 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Jul 2019 05:24:34 EDT
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x659LCdb013931;
        Fri, 5 Jul 2019 04:24:33 -0500
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp2052.outbound.protection.outlook.com [104.47.50.52])
        by mx0a-00010702.pphosted.com with ESMTP id 2thbqmm5d3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 05 Jul 2019 04:24:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdUifmnF9e8rsAtVGDvK7PFzpG0jGdCLVsIDBBO2odM=;
 b=mUAngV3xwDU2u9eQ665S+7vep55qGtwVzxcdwmba+9vTuV5BQXonf2Ovi2Rj4k0L/POYNfLFIjLL+si3DN0HWlC6I9cg2iWdh/FZK7CGS7rp+VWf05Q8oxEeTyTCjVcLiadVitVDUceTOprHOsEG5wf6VxTOnDrgXfSWMy3Od5s=
Received: from MN2PR04MB5920.namprd04.prod.outlook.com (20.179.21.161) by
 MN2PR04MB6686.namprd04.prod.outlook.com (10.186.147.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Fri, 5 Jul 2019 09:24:31 +0000
Received: from MN2PR04MB5920.namprd04.prod.outlook.com
 ([fe80::7ca2:1dbc:355d:64c7]) by MN2PR04MB5920.namprd04.prod.outlook.com
 ([fe80::7ca2:1dbc:355d:64c7%5]) with mapi id 15.20.2052.010; Fri, 5 Jul 2019
 09:24:31 +0000
From:   Je Yen Tam <je.yen.tam@ni.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v3] serial/8250: Add support for NI-Serial
 PXI/PXIe+485 devices
Thread-Index: AQHVMwxiepuXonzYy0u12ekosjeaz6a7uywAgAAFgdA=
Date:   Fri, 5 Jul 2019 09:24:31 +0000
Message-ID: <MN2PR04MB592075355D90BC59B79DFCF8B7F50@MN2PR04MB5920.namprd04.prod.outlook.com>
References: <20190705083349.44047-1-je.yen.tam@ni.com>
 <20190705090422.GA32289@kroah.com>
In-Reply-To: <20190705090422.GA32289@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [115.164.187.157]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: faa3cb9b-399c-435f-7764-08d7012a962c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR04MB6686;
x-ms-traffictypediagnostic: MN2PR04MB6686:
x-microsoft-antispam-prvs: <MN2PR04MB6686022DDA92CF9AA814D26BB7F50@MN2PR04MB6686.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 008960E8EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(396003)(136003)(366004)(346002)(376002)(39860400002)(189003)(199004)(86362001)(8936002)(9686003)(55016002)(26005)(186003)(53936002)(256004)(4744005)(76176011)(7736002)(6246003)(305945005)(74316002)(81156014)(81166006)(446003)(6436002)(229853002)(71200400001)(71190400001)(8676002)(11346002)(476003)(55236004)(102836004)(6506007)(7696005)(99286004)(3846002)(6116002)(478600001)(66066001)(68736007)(486006)(4326008)(25786009)(33656002)(5660300002)(2906002)(14454004)(54906003)(316002)(66446008)(52536014)(66946007)(66556008)(73956011)(76116006)(64756008)(66476007)(6916009)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6686;H:MN2PR04MB5920.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7Ru6Jaa5crwpzQUsnpCzTGUmerYvmvAJIQFXCrG17WEYMKK57hnO/gVNuO9SIuWed4IqfZad1u1RDNg12LrGLzpy5bfVLNTZnEl4txe9JRl7f3fEgFSWS+o8yryFNWOsfyCT5B+a0LvGWZp66zWjVPjpGYzh5ZiUEDWLuAVQhEe0yCGXjLjpVVesrC3HMUttJh60HBG+OwH67GcKfSJjwXH9AR2Ch301HlKcNlX5rBGLqUl/bvq5Gf2hXzx2i8ChQUoV3uRr2AbiDgWRp9TZGEEddtq3LTYSzxqv80hZvi0PlWplaEGrSL/oQAoMDVLwGaExRdrya+PeRAJSsyQuBUuF76dB9fkR3FINWYob5CYjLA8lTq0rlFjkdTc+xt6HH1gJQ0V2eYOushY7JtGQPverOyJGeHV/HzUWVtnSHVA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faa3cb9b-399c-435f-7764-08d7012a962c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2019 09:24:31.5415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: je.yen.tam@ni.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6686
Subject: RE: Re: [PATCH v3] serial/8250: Add support for NI-Serial PXI/PXIe+485
 devices
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-05_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907050120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Jul 05, 2019 at 01:33:49AM -0700, jeyentam wrote:
> > Add support for NI-Serial PXIe-RS232, PXI-RS485 and PXIe-RS485 devices.
> >
> > Signed-off-by: Je Yen Tam <je.yen.tam@ni.com>
> > ---
> >  drivers/tty/serial/8250/8250_pci.c | 298 ++++++++++++++++++++++++++++-
> >  1 file changed, 294 insertions(+), 4 deletions(-)
>=20
> What changed from the previous versions?
>=20
> Always put that below the --- line.
>=20
> Please fix up and send a v4 with that information.

Ok, will do so.

>=20
> thanks,
>=20
> greg k-h
