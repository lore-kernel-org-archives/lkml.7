Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4A1C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 20:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4889E2235D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 20:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="oZtF8Fzt";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="ByatIm8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfKSUXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 15:23:53 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:37158 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726711AbfKSUXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 15:23:52 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAJKJmdY002225;
        Tue, 19 Nov 2019 12:23:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=NMmYMjuVeWbYfyKQWy8blFlkVL6iuw2H/NU/67IIKP4=;
 b=oZtF8Fzt127gcTFlgNx6sPc2YC8XLSpTppV7sQMA7/8edo/BcmCBZbMqta70aOFb2Z0G
 rFn91kF215ofnAGnRZGw4z8nB1bu6hH8o0jS3Gq79FlFGE/4w6jYu/vx1YYetnpzqg9V
 hw4rOC59BnY7JlOIF3ktRGazEkUAzAzpZ/DRxJkhC4vKPpSNeSIV19AIIwGMkkFrJexr
 7blLbdmh17yd3PrMeN+aiOBWmDmvcOAeHokStowmZERj9mG1sTATCcEFPg/1hbXBm3KO
 vX8xidrqccxMVaypWFWlDxJ6PXK25g5nNyLJs6f6pcxVPtySbxWgfdX+F/Slafx0HfsC ag== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2wc8423ygp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 19 Nov 2019 12:23:39 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 19 Nov
 2019 12:23:38 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.54) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 19 Nov 2019 12:23:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2wm+gB5RwAGBUAtdEUBZ+Tsj20vqDfekvN/xvUNXZvcTO79m4PWlY0YX1OuCeFQpRnoImMZivqo80QP49JknVOSTHm4cjvZYTviLQae1TZrRPDx14iHyv2cEHa1Z8QQKoBPR5uIeQNomG4UbW5+X9H97f21LE20isQdd9bp85Y73KdRWnnUpXlJw0Y6kXwBU6ODOtjGPTxRcKYoHoqhgYxI4ppNGbjRXPjxoLU+9w8U+NEtgCCZVp/ZYsx+2kTafnFDKDXYKuKcTsUcDeaEvY3rsuzH5Y40hDj0P1ddzjtjOjXwTRVw0ZlUJpSjLqjKZSg7OevNJqUErXBYJQNPVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMmYMjuVeWbYfyKQWy8blFlkVL6iuw2H/NU/67IIKP4=;
 b=J2xlRaMDVjyURa+Bm2GogTJn3ZlOzb/LjSIek9ZM8dLpKi0sDrfho00bywHJNnk5/th8OxUJtpx1NJd4jgQhpdj5aMlW1uFZ1VGm1SoLZ2pUq8PKFHcfMhVuEe320eqmVgMHcz292CyMhJf1ZCp5BxfNM0GERJIe3RZZbRZGD1o0lXkTXEYD+nrlxaqcsxvFL1diUHvUVa3tG6OzK9X+eMwyc5pS2HG1Io79CBSS4IPXxnTlzcGnpiS+eyu5qZ37IdP73xBY48i17sONj3fqtouV1Nra/2GqqKJA+5bo4YNQyriV6YAK0Ns4Qo/Pl0NMwEOwpC/7kBtEqgr45Lcpzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMmYMjuVeWbYfyKQWy8blFlkVL6iuw2H/NU/67IIKP4=;
 b=ByatIm8FmX7ck9/iRBk2wjRBsleWT/nXebL9/f9xgSznb5u9C8KEtim/7aGT0Wc8KiHpIuO5cD+69+qE5/3f3Ew7NKhrM2jHcnOco5EGDdPXW6UtEpK//9nR73nxHJGbbmD654XqpE+LpRigAPsPUpxdH9SAVTbIoWt54U1Tkro=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3375.namprd18.prod.outlook.com (10.255.236.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.30; Tue, 19 Nov 2019 20:23:37 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106%7]) with mapi id 15.20.2451.029; Tue, 19 Nov 2019
 20:23:37 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Joe Perches <joe@perches.com>
CC:     Arnd Bergmann <arnd@arndb.de>, arm soc <arm@kernel.org>,
        Jan Glauber <jglauber@marvell.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "George Cherian" <gcherian@marvell.com>,
        Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "soc@kernel.org" <soc@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] MAINTAINERS: Switch to Marvell addresses
Thread-Topic: [PATCH 2/2] MAINTAINERS: Switch to Marvell addresses
Thread-Index: AQHVnxc526FsAUcWSEycL6HUHOvp6g==
Date:   Tue, 19 Nov 2019 20:23:36 +0000
Message-ID: <20191119202328.cqfzf5a4svn23h5a@rric.localdomain>
References: <20191119165549.14570-1-rrichter@marvell.com>
 <20191119165549.14570-4-rrichter@marvell.com>
 <64ace55545c028bc39b08370074aafd32e8fc5f5.camel@perches.com>
 <20191119185012.2fekd6f5gbpflpqe@rric.localdomain>
 <cb41a8956be6cf11e9d25c1790eeb8c935b9ab29.camel@perches.com>
In-Reply-To: <cb41a8956be6cf11e9d25c1790eeb8c935b9ab29.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR02CA0092.eurprd02.prod.outlook.com
 (2603:10a6:7:29::21) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4eb2d43-421c-4a41-386b-08d76d2e5b86
x-ms-traffictypediagnostic: MN2PR18MB3375:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB337546CB5AD6095407FF76FED94C0@MN2PR18MB3375.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(199004)(189003)(66446008)(71200400001)(8936002)(6436002)(25786009)(229853002)(86362001)(81156014)(71190400001)(8676002)(2906002)(4326008)(6512007)(66066001)(316002)(3846002)(6116002)(54906003)(6246003)(256004)(11346002)(81166006)(476003)(1076003)(446003)(9686003)(64756008)(66556008)(6486002)(486006)(99286004)(66946007)(52116002)(186003)(26005)(6916009)(305945005)(478600001)(7736002)(76176011)(4744005)(5660300002)(102836004)(14454004)(66476007)(53546011)(386003)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3375;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jjtK0xeK0YZx1XcsxKa5xlY0NkEpXGbmQG1yEOOMbR43z3wk9FTU5n2KUno9tEQoFejWE/xdVLzdRPH5S888iohGoxBGYR4NO/pDMIZM5u9kiZxBjDxDXQpWtJvSyRjlvErlwsF7oewGOB8qeBZjUFDkFo0RJRAoI3d+UZrTPu1/SmWtFfbNzZsD1OxThjk6QAP2o4aScvGZEwGcGloP+626lLt7Gu5vo28RUjwIVnME4QaqFQq6EXEmMR8eazuMSpK60C75wacLOf29bOS9W+O6i1OG5CkUu+hWOgJnWIbFHFnOf9EFtV/EJu+ydgPYX6yIUlZYvS8f2ptoVchbS54OdOnLMDZUCMxKA0YPc59ikhISEVf+oswxGIDZ7NZ/krKbVlvqJs332Jlk5OK9KuSxe914qySxnonBpy4DhHwygZryPF+J1v7Y+wiDKC+Q
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0B9FD714210A1F4D9149F6A6F49D01D9@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b4eb2d43-421c-4a41-386b-08d76d2e5b86
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 20:23:37.0119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vhTCoS7QUqAzWvk/m/4L4d6DHIpQOa2oyciewioHyNCwaWKSZevF9QkWoM/WHaXr/reAZiW8Gy70NScMPn7jVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3375
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-19_07:2019-11-15,2019-11-19 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe,

thanks for your review.

On 19.11.19 11:56:53, Joe Perches wrote:
> Maybe make that change globally in all the files other
> than MAINTAINERS as well eventually.
>=20
> arch/arm64/mm/numa.c:6: * Author: Ganapatrao Kulkarni <gkulkarni@cavium.c=
om>
> arch/mips/cavium-octeon/octeon-usb.c:551:MODULE_AUTHOR("David Daney <davi=
d.daney@cavium.com>");
> arch/mips/include/asm/octeon/cvmx-coremask.h:6: * Copyright (c) 2016  Cav=
ium Inc. (support@cavium.com).

[...]

This is a bit past the scope of this patch. I will leave that change
to the driver's maintainers. I also think that authorship does not
change even if the author's email address changed or vanished later. I
am not sure on the general handling of MODULE_AUTHOR(), should that
always contain a valid email address? Seems not the case. I don't
think somebody actually sends an email to the author, it is more to
better identify the author.

Thank you,

-Robert
