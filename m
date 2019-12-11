Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E06FC00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 000C721556
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="EAbJ+NLk";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="EAbJ+NLk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731064AbfLKRaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 12:30:17 -0500
Received: from mail-eopbgr80082.outbound.protection.outlook.com ([40.107.8.82]:31119
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726368AbfLKRaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 12:30:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47muZcJqcdrDAhjem+PYlfaiiIA89kh7P3pEFizoZ/A=;
 b=EAbJ+NLkpnfhThg7ObcAUEtLuAMuayiLZiUMFgxCcf7a0sjPnWUWzZN5nvwzCjp/866I460tIRDcyYe2/xq5zr8maq21mlrtAOsd3C29XDLGe0teG61RF7FPP1LcRHPibe8y9vNlbEKCU9Mkh6bSsenBVENv6N7mlm90GOXufcc=
Received: from VI1PR0802CA0047.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::33) by HE1PR0801MB1882.eurprd08.prod.outlook.com
 (2603:10a6:3:4e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15; Wed, 11 Dec
 2019 17:30:10 +0000
Received: from VE1EUR03FT025.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::205) by VI1PR0802CA0047.outlook.office365.com
 (2603:10a6:800:a9::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.14 via Frontend
 Transport; Wed, 11 Dec 2019 17:30:10 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT025.mail.protection.outlook.com (10.152.18.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Wed, 11 Dec 2019 17:30:10 +0000
Received: ("Tessian outbound 58ad627f3883:v37"); Wed, 11 Dec 2019 17:30:10 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: aa402616a960aa56
X-CR-MTA-TID: 64aa7808
Received: from 0c035635b898.3
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 7D932FF7-45BD-4FAC-9FE2-4733ED567894.1;
        Wed, 11 Dec 2019 17:30:03 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 0c035635b898.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 11 Dec 2019 17:30:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eto7VtgF/bFZYQqTSOdAJ2yMkb7RTUHd9B2/H3MTfx5ZVMVKvt7ShXA42xLO1jXbSDPaYNUKcT8zswdYn46ZkqlT+T02EaOmnRcgbFwPqTogaB3KvyjWGRPbnr+EDXPd3gFihrcRs+L0wgD9YJB3jTdDQxHBL6RY5mFRPk3H+ydUsCZBEDbxtZNVyTXMLRz9arUqddEq9lPveCwgp+b/sjXDla+6TOkp2p55rIxIDIOO1w9t/9qhHuR0zahgeR3KwYm7IxgyiC2THcaGZdPTfnRPceaELifGAH7gIAkqQSC0DKYjgwuRHmzelm4+astWS48GuOD0fLQM5l+poq9eOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47muZcJqcdrDAhjem+PYlfaiiIA89kh7P3pEFizoZ/A=;
 b=YRzexFNqtxxuCYA31hZFTbYc8crwoAboanblraRu4HPaztZ4ixT08WHmNT1donq1LAjvjgCZbD68zQRckyP42iQUkSqOKu/psVafsUVs43CYZpu+3HBbQEgGbC5fB3Y2Y7eZ+DkOHdEDNU7vzNWVoYpzhn04ImCU71r6Wsad25WmWmOBJtfOphNx1jlg31hJj0l+yVZ4Ip9FEXxNZYU8VIoFvkaLRBxSQ0m6h7C3GeQfl+tn01otFI+6+e/qB+su/YkgK02zBSjc+Am27MS4njoxUKOqV1tTfn5QRWLUZQDhl5LcCj+C6LsQDS7WpmnTwHYDNU1D6BmwB/Y0Mf1yWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47muZcJqcdrDAhjem+PYlfaiiIA89kh7P3pEFizoZ/A=;
 b=EAbJ+NLkpnfhThg7ObcAUEtLuAMuayiLZiUMFgxCcf7a0sjPnWUWzZN5nvwzCjp/866I460tIRDcyYe2/xq5zr8maq21mlrtAOsd3C29XDLGe0teG61RF7FPP1LcRHPibe8y9vNlbEKCU9Mkh6bSsenBVENv6N7mlm90GOXufcc=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3151.eurprd08.prod.outlook.com (52.133.15.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Wed, 11 Dec 2019 17:30:01 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c%7]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 17:30:01 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
CC:     nd <nd@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>
Subject: Re: [PATCH] drm/komeda: Correct d71 register block counting
Thread-Topic: [PATCH] drm/komeda: Correct d71 register block counting
Thread-Index: AQHVryCISCrm/Iio6km6+MdLrsMXu6e1I3uA
Date:   Wed, 11 Dec 2019 17:30:01 +0000
Message-ID: <1904852.g9mvNTCQN0@e123338-lin>
References: <20191210061015.25905-1-james.qian.wang@arm.com>
In-Reply-To: <20191210061015.25905-1-james.qian.wang@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.54]
x-clientproxiedby: LO2P265CA0194.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::14) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 852f9bb7-859f-4dab-4c4a-08d77e5fc61c
X-MS-TrafficTypeDiagnostic: VI1PR08MB3151:|VI1PR08MB3151:|HE1PR0801MB1882:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1882D9226E148D50B671E2888F5A0@HE1PR0801MB1882.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:1443;OLM:1443;
x-forefront-prvs: 024847EE92
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(199004)(189003)(8936002)(5660300002)(86362001)(478600001)(6636002)(2906002)(54906003)(71200400001)(8676002)(81156014)(81166006)(66446008)(52116002)(186003)(4326008)(6512007)(26005)(64756008)(316002)(33716001)(9686003)(6862004)(6486002)(6506007)(66476007)(66556008)(66946007)(39026012);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3151;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: R0CbE0/kTM80krFAiMiZETAWqM1drahEVjOqu2vYhcSvz+bWVaqb0JiBBKTLTfRdqtHOgQCXEutd9n4pJVLb/cD5EiYuqaus90/Maziu4wUaih3mjNs3DY7Cq0TXRp1J4QI6/49sc2TJHKZ0jq03Wn7qIeiDpc6Xx7ijjFJJFl/26MsU1QxAeXKsQL3HOULJJQcN16LESnaU50nqByrw/n2NvvalY75Tl4TmwnLZ7aNh3uIMSIeb/GBaSH2VWFmJpqyZF5zJ0PgRvPv+tfz2UDebbG7vPMEFC6h5rfq7/627a4jD8omlNTUTdAjS/OYek+enlFE1G0UqIT4ie2ET9oZX5yARGRclTXktqnj8WJOC+ICgDpwUrSidaJZDXIXCGKpVnLJc3OqXdGrHu7mhCXffBf40RXbvWjDxR54RRabKB2kusR6Im3awJ//vRkcbQpKze+qbVxtoPNoLWtNRb03oo/clcDGk7LzmFUTfhEz2z+dnePUU5xWo2xx4djtQ
Content-Type: text/plain; charset="us-ascii"
Content-ID: <277462619924DD4B997912FDC952039A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3151
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT025.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(376002)(346002)(136003)(39860400002)(396003)(199004)(189003)(70586007)(86362001)(478600001)(2906002)(6636002)(186003)(70206006)(26005)(76130400001)(6862004)(33716001)(4326008)(26826003)(336012)(8936002)(356004)(6506007)(9686003)(54906003)(36906005)(6512007)(316002)(6486002)(81156014)(81166006)(8676002)(5660300002)(39026012);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0801MB1882;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: ec7f7202-3695-4c4e-534f-08d77e5fc042
NoDisclaimer: True
X-Forefront-PRVS: 024847EE92
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q1yXfaTnmF/TM4XgHymVoxQJaaa+PqArkfH0nZOxDXNFSvunprne31eY8gOKFcVsW5NffZ+QqfkaCyzEBK+ggnL8tcWrrXh4zC3YjEWrS1aI7Ip9TXwlfUP+cmAqkSRy6GV784bmqDoolsBujGu/b7ZSBzvi2hp2lKAhj0MeipgWb3VSELRpwpZnQOKT7vuCVrS593uAh1Mjreptspqv/v3NwSimlJ9ftJyT5bvrdVhnAkaoU7dSB3jpHvWt6+613BHrqWyDzu6i92uQGGAoQbMDTxyTJD32q+UvvvIPmephIBJKbwO3ZJj243OeKG0w8H0OGL6yMGKPq8pmdrP+bO7mS7SeGoiE5Cvs4h4cQvYQwapIwTRiRnH0vg1SgSxkBDfS52kXn5jvbnr4U5TOpDMDdHGIbhVds5cveYn4AuRALvAM4GLF6ojX3y7QMxzwSGQHp6wBH4jigalQwolYZpFN2foEVCPg9idBeGeXiBKmxfB6Fk0C2eVyupfh+Cik
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 17:30:10.5849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 852f9bb7-859f-4dab-4c4a-08d77e5fc61c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1882
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 10 December 2019 06:10:34 GMT james qian wang (Arm Technology C=
hina) wrote:
> Per HW, d71->num_blocks includes reserved blocks but no PERIPH block,
> correct the block counting accordingly.
> D71 happens to only have one reserved block and periph block, which
> hides this counting error.
>=20
> Signed-off-by: james qian wang (Arm Technology China) <james.qian.wang@ar=
m.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers/g=
pu/drm/arm/display/komeda/d71/d71_dev.c
> index 822b23a1ce75..d53f95dea0a1 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> @@ -414,8 +414,11 @@ static int d71_enum_resources(struct komeda_dev *mde=
v)
>  		d71->pipes[i] =3D to_d71_pipeline(pipe);
>  	}
> =20
> -	/* loop the register blks and probe */
> -	i =3D 2; /* exclude GCU and PERIPH */
> +	/* loop the register blks and probe.
> +	 * NOTE: d71->num_blocks includes reserved blocks.
> +	 * d71->num_blocks =3D GCU + valid blocks + reserved blocks
> +	 */
> +	i =3D 1; /* exclude GCU */
>  	offset =3D D71_BLOCK_SIZE; /* skip GCU */
>  	while (i < d71->num_blocks) {
>  		blk_base =3D mdev->reg_base + (offset >> 2);
> @@ -425,9 +428,9 @@ static int d71_enum_resources(struct komeda_dev *mdev=
)
>  			err =3D d71_probe_block(d71, &blk, blk_base);
>  			if (err)
>  				goto err_cleanup;
> -			i++;
>  		}
> =20
> +		i++;
>  		offset +=3D D71_BLOCK_SIZE;
>  	}
> =20
>=20

Reviewed-by: Mihail Atanassov <mihail.atanassov@arm.com>

--=20
Mihail



