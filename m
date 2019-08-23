Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CF9C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 13:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C733F22CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 13:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="UNPT2yFQ";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="UNPT2yFQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390159AbfHWNoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 09:44:11 -0400
Received: from mail-eopbgr130073.outbound.protection.outlook.com ([40.107.13.73]:8579
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731976AbfHWNoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 09:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNtI5wqrTyggMyjM01vDUYvNWAaEVU9KwHvb0PD2H7M=;
 b=UNPT2yFQXh7Xsi88d/w/zokyg422VPkIpl/G0+bZTrpOKNE/4Ft9TtMvx/0M0KRQD6UtL8ktvAYzA1eZ5UjrzinZqdllozXulOlotVR2/L0KoP7xEU+S7HOln7ZHP6+F6HztJcMqCIc3sjhuesOiS+8vmrxbHzxlu6UT6IWJn9A=
Received: from VI1PR0802CA0008.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::18) by VI1PR0801MB1854.eurprd08.prod.outlook.com
 (2603:10a6:800:5c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2178.18; Fri, 23 Aug
 2019 13:44:00 +0000
Received: from DB5EUR03FT024.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::205) by VI1PR0802CA0008.outlook.office365.com
 (2603:10a6:800:aa::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2199.14 via Frontend
 Transport; Fri, 23 Aug 2019 13:44:00 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT024.mail.protection.outlook.com (10.152.20.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2199.13 via Frontend Transport; Fri, 23 Aug 2019 13:43:58 +0000
Received: ("Tessian outbound 8b8b6ad907d7:v27"); Fri, 23 Aug 2019 13:43:56 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 41f84fbdbd92ee24
X-CR-MTA-TID: 64aa7808
Received: from 18a976e32348.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.4.52])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 19EE2CAC-A7CB-40BF-96E2-69C40DFAB334.1;
        Fri, 23 Aug 2019 13:43:50 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-am5eur02lp2052.outbound.protection.outlook.com [104.47.4.52])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 18a976e32348.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 23 Aug 2019 13:43:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvgkVkTwnafWbGMsLwICFMJVaFslwijPknossceLOQxOhPPuav1tzYmhzjpqqdgot6pXo0m8VaXv40bmR3ylAKvjflljU/7nIzzfpmoBOs+5fUnWNg1vbGeNBdiimRedgX/UtGcFGPlMLumQLqRyqpsjvhkYVoSXA/dDsYkDiBSipqyCxT6mxsubPWa7xJm7/zH9qJ2mSZ0zL8fY926fxpOLwv8WRSua9Jf0X8IZCnivWJ8XXFecYRJUKLS2O76OstIVYFe9kn+hJk6GLjB6l/kE36aD7kwQPOCFlcuM3s9PxNCKdUg8isE9OinHq/ztrnPq71Wip5WhyAq8z+EHAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNtI5wqrTyggMyjM01vDUYvNWAaEVU9KwHvb0PD2H7M=;
 b=ahNUb1I3+0R0mcTuMVLqVVxkge0pm0FjvWDCk+eX+W4Or+9wsl3gjGCxpqET1shCBiA6yXcsdjkAWDSFi2zZI/uvgH7LD9adge18/o1OTSj/X/SrP1+iR0g6y6HozsfAQw5Bu9e6gQrlu1yLpSkcWrTzyj2L7GAw9dpni9FeYGiImz1zwVnGAZkuFx7FLmX8qAFUH4zDptsGnX5PverhyDCVxUj+Sffg29u0885TIR5r2IZcQOKJnfNFOggj6SafFMPutdOCzV98rvFlPXXg+wUeB7oQgNa8C1IOtI1g244gqcOGFgX+IJz+RicMxD+ClMstac1EJcnwLMzgDsTtxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNtI5wqrTyggMyjM01vDUYvNWAaEVU9KwHvb0PD2H7M=;
 b=UNPT2yFQXh7Xsi88d/w/zokyg422VPkIpl/G0+bZTrpOKNE/4Ft9TtMvx/0M0KRQD6UtL8ktvAYzA1eZ5UjrzinZqdllozXulOlotVR2/L0KoP7xEU+S7HOln7ZHP6+F6HztJcMqCIc3sjhuesOiS+8vmrxbHzxlu6UT6IWJn9A=
Received: from AM7PR08MB5352.eurprd08.prod.outlook.com (10.141.172.139) by
 AM7PR08MB5462.eurprd08.prod.outlook.com (10.141.174.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Fri, 23 Aug 2019 13:43:50 +0000
Received: from AM7PR08MB5352.eurprd08.prod.outlook.com
 ([fe80::842f:3fe:54f9:b18a]) by AM7PR08MB5352.eurprd08.prod.outlook.com
 ([fe80::842f:3fe:54f9:b18a%2]) with mapi id 15.20.2178.020; Fri, 23 Aug 2019
 13:43:50 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     David Airlie <airlied@linux.ie>, Liviu Dudau <Liviu.Dudau@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        nd <nd@arm.com>
Subject: Re: [PATCH] drm/komeda: Add missing of_node_get() call
Thread-Topic: [PATCH] drm/komeda: Add missing of_node_get() call
Thread-Index: AQHVV2pPVPebZtWZiUahUiy3IZo+PqcIwsGA
Date:   Fri, 23 Aug 2019 13:43:49 +0000
Message-ID: <20190823134348.GA27922@arm.com>
References: <20190820151357.22324-1-mihail.atanassov@arm.com>
In-Reply-To: <20190820151357.22324-1-mihail.atanassov@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0133.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::25) To AM7PR08MB5352.eurprd08.prod.outlook.com
 (2603:10a6:20b:106::11)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.54]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: f389b4ac-b233-4652-2094-08d727cff347
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM7PR08MB5462;
X-MS-TrafficTypeDiagnostic: AM7PR08MB5462:|VI1PR0801MB1854:
X-MS-Exchange-PUrlCount: 1
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0801MB18549A14B0AB937734E6DA7BE4A40@VI1PR0801MB1854.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:42;OLM:42;
x-forefront-prvs: 0138CD935C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(199004)(189003)(11346002)(966005)(6306002)(71200400001)(71190400001)(6512007)(6486002)(478600001)(99286004)(81156014)(81166006)(14454004)(66066001)(305945005)(8936002)(7736002)(52116002)(76176011)(229853002)(6246003)(26005)(4326008)(3846002)(5660300002)(2906002)(33656002)(66946007)(36756003)(66446008)(64756008)(66556008)(66476007)(53936002)(386003)(25786009)(6506007)(54906003)(1076003)(6862004)(316002)(102836004)(186003)(6436002)(2616005)(44832011)(476003)(8676002)(486006)(86362001)(6636002)(14444005)(256004)(6116002)(446003)(37006003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM7PR08MB5462;H:AM7PR08MB5352.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: k5x1IQl9a1wBNKRLJ1QpamjGK46y3UG7ACCArDnVUen05Gl8caeL1hABPl8jIW7AoyhQiyCf5UX57pHxYJHcNmtWVq7YZsmeK2gdiRqFYXdWJYSUlapugOrhzL6I/PG3zBR9h1y1xmRAtIYbjslNU/pUJz4bf4D8732AiJi7iOqOu5eVNBrSfLz6d6/PL3l7qz8uqWR6FJmJj4CpDUeLK0ikgQ5N93/vr5jSoOlexJU/yD8LVUaUr+9hY1m/ZCMZoGgCBq5oZW0Zi/x6u6lR5X2y+LIuqfQTcaPB6+sFlahDZyv4QzPeujNiSOaSIz2aoY4RGWtN0GvKfq9FPLfwELmN6yY7O7ssF1wr1if7SLagbHJyUf7qnlR7CWQiKLQEeKsUXm4dJzKGwVK4zOQQQ8dYzx7bHS9sF6e3xA7rmIg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8CCBA03F563D0E4E85AC075BD916E953@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5462
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT024.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(346002)(376002)(2980300002)(189003)(199004)(102836004)(46406003)(8936002)(8746002)(76176011)(6862004)(36756003)(11346002)(66066001)(70586007)(70206006)(316002)(186003)(25786009)(97756001)(305945005)(336012)(126002)(7736002)(476003)(63370400001)(81166006)(63350400001)(446003)(33656002)(26826003)(81156014)(47776003)(2616005)(8676002)(966005)(22756006)(478600001)(229853002)(37006003)(4326008)(14454004)(99286004)(86362001)(54906003)(486006)(1076003)(26005)(6486002)(76130400001)(6636002)(6246003)(14444005)(50466002)(2906002)(386003)(6506007)(6116002)(5660300002)(6512007)(23726003)(6306002)(3846002)(356004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB1854;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4ca3d629-bcfc-489e-92c7-08d727cfedcb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0801MB1854;
NoDisclaimer: True
X-Forefront-PRVS: 0138CD935C
X-Microsoft-Antispam-Message-Info: 8RJuOy4F5OEb2W5swoi2iseJHDvy7nALvojJBeJLzrJIH8hR8Uiq3+Job0uv9zXS8lw5Nb+h6l25eI28jB2qoo2Reh5sRPrGpsowNOfumrulHeLg1uI4Xmm+Rw6so9ScWl88vy3/e1E/h7SNF95YfwYet9YT5h1JeEvX8ITJMvEa8m5YEv0aEIqoAelYsZEohvaak8l1opsmP0Nd1xeaBoRR0A4nECUw5RlZeNe5BzL62iG8INIjADQhoATARZVeAJ6zRGR0LKeKk+Dxgzu3r/JYpJo26NiqSC3iIOd8j4i+9Xuh0MPvOF+Rva2stUCJ7DogTYxuvtvWY0cTd3XqNFi5pz61wFVCPES11an4Zn4JeUH4Sflr59XebmioDUkLHc+FbiixVsSDGsu+kgBS5uXC3jpbwSp3/JN+3HM4v3U=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2019 13:43:58.8892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f389b4ac-b233-4652-2094-08d727cff347
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1854
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 03:16:58PM +0000, Mihail Atanassov wrote:
> komeda_pipeline_destroy has the matching of_node_put().
>=20
> Fixes: 29e56aec911dd ("drm/komeda: Add DT parsing")
> Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_dev.c
> index 0142ee991957..ca64a129c594 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> @@ -130,7 +130,7 @@ static int komeda_parse_pipe_dt(struct komeda_dev *md=
ev, struct device_node *np)
>  		of_graph_get_port_by_id(np, KOMEDA_OF_PORT_OUTPUT);
> =20
>  	pipe->dual_link =3D pipe->of_output_links[0] && pipe->of_output_links[1=
];
> -	pipe->of_node =3D np;
> +	pipe->of_node =3D of_node_get(np);
> =20

Good catch.
Reviewed-by: Ayan Kumar Halder <ayan.halder@arm.com>
>  	return 0;
>  }
> --=20
> 2.22.0
>=20
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
