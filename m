Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54781C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A211213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="uhKmN35n";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="BR7EM2C3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731938AbfETNQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 09:16:35 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:52738 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727319AbfETNQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:16:34 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4KDAs14031598;
        Mon, 20 May 2019 06:16:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=eB+3+2S3PTX55u4FNxiD39Eb2BmP/5XbQ3jJaRQ3p+4=;
 b=uhKmN35nDrjfX1jm43IJ69S6sL8YJeGRf/V0KvGZW8OBZzlvGScmsPC91nTIAmX0ZdeQ
 cpFBcDposT4iZxAnnySb91uMi50M4e6NH2IqmjLP4IkAUoxYcdJ5q+E+ghVj8Di0Hf10
 Hj84GkF0N1tYEuxsM8jhg2zXZaoh9Pdy2YgEVNEmV6Tv5KuGwCLnxgZjtRUneWcW8zxC
 G80SG8/HGiGfoP7Ye0i6OmAVcnq88r3tyu/GmADbe2ZwydOoVuVWyIREvxwCcFvD2pob
 MP9LoEq6+rSXhiF1zJosqCobsRAhR8flGFdNCyZuMPJJrenp6G6mtyt06CzENG0RVsxl Mw== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2skr7m9761-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 20 May 2019 06:16:26 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 20 May
 2019 06:16:25 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (104.47.50.59) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 20 May 2019 06:16:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eB+3+2S3PTX55u4FNxiD39Eb2BmP/5XbQ3jJaRQ3p+4=;
 b=BR7EM2C3j2I8am4ardyc75m0ThxdVgya4AvRu5Ypuz8/gLV92KlTFsmw/QuorxNIKLnLGy3vI0yAqsPYDmuNDbSH9qF9ZEXnHYGAOYor8psFJdyPKkA8Q3DDOMWloTc6qhEUYVwNGIwQ20tJ6yQlv1Drf5tDwD7EZ7/lGIgc3Eo=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB3328.namprd18.prod.outlook.com (10.255.238.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Mon, 20 May 2019 13:16:23 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::70e4:8c34:d3ab:945f]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::70e4:8c34:d3ab:945f%6]) with mapi id 15.20.1900.020; Mon, 20 May 2019
 13:16:23 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Joe Perches <joe@perches.com>, "leon@kernel.org" <leon@kernel.org>,
        "apw@canonical.com" <apw@canonical.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David Miller" <davem@davemloft.net>
Subject: RE: [EXT] Re: [PATCH] checkpatch: add test for empty line after Fixes
 statement
Thread-Topic: [EXT] Re: [PATCH] checkpatch: add test for empty line after
 Fixes statement
Thread-Index: AQHVDwnjsCGL/Av60EiSxvhriQxooqZz+NYAgAAFCSA=
Date:   Mon, 20 May 2019 13:16:23 +0000
Message-ID: <MN2PR18MB318292E37F3AB9383D9FBE0FA1060@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190520124238.10298-1-michal.kalderon@marvell.com>
 <ed26df86d7d0e12263404842895460b1611def61.camel@perches.com>
In-Reply-To: <ed26df86d7d0e12263404842895460b1611def61.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.199.69.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ce514b4-29df-4a05-85bb-08d6dd255b91
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MN2PR18MB3328;
x-ms-traffictypediagnostic: MN2PR18MB3328:
x-microsoft-antispam-prvs: <MN2PR18MB332835BF2D6F0D0B883FC896A1060@MN2PR18MB3328.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(136003)(346002)(366004)(396003)(376002)(199004)(189003)(53546011)(6506007)(53936002)(7736002)(7696005)(76176011)(256004)(4744005)(102836004)(4326008)(316002)(9686003)(33656002)(25786009)(478600001)(14454004)(6116002)(52536014)(2501003)(6246003)(66946007)(73956011)(66476007)(99286004)(71200400001)(76116006)(71190400001)(68736007)(3846002)(110136005)(54906003)(66556008)(66446008)(2906002)(64756008)(74316002)(55016002)(86362001)(2201001)(229853002)(305945005)(81156014)(8676002)(81166006)(6436002)(26005)(5660300002)(476003)(8936002)(66066001)(186003)(11346002)(446003)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3328;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KO/x/ZNEhzXSEj2KRLnzvkuK0o66qsdvbplkKvpaeyT27ZuddP8X7txT/ZHxHgi3SH+TZZo8w2LOZej5QdJRcPB4aJOeYP4TAo4XIYzBkcCjwIxPG9c5dkTE9wmgRvrVYUnN1LKSon4pVcZuvYh4U0lMloADNks1kIBHoSHfCwcb3XcY+AgW7GEaM5DbjfXxzgcDlBf7PVCfeArQbAVrB2b4393ZBp+fXTFMg1BxbmngTbWpzy51OfpbbqoTDF4BGoBzr/Q58YJFofr8NCAvNYZNSe3/f0Up/C5Nit5KgrwDmz1t/MFZgxkcd+TYb+BmXavrbFkm7BeOj2tWsxVIgvSg+2NTN/jD3y2lUK9flmpsrvL/RRBnryiY7GpE35XGYNbkEU8pg7QAgoGlSzIrXIa8n0wSjSaPiKm51BHN20U=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ce514b4-29df-4a05-85bb-08d6dd255b91
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 13:16:23.8205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3328
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-20_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Joe Perches <joe@perches.com>
> Sent: Monday, May 20, 2019 3:57 PM
> Subject: [EXT] Re: [PATCH] checkpatch: add test for empty line after Fixe=
s
> statement
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Mon, 2019-05-20 at 15:42 +0300, Michal Kalderon wrote:
> > Check that there is no empty line after a fixes statement
>=20
> why?
>=20
This comment is given a lot on the netdev and rdma mailing lists when patch=
es are submitted with
an empty line between Fixes: tag and SOB tags. Since "Fixes:" is just anoth=
er tag and should be kept
together with the other ones.
thanks,
Michal
