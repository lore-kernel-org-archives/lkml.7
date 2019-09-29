Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B89C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 05:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCEE62082F
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 05:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="2uCNeb0y";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="2uCNeb0y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfI2FXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 01:23:32 -0400
Received: from mail-eopbgr60061.outbound.protection.outlook.com ([40.107.6.61]:23422
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725958AbfI2FXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 01:23:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9P+wAd+Z1hHNNb9A9N6OTC+duUrGTYpjIxR+D145nnE=;
 b=2uCNeb0yTLgZjjhHfCflhfgnDaP+DDmJJYPP7PptP+hlWZxaQ8uGxQrZN9hGFGmfaNQFeLnCQtYd7To8j5UYnGe6WwLXHFYx6rqiPq2wo5Lorq/SySCD9wADRWB21/YkKNVuB54neoHMZAh8q5VbrdJwe/1Ztontu2Fh9HXDRgU=
Received: from VI1PR08CA0274.eurprd08.prod.outlook.com (2603:10a6:803:dc::47)
 by AM6PR08MB4022.eurprd08.prod.outlook.com (2603:10a6:20b:b0::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.20; Sun, 29 Sep
 2019 05:23:26 +0000
Received: from DB5EUR03FT048.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::208) by VI1PR08CA0274.outlook.office365.com
 (2603:10a6:803:dc::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.20 via Frontend
 Transport; Sun, 29 Sep 2019 05:23:26 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT048.mail.protection.outlook.com (10.152.21.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Sun, 29 Sep 2019 05:23:24 +0000
Received: ("Tessian outbound 0939a6bab6b1:v33"); Sun, 29 Sep 2019 05:23:21 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 6ed8157f2402cf5c
X-CR-MTA-TID: 64aa7808
Received: from 8e86b7e8f3cf.1 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.6.52])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id B49AD9E9-9769-404B-A0D3-BC3FDE6EB248.1;
        Sun, 29 Sep 2019 05:23:16 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-ve1eur02lp2052.outbound.protection.outlook.com [104.47.6.52])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 8e86b7e8f3cf.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Sun, 29 Sep 2019 05:23:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9aA+zM3U04TKZQCxqMdgBw4pZ519Z3yOnH8flUw0iS2T1UWut7JANdO8b5dyd3zJR6KAXs3v4KzRTu201Aiig/NMxRig5svt7Q7OqhthPzmAOurq8eICzGhzAXBm/TGSCZHjKSSrvlR0EKt72Mi2NXMr/fJt7YOQTHFsHXB0+tw9jClO8sug7teAgenjzlUQK7gdBrxBAg1PpZ4SbOsmvrptkTyJYe9WMOU3DD1vufqYYh2LOAryNFRuZ38tJ0D1FTVj5mHoCcXcweBCIbcr+B9Cb30sqzpM/LTGvaAy98LKzwMmhBjZgLR7ACVlZieUogVubnI1GWCIeolKVn55Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9P+wAd+Z1hHNNb9A9N6OTC+duUrGTYpjIxR+D145nnE=;
 b=cZ3drsQj+AfbJokAlAYgjqN1nFrKT8Ngi8hE4pg3xIRYA5SdEzr2LQKthVKNOlGE1ug6zRcGiNosKaVOPRC/GF22thZmMn5MAZFVdIS9XAoiLbJbKe41gbRlGH5mJ8odmc9oaz0keZ3rR2QZTz4payDLE5qPH7Dnm0PnxW4liGh3nJAFmgts+2uotwwKZG63r3iMKV3AE2cVIFHnVqlaubVwQbyv/co90MFopk9KTergm4HV89fFlnOP9kDOv4dfTfp7E3NmzJ/bTHrc+64zMNUliChxSsx7FJpVYjZBYxupcIFGemm163cXxWBq5P2JcY/7mM0ZvydrbPMRi+1ktg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9P+wAd+Z1hHNNb9A9N6OTC+duUrGTYpjIxR+D145nnE=;
 b=2uCNeb0yTLgZjjhHfCflhfgnDaP+DDmJJYPP7PptP+hlWZxaQ8uGxQrZN9hGFGmfaNQFeLnCQtYd7To8j5UYnGe6WwLXHFYx6rqiPq2wo5Lorq/SySCD9wADRWB21/YkKNVuB54neoHMZAh8q5VbrdJwe/1Ztontu2Fh9HXDRgU=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4830.eurprd08.prod.outlook.com (10.255.113.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Sun, 29 Sep 2019 05:23:14 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a0a6:ad4c:b7a7:f879]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a0a6:ad4c:b7a7:f879%5]) with mapi id 15.20.2284.028; Sun, 29 Sep 2019
 05:23:14 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Derek Basehore <dbasehore@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>, Sean Paul <sean@poorly.run>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, nd <nd@arm.com>
Subject: Re: [v8,2/4] drm/panel: set display info in panel attach
Thread-Topic: [v8,2/4] drm/panel: set display info in panel attach
Thread-Index: AQHVdoX9hlvb+H46dE2AJOeuAIY3EA==
Date:   Sun, 29 Sep 2019 05:23:14 +0000
Message-ID: <20190929052307.GA28304@jamwan02-TSP300>
References: <20190925225833.7310-3-dbasehore@chromium.org>
In-Reply-To: <20190925225833.7310-3-dbasehore@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0P153CA0035.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::23) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 21b7e767-7b2d-47e1-c5e8-08d7449d26a8
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB4830:|AM6PR08MB4022:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4022833A3F31E66AC0754AD1B3830@AM6PR08MB4022.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 017589626D
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(366004)(39850400004)(376002)(396003)(136003)(346002)(189003)(199004)(5660300002)(6486002)(25786009)(256004)(58126008)(54906003)(6246003)(99286004)(86362001)(4326008)(229853002)(33656002)(6512007)(9686003)(5024004)(66066001)(81166006)(7416002)(316002)(8676002)(6916009)(6436002)(8936002)(52116002)(81156014)(64756008)(66446008)(66476007)(11346002)(2906002)(26005)(446003)(3846002)(186003)(76176011)(66556008)(102836004)(55236004)(386003)(6506007)(1076003)(71200400001)(6116002)(66946007)(71190400001)(476003)(486006)(305945005)(14454004)(33716001)(7736002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4830;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: V+gWh0SOiCJZx9vpM8JB+q2TrlXBzjfX+GqN7IDKsMDhSpDcSwRIEIsps3vubKYAngvTMALFRI8R0CG/qxZDfK4O1SVdauHoD+53E1q/cvlNNE2Ed0jR5zYJns2mxJojTPd25ou6wAyDLmgR+Tay3suM44LmfB7HLwhvFnSoXEbVyDM4cvZHksuVJ0jDJSvI720OdJNcmfv5JIUPBbk1/NpsWHdoRY7zDINCpFHddJNQGFs2fQvRrIUy8gHb0L7k1MG17/UPSpY8CW8lIOR+S6oTZYYwHDZCc2Qx7DDyfX5dS473J/FeMI0YOSX5xHNSpZbmw5YmY4joPWNnTG6lFTrFHB4VxRV8WwmF4ygNATvRQv8VkFUsd1RF2ARsjZ6il4vM+JIQ0RLyxPyHpKLBm+EW7iElnHdJVvcoVhFekkg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <672C734F3D2D1142A821032C5E0FBE8C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4830
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT048.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(376002)(136003)(346002)(39850400004)(396003)(189003)(199004)(70586007)(6512007)(6486002)(2906002)(7736002)(305945005)(97756001)(316002)(229853002)(46406003)(76130400001)(70206006)(9686003)(99286004)(58126008)(86362001)(54906003)(14454004)(8936002)(478600001)(26826003)(4326008)(33716001)(8746002)(5024004)(6862004)(1076003)(8676002)(50466002)(81166006)(33656002)(476003)(6116002)(336012)(81156014)(356004)(386003)(6506007)(76176011)(25786009)(23726003)(102836004)(26005)(186003)(5660300002)(22756006)(47776003)(66066001)(63350400001)(126002)(3846002)(446003)(6246003)(11346002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB4022;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 89114cdd-ee15-4b23-7be2-08d7449d2048
NoDisclaimer: True
X-Forefront-PRVS: 017589626D
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +kSQnKAiFSkqswlBw+zlr8H44hK1hSPWFPygx9hLyUQKocGbj5SPYakZK80r73nW4fImSnbH/pATkbUC54XvmxmOaruergT4Wr+gfU7RrNbAKlXLg11kYD3sQVmq05AEjGG5PW0m+xeD4JRkon2o7/fAIUh88G9vnwsPUatFlElFN9XSQ4elutK3KpNhI6+3JyENFKhj7+SvS0k6qZ/p2V8zjO4GYzn0kp3/iS6qkF/5vPnRczk3XvSS5kOPojk51I9qSOGychIdq1UnT3pUxK7VMokLdAzc35o9FS1snBGBwiwswhzo6081ubrytENWibpnLCZIIfcBGpD7ITHCvntuQpbdtizc7tjk9ji5JsLR4hBRitfsaXWzfCi1/l2ni9dLdAo0sAdUdxI/ZU5eAZxZNtVfgwLrIv3rwC/9UKs=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2019 05:23:24.4863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b7e767-7b2d-47e1-c5e8-08d7449d26a8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 03:58:31PM -0700, Derek Basehore wrote:
> Devicetree systems can set panel orientation via a panel binding, but
> there's no way, as is, to propagate this setting to the connector,
> where the property need to be added.
> To address this, this patch sets orientation, as well as other fixed
> values for the panel, in the drm_panel_attach function. These values
> are stored from probe in the drm_panel struct.
>=20
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  drivers/gpu/drm/drm_panel.c | 28 +++++++++++++++++++++
>  include/drm/drm_panel.h     | 50 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 78 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index 0909b53b74e6..1cd2b56c9fe6 100644
> --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c
> @@ -104,11 +104,23 @@ EXPORT_SYMBOL(drm_panel_remove);
>   */
>  int drm_panel_attach(struct drm_panel *panel, struct drm_connector *conn=
ector)
>  {
> +	struct drm_display_info *info;
> +
>  	if (panel->connector)
>  		return -EBUSY;
> =20
>  	panel->connector =3D connector;
>  	panel->drm =3D connector->dev;
> +	info =3D &connector->display_info;
> +	info->width_mm =3D panel->width_mm;
> +	info->height_mm =3D panel->height_mm;
> +	info->bpc =3D panel->bpc;
> +	info->panel_orientation =3D panel->orientation;
> +	info->bus_flags =3D panel->bus_flags;
> +	if (panel->bus_formats)
> +		drm_display_info_set_bus_formats(&connector->display_info,
> +						 panel->bus_formats,
> +						 panel->num_bus_formats);
> =20
>  	return 0;
>  }
> @@ -126,6 +138,22 @@ EXPORT_SYMBOL(drm_panel_attach);
>   */
>  void drm_panel_detach(struct drm_panel *panel)
>  {
> +	struct drm_display_info *info;
> +
> +	if (!panel->connector)
> +		goto out;
> +
> +	info =3D &panel->connector->display_info;
> +	info->width_mm =3D 0;
> +	info->height_mm =3D 0;
> +	info->bpc =3D 0;
> +	info->panel_orientation =3D DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
> +	info->bus_flags =3D 0;
> +	kfree(info->bus_formats);
> +	info->bus_formats =3D NULL;
> +	info->num_bus_formats =3D 0;
> +
> +out:
>  	panel->connector =3D NULL;
>  	panel->drm =3D NULL;
>  }
> diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
> index d16158deacdc..f3587a54b8ac 100644
> --- a/include/drm/drm_panel.h
> +++ b/include/drm/drm_panel.h
> @@ -141,6 +141,56 @@ struct drm_panel {
>  	 */
>  	const struct drm_panel_funcs *funcs;
>

All these new added members seems dupliated with drm_display_info,
So I think, can we add a new drm_plane_funcs func:

int (*set_display_info)(struct drm_panel *panel,
                        struct drm_display_info *info);

Then in drm_panel_attach(), via this interface the specific panel
driver can directly set connector->display_info. like

   ...
   if (panel->funcs && panel->funcs->set_display_info)
		panel->funcs->unprepare(panel, connector->display_info);
   ...

Thanks
James

> +	/**
> +	 * @width_mm:
> +	 *
> +	 * Physical width in mm.
> +	 */
> +	unsigned int width_mm;
> +
> +	/**
> +	 * @height_mm:
> +	 *
> +	 * Physical height in mm.
> +	 */
> +	unsigned int height_mm;
> +
> +	/**
> +	 * @bpc:
> +	 *
> +	 * Maximum bits per color channel. Used by HDMI and DP outputs.
> +	 */
> +	unsigned int bpc;
> +
> +	/**
> +	 * @orientation
> +	 *
> +	 * Installation orientation of the panel with respect to the chassis.
> +	 */
> +	int orientation;
> +
> +	/**
> +	 * @bus_formats
> +	 *
> +	 * Pixel data format on the wire.
> +	 */
> +	const u32 *bus_formats;
> +
> +	/**
> +	 * @num_bus_formats:
> +	 *
> +	 * Number of elements pointed to by @bus_formats
> +	 */
> +	unsigned int num_bus_formats;
> +
> +	/**
> +	 * @bus_flags:
> +	 *
> +	 * Additional information (like pixel signal polarity) for the pixel
> +	 * data on the bus.
> +	 */
> +	u32 bus_flags;
> +
>  	/**
>  	 * @list:
>  	 *
