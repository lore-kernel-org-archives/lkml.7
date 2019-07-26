Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA92C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 07:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E8B21852
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 07:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="eIzy3l+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfGZHR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 03:17:58 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:56262 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725864AbfGZHR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 03:17:57 -0400
Received: from pps.filterd (m0098778.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6Q7FpgN016678;
        Fri, 26 Jul 2019 02:17:56 -0500
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2057.outbound.protection.outlook.com [104.47.38.57])
        by mx0b-00010702.pphosted.com with ESMTP id 2tx62ha42r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Jul 2019 02:17:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxF4VEVlyRAIXPRJwKOwaEmJvUukrnI6mOS6byLwMZ5587ClYlQ+cUV8yxYp8gbWUhRn9IofjklNvrXmKDwF8Mna2Q7+VVXxYTeoeb68rJjR1J5IsN2daPDgbZXELaFfv4UsSG34mc1cPb7zs2Ne1oKyMD+7wmnBxO/piFuegDLl3UYL+R83jq5zpTGopnBMDrH2v6IRS+bT1UhDywbZma98AXD86k9yEOVjPlF3cHuthTM5o18vTpD2KAVZ7ss3XjoYUNqQVxl66gzlYZkpM0Zd9JDZX6NOTJRVWqDPpGsQCtiR3Ovbdg4x+r7WVsrAHp/WfSAe5TZAG1phTlIeDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKwp8CjaeUvz3CiHVkGBr3l5I2skOP7r0GetkhMolY4=;
 b=Lh6SRFQVGAkoZ0BukXSbxiASqlExXjRzU6TAWVwTKEtNK4Ch6E3N8BApd6szBiu68Kj5G328gEwskWrZS6cv6FUxQSanakXUtOcLDf97jY9XUNXd/6bhcXGMdb7RoiIjjyC2dJA+93yMkmgeBLvX6rWcKmAbo7kZ10GMYOrCvCDUou8y7hGRYLTJGQhmfVSyLJUDV0aoHRHr5B9AzXyWfZsV4cI1PQrktaIOOxV5DhH85A7tJdhW9DejXchrYJf0WJ2sWD+kTT6Ye6vBqQke+3tGxI6I44o5HLSGgygk8OopY59rMc+0BsJcxtBUk7MEynA5dDHbH2Oziqu7WzVAlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=ni.com;dmarc=pass action=none header.from=ni.com;dkim=pass
 header.d=ni.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKwp8CjaeUvz3CiHVkGBr3l5I2skOP7r0GetkhMolY4=;
 b=eIzy3l+o+D/V8cKRpStNLDVAnfpWC8XCvgWhXqWvMEyTwYqAZgMtGkB92inEfaqNHHR+kA1fMQDNbIfAu8vJYGyYH/T2i9h7KiB28Duhlw2osGZd1UGFjqidN7ybdLPW2EbMKW9mmRGs05ThX1Kop0Tp/Fck2kPHUzgdBc9Dr44=
Received: from MN2PR04MB5920.namprd04.prod.outlook.com (20.179.21.161) by
 MN2PR04MB5679.namprd04.prod.outlook.com (20.179.20.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Fri, 26 Jul 2019 07:17:54 +0000
Received: from MN2PR04MB5920.namprd04.prod.outlook.com
 ([fe80::584f:77e7:16ee:ba8]) by MN2PR04MB5920.namprd04.prod.outlook.com
 ([fe80::584f:77e7:16ee:ba8%7]) with mapi id 15.20.2115.005; Fri, 26 Jul 2019
 07:17:54 +0000
From:   Je Yen Tam <je.yen.tam@ni.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v5] serial/8250: Add support for NI-Serial
 PXI/PXIe+485 devices
Thread-Index: AQHVQ1uO9G2waROnik6RFS2RainSUqbcfTwAgAAAZPA=
Date:   Fri, 26 Jul 2019 07:17:54 +0000
Message-ID: <MN2PR04MB59205704D8A670ECBF5ABA81B7C00@MN2PR04MB5920.namprd04.prod.outlook.com>
References: <20190726024046.5873-1-je.yen.tam@ni.com>
 <20190726071600.GA12610@kroah.com>
In-Reply-To: <20190726071600.GA12610@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [130.164.74.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75575433-d01c-40b1-f950-08d7119960db
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR04MB5679;
x-ms-traffictypediagnostic: MN2PR04MB5679:
x-microsoft-antispam-prvs: <MN2PR04MB5679924CBA246E137BA96B3DB7C00@MN2PR04MB5679.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 01106E96F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(39850400004)(396003)(366004)(199004)(189003)(33656002)(4326008)(71190400001)(229853002)(7736002)(446003)(11346002)(71200400001)(6436002)(14454004)(8676002)(81156014)(81166006)(68736007)(52536014)(86362001)(6916009)(66066001)(6246003)(53936002)(74316002)(5660300002)(4744005)(3846002)(6116002)(66946007)(8936002)(66476007)(66446008)(64756008)(66556008)(25786009)(186003)(9686003)(55016002)(102836004)(26005)(2906002)(476003)(99286004)(6506007)(76176011)(7696005)(76116006)(54906003)(256004)(305945005)(316002)(486006)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5679;H:MN2PR04MB5920.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2PhXXhkc0r8rLOb4OikOTlEiuvvwFRIdvpOWvQTaz2otPvjEUlqvs7smByxB2zS+hBbGH0eSZ/s2Ypys9s4p3uzVX40z1aIKJLsMzvhHbDHpZynxolx/DshZLgX74f3fSWwjqaumu7c3lncqj2mapRqoVwACmo2g95NFHG58gvLLxcupICTzR4gj6mGaPb/KjUvo2Qq04LAtPhKMT6BSPaOiywMNu9Few/wfALro1J872RxAfT+NelHBcpTaGpvauKQOG8/LiiEfQREbINBW41VJj/mS0wl0NVd3pYKu0KBKbk6J0oVhZ+x0gzA/B4DF60mg0NFyTGpWniilxzHqDjBSORvILXhwDXaRBlOxR3j4RRBgzgUc17w+4CuRh8HLV1bSbCbtO6PUuNaegHIGmkOie6T5/QUldRP8Q+XMszo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75575433-d01c-40b1-f950-08d7119960db
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2019 07:17:54.7023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: je.yen.tam@ni.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5679
Subject: RE: Re: [PATCH v5] serial/8250: Add support for NI-Serial PXI/PXIe+485
 devices
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-07-26_04:2019-07-26,2019-07-26 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30 malwarescore=0
 clxscore=1015 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-1906280000 definitions=main-1907260095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [EXTERNAL] Re: [PATCH v5] serial/8250: Add support for NI-Serial
> PXI/PXIe+485 devices
>=20
> On Fri, Jul 26, 2019 at 10:40:46AM +0800, jeyentam wrote:
> > Add support for NI-Serial PXIe-RS232, PXI-RS485 and PXIe-RS485 devices.
> >
> > Signed-off-by: jeyentam <je.yen.tam@ni.com>
>=20
> You messed up the From: and signed-off-by: lines this time :(
>=20
> v4 had it "correct", please fix up and send v6.

Oh snap, will fix it in v6.

>=20
> thanks,
>=20
> greg k-h
