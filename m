Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BECCC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 06:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 281D820700
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 06:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Zg0OG1/2";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="m6GiGw6K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbfDEGuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 02:50:02 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:44774 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726389AbfDEGuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 02:50:02 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x356kPsl008194;
        Thu, 4 Apr 2019 23:49:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=HhqynMrsXDvwWZ2vJRTUq+EeGXyfLLq3QuQOM/Z5wCQ=;
 b=Zg0OG1/2E5y0RBiUqTl6VmiNN8h2whKmtlELAjyqGAOIjxM4lgUjmiVPONFNKac6yaR3
 zGpytxQEHvOXuiDU+bidAacJn0JlQbjxGl4vFa9EwQYKgGVP/5eZRXTG0UVCsKasnZ7Q
 eyZMXv/yMF6PKP9j/7qmVFgEB3p01LGQKNSRwN0MCJOnfl/YyYuec07HNWIArAAZYd7R
 Z9meE/bbzW96d8mafu52fZOxkPZPwli7/Tjy4Wd3MM6+tLZmXqfvfLMV4B1j71iNJjSd
 yjPgVXiW+fE3PA5EcL2SWrP8ceU44GVEIPa5Eyex7KEERJTiBjwbIsoqMkpUpfmNnw4H +w== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2rnv96159r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 04 Apr 2019 23:49:51 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 4 Apr
 2019 23:49:40 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.50) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 4 Apr 2019 23:49:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhqynMrsXDvwWZ2vJRTUq+EeGXyfLLq3QuQOM/Z5wCQ=;
 b=m6GiGw6K+lyXsAI23Vh2ldJ+9j9tMEJAXIyjd34djw+eg/2fqBHTE54pie8aVRel7/ksFezjNhKYsV+DKnw7lov/+suy0WxCnrVMj7b4BrIyNiV17I20Ac9aOMcB4o0O6nD5tX6QmAB6Ybc4HJnrOHHKe1fznqDw42U1HxYuks8=
Received: from BL0PR18MB2305.namprd18.prod.outlook.com (52.132.30.25) by
 BL0PR18MB2322.namprd18.prod.outlook.com (52.132.30.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.19; Fri, 5 Apr 2019 06:49:35 +0000
Received: from BL0PR18MB2305.namprd18.prod.outlook.com
 ([fe80::d42:95e4:7e1c:76b6]) by BL0PR18MB2305.namprd18.prod.outlook.com
 ([fe80::d42:95e4:7e1c:76b6%5]) with mapi id 15.20.1750.017; Fri, 5 Apr 2019
 06:49:35 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Moving to @marvell.com addresses for Cavium
 ThunderX2
Thread-Topic: [PATCH] MAINTAINERS: Moving to @marvell.com addresses for Cavium
 ThunderX2
Thread-Index: AQHU39Z7ml8v/3ZEokigx4+LKvn4qKYtN8IA
Date:   Fri, 5 Apr 2019 06:49:35 +0000
Message-ID: <20190405064930.kur553xvpx7rugq5@rric.localdomain>
References: <20190321110741.19177-1-rrichter@marvell.com>
In-Reply-To: <20190321110741.19177-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0202CA0023.eurprd02.prod.outlook.com
 (2603:10a6:203:69::33) To BL0PR18MB2305.namprd18.prod.outlook.com
 (2603:10b6:207:43::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.12.173.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22d70794-69d3-4040-713c-08d6b992dd4a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BL0PR18MB2322;
x-ms-traffictypediagnostic: BL0PR18MB2322:
x-microsoft-antispam-prvs: <BL0PR18MB2322BE780AE9F32A68DCDBCDD9510@BL0PR18MB2322.namprd18.prod.outlook.com>
x-forefront-prvs: 0998671D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(39860400002)(396003)(346002)(189003)(199004)(6506007)(53546011)(71190400001)(2906002)(386003)(99286004)(71200400001)(102836004)(478600001)(97736004)(8936002)(8676002)(86362001)(14454004)(229853002)(6116002)(81166006)(76176011)(6486002)(81156014)(3846002)(26005)(486006)(68736007)(52116002)(25786009)(66066001)(6246003)(476003)(186003)(105586002)(6436002)(4326008)(256004)(53936002)(106356001)(5660300002)(110136005)(305945005)(7736002)(4744005)(446003)(54906003)(11346002)(316002)(1076003)(9686003)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR18MB2322;H:BL0PR18MB2305.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cqkXmvalQrGAMoAQUGjeqYZ2fclcKZj1/hxsnsG2XHdlyQ8IUJSgvXH81mKKQl1v6f8E+V3qEEeBpKQIBhhzsDjgDZZSCOx2P6m2LO8RBrnrwiHQj2fKHbx7cwICSCdfP1UjQRpxsBsUP9QZlga2oU3QQQuvuYUwjJYn1vGadqfLpbib0E7JSjx3u1diVsQm8oigvZ3phmUhft1bXxmTg/Lwr2Gi/i5DoVQjPpS2dx7qGRH0PPlgKYdeMD1UtrL975+gTUMkF7CXP0j5C2Y+4AVaPQRWgVofuVTRiQTdyUim7kk+GryBCTpZCS/ztEDiI03jlJem4mkXM3J1qCmMQJn/eG3uUAFbXCcQqJP8rT2RSE4XPezAG8r2KogzSzcIHwFjnxVcqvvdUr/WbWT4uDn23M+IUwQ7vyZqNzmHa2A=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3CA7D16C3808AF42BFD6E7506BC2A034@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d70794-69d3-4040-713c-08d6b992dd4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2019 06:49:35.4625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR18MB2322
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-05_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.03.19 11:08:59, Robert Richter wrote:
> Our @cavium.com addresses will be switched off soon. Using
> @marvell.com addresses from now on.
>=20
> Cc: Jayachandran C <jnair@marvell.com>
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Rob,

could you route this patch through dt/next? Please let me know if you
need anything to apply this.

Thanks,

-Robert

>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a7432224930b..37f0a2aed4bb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3507,8 +3507,8 @@ S:	Supported
>  F:	drivers/crypto/cavium/cpt/
> =20
>  CAVIUM THUNDERX2 ARM64 SOC
> -M:	Robert Richter <rrichter@cavium.com>
> -M:	Jayachandran C <jnair@caviumnetworks.com>
> +M:	Robert Richter <rrichter@marvell.com>
> +M:	Jayachandran C <jnair@marvell.com>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  F:	arch/arm64/boot/dts/cavium/thunder2-99xx*
> --=20
> 2.20.1
>=20
