Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE9CC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 06:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F141C20709
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 06:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="xP+ERfLW";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="xP+ERfLW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfKUGeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 01:34:10 -0500
Received: from mail-eopbgr50050.outbound.protection.outlook.com ([40.107.5.50]:3138
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725904AbfKUGeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 01:34:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qrys8ZmVbaxAdz+iUV34mPGZXaz0vn5Z4q3Myc7XMV0=;
 b=xP+ERfLWjCFp0eu8td0BU1JrMwYHVwSN6XNbY+wQbE9HN74USiWoVvl+bRnzm70N4Pr7q0Bb3bWjy+KofaFpjG03muGqgrKHh1dMcLSAdehLjL/RsqhnBY7QOCMOwdKeGlcGXlLqB527k8bt7QzsmiTjW+JADj7NzangUzMCON0=
Received: from VI1PR08CA0244.eurprd08.prod.outlook.com (2603:10a6:803:dc::17)
 by AM5PR0802MB2417.eurprd08.prod.outlook.com (2603:10a6:203:9c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23; Thu, 21 Nov
 2019 06:34:04 +0000
Received: from DB5EUR03FT037.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::208) by VI1PR08CA0244.outlook.office365.com
 (2603:10a6:803:dc::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.16 via Frontend
 Transport; Thu, 21 Nov 2019 06:34:04 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT037.mail.protection.outlook.com (10.152.20.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17 via Frontend Transport; Thu, 21 Nov 2019 06:34:04 +0000
Received: ("Tessian outbound 512f710540da:v33"); Thu, 21 Nov 2019 06:34:03 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 846db7b12def9770
X-CR-MTA-TID: 64aa7808
Received: from c732f6f9984d.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.12.50])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id E7E39B9F-3919-4BA3-AA7D-623A07958483.1;
        Thu, 21 Nov 2019 06:33:58 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04lp2050.outbound.protection.outlook.com [104.47.12.50])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id c732f6f9984d.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 21 Nov 2019 06:33:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyNrRs0BI0J6FgfFXIVRdTAEjL7ubjMg0V7OTMZy8w4Avt/77xU/b4r2xRGY+v6nJrkvOgQDtHtamH+xez3SctE5EFS42Jfq5wQcgV7Txjhc0L2spdRSuQ4YiO5DSYCyasG1vLKqXOaH8B3qqlqXpUM6ab2xMOnPt6dgW8fgvihYBZ4j2n051KRVAh8GvwOSZdILdL7Xv9ri7jwXBn2VzjPSqO8zG5EjdjwGMr9NTRmPYgqo8m8bkGjwGsHQCAbAvncqFWdEcsmkH85sLb6HOnzanh3mTQDf2/m+oRbJLww4Z7sDS9/atmCnPbajgFSLk88G7crmO/pfxogBNtnNfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qrys8ZmVbaxAdz+iUV34mPGZXaz0vn5Z4q3Myc7XMV0=;
 b=CBAVi49PR3VWfnXbHjHRxAcvgjx4Mfs0Pnv+1925bH04nUcWc48AXNWGXTafCbWCoY920KlfIwMXqHW1TBeZW7XZuwQHAWK+UgUOVdciRULPez01KbzxlPp52A2sn5dc9ZxOm1eShFfXgGPqyTcO20p0f+JPrD+PN/t0EYaATc6ii22pBfR+1pNmqyli+LY15o8F9hJzCN/8m+xXUN4/psu795VTTS+dOBvpMMbcG2qkhQ9n9EeIbWKRfRSE3hbqPYzQZDoajIBsFPnopEXP7UEueSYRzzle1vImEXme4JSc3hiTsIAPjeYZDyWGgq2mgUdLQ0j9G0MstqzvnSN0Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qrys8ZmVbaxAdz+iUV34mPGZXaz0vn5Z4q3Myc7XMV0=;
 b=xP+ERfLWjCFp0eu8td0BU1JrMwYHVwSN6XNbY+wQbE9HN74USiWoVvl+bRnzm70N4Pr7q0Bb3bWjy+KofaFpjG03muGqgrKHh1dMcLSAdehLjL/RsqhnBY7QOCMOwdKeGlcGXlLqB527k8bt7QzsmiTjW+JADj7NzangUzMCON0=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5037.eurprd08.prod.outlook.com (10.255.158.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.28; Thu, 21 Nov 2019 06:33:54 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7%6]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 06:33:54 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>, Sean Paul <sean@poorly.run>
Subject: Re: drm/komeda: Remove unnecessary komeda_wb_connector_detect
Thread-Topic: drm/komeda: Remove unnecessary komeda_wb_connector_detect
Thread-Index: AQHVoDWlPqB60NeFLUufwrTo5mSxsw==
Date:   Thu, 21 Nov 2019 06:33:54 +0000
Message-ID: <20191121063347.GA25271@jamwan02-TSP300>
References: <20191120120348.37340-1-mihail.atanassov@arm.com>
In-Reply-To: <20191120120348.37340-1-mihail.atanassov@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR04CA0077.apcprd04.prod.outlook.com
 (2603:1096:202:15::21) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4fab43cd-d876-4053-32b2-08d76e4ccdd3
X-MS-TrafficTypeDiagnostic: VE1PR08MB5037:|VE1PR08MB5037:|AM5PR0802MB2417:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB241796BC6A35F296AE99F5E9B34E0@AM5PR0802MB2417.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:1468;OLM:1468;
x-forefront-prvs: 0228DDDDD7
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(136003)(346002)(396003)(39850400004)(376002)(366004)(189003)(199004)(5660300002)(316002)(33716001)(25786009)(66066001)(8676002)(102836004)(6636002)(64756008)(66446008)(66476007)(33656002)(3846002)(2906002)(6512007)(66946007)(99286004)(86362001)(52116002)(229853002)(386003)(6506007)(76176011)(6436002)(6486002)(54906003)(6862004)(6246003)(4326008)(9686003)(6116002)(66556008)(7736002)(305945005)(446003)(14454004)(11346002)(478600001)(71190400001)(8936002)(1076003)(71200400001)(186003)(58126008)(26005)(14444005)(256004)(81156014)(55236004)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5037;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: zZkBPE9o8CM1aaJb08NxuuULVBTJY5GDFJWZYgPyyP2+xjhuXdb6g8E3O1qFcFhLFP/jNeNEcKARXZXpAEW5HsIb2ocwwR20CW91PRXM3S6EvY2lf+N9pfF1f3djPlRAth5Xco70DN/uhgn/3rtRvPMG848/Q35qRMwapw3TzVZtcpyk8+EYd5o9UG/0dkq8/hSL1TK8RMRuoW40WdhDj2Okw+D1jTfVSIIxqzfxxJGT/8kXv0tCsPWLJ0CrESlFq6/akeYYCzWrNfdKY/JBCmBMpACupCESVupFl5btu/D0jp7STCuzp63lrFuGN211hTprEr+vjkD7WB4TIflnWY+Z1b9vJRb3BIksIN4j+EzuYewZHX+rJmdOGPaYulmKgIsRdpffPsp5Hp55azXReFNjTsrQGQDFApEoT4G4S4fT/tLx7nWSBAvwV6q461a2
Content-Type: text/plain; charset="us-ascii"
Content-ID: <38FC27F944BE454FB1A4131BB69BFEFB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5037
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT037.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(136003)(396003)(346002)(376002)(39850400004)(1110001)(339900001)(189003)(199004)(33716001)(6246003)(305945005)(2906002)(99286004)(33656002)(25786009)(1076003)(8936002)(23726003)(3846002)(8676002)(446003)(6862004)(70206006)(70586007)(6116002)(50466002)(26826003)(4326008)(6636002)(356004)(478600001)(76130400001)(66066001)(8746002)(76176011)(14454004)(47776003)(26005)(46406003)(22756006)(107886003)(102836004)(5660300002)(11346002)(7736002)(336012)(9686003)(386003)(6506007)(97756001)(81156014)(14444005)(54906003)(81166006)(58126008)(6512007)(186003)(6486002)(316002)(229853002)(86362001)(105606002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0802MB2417;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 03bf7d68-17fc-480c-f4ef-08d76e4cc7b8
NoDisclaimer: True
X-Forefront-PRVS: 0228DDDDD7
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DMcReVG5szreuRh+P0zkP//OytoEBFHRPBuAEdb70cgNmoFQ6aX8mFixAr8Bjb60NGPKqbhOfuTNes/JqI5TRoElpqj0LN1yL9NU7p0q7xymPb0VFOd4kaC6NLbdFw96gXU/pyPW8ZFvmh4QObZGhIBJpWnqhleKJ+PnosOuupbx1uzFSVWrpJX7zXDXjcU5KMHqFVYkYkn7BfjKgwqqWVjUhSzcWYszsUj4JmG2CLOn+x1juRPk6WggRpDDIkOu38MnG0drQrtrHqPSAw/hv6sPyJoXFhiG7Zvh7ckXd0tcGw2yiW1pEoJvcPwqpaNuvVVWVZYKFWDkdM0nihllaEDcNmSHqqs80ePf3qL7SKbZXgbvtHmvciVsN6i9Fi+QvY+PocKi6h9p/1ropGw95+Q68dJrHcV3gnEpe1y8CDU07B3blUewR2fRk3xBaZvQ
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2019 06:34:04.5404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fab43cd-d876-4053-32b2-08d76e4ccdd3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2417
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 12:03:55PM +0000, Mihail Atanassov wrote:
> The func is optional and the connector will report as always connected,
> i.e. no change in behaviour.
>=20
> Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c | 7 -------
>  1 file changed, 7 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> index e465cc4879c9..c89ecdba8c28 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> @@ -107,12 +107,6 @@ static const struct drm_connector_helper_funcs komed=
a_wb_conn_helper_funcs =3D {
>  	.mode_valid	=3D komeda_wb_connector_mode_valid,
>  };
> =20
> -static enum drm_connector_status
> -komeda_wb_connector_detect(struct drm_connector *connector, bool force)
> -{
> -	return connector_status_connected;
> -}
> -
>  static int
>  komeda_wb_connector_fill_modes(struct drm_connector *connector,
>  			       uint32_t maxX, uint32_t maxY)
> @@ -128,7 +122,6 @@ static void komeda_wb_connector_destroy(struct drm_co=
nnector *connector)
> =20
>  static const struct drm_connector_funcs komeda_wb_connector_funcs =3D {
>  	.reset			=3D drm_atomic_helper_connector_reset,
> -	.detect			=3D komeda_wb_connector_detect,
>  	.fill_modes		=3D komeda_wb_connector_fill_modes,
>  	.destroy		=3D komeda_wb_connector_destroy,
>  	.atomic_duplicate_state	=3D drm_atomic_helper_connector_duplicate_state=
,

Looks good to me.

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>
