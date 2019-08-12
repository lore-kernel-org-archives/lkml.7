Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA33C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B80620820
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="U3BtJhzu";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="U3BtJhzu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfHLKxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:53:23 -0400
Received: from mail-eopbgr00070.outbound.protection.outlook.com ([40.107.0.70]:60753
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727235AbfHLKxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 06:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ci5HU8tWWizDNnGoi7DKH7OhOZVra6V7y6kMv+eux4E=;
 b=U3BtJhzuA9c6Fht3bVtYcYtx43nBD79llP7eBQzDz2pbKOFHmR2cMaQ+0Ovx2s5OVq+lridRLiI3TXhtOt4axOqYZv6aeTNqpF7k87xYFqR6grWKnu13TY9u+1UA1oEJ6FWIUE9l1VGTF0V3G3Dp5AU7mdxPHCz7S4831FgSseE=
Received: from AM6PR08CA0046.eurprd08.prod.outlook.com (2603:10a6:20b:c0::34)
 by DB8PR08MB4955.eurprd08.prod.outlook.com (2603:10a6:10:38::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.18; Mon, 12 Aug
 2019 10:53:12 +0000
Received: from DB5EUR03FT027.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::202) by AM6PR08CA0046.outlook.office365.com
 (2603:10a6:20b:c0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2157.15 via Frontend
 Transport; Mon, 12 Aug 2019 10:53:11 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT027.mail.protection.outlook.com (10.152.20.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2052.18 via Frontend Transport; Mon, 12 Aug 2019 10:53:09 +0000
Received: ("Tessian outbound 578a71fe5eaa:v26"); Mon, 12 Aug 2019 10:53:07 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 35efab63fa2a806b
X-CR-MTA-TID: 64aa7808
Received: from fd417c9c4efb.1 (cr-mta-lb-1.cr-mta-net [104.47.13.58])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id D15525B1-FAD6-467E-8DC1-21DDBD926FAA.1;
        Mon, 12 Aug 2019 10:53:02 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04lp2058.outbound.protection.outlook.com [104.47.13.58])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id fd417c9c4efb.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 12 Aug 2019 10:53:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRuqkcCM9QNDOkbBZi1GZwL27K9oy2Is7zAH1gD0+zJhxtrZwtx6aH7bzwXx1YBX+rCH1tZTTTbSX1kKUMCLKPKcvE7lxeJaxESQZPJ39dut9zXUQivqcgIixOzjm9n3jGv94TwZNJnOXnvHggKrQ0kH+DT0IlJmIBYsz7RX+8fcYZUbzWf6XtvWJ5LhBpw/z4UzsVkhpHXbIIVDmtd1x3uXQ5jzpaDFWUoJc8pu2amVnrwBjrmjckFQmwN/NOG24AWCFDiVfIezBLebv1GLrzocn7ryftGxz2Pe+MZNUkLvNKubG458/AUhPowU3KFeM0TzqqzoOM487QTDpJnJ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ci5HU8tWWizDNnGoi7DKH7OhOZVra6V7y6kMv+eux4E=;
 b=W1P/oWnOnX+FUe7+GYfuw4DdE/ti6Ef49Zcp+iDScM5YgvyhFX7FLztS0bLS2Iv5tf9PZqII2HJrA5lvFo34bvrJCA2IC+gJIS5ZdDY/ECmv0HX8bOj57Nps2ltTCusGC1dcFaUN16Y5p0xH33ykZISLBTSnSJ6Ov+3SI2csWA2Bci3V8CQr58irruAOaLJslWUFtngXKeOZanDlOWgS53zZm+qqsLOOaiLqDutRxUrudgySuOj1SK0X3UjWzNJ8MGuQ2VZk2ygEq8TrK+vbbvfrcFJwWgVd7VGW95Mb0kihReu2P1yYqMuhW5npIHF+q0tyvRiA02n+tj2WOmT+Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ci5HU8tWWizDNnGoi7DKH7OhOZVra6V7y6kMv+eux4E=;
 b=U3BtJhzuA9c6Fht3bVtYcYtx43nBD79llP7eBQzDz2pbKOFHmR2cMaQ+0Ovx2s5OVq+lridRLiI3TXhtOt4axOqYZv6aeTNqpF7k87xYFqR6grWKnu13TY9u+1UA1oEJ6FWIUE9l1VGTF0V3G3Dp5AU7mdxPHCz7S4831FgSseE=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4654.eurprd08.prod.outlook.com (10.255.27.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Mon, 12 Aug 2019 10:52:59 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::2151:f0b1:3ea7:c134]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::2151:f0b1:3ea7:c134%6]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 10:52:59 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        nd <nd@arm.com>
Subject: Re: drm/komeda: Adds internal bpp computing for arm afbc only format
 YU08 YU10
Thread-Topic: drm/komeda: Adds internal bpp computing for arm afbc only format
 YU08 YU10
Thread-Index: AQHVUPwa45rlrHJFJkaIagZP40lFIw==
Date:   Mon, 12 Aug 2019 10:52:59 +0000
Message-ID: <20190812105252.GA7054@jamwan02-TSP300>
References: <1565073104-24047-1-git-send-email-lowry.li@arm.com>
In-Reply-To: <1565073104-24047-1-git-send-email-lowry.li@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0P153CA0047.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::35) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: b0f13430-57a0-4d1f-b06b-08d71f1343bb
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4654;
X-MS-TrafficTypeDiagnostic: VE1PR08MB4654:|DB8PR08MB4955:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB49553FB5D88E25C10051F1D5B3D30@DB8PR08MB4955.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2201;OLM:2201;
x-forefront-prvs: 012792EC17
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(376002)(366004)(346002)(396003)(39860400002)(136003)(199004)(189003)(486006)(229853002)(476003)(66476007)(66556008)(256004)(14444005)(66066001)(6636002)(6436002)(5660300002)(14454004)(6486002)(8936002)(33716001)(54906003)(446003)(58126008)(11346002)(66446008)(64756008)(478600001)(316002)(71190400001)(71200400001)(2906002)(3846002)(66946007)(53936002)(52116002)(99286004)(6246003)(4326008)(1076003)(76176011)(6512007)(386003)(86362001)(6506007)(33656002)(81166006)(81156014)(9686003)(8676002)(102836004)(7736002)(55236004)(25786009)(26005)(305945005)(186003)(6862004)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4654;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: +DwiPc0XGDGauofxLA56FrZPidilVnMD5elsrR5NXn0dHyol5olc4p12sb8KnmZKWFuIqssGSbYdMkptqK6uAxKIFAvG7VB3cBvur0vJgjEjaQ9TLM7DU8LfJnEvUBSziUuwVKG17NRhTqoc9K0aCVeM2fRh/zFYQSJI0VJisTbVU1j3k8YOKavoTncAhID5GM/nIRQG5fBQvjjZ48wbKhAPqfrJ4r+qfC6TjVPkWn24sWnH0GThRVFQUoq6+I4HXwqwhIJUB6Qgtx1qFjZP8CGZX7MATpgtX9xWooox/rtqwwmDVV3SU4J2cO+rWgBdfEwt0VkYYrjMEWUxo1rU1Widrhja199E+RDXl1CnJFlYkb6X1jmeBxOv5t8c7pv8z9/WMO32rKXCAGOTh/u1t5OE6rpZjzE8ZZvxcCWn9Yk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BA0F9DE1EB2CAD46AA108282155017E3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4654
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT027.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(39860400002)(346002)(136003)(396003)(376002)(2980300002)(189003)(199004)(86362001)(66066001)(50466002)(22756006)(97756001)(47776003)(478600001)(26826003)(8936002)(446003)(6862004)(386003)(6506007)(336012)(8676002)(26005)(2906002)(23726003)(76176011)(4326008)(6116002)(81156014)(3846002)(63370400001)(63350400001)(6246003)(81166006)(102836004)(126002)(476003)(25786009)(8746002)(486006)(186003)(305945005)(11346002)(7736002)(99286004)(1076003)(70206006)(33656002)(46406003)(14444005)(6512007)(9686003)(356004)(70586007)(54906003)(33716001)(6636002)(76130400001)(229853002)(6486002)(58126008)(14454004)(5660300002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB4955;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: a517b537-9f4e-4576-ee5c-08d71f133d5f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(710020)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB8PR08MB4955;
NoDisclaimer: True
X-Forefront-PRVS: 012792EC17
X-Microsoft-Antispam-Message-Info: lilA7TANVvap+gn17MshaDxInHYj+tsukruwe2JQGGolGMG4UuOvu/rSE6zk/ZMkNcjG1TwW2HW6ZVJ9BqU0t7dxm7muZXYxEGPVeQfih4ST87S7d0Ylt+vHQQgbszhm16nh03177HjTYb4KdctACkavLyxKDFLwKgyCKX076UGWpqjyne9nGEPgzVrbkYYKaXkGBDjUU3LgtaSYcgNvkC2kNpG1JTuosclss6IpWtEdf6jk89tpshwtHM5fJjlv0k8h/iViSm4ghWDOWH/rJAiEWkXf5uDTtCrPTP6DEvfs16fpZVGCHT+ZIVWWGAvhQ1sZK8ebH1ugDKARFlGk9n1sUhsMgXB26FTriZ5qaNAVm+j9W/AQBqcyYanOtEO5N4yD/gTbZt1LDmxnihonD7cf1kL41edDIEJ006dmHDs=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2019 10:53:09.6867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f13430-57a0-4d1f-b06b-08d71f1343bb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4955
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 06:31:56AM +0000, Lowry Li (Arm Technology China) w=
rote:
> From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
>=20
> The drm_format_info doesn't have any cpp or block_size (both are zero)
> information for arm only afbc format YU08/YU10. we need to compute it
> by ourselves.
>=20
> Changes since v1:
> 1. Removed redundant warning check in komeda_get_afbc_format_bpp();
> 2. Removed a redundant empty line;
> 3. Rebased the branch.
>=20
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> ---
>  .../gpu/drm/arm/display/komeda/komeda_format_caps.c   | 19 +++++++++++++=
++++++
>  .../gpu/drm/arm/display/komeda/komeda_format_caps.h   |  3 +++
>  .../gpu/drm/arm/display/komeda/komeda_framebuffer.c   |  5 +++--
>  3 files changed, 25 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.c b/dr=
ivers/gpu/drm/arm/display/komeda/komeda_format_caps.c
> index cd4d9f5..c9a1edb 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.c
> @@ -35,6 +35,25 @@
>  	return NULL;
>  }
> =20
> +u32 komeda_get_afbc_format_bpp(const struct drm_format_info *info, u64 m=
odifier)
> +{
> +	u32 bpp;
> +
> +	switch (info->format) {
> +	case DRM_FORMAT_YUV420_8BIT:
> +		bpp =3D 12;
> +		break;
> +	case DRM_FORMAT_YUV420_10BIT:
> +		bpp =3D 15;
> +		break;
> +	default:
> +		bpp =3D info->cpp[0] * 8;
> +		break;
> +	}
> +
> +	return bpp;
> +}
> +
>  /* Two assumptions
>   * 1. RGB always has YTR
>   * 2. Tiled RGB always has SC
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h b/dr=
ivers/gpu/drm/arm/display/komeda/komeda_format_caps.h
> index 3631910..32273cf 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h
> @@ -97,6 +97,9 @@ static inline const char *komeda_get_format_name(u32 fo=
urcc, u64 modifier)
>  komeda_get_format_caps(struct komeda_format_caps_table *table,
>  		       u32 fourcc, u64 modifier);
> =20
> +u32 komeda_get_afbc_format_bpp(const struct drm_format_info *info,
> +			       u64 modifier);
> +
>  u32 *komeda_get_layer_fourcc_list(struct komeda_format_caps_table *table=
,
>  				  u32 layer_type, u32 *n_fmts);
> =20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c b/dr=
ivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
> index 3b0a70e..1b01a62 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
> @@ -43,7 +43,7 @@ static int komeda_fb_create_handle(struct drm_framebuff=
er *fb,
>  	struct drm_framebuffer *fb =3D &kfb->base;
>  	const struct drm_format_info *info =3D fb->format;
>  	struct drm_gem_object *obj;
> -	u32 alignment_w =3D 0, alignment_h =3D 0, alignment_header, n_blocks;
> +	u32 alignment_w =3D 0, alignment_h =3D 0, alignment_header, n_blocks, b=
pp;
>  	u64 min_size;
> =20
>  	obj =3D drm_gem_object_lookup(file, mode_cmd->handles[0]);
> @@ -88,8 +88,9 @@ static int komeda_fb_create_handle(struct drm_framebuff=
er *fb,
>  	kfb->offset_payload =3D ALIGN(n_blocks * AFBC_HEADER_SIZE,
>  				    alignment_header);
> =20
> +	bpp =3D komeda_get_afbc_format_bpp(info, fb->modifier);
>  	kfb->afbc_size =3D kfb->offset_payload + n_blocks *
> -			 ALIGN(info->cpp[0] * AFBC_SUPERBLK_PIXELS,
> +			 ALIGN(bpp * AFBC_SUPERBLK_PIXELS / 8,
>  			       AFBC_SUPERBLK_ALIGNMENT);
>  	min_size =3D kfb->afbc_size + fb->offsets[0];
>  	if (min_size > obj->size) {

Looks good to me.

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>
