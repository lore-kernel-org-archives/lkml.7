Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C70C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 18:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE912208A1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 18:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kPt8IbHB";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="Ns9eWvNM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfKSSr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 13:47:28 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:23006 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726792AbfKSSr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 13:47:28 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAJIjtm9029041;
        Tue, 19 Nov 2019 10:47:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=fVwou1cwdHpI7+SoHixSqd70XiclbDxRh1WpAM9L4ek=;
 b=kPt8IbHBnXaeiKgoR0baC6+Ztbh+zQDcBpm+P36kV5XYVSEO03r82UQgQDj+T6QS0VMi
 6QeF/HarUxHeeegJTFKVLZtJhwLbFqKO+grjTvAiSpvFuG3vg6EzGyd1nYz98SE5gNeQ
 10nIUjONi4w03Bd4s9tbGvW6g0daQ70gziXghYhbG8mSV9qhkezp7gCzKwMNf4Vpzs17
 Vd6GXbSjd4fcRbHc09xexqywd3SCWZfli0Z04/mIqttxLSaUaZsy9bZAFydLV7A6CEVO
 dr1rrOcrJjfbmmFVJr2zcRDwc9vxL6r/AbUMfaf+e33+5KUCBg5Encf4D8cy+NkBPsuH gQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2wc8423j0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 19 Nov 2019 10:47:14 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 19 Nov
 2019 10:47:13 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.51) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 19 Nov 2019 10:47:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEJxem/CCLiZdVbNCDmOdUq3mc7qZ1OpTigYuLnfdF6/PPdeIN53rCYqY1m8MQnmaaRCWldE8huMz6fwdX5oXHi8eBzPxApQLoF4Kx2YQdOoLp7ZJzcCNBoopxYJCPYUhSSe+bZ2Wv+DNT7cqC1tYjTPgZLfcCFVv9VhUK1ENxJfYrSJ/GjPMSlHAwAL7T4HF1W59h5undPFEQNnNuHss+zqYKQi3jwrQNqUuzO3C4XwK/YnYeh+A69zeBPUhzO/njPAd807XbuvkAkT8LF5xke0vkDajgzePwnOOYNpuSgYfXhgsjmO0Bm7p8RFJgooXy32F0pUOjJwffXLaSF3bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVwou1cwdHpI7+SoHixSqd70XiclbDxRh1WpAM9L4ek=;
 b=WboR907Fby7+YZK1kYvQ1oQ/4EdP48VrslBNmXJ8LxScp3p/N6QtrVSlQxvGk3GECI06ysyYjSEHODjy6qtnO3TOMs0yUecIh+c+3jczWHfEpUBbj97F6qQC5K3MSk7bsYEBs/vgPm6D/VL3LzBg+Hyc7uBFLmU9s7zD02w3n9PTnWLxMkzM/pM2JtKY5bpMhjlHLxVQ3Ae70p0HGLf9iEk7kT4LUnrzBsYM5CFhUAcsKPX2SuOk0pipJ21nCPqhkjv20+jzbAGndmeJ7VmdUJYQOwkIeorSj94jxfGPeOlxwK7tL5Wl+YPutJQv14aJPm7e5h59VGen81D9Muzllw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVwou1cwdHpI7+SoHixSqd70XiclbDxRh1WpAM9L4ek=;
 b=Ns9eWvNM6IWUsObRhqDUVffrhhXrj54up6JUoa5xnW9kRDrr2ZG8Sw0dleeJ8VF+C8K3JF1jXh4l8huusQRPIezydJ6rdLa8FqfioIcLfARq7lPQKZGMIyu2hbgqO3J6GSnFpBeHdIY4iyAFP/oz/j0SAuOn2LlNfow3OlHvN0Y=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3328.namprd18.prod.outlook.com (10.255.237.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Tue, 19 Nov 2019 18:47:12 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106%7]) with mapi id 15.20.2451.029; Tue, 19 Nov 2019
 18:47:12 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Baruch Siach <baruch@tkos.co.il>,
        Jan Glauber <jglauber@marvell.com>
CC:     Arnd Bergmann <arnd@arndb.de>, arm soc <arm@kernel.org>,
        "Ganapatrao Prabhakerrao Kulkarni" <gkulkarni@marvell.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "soc@kernel.org" <soc@kernel.org>,
        "George Cherian" <gcherian@marvell.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        "Sunil Kovvuri Goutham" <sgoutham@marvell.com>
Subject: Re: [PATCH 1/2] MAINTAINERS: Update Cavium ThunderX drivers
Thread-Topic: [PATCH 1/2] MAINTAINERS: Update Cavium ThunderX drivers
Thread-Index: AQHVnwnBWbWzqpNF6EqB5ClGRnz9uw==
Date:   Tue, 19 Nov 2019 18:47:12 +0000
Message-ID: <20191119184657.2g5v36rq6p4nm5pr@rric.localdomain>
References: <20191119165549.14570-1-rrichter@marvell.com>
 <20191119165549.14570-3-rrichter@marvell.com>
 <20191119170207.cwfowgc57rvhg2td@sapphire.tkos.co.il>
In-Reply-To: <20191119170207.cwfowgc57rvhg2td@sapphire.tkos.co.il>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0043.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::11) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56bcf628-3f96-4114-d37f-08d76d20e381
x-ms-traffictypediagnostic: MN2PR18MB3328:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB332854E3A827A4BF91014EA9D94C0@MN2PR18MB3328.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(199004)(189003)(186003)(25786009)(6246003)(81166006)(107886003)(102836004)(478600001)(76176011)(66066001)(14454004)(52116002)(6636002)(7736002)(4744005)(305945005)(6116002)(3846002)(8936002)(64756008)(66446008)(256004)(66946007)(476003)(66556008)(14444005)(66476007)(26005)(81156014)(6436002)(386003)(53546011)(1076003)(5660300002)(486006)(110136005)(6506007)(86362001)(54906003)(71200400001)(4326008)(316002)(2906002)(71190400001)(11346002)(446003)(9686003)(6512007)(6486002)(229853002)(8676002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3328;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tulj+FbYeIBizla2v1EiSJ57+upKpTOaLtkROh00BssvvnQv3U5ytbU5Zs+O2x61kq83kXuWvap/shjkIRyw7Tt/lw7XB0aJOURYTgWZPMKXr1EYBVCGT65LGqUqGlRH/Uu9grV1oSNULjMzf/yf/MWnRgT1N+GIZ9X1a0AkPdu4YZLtbuwGNuAS1rGiQVW1X8t4An48WQpSgSEGuD8dw09nTdpEaI5MtUNSXZJoYamZRZyeySh5jCvDXsbc9JRUIKCeS1LEkfXvSDcjYha4XsblBhr40EqA/LrTQo355+iqjpSkFgQ20RL70YwqFrEsuM/XTOr1VjBsfHRq6IoIX1u6As47ZlTU1z0mBU8Mp3OKmTZ/7j/N4hz58E7k1Q7gExFWcS39R2K+AN60nEFbvzsrKJ3tveXJVAupvZaWUi6th1yNZOWElY/1z9N388y7
Content-Type: text/plain; charset="us-ascii"
Content-ID: <682405F23D2E6A40995A8BAB8B467197@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 56bcf628-3f96-4114-d37f-08d76d20e381
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 18:47:12.2050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mbeJiSHtarFsdKGVZIseZbtLdJRHoTZYuv2nXnvtJgU+Wf+TB66CBZj5A2+Q6PlCzb8S0URH0d0Y1VnOAmCRWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3328
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-19_06:2019-11-15,2019-11-19 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.11.19 19:02:07, Baruch Siach wrote:
> On Tue, Nov 19, 2019 at 04:56:26PM +0000, Robert Richter wrote:
> > From: Jan Glauber <jglauber@marvell.com>
> >=20
> > Remove my maintainer entries for ThunderX drivers as I'm moving on
> > and won't have access to ThunderX hardware anymore and add Robert.
> > Also remove the obsolete addresses of David Daney and Steven Hill.
> >=20
> > Add an entry to .mailmap for my various email addresses.
>=20
> Couldn't find that part in this patch.

Right, this got lost during patch flow, have fixed that.

Will send v2.

Thanks,

-Robert
