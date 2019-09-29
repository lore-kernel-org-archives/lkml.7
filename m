Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6869CC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 04:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B7DB2082F
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 04:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="RaZoKntl";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="RaZoKntl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfI2EoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 00:44:01 -0400
Received: from mail-eopbgr130043.outbound.protection.outlook.com ([40.107.13.43]:45159
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725924AbfI2EoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 00:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XbRbHPLmiw38gpZsvPVr2bGfAh0oLA55yde65rHJws=;
 b=RaZoKntl0WnIJi1nTRPefCPLko0hlykQ21r2BfGMmsXZ9SAH6GoOuuRmRd7WLFu4mMwDWtYZHhx2l283mjFfGcNukB2TNQP/+NHsv5R39EZZ0VXjqt+eysZ4yfzG+nYCNA7yz5uBBQ04btHcjr2uBOdjpLaw9cwUDnLNvA3PkN4=
Received: from DB6PR0802CA0032.eurprd08.prod.outlook.com (2603:10a6:4:a3::18)
 by DB7PR08MB3242.eurprd08.prod.outlook.com (2603:10a6:5:1a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.20; Sun, 29 Sep
 2019 04:43:52 +0000
Received: from AM5EUR03FT015.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::205) by DB6PR0802CA0032.outlook.office365.com
 (2603:10a6:4:a3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.17 via Frontend
 Transport; Sun, 29 Sep 2019 04:43:52 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT015.mail.protection.outlook.com (10.152.16.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Sun, 29 Sep 2019 04:43:50 +0000
Received: ("Tessian outbound 927f2cdd66cc:v33"); Sun, 29 Sep 2019 04:43:48 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 1e1bbf0cce65ad95
X-CR-MTA-TID: 64aa7808
Received: from acdc22bc298c.1 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.0.50])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id EA6931B6-21F8-44EC-971D-876A7561CC6A.1;
        Sun, 29 Sep 2019 04:43:43 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01lp2050.outbound.protection.outlook.com [104.47.0.50])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id acdc22bc298c.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Sun, 29 Sep 2019 04:43:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aa8YNIBJTc6ZZ7UJqDbXZHPpO61/mIM4UwXDxLVKnufJaMN8BKJQ1wjzGDs8K6nRiTNangdUMJ6iz0iwT2fKyPSpaCVZkd5Xb0pSAs+4v57UrNAiyhI3LFKqcfMqWSTMY3XH15uIxuvRBzEcCt2byZSl3mEOvcVGIQOeirqIChprwzKS7Mw+XfPunkEyhP45cFZ9jaW8HaB011RoehRT8XEymqn/bdzGXRHx8wbULWZ55xpF+ZpscdVdDiTeFSBGIIQTMkob5HkpjfDyFMy18ILl4IZp6RXZ8XWX5Yer83j1/dvfgI5AQNTwxefvmjlPwj4y7cDB4FMHxq0e/bevHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XbRbHPLmiw38gpZsvPVr2bGfAh0oLA55yde65rHJws=;
 b=MZD8yJfMRDgjmFdS5scNzLrmXl8hJV821BujUYqsdPvBahWElmeRXvi36OErRYxgJU9qEBKRIKLTCjSSE0L5dHP8LPB9+9T39H03+OSHjo0G8wxGxHWhN+RJSqEqBJK9Aaxvue+c1rudk1khVCFRXrNTz+8NSgQPtR/AunYEqnKsoKE1SVQmVtGKDYAVAAtQRC3fgohhJn0+vKg4fpErKD94WNiNnFYz8qy1LMQyQAFjMUla+Trd6BZSAHSLc74MkhwLxNO6IfnHBMurcb78MBZ90AODdTIG2G7OsNVUvG/L+S7/1ORmbRKQZ4IDZllSBXs3514n88rK83Jb/QO2rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XbRbHPLmiw38gpZsvPVr2bGfAh0oLA55yde65rHJws=;
 b=RaZoKntl0WnIJi1nTRPefCPLko0hlykQ21r2BfGMmsXZ9SAH6GoOuuRmRd7WLFu4mMwDWtYZHhx2l283mjFfGcNukB2TNQP/+NHsv5R39EZZ0VXjqt+eysZ4yfzG+nYCNA7yz5uBBQ04btHcjr2uBOdjpLaw9cwUDnLNvA3PkN4=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4991.eurprd08.prod.outlook.com (10.255.158.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.18; Sun, 29 Sep 2019 04:43:41 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a0a6:ad4c:b7a7:f879]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a0a6:ad4c:b7a7:f879%5]) with mapi id 15.20.2284.028; Sun, 29 Sep 2019
 04:43:41 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Jeykumar Sankaran <jsanka@codeaurora.org>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        nd <nd@arm.com>
Subject: Re: drm: add fb max width/height fields to drm_mode_config
Thread-Topic: drm: add fb max width/height fields to drm_mode_config
Thread-Index: AQHVdoB3D2QDVHLEG0iqFyeHKtBpcQ==
Date:   Sun, 29 Sep 2019 04:43:40 +0000
Message-ID: <20190929044334.GA27802@jamwan02-TSP300>
References: <1569634284-14147-2-git-send-email-jsanka@codeaurora.org>
In-Reply-To: <1569634284-14147-2-git-send-email-jsanka@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR02CA0196.apcprd02.prod.outlook.com
 (2603:1096:201:21::32) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 03273bfd-4885-4cab-0800-08d744979fa6
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VE1PR08MB4991;
X-MS-TrafficTypeDiagnostic: VE1PR08MB4991:|DB7PR08MB3242:
X-Microsoft-Antispam-PRVS: <DB7PR08MB324258875E15B274AF55D891B3830@DB7PR08MB3242.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 017589626D
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(366004)(376002)(136003)(346002)(39850400004)(396003)(189003)(199004)(71200400001)(25786009)(6116002)(26005)(486006)(3846002)(55236004)(11346002)(6246003)(6506007)(386003)(102836004)(478600001)(86362001)(1076003)(71190400001)(5660300002)(14454004)(66066001)(229853002)(6486002)(33716001)(316002)(58126008)(8936002)(66556008)(64756008)(66476007)(66446008)(66946007)(6436002)(54906003)(6512007)(81156014)(81166006)(256004)(9686003)(99286004)(6916009)(186003)(446003)(7736002)(305945005)(4326008)(52116002)(2906002)(76176011)(476003)(33656002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4991;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: n2QY17ko/OZmGQ1AAoWcjTkQekxNKYoPkaIiP3dWmrX6Od27Pja/ld24HRk915oUQqEoVfGs3kv6ZvcccTHnqyDanplN9hVesd1ZwBGhTz5cOQ9FV4G0OdgwBacNXAsH16C80usIsUnWKFDLxuTfc629qkfEyGHrl+Rcz1sKV89JapMiWamf4B5OLtUfRmyMUx9HGoiJYlyUFecjefbaRYGgdTgIRtCC/7AJ7uxd+mh/12wjiwGHlQAG7AVsCwsgvY+iy4ZQ6/fKCvYzZkuOR4Fxouu4EnecYX7ZAAa9PIxKt/fODsa8XbRciYB3cCkR7WW3eYjsrhdYMQ4qYNrF9kVLEn3kQjp8kqKdmtc7/dMMl/PYKFJRnbWkLD+LoQCbmj75cuZYFOvzpBNHaun+OmsfBiVgeSWkaEE0zfcuVd8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FC3EC09C5348AD45897DD94AAC06416F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4991
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT015.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(136003)(396003)(39850400004)(346002)(376002)(199004)(189003)(2906002)(54906003)(86362001)(76176011)(76130400001)(386003)(6506007)(97756001)(70586007)(70206006)(33656002)(81166006)(66066001)(81156014)(1076003)(22756006)(58126008)(336012)(36906005)(47776003)(99286004)(3846002)(6116002)(356004)(6486002)(446003)(33716001)(23726003)(316002)(11346002)(229853002)(26005)(8676002)(63350400001)(8936002)(8746002)(26826003)(102836004)(126002)(14454004)(476003)(6246003)(25786009)(6862004)(186003)(46406003)(4326008)(50466002)(305945005)(5660300002)(7736002)(9686003)(6512007)(486006)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3242;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4f531287-7c9d-4c08-4519-08d7449799c5
NoDisclaimer: True
X-Forefront-PRVS: 017589626D
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SlnlO4evRbB8NEinqOSPrwN4shw9U/gGDZVgnJFo999Fc5zE0Z6orkFlkrzTWNV0QfrFvxHdpnsb/I24eCCa17env6U0j8dl3bFJ9HTS5vrv2K2Gxr3t6BQvYPRBoq95L2Tr8bVaDAALtw+XAZinY9NTsWXpx5xjRPAxbElSoPC5i64Uf2VlTcx7XbPLMmf2hMW77S8BDRSj/dNkz4IlnGVj1bevoDCI3s4ahXr+4jw7EK8uTkd41w2M8S1DDO5wqJ74PN+ZispNS/5JDh04RSzvBNYSfaauucqb2umfPXlKjZ5wm7WlkzSVG8erKcGuAqmb3wxLk8GhGESLBRjdAiI/dCjG/SJ095f15uI6z63seoSv4DbThx/7emN5bZcn7ZAvIWCwXYG9/FUN7y1kgLXNHz/UqwYOTbvM1zzfDz8=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2019 04:43:50.4862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03273bfd-4885-4cab-0800-08d744979fa6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3242
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 06:31:24PM -0700, Jeykumar Sankaran wrote:
> The mode_config max width/height values determine the maximum
> resolution the pixel reader can handle. But the same values are
> used to restrict the size of the framebuffer creation. Hardware's
> with scaling blocks can operate on framebuffers larger/smaller than
> that of the pixel reader resolutions by scaling them down/up before
> rendering.
>=20
> This changes adds a separate framebuffer max width/height fields
> in drm_mode_config to allow vendors to set if they are different
> than that of the default max resolution values.
>=20
> Vendors setting these fields should fix their mode_set paths too
> by filtering and validating the modes against the appropriate max
> fields in their mode_valid() implementations.
>=20
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Jeykumar Sankaran <jsanka@codeaurora.org>

Hi Jeykumar:

Komeda driver also meets this problem, thank for the fix.

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>

Thanks
James

> ---
>  drivers/gpu/drm/drm_framebuffer.c | 15 +++++++++++----
>  include/drm/drm_mode_config.h     |  3 +++
>  2 files changed, 14 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_fram=
ebuffer.c
> index 5756431..2083168 100644
> --- a/drivers/gpu/drm/drm_framebuffer.c
> +++ b/drivers/gpu/drm/drm_framebuffer.c
> @@ -300,14 +300,21 @@ struct drm_framebuffer *
>  		return ERR_PTR(-EINVAL);
>  	}
> =20
> -	if ((config->min_width > r->width) || (r->width > config->max_width)) {
> +	if ((config->min_width > r->width) ||
> +	    (!config->max_fb_width && r->width > config->max_width) ||
> +	    (config->max_fb_width && r->width > config->max_fb_width)) {
>  		DRM_DEBUG_KMS("bad framebuffer width %d, should be >=3D %d && <=3D %d\=
n",
> -			  r->width, config->min_width, config->max_width);
> +			r->width, config->min_width, config->max_fb_width ?
> +			config->max_fb_width : config->max_width);
>  		return ERR_PTR(-EINVAL);
>  	}
> -	if ((config->min_height > r->height) || (r->height > config->max_height=
)) {
> +
> +	if ((config->min_height > r->height) ||
> +	    (!config->max_fb_height && r->height > config->max_height) ||
> +	    (config->max_fb_height && r->height > config->max_fb_height)) {
>  		DRM_DEBUG_KMS("bad framebuffer height %d, should be >=3D %d && <=3D %d=
\n",
> -			  r->height, config->min_height, config->max_height);
> +			r->height, config->min_height, config->max_fb_width ?
> +			config->max_fb_height : config->max_height);
>  		return ERR_PTR(-EINVAL);
>  	}
> =20
> diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.=
h
> index 3bcbe30..c6394ed 100644
> --- a/include/drm/drm_mode_config.h
> +++ b/include/drm/drm_mode_config.h
> @@ -339,6 +339,8 @@ struct drm_mode_config_funcs {
>   * @min_height: minimum fb pixel height on this device
>   * @max_width: maximum fb pixel width on this device
>   * @max_height: maximum fb pixel height on this device
> + * @max_fb_width: maximum fb buffer width if differs from max_width
> + * @max_fb_height: maximum fb buffer height if differs from  max_height
>   * @funcs: core driver provided mode setting functions
>   * @fb_base: base address of the framebuffer
>   * @poll_enabled: track polling support for this device
> @@ -523,6 +525,7 @@ struct drm_mode_config {
> =20
>  	int min_width, min_height;
>  	int max_width, max_height;
> +	int max_fb_width, max_fb_height;
>  	const struct drm_mode_config_funcs *funcs;
>  	resource_size_t fb_base;
> =20
