Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59558C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CB0120867
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="92Ep4tvu";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="92Ep4tvu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394016AbfIWMQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 08:16:37 -0400
Received: from mail-eopbgr00068.outbound.protection.outlook.com ([40.107.0.68]:34007
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2393851AbfIWMQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 08:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdzWMDQxDWCCtNruIzMeKRw/iceb0u5DifDW35t9ezw=;
 b=92Ep4tvuUf+DqQFNdY0DMWNpTfyWNy+DpCTNFwBzc5WdGkGREqKrhzHMVepqGH+rS4VByq4xAwdhsUzC5uBkcJHpZv08d3KV03bFX2z15H6vnT8LJfCMOCTRgWbVrCmKBB4NRdRYLgSUenxSk6H0Ql0jSYr8UAj1PrTgAr9LRQw=
Received: from VI1PR0802CA0014.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::24) by DB8PR08MB5132.eurprd08.prod.outlook.com
 (2603:10a6:10:ea::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.22; Mon, 23 Sep
 2019 12:16:25 +0000
Received: from DB5EUR03FT063.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::202) by VI1PR0802CA0014.outlook.office365.com
 (2603:10a6:800:aa::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.18 via Frontend
 Transport; Mon, 23 Sep 2019 12:16:25 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT063.mail.protection.outlook.com (10.152.20.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.25 via Frontend Transport; Mon, 23 Sep 2019 12:16:23 +0000
Received: ("Tessian outbound 55d20e99e8e2:v31"); Mon, 23 Sep 2019 12:16:19 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 5b77d8f8e85165da
X-CR-MTA-TID: 64aa7808
Received: from 95892a7ac6e1.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.10.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 3E59FD38-12EA-4A52-A011-B3EC83F069FB.1;
        Mon, 23 Sep 2019 12:16:13 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2056.outbound.protection.outlook.com [104.47.10.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 95892a7ac6e1.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 23 Sep 2019 12:16:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTRRklkW+LlhL5uNFjGhIzyMco4jMsXlWnORXQ5nqqGSt9h6WI+wUMlTt3+ZiRY6YA4BdIpmPa3q+TtFP6T8ZrXbLuoD7hrvqdMu2QlycCHUsCM6uCrtdpyXs6qgZ3+lLLIfOaFo4vHD1JnxqnvTIYb/5HZ10yhTPre3E5PPmhidn02A+BqlPHNdlsa3aNlIot3D5b2y6Gtx8LQbIZQwEIgRHEbzVEf5W2yoC6qsUoQ8ojtQbKuRcCvXGmrj9y8fPXouWc23tKXt0iNt0HOLsuhO+u34qgo+O1ngXzo6cYHGnnLg9sLEPueZSySw08bLWY7YyfXsThwHbGnO1Sck4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdzWMDQxDWCCtNruIzMeKRw/iceb0u5DifDW35t9ezw=;
 b=LF8h4YthKEoWioo48MOeLMWbthuWiBS+ojs5MyNjMRV2Mu2LEzY+Igy9ukYSJvosn3WR5V+NBzRv4S8eDWfln3asfgWvnIm9grONT4Jxlr8B1eKeN823d7eWBMMSHusT26el1Q8PfF/7n/c8keUiZYZRrM3VcsKtDn5943urNW6DNV4KV1LShcmQx9aPLUDPZWmfAH8lZ3A+9Q0FYmn8wzIwYdBSLO6xXlB4dFNdxRzQrL7OIBxAn9jRwL81+XzD4UlXlEw7bsz8Giw5v4FgANGQXvRSYS/oa8UoTiiA1jRsCV1LP9M3KVNZYBzNyOQrguDfsf5zL427WwU95Jd5gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdzWMDQxDWCCtNruIzMeKRw/iceb0u5DifDW35t9ezw=;
 b=92Ep4tvuUf+DqQFNdY0DMWNpTfyWNy+DpCTNFwBzc5WdGkGREqKrhzHMVepqGH+rS4VByq4xAwdhsUzC5uBkcJHpZv08d3KV03bFX2z15H6vnT8LJfCMOCTRgWbVrCmKBB4NRdRYLgSUenxSk6H0Ql0jSYr8UAj1PrTgAr9LRQw=
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com (20.178.89.14) by
 AM6PR08MB4552.eurprd08.prod.outlook.com (20.179.18.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.25; Mon, 23 Sep 2019 12:16:12 +0000
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::3d72:3e6c:cb97:8976]) by AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::3d72:3e6c:cb97:8976%7]) with mapi id 15.20.2284.023; Mon, 23 Sep 2019
 12:16:12 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH] drm/komeda: Adds output-color format/depth support
Thread-Topic: [PATCH] drm/komeda: Adds output-color format/depth support
Thread-Index: AQHVb5fml3iiEtk+MEOqXjNduhm+kKc5MiiA
Date:   Mon, 23 Sep 2019 12:16:12 +0000
Message-ID: <20190923121604.jqi6ewln27yvdajw@DESKTOP-E1NTVVP.localdomain>
References: <20190920094329.17513-1-lowry.li@arm.com>
In-Reply-To: <20190920094329.17513-1-lowry.li@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.96.140]
x-clientproxiedby: LO2P265CA0118.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::34) To AM6PR08MB3829.eurprd08.prod.outlook.com
 (2603:10a6:20b:85::14)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: a75ea5c0-0fc9-4a0d-c171-08d7401fd99f
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR08MB4552;
X-MS-TrafficTypeDiagnostic: AM6PR08MB4552:|AM6PR08MB4552:|DB8PR08MB5132:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB513241DDFC6FDBFC6D29A42FF0850@DB8PR08MB5132.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:7691;OLM:7691;
x-forefront-prvs: 0169092318
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(199004)(189003)(6116002)(186003)(44832011)(486006)(66066001)(316002)(30864003)(9686003)(6636002)(386003)(6506007)(76176011)(52116002)(5660300002)(8676002)(81156014)(478600001)(229853002)(99286004)(6512007)(58126008)(71190400001)(71200400001)(64756008)(66446008)(2906002)(6486002)(6436002)(54906003)(11346002)(1076003)(446003)(66946007)(66556008)(66476007)(305945005)(6862004)(81166006)(8936002)(476003)(7736002)(86362001)(4326008)(102836004)(14454004)(3846002)(256004)(14444005)(6246003)(26005)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB4552;H:AM6PR08MB3829.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: yOy//xk5mkM0jChON8u29q++P3DyxTC8HMG23xYgYUgFYu8PPVIt7/RbqT+uJXQLLUwWelE6+8/E8vBT9aJRs+ddue3bTGlbBNsRRvnHHE7wpxCtVIV/U8HyzJEgC2fgPpRNI5EnQT1+/rX6Cu4yucqVXcuDdQrWRQP5+DRi7uxbPe8vs1dE6AdjZyZ5ugSzeoSk7cim8H6rlnPYxEZTfUTVB+qfEiDfFgcMD7vyq+Fb0qNsAOiXB4Wg+OKO+Sk82C3Op8kfKQlAZyGbhPR11Z9xbJKri9U9QZZnNVqo5MI0AvXXM6SMmwBuMnUPun02QFeyclZ0dEQgS47wcST5pilLKzYdXYJKaZkVLzDBOtRwwpMpiBUKG5V0N8cQ3LuyeGwUKnJzc73pzwoLjxnxAWI+9mE8n++hNJ6VrC0RDUU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EC2E6E1764082246B388F2320A85179F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4552
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT063.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(189003)(199004)(76130400001)(25786009)(7736002)(8676002)(50466002)(386003)(6506007)(63350400001)(14444005)(11346002)(97756001)(102836004)(446003)(336012)(26005)(126002)(486006)(186003)(229853002)(4326008)(86362001)(6486002)(6862004)(5660300002)(2906002)(6246003)(9686003)(6116002)(30864003)(476003)(22756006)(3846002)(6512007)(46406003)(23726003)(76176011)(1076003)(99286004)(316002)(54906003)(58126008)(66066001)(6636002)(70586007)(47776003)(8746002)(8936002)(356004)(70206006)(305945005)(26826003)(81156014)(81166006)(14454004)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB5132;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: f0502f3a-1217-4a8e-bbae-08d7401fd2b0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB8PR08MB5132;
NoDisclaimer: True
X-Forefront-PRVS: 0169092318
X-Microsoft-Antispam-Message-Info: cjfmx4OvW7+cMjtVnct2Tq59Ful9+acjuIBhwdaJXmclp7mGtfZX2+mq/vsnATCo2i74GjXghzvQnW2ejOmYI3V7MrhZZN25A4cyOugUOtby3u2Xd4MKFqcPWFZHFpVZ01n8SpGYd7vZObaasGtfj2tgt0DnhCNjfU9WUO5DlXhK4EG7YWOw2fKxR7eYt2hlbASnTdpNW1GJReXpVfYB7Nayh00/RK4kbVqZJqXPFUWfgfPU72h5jpVaHwBXJsKGSJCYbzcgT+SzA+iVQbE690WDbpzuhi7k1dcF04fRR03WSKZU1k1wgKNxBflRzJh6v2dYTZ5o9Wj2dGKvFSndB7BZPNlU/Kjh9Qz7H+h8iAjgOBSs2n97oCDnAd2KAKMmFnSUZ4kNwLlvTbSdubEYqaKr7bSn6DOX2BSCPgrugmE=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2019 12:16:23.4863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a75ea5c0-0fc9-4a0d-c171-08d7401fd99f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lowry,

On Fri, Sep 20, 2019 at 09:43:47AM +0000, Lowry Li (Arm Technology China) w=
rote:
> From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
>=20
> Sets color_depth according to connector->bpc.
> Adds a new optional DT attribute "color-format" to represent a
> preferred color formats for a specific pipeline, and the select order
> is:
> 	YCRCB420 > YCRCB422 > YCRCB444 > RGB444
> The color-format can be anyone of these 4 format, one color-format not
> only represent one format, but also include the lower formats, like
>=20
> color-format         preferred_color_formats
> YCRCB420        YCRCB420 > YCRCB422 > YCRCB444 > RGB444
> YCRCB422        YCRCB422 > YCRCB444 > RGB444
> YCRCB444        YCRCB444 > RGB444
> RGB444          RGB444
>=20
> Then the final color_format is calculated by 3 steps:
> 1. calculate HW available formats.
>   avail_formats =3D connector_color_formats & improc->color_formats;
> 2. filter out un-preferred format.
>   avail_formats &=3D preferred_color_formats;
> 3. select the final format according to the preferred order.
>   color_format =3D BIT(__fls(aval_formats));

Is there a specific use-case for the DT property for selecting color
format?

I think in general the color format should be determined according to
the rules in the CEA spec. There's also the drm_mode_is_420_only()
helper we can use to determine if YCBCR420 must be used. For the cases
where it's optional, I think we can default to RGB444.

Thanks,
-Brian

>=20
> Changes since v1:
> Rebased to the drm-misc-next branch.
>=20
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> ---
>  .../arm/display/komeda/d71/d71_component.c    | 15 ++++++++-
>  .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 27 ++++++++++++++++
>  .../gpu/drm/arm/display/komeda/komeda_dev.c   | 32 ++++++++++++++++++-
>  .../gpu/drm/arm/display/komeda/komeda_kms.h   |  2 ++
>  .../drm/arm/display/komeda/komeda_pipeline.h  |  3 ++
>  .../display/komeda/komeda_pipeline_state.c    | 31 ++++++++++++++++++
>  .../arm/display/komeda/komeda_wb_connector.c  |  5 +++
>  7 files changed, 113 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/dri=
vers/gpu/drm/arm/display/komeda/d71/d71_component.c
> index c3d29c0b051b..7b374a3b911e 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> @@ -944,13 +944,26 @@ static void d71_improc_update(struct komeda_compone=
nt *c,
>  {
>  	struct komeda_improc_state *st =3D to_improc_st(state);
>  	u32 __iomem *reg =3D c->reg;
> -	u32 index;
> +	u32 index, mask =3D 0, ctrl =3D 0;
> =20
>  	for_each_changed_input(state, index)
>  		malidp_write32(reg, BLK_INPUT_ID0 + index * 4,
>  			       to_d71_input_id(state, index));
> =20
>  	malidp_write32(reg, BLK_SIZE, HV_SIZE(st->hsize, st->vsize));
> +	malidp_write32(reg, IPS_DEPTH, st->color_depth);
> +
> +	mask |=3D IPS_CTRL_YUV | IPS_CTRL_CHD422 | IPS_CTRL_CHD420;
> +
> +	/* config color format */
> +	if (st->color_format =3D=3D DRM_COLOR_FORMAT_YCRCB420)
> +		ctrl |=3D IPS_CTRL_YUV | IPS_CTRL_CHD422 | IPS_CTRL_CHD420;
> +	else if (st->color_format =3D=3D DRM_COLOR_FORMAT_YCRCB422)
> +		ctrl |=3D IPS_CTRL_YUV | IPS_CTRL_CHD422;
> +	else if (st->color_format =3D=3D DRM_COLOR_FORMAT_YCRCB444)
> +		ctrl |=3D IPS_CTRL_YUV;
> +
> +	malidp_write32_mask(reg, BLK_CONTROL, mask, ctrl);
>  }
> =20
>  static void d71_improc_dump(struct komeda_component *c, struct seq_file =
*sf)
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/g=
pu/drm/arm/display/komeda/komeda_crtc.c
> index 624d257da20f..38d5cb20e908 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> @@ -18,6 +18,33 @@
>  #include "komeda_dev.h"
>  #include "komeda_kms.h"
> =20
> +void komeda_crtc_get_color_config(struct drm_crtc_state *crtc_st,
> +				  u32 *color_depths, u32 *color_formats)
> +{
> +	struct drm_connector *conn;
> +	struct drm_connector_state *conn_st;
> +	u32 conn_color_formats =3D ~0u;
> +	int i, min_bpc =3D 31, conn_bpc =3D 0;
> +
> +	for_each_new_connector_in_state(crtc_st->state, conn, conn_st, i) {
> +		if (conn_st->crtc !=3D crtc_st->crtc)
> +			continue;
> +
> +		conn_bpc =3D conn->display_info.bpc ? conn->display_info.bpc : 8;
> +		conn_color_formats &=3D conn->display_info.color_formats;
> +
> +		if (conn_bpc < min_bpc)
> +			min_bpc =3D conn_bpc;
> +	}
> +
> +	/* connector doesn't config any color_format, use RGB444 as default */
> +	if (conn_color_formats =3D=3D 0)
> +		conn_color_formats =3D DRM_COLOR_FORMAT_RGB444;
> +
> +	*color_depths =3D GENMASK(conn_bpc, 0);
> +	*color_formats =3D conn_color_formats;
> +}
> +
>  static void komeda_crtc_update_clock_ratio(struct komeda_crtc_state *kcr=
tc_st)
>  {
>  	u64 pxlclk, aclk;
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_dev.c
> index 9cbcd56e54cd..bee4633cdd9f 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> @@ -113,12 +113,34 @@ static struct attribute_group komeda_sysfs_attr_gro=
up =3D {
>  	.attrs =3D komeda_sysfs_entries,
>  };
> =20
> +static int to_color_format(const char *str)
> +{
> +	int format;
> +
> +	if (!strncmp(str, "RGB444", 7)) {
> +		format =3D DRM_COLOR_FORMAT_RGB444;
> +	} else if (!strncmp(str, "YCRCB444", 9)) {
> +		format =3D DRM_COLOR_FORMAT_YCRCB444;
> +	} else if (!strncmp(str, "YCRCB422", 9)) {
> +		format =3D DRM_COLOR_FORMAT_YCRCB422;
> +	} else if (!strncmp(str, "YCRCB420", 9)) {
> +		format =3D DRM_COLOR_FORMAT_YCRCB420;
> +	} else {
> +		DRM_WARN("invalid color_format: %s, please set it to RGB444, YCRCB444,=
 YCRCB422 or YCRCB420\n",
> +			 str);
> +		format =3D DRM_COLOR_FORMAT_RGB444;
> +	}
> +
> +	return format;
> +}
> +
>  static int komeda_parse_pipe_dt(struct komeda_dev *mdev, struct device_n=
ode *np)
>  {
>  	struct komeda_pipeline *pipe;
>  	struct clk *clk;
>  	u32 pipe_id;
> -	int ret =3D 0;
> +	int ret =3D 0, color_format;
> +	const char *str;
> =20
>  	ret =3D of_property_read_u32(np, "reg", &pipe_id);
>  	if (ret !=3D 0 || pipe_id >=3D mdev->n_pipelines)
> @@ -133,6 +155,14 @@ static int komeda_parse_pipe_dt(struct komeda_dev *m=
dev, struct device_node *np)
>  	}
>  	pipe->pxlclk =3D clk;
> =20
> +	/* fetch DT configured color-format, if not set, use RGB444 */
> +	if (!of_property_read_string(np, "color-format", &str))
> +		color_format =3D to_color_format(str);
> +	else
> +		color_format =3D DRM_COLOR_FORMAT_RGB444;
> +
> +	pipe->improc->preferred_color_formats =3D (color_format << 1) - 1;
> +
>  	/* enum ports */
>  	pipe->of_output_links[0] =3D
>  		of_graph_get_remote_node(np, KOMEDA_OF_PORT_OUTPUT, 0);
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gp=
u/drm/arm/display/komeda/komeda_kms.h
> index 45c498e15e7a..456f3c435719 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> @@ -166,6 +166,8 @@ static inline bool has_flip_h(u32 rot)
>  		return !!(rotation & DRM_MODE_REFLECT_X);
>  }
> =20
> +void komeda_crtc_get_color_config(struct drm_crtc_state *crtc_st,
> +				  u32 *color_depths, u32 *color_formats);
>  unsigned long komeda_crtc_get_aclk(struct komeda_crtc_state *kcrtc_st);
> =20
>  int komeda_kms_setup_crtcs(struct komeda_kms_dev *kms, struct komeda_dev=
 *mdev);
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drive=
rs/gpu/drm/arm/display/komeda/komeda_pipeline.h
> index a7a84e66549d..910d279ae48d 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> @@ -315,6 +315,8 @@ struct komeda_splitter_state {
>  struct komeda_improc {
>  	struct komeda_component base;
>  	u32 supported_color_formats;  /* DRM_RGB/YUV444/YUV420*/
> +	/* the preferred order is from MSB to LSB YUV420 --> RGB444 */
> +	u32 preferred_color_formats;
>  	u32 supported_color_depths; /* BIT(8) | BIT(10)*/
>  	u8 supports_degamma : 1;
>  	u8 supports_csc : 1;
> @@ -323,6 +325,7 @@ struct komeda_improc {
> =20
>  struct komeda_improc_state {
>  	struct komeda_component_state base;
> +	u8 color_format, color_depth;
>  	u16 hsize, vsize;
>  };
> =20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b=
/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> index ea26bc9c2d00..5526731f5a33 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> @@ -743,6 +743,7 @@ komeda_improc_validate(struct komeda_improc *improc,
>  		       struct komeda_data_flow_cfg *dflow)
>  {
>  	struct drm_crtc *crtc =3D kcrtc_st->base.crtc;
> +	struct drm_crtc_state *crtc_st =3D &kcrtc_st->base;
>  	struct komeda_component_state *c_st;
>  	struct komeda_improc_state *st;
> =20
> @@ -756,6 +757,36 @@ komeda_improc_validate(struct komeda_improc *improc,
>  	st->hsize =3D dflow->in_w;
>  	st->vsize =3D dflow->in_h;
> =20
> +	if (drm_atomic_crtc_needs_modeset(crtc_st)) {
> +		u32 output_depths, output_formats;
> +		u32 avail_depths, avail_formats;
> +
> +		komeda_crtc_get_color_config(crtc_st, &output_depths,
> +					     &output_formats);
> +
> +		avail_depths =3D output_depths & improc->supported_color_depths;
> +		if (avail_depths =3D=3D 0) {
> +			DRM_DEBUG_ATOMIC("No available color depths, conn depths: 0x%x & disp=
lay: 0x%x\n",
> +					 output_depths,
> +					 improc->supported_color_depths);
> +			return -EINVAL;
> +		}
> +
> +		avail_formats =3D output_formats &
> +				improc->supported_color_formats &
> +				improc->preferred_color_formats;
> +		if (avail_formats =3D=3D 0) {
> +			DRM_DEBUG_ATOMIC("No available color_formats, conn formats 0x%x & dis=
play: 0x%x & preferred: 0x%x\n",
> +					 output_formats,
> +					 improc->supported_color_formats,
> +					 improc->preferred_color_formats);
> +			return -EINVAL;
> +		}
> +
> +		st->color_depth =3D __fls(avail_depths);
> +		st->color_format =3D BIT(__fls(avail_formats));
> +	}
> +
>  	komeda_component_add_input(&st->base, &dflow->input, 0);
>  	komeda_component_set_output(&dflow->input, &improc->base, 0);
> =20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> index 617e1f7b8472..49e5469ba48e 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> @@ -142,6 +142,7 @@ static int komeda_wb_connector_add(struct komeda_kms_=
dev *kms,
>  	struct komeda_dev *mdev =3D kms->base.dev_private;
>  	struct komeda_wb_connector *kwb_conn;
>  	struct drm_writeback_connector *wb_conn;
> +	struct drm_display_info *info;
>  	u32 *formats, n_formats =3D 0;
>  	int err;
> =20
> @@ -171,6 +172,10 @@ static int komeda_wb_connector_add(struct komeda_kms=
_dev *kms,
> =20
>  	drm_connector_helper_add(&wb_conn->base, &komeda_wb_conn_helper_funcs);
> =20
> +	info =3D &kwb_conn->base.base.display_info;
> +	info->bpc =3D __fls(kcrtc->master->improc->supported_color_depths);
> +	info->color_formats =3D kcrtc->master->improc->supported_color_formats;
> +
>  	kcrtc->wb_conn =3D kwb_conn;
> =20
>  	return 0;
> --=20
> 2.17.1
>=20
