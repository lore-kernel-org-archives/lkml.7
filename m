Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DB9C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 19:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2605022440
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 19:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="R9/bgvpO";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="W5iV2Xjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfKSTQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 14:16:33 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:27114 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727395AbfKSTQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 14:16:32 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAJJFYI3011105;
        Tue, 19 Nov 2019 11:16:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=VvUMH457ZL7I90dzY1WA5YNY5ze1zWdCgfdiM9yNAg8=;
 b=R9/bgvpOghLgJ+dHIC1ehGm4BeMN4geRep3s5cMw5kdLKbiWi1/8niu+PRCGuGPEd+KD
 cLtXLHCFJNNs/RG+ZSG7v3wUre0IpaF1b7jicqJKQ/8ripUu3BO1hDVCSxJq/xiH5kq+
 RZopTDRcAtEjaH7uhI6bEFjlJiU7xpsXei3OswAo3Q1c5cEvkGs1my5qf871E+G18Mo8
 PuNGP9GR96mEoOX3Q3oUMbf0HK1a5wFmhOke3JcWRYM6zhfkEI+mKyuAmerLbdzQI/lA
 0SWyjsaKie2iDk4LkHlf06krBU9U89pNmBISVRGJb3V2Kdi8oX/XgfRfBd+V5RetS8jq 7A== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2wc82vkhxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 19 Nov 2019 11:16:23 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 19 Nov
 2019 11:16:22 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.59) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 19 Nov 2019 11:16:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hUyIhmR2xsOmOLWQ7HrX8YJ57WznXvj8tz+qIhVXJRkmacjuAV+kAjLPA/5AZVZoCUJG1h32Az+fqSh+DBF5ATXrbrq2oHGmNltZINB5jZ1QSZ7L7/kTtWYL+eminIugPpyjpUtvgdDIW5Rbrlv3rnUHW3I2oAP/8LDj18JXHc76k3CmBVMG1I1TMP6yPUzif/VlYF/JtOqHaZFBX++FTloa8STWQuEHq4dxfFTy9J+EcTxxjiwt4a8tial9jJxm4S7GxnRb2CLdk3brktHNFacVwZFvZNdtZLpM+0tpJqNSELlfZ7VvUJTyGjHLxjVJ4P1JQ7te1FLIKbxJC4Nq5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvUMH457ZL7I90dzY1WA5YNY5ze1zWdCgfdiM9yNAg8=;
 b=SP6XyxNxC8WaxeUlsASLGxOZsFtUmmsme9UaxTt1M5QCku9QsKLrhOLUEtsDtlNpxGp8TNh5znTq/RrVSxflMu7NhA1r+2UFhRIx8FRB40NuH4iYHngeQYtOyyoW23s3k6W3ZkJS9hzQ1XEzib1TGYDdNesDf0W0WS0q6p4tHqQPXhNeJf47fQu1RvZAt7HchqFmD3cczvr/AY9XK7kLA85646iDuqSQIIxJ1SPFzLVBSQjo2qGT6qfHjFr9zyNNu+K3g8bjUbiazpnoa04+fmnFcpahLKLIaxweEbK45qTssXYwiwk8D2bf3/TlCmYBuPaSdSB7TInfFf+QLhRGCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvUMH457ZL7I90dzY1WA5YNY5ze1zWdCgfdiM9yNAg8=;
 b=W5iV2XjlzA0cjAnissOiwUQLq14BI6773DLbNT/HIEvGYWlrgLMX3r08MWcMtLoRdFEkPL+eoF/cGIt7LitR5/Mcc4MlXYq5Ls0EmG+A6UWjfYfeUYBjDS1hT/pm3NdTXDTmAMVP+goAKdPA21kwqA84mnDziBUeFttt4tnWnwk=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2975.namprd18.prod.outlook.com (20.179.22.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.28; Tue, 19 Nov 2019 19:16:20 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106%7]) with mapi id 15.20.2451.029; Tue, 19 Nov 2019
 19:16:20 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Arnd Bergmann <arnd@arndb.de>, arm soc <arm@kernel.org>
CC:     Jan Glauber <jglauber@marvell.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        George Cherian <gcherian@marvell.com>,
        "Ganapatrao Prabhakerrao Kulkarni" <gkulkarni@marvell.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "soc@kernel.org" <soc@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] MAINTAINERS: update Cavium ThunderX drivers
Thread-Topic: [PATCH 1/2] MAINTAINERS: update Cavium ThunderX drivers
Thread-Index: AQHVnvpGhPZ0pb7yrke8Hp6sbUjcE6eS3acA
Date:   Tue, 19 Nov 2019 19:16:20 +0000
Message-ID: <20191119191612.bnyy4agiaoakpizz@rric.localdomain>
References: <20191119165549.14570-1-rrichter@marvell.com>
 <20191119165549.14570-2-rrichter@marvell.com>
In-Reply-To: <20191119165549.14570-2-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0228.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::28) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ace1895-80b6-4d57-3dbc-08d76d24f564
x-ms-traffictypediagnostic: MN2PR18MB2975:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB29751F87EE50D6845A03DFF8D94C0@MN2PR18MB2975.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39850400004)(366004)(396003)(346002)(376002)(199004)(189003)(5660300002)(4744005)(6246003)(52116002)(4326008)(54906003)(446003)(11346002)(64756008)(110136005)(478600001)(15650500001)(66066001)(229853002)(66476007)(66446008)(14454004)(3846002)(486006)(66946007)(66556008)(2906002)(186003)(476003)(71190400001)(71200400001)(316002)(1076003)(256004)(81166006)(76176011)(99286004)(6116002)(305945005)(8676002)(7736002)(6512007)(9686003)(386003)(53546011)(6506007)(6436002)(86362001)(102836004)(6486002)(8936002)(81156014)(14444005)(26005)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2975;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mtYjojoVTAZYmVNHK/7C3MQ+8U86BtPibtATeP8woxIE27UK4BWR7dpvnMg5LdOYCp+PHWEPjkcKmxi8TKiaoC9GxIA8HujEE3d2McywesWl+veuPsJNFpP3Yw/enVJetuduH4AtSRtjaRbKMHtSTV7ozwe/umBAUshxw8ltlItmN7E9AbnNt8ZnanLJeRr7rp9xClyPqAAIwBECgDWUimRCkK9jSLB7m+IctqH1q5h4JwpUaj0GcQX4wtBi122AS3hqUGyYuQSXpr0qMjYul3mcPbHML07YV0pgd1ikbY3FcJkKlCdeHqT8yX/364IrM2/bIzxtLWsXK4+FeZ61WLOYoffmeBVLjyj/0Tcr6gPiFJYA8TGEtWITjefoqpM/552U2QI0NQvZVKQwHIGHnS7FPF+NsPlr6X0jNbfvs4dEnxusTtEikSldtPq6MfmU
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5D0A981A3E226A48B7A3670F71E3B72D@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ace1895-80b6-4d57-3dbc-08d76d24f564
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 19:16:20.1011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z5avICysYgFdmenJN29bzn6pbvzMnT06nwnwxMpMs2wxnowJBORzs7sFt0X2FCu7HaNPoXJvKWHs7u/x97pbMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2975
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-19_06:2019-11-15,2019-11-19 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.11.19 16:56:24, Robert Richter wrote:
> From: Jan Glauber <jglauber@marvell.com>
>=20
> Remove my maintainer entries for ThunderX drivers as I'm moving on
> and won't have access to ThunderX hardware anymore and add Robert.
> Also remove the obsolete addresses of David Daney and Steven Hill.
>=20
> Add an entry to .mailmap for my various email addresses.

This patch is a leftover and shouldn't have been sent. The actual
patch has a slightly modified subject:

 [PATCH 1/2] MAINTAINERS: Update Cavium ThunderX drivers

I have sent a v2 already that supersedes this series.

Thanks,

-Robert
