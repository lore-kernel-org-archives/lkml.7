Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230F9C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A88217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="1BHTDRRY";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="1BHTDRRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfI0IJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 04:09:17 -0400
Received: from mail-eopbgr00061.outbound.protection.outlook.com ([40.107.0.61]:32263
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725769AbfI0IJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 04:09:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awzzyHw/0QSg+Qbj/bMWYl8B/+n5C9OdQ3BaY30ZcUs=;
 b=1BHTDRRYQclVxxbmqdUJq79dZvU1xkhUl0yHU1YjcExKFmw3oHyqE5Gor4HC4Zmf1FB+GBUjLm+8ECMfjp60I6LbcEwt2RGl//PLUC+LTInak7DoJoVDMOuTUbWzdgipMAfA5AoMq62+KVDkP9a3OkLFj5qI3RbPbsw8DCBPpI8=
Received: from VI1PR08CA0125.eurprd08.prod.outlook.com (2603:10a6:800:d4::27)
 by HE1PR0802MB2571.eurprd08.prod.outlook.com (2603:10a6:3:e2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.23; Fri, 27 Sep
 2019 08:09:09 +0000
Received: from VE1EUR03FT052.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::203) by VI1PR08CA0125.outlook.office365.com
 (2603:10a6:800:d4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.15 via Frontend
 Transport; Fri, 27 Sep 2019 08:09:09 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT052.mail.protection.outlook.com (10.152.19.173) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Fri, 27 Sep 2019 08:09:08 +0000
Received: ("Tessian outbound 0cf06bf5c60e:v33"); Fri, 27 Sep 2019 08:09:06 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 0bfc9e9ded52eff4
X-CR-MTA-TID: 64aa7808
Received: from 482ea364ef6e.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.8.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id ABC011FB-8A4F-4DB7-90BE-0183F839DC62.1;
        Fri, 27 Sep 2019 08:09:00 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-am5eur03lp2051.outbound.protection.outlook.com [104.47.8.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 482ea364ef6e.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 27 Sep 2019 08:09:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9DhLeNi3lpOdDOlRQ0MFdCTKazkU94uKf8TUwF5yAKMf4RYZWzQ6ImKdbkG6U7HeytMI92tm1jSIshs4wE/Dn6vdSQee437GnJQD41NseIcZp2T9o2xeernoO3C5ZXzNUhrdVM7+8YbgNGNyysbt6fnfLNqAF/bsd7iOFj1FhWkNWb5WEd3rAH2gt8J//jmy6RQCrW35HxiN6U9VcGROczyYTZbpOVTHtLI6qrdZC/NnQSzLtZiME/l22JAWP7ZdA/vM6jtgA/7h9VQS0l1Cucofvc2idrXUUVnPKRU+M46ajGj4tCm6KduNq74+4skstpdrPs/Jff+GdlBXK78Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awzzyHw/0QSg+Qbj/bMWYl8B/+n5C9OdQ3BaY30ZcUs=;
 b=Zj/dmbpmcIPiUhVz/vdYny8CjLA8387YXKY4ZVLiBmLINMiIQeKxbfc7szQQQGmvDBMcuf61vpwHoh0PJMlY+XURvQyh0KrddSYERNl5M8yxgmDWTwMSecxMOEHEwyp1hAhQN+g1VYtPv/zAuQ7XVBMi+o8RnLzs2XqgPKF7QodRoBy5UDvPR1dfOM62IPm4+3smx7/xwhdLb4mXfeGSHRPP2goEWze1Brxike55XYnnWwVSAlgS5/ZNzRVnpEiuP76OoiCpkc7pH+UE79RBQEOgAb/rgQCJONFh+/s5fc7TZx+an6UiF7p5gftT+YcrAXHI54YR2g+UL/JB1t1b0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awzzyHw/0QSg+Qbj/bMWYl8B/+n5C9OdQ3BaY30ZcUs=;
 b=1BHTDRRYQclVxxbmqdUJq79dZvU1xkhUl0yHU1YjcExKFmw3oHyqE5Gor4HC4Zmf1FB+GBUjLm+8ECMfjp60I6LbcEwt2RGl//PLUC+LTInak7DoJoVDMOuTUbWzdgipMAfA5AoMq62+KVDkP9a3OkLFj5qI3RbPbsw8DCBPpI8=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5087.eurprd08.prod.outlook.com (10.255.159.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.19; Fri, 27 Sep 2019 08:08:59 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a0a6:ad4c:b7a7:f879]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a0a6:ad4c:b7a7:f879%5]) with mapi id 15.20.2284.023; Fri, 27 Sep 2019
 08:08:59 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
CC:     David Airlie <airlied@linux.ie>, "kjlu@umn.edu" <kjlu@umn.edu>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "emamd001@umn.edu" <emamd001@umn.edu>,
        "smccaman@umn.edu" <smccaman@umn.edu>, nd <nd@arm.com>
Subject: Re: drm/komeda: prevent memory leak in komeda_wb_connector_add
Thread-Topic: drm/komeda: prevent memory leak in komeda_wb_connector_add
Thread-Index: AQHVdQrQ/2qKdtcMBE6ojSvUeSYtTg==
Date:   Fri, 27 Sep 2019 08:08:59 +0000
Message-ID: <20190927080852.GA25223@jamwan02-TSP300>
References: <20190925043031.32308-1-navid.emamdoost@gmail.com>
In-Reply-To: <20190925043031.32308-1-navid.emamdoost@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0P153CA0044.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::32) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: dbaf78b7-5b03-4a1e-f992-08d74321f8d1
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VE1PR08MB5087;
X-MS-TrafficTypeDiagnostic: VE1PR08MB5087:|VE1PR08MB5087:|HE1PR0802MB2571:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB257109EA29CD21DF6239CB07B3810@HE1PR0802MB2571.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:7691;OLM:7691;
x-forefront-prvs: 0173C6D4D5
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(39860400002)(366004)(136003)(346002)(396003)(376002)(189003)(199004)(446003)(5660300002)(66476007)(478600001)(54906003)(58126008)(316002)(66556008)(81166006)(99286004)(66446008)(55236004)(64756008)(8936002)(81156014)(52116002)(2906002)(102836004)(229853002)(3846002)(6116002)(33716001)(14444005)(6916009)(66946007)(76176011)(25786009)(6506007)(386003)(256004)(26005)(186003)(33656002)(6512007)(8676002)(1076003)(9686003)(4326008)(486006)(6436002)(305945005)(86362001)(476003)(7736002)(6246003)(6486002)(71190400001)(71200400001)(66066001)(11346002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5087;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: mplRSBmQFRWDuSkEPtLpJhO/VBH6IFdZ77khwvSrDARPfa4m4Db6srWxRb+16mkzFWbBMrV6BJWYbwc5rglrJuOqN+fLHixXWZ+tUcOunJ3fl8cib+Yqnw9Feo/Np0CBupi0qvEGrT9lUQ1uXMoE82C0uJ8kxNz2AIH9jEVW6iahBJ64dRJYq+sAnOjuIb010Giq+ScoHDjs3GBz8wRYGr0ltPQlIZrenCLK683vgUOYZML3xxWbBJhHF3r2AABfzy8vdLxlc80TSDGaPJGk92VU9++Uxsns804v3hqxuc7ZSQ7t0lr0eZf5rNkFkTE+5uSNBwYX8+9Bp6ArwMAxamH/FoaWIVvtPZkCaBRNBxCddMKAtxqSNrHVdGJsCekWCTn0wK6Op5FgMD468BSWPrDRBzBXTgIgTDiq3HOzpH8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9AB2ADE2338123448D05C93BCCB5DEE1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5087
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT052.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(39860400002)(396003)(346002)(376002)(136003)(189003)(199004)(99286004)(3846002)(5660300002)(6116002)(76176011)(386003)(1076003)(486006)(63350400001)(47776003)(446003)(126002)(336012)(11346002)(476003)(8936002)(316002)(26005)(36906005)(54906003)(8676002)(81166006)(81156014)(33716001)(6506007)(186003)(356004)(102836004)(14444005)(14454004)(229853002)(478600001)(70586007)(25786009)(86362001)(6862004)(8746002)(97756001)(58126008)(9686003)(33656002)(6486002)(6512007)(22756006)(76130400001)(2906002)(46406003)(26826003)(6246003)(70206006)(305945005)(4326008)(23726003)(66066001)(7736002)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0802MB2571;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 75b8f8f1-0c86-4df0-e09a-08d74321f35e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:HE1PR0802MB2571;
NoDisclaimer: True
X-Forefront-PRVS: 0173C6D4D5
X-Microsoft-Antispam-Message-Info: g/OY7NAwAQhSv4KImXkvLNHhSPZR/5gsXZe0dgKFskf8TU7ZuUeMJMFHSpEMhrD4DEjGlQ/yXtLWwTit+KkfPavZe3MHpcv6rfOs4sZpB4CPOEoRSD3McfYJLoqqvpQQc1A7J45Smbh8eMHUJ8kQWquFXFe22fUthFquyzJZnlgmLR4hIyV7Ty5nSLV/YEF4TWmgRiaPewojmsEo1pOVwwnTIGu/GEc9fgIDo3jDtbV0d3GikjfqqtnJU+n/iF6TwILyy4iTHcF3uVNPcj5gu3H8LwPwLZyIXjSuJANh3VqgzgNpwS8XwLlrqs1uBZx5HnS8/U+I6sAZ0qD5QhRTQ6p5HKTRmBjBb92es0NmssH0UuqcLJyHmXqHHky9rXC6+jLJDqUVolYOmYb0MMU9DQh05dzZNJTwt8Thf2HsJek=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2019 08:09:08.2565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbaf78b7-5b03-4a1e-f992-08d74321f8d1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2571
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 11:30:30PM -0500, Navid Emamdoost wrote:
> In komeda_wb_connector_add if drm_writeback_connector_init fails the
> allocated memory for kwb_conn should be released.
>=20
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> index 2851cac94d86..75133f967fdb 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> @@ -166,8 +166,10 @@ static int komeda_wb_connector_add(struct komeda_kms=
_dev *kms,
>  					   &komeda_wb_encoder_helper_funcs,
>  					   formats, n_formats);
>  	komeda_put_fourcc_list(formats);
> -	if (err)
> +	if (err) {
> +		kfree(kwb_conn);
>  		return err;
> +	}

Thank you for the fix.

Will push it to drm-misc-fixes

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>

> =20
>  	drm_connector_helper_add(&wb_conn->base, &komeda_wb_conn_helper_funcs);
> =20
