Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28E0C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 07:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797CC20637
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 07:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="AOQkuYMt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfK0HXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 02:23:44 -0500
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:36844 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726145AbfK0HXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 02:23:44 -0500
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAR7NA44008353;
        Wed, 27 Nov 2019 01:23:42 -0600
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2055.outbound.protection.outlook.com [104.47.46.55])
        by mx0a-00010702.pphosted.com with ESMTP id 2whd021afd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Nov 2019 01:23:42 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+8bvorl1ADxfznTz9ThU95ov6wUM8bzx1Mv8Cbx++qtjWY456wV2rXKrHDO8d0401dRG51boLjdt8KawoY6IkZ6okK29aXJsaPVpUfvZnr6NzPT7SJ0eE9o54hFSyxM+ayaPZGwnFI/pIdDKBFOHMkFPrAw5gMh8vtdAla9UHVziZx6J6J1dCBiBwffIDBuhA+Vn6Q9lu/GHakVy+KpszhNdSwHctlH+d3UjPXjiBV/Ibyw/8jS+2/vqQFB1oCi6D+fkXSBkH9mo66aMadGJkyh4XLNFHqkrXyGQMnv3ukd/PwfO6/tRnuIWepmko3G0+dpxdnxshwMr1FEo7YkXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPBMuNY9FBtLQta9P8U4aAD1xx4eH88iEelBp9hG/EU=;
 b=YO5eT+NvM56Iv1iYWs1FhDMo3Q2CJBkzSbIuC9kLuMSm7F1Ph3R+rDpT11ACOR3APzJhjZAvPZiNNvS39fvIXF59YY8rfVYi2F9cBn7SX0pO/FRaDRuRp+JQIVh2B+YAXvmsOyfUCakISCAICNcb4cCVNIMSh1Kv58MuIOVvuKj8YCLk4zqBccp10khSZ7mXHDQXtFeXkg2EQhCuX88LHIii7eDa6D5cOnA+iJM18bckGqydii6XTA8YoKflnxOwlc3/X9u21T8zedJPfVgjGj560AxdgiJddMMZjobHIX9/HIyI9LPilbQeBzDAioIKRVAE32QS6bfUs82ezBXqAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPBMuNY9FBtLQta9P8U4aAD1xx4eH88iEelBp9hG/EU=;
 b=AOQkuYMtixvbhDH7PJM9oeZGWtEOVJOcc8hj24urFCGXcXdzy0fIt4p0QEhSpZWdg0LdBbvGNe6Myg0d04Xgm+AXXHGc9iroptB7YCkMW9paugWzWW++P8/K2d9iT0i7YWZMHTVWPxueGiOIszQvi1igrqGNPE730Y8+kPDRtVs=
Received: from MN2PR04MB5920.namprd04.prod.outlook.com (20.179.21.161) by
 MN2PR04MB6254.namprd04.prod.outlook.com (20.178.246.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Wed, 27 Nov 2019 07:23:39 +0000
Received: from MN2PR04MB5920.namprd04.prod.outlook.com
 ([fe80::c115:9884:d22:fb7d]) by MN2PR04MB5920.namprd04.prod.outlook.com
 ([fe80::c115:9884:d22:fb7d%7]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 07:23:39 +0000
From:   Je Yen Tam <je.yen.tam@ni.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH] Revert "serial/8250: Add support for
 NI-Serial PXI/PXIe+485 devices"
Thread-Index: AQHVpNFY41vflLOwrUyBaS1l7dEVIqeelquAgAACTOA=
Date:   Wed, 27 Nov 2019 07:23:39 +0000
Message-ID: <MN2PR04MB5920DA1BBA0AF9D07E48EAC1B7440@MN2PR04MB5920.namprd04.prod.outlook.com>
References: <20191127031751.9082-1-je.yen.tam@ni.com>
 <20191127065903.GA1725222@kroah.com>
In-Reply-To: <20191127065903.GA1725222@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [130.164.75.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d3236a9-0e11-4ec1-d531-08d7730ab974
x-ms-traffictypediagnostic: MN2PR04MB6254:
x-microsoft-antispam-prvs: <MN2PR04MB6254453DCC5B09BD5F44CE03B7440@MN2PR04MB6254.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1091;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(366004)(39860400002)(346002)(189003)(199004)(7736002)(66446008)(66946007)(76116006)(66556008)(14454004)(64756008)(5660300002)(71200400001)(33656002)(478600001)(66476007)(52536014)(3846002)(71190400001)(54906003)(256004)(66066001)(99286004)(81156014)(81166006)(74316002)(316002)(8676002)(6116002)(305945005)(6436002)(102836004)(229853002)(76176011)(7696005)(11346002)(186003)(26005)(6916009)(8936002)(25786009)(6246003)(9686003)(86362001)(55016002)(2906002)(4326008)(6506007)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6254;H:MN2PR04MB5920.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fZ9dh2VkRIJZa+Sh0zx5tbk6NZG3YyWRQjwJ9+Z2q/419Cm3BSpQ438SIqDdu4sQrQhXmYGYFRPssk7COXwsAbC3snfi6+0NKoi3jkNPT7WyFj1pJgHy7imDPIAYAC5H8wdb+iOWKMVefmbtVo339/zhEAQBtmuzDSG87zyQikeNKOwCeuyZVUuo6N5DU7LGXWdMOesSulHfTUo4bb5hCw9Y2cQItxZIBc7Ofq53ReD2uANQXistq3E6/FUd5dF4+CwrSNkXkJy6ejPDQraUg/X8AIiVQX0nuGquJi7r/KzQa78mq1rN7sVsegLlt75qdHdPrP33bxtqCF4AHzriSybxNs3Ja4KgL61FIyHmomQZSBpCp9iASJT8PCD3Ma9bcEPBG4vb/kDqGJBnDnnhMHh9UxVAWtCCMeKp+eRxJWLax0ou4k9KLrR5/FTDuRbc
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d3236a9-0e11-4ec1-d531-08d7730ab974
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 07:23:39.4073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rqsp6RXoRwQcezRrWpzMnOZhNZ8yOJOr7lCXfh0zOHbI2DP02UnYETnY8WCIz1mDJT/6LEzWqrdZ0qI709OpLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6254
Subject: RE: Re: [PATCH] Revert "serial/8250: Add support for NI-Serial PXI/PXIe+485
 devices"
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-27_01:2019-11-27,2019-11-27 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30 clxscore=1015
 malwarescore=0 impostorscore=0 mlxscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 classifier=spam adjust=30 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911270059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [EXTERNAL] Re: [PATCH] Revert "serial/8250: Add support for NI-S=
erial
> PXI/PXIe+485 devices"
>=20
> On Wed, Nov 27, 2019 at 11:17:51AM +0800, Je Yen Tam wrote:
> > This reverts commit fdc2de87124f5183a98ea7eced1f76dbdba22951 which is
> > commit 225607f75454 ("serial/8250: Add support for NI-Serial PXI/PXIe+4=
85
> devices").
>=20
> That sentance does not make sense.  fdc2de87124f ("serial/8250: Add suppo=
rt for
> NI-Serial PXI/PXIe+485 devices") is in the 5.4 kernel tree, where did the=
 commit id
> "225607f75454" come from?  I don't see it anywhere in Linus's tree.

Overlooked the commit 225607f75454 which only visible to my own branch, wil=
l=20
remove it, sorry for the confusion.

> > The upstream introduced a breakage on NI-Serial PXI(e)-RS485 devices,
> > RS-232 variants have no issue. The Linux system can enumerate the
> > Serial
> > PXI(e)-RS485 devices, but it broke the R/W operation on the ports.
>=20
> I can not parse this paragraph either, what do you mean by "The upstream"=
?

"The upstream" actually means the commit fdc2de87124f. To be more specific,=
 will
rephrase it to "The commit fdc2de87124f".

> > However, the implementation is working on the NI internal Linux RT
> > kernel but it does not work in the Linux main tree kernel. This is
> > only affecting NI products, specifically the RS-485 variants.
> > Reverting the upstream until a proper implementation that can apply to
> > both NI internal Linux kernel and Linux mainline kernel is figured out.
>=20
> So this patch really does not work at all?  Can't you just find a simple =
fix to go on top
> of it to resolve the issue?  You really want it all ripped out for 5.5 an=
d 5.4.y?

It does work in NI Linux kernel but not in generic Linux kernel from the ma=
in tree, NI's
Serial team's decision is to have a cleaner implementation so decided to ri=
p out all of it
for 5.5 and 5.4.y to prevent unexpected breakage.

> thanks,
>=20
> greg k-h
