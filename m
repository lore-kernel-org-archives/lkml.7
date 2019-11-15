Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB18C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 00:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C7420727
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 00:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="l6/juJJJ";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="l6/juJJJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfKOAAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 19:00:22 -0500
Received: from mail-eopbgr00050.outbound.protection.outlook.com ([40.107.0.50]:37095
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726767AbfKOAAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 19:00:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FhtczBPmxxyVFjd6a8jru8FvGOSfJ00gPRNlpS7v00=;
 b=l6/juJJJ83U8gpVx2z+v8F+LfP3Dwv/2ZvwqIvhzRjkwyd4wlSwoLtWaNT1oFAF9PU3Y6XgYt6avEEuH13I6JT8+mVUbgKxi12VznyyxV4hRHkYDMoVOxhNB/wVHcnHAyuEZc/19+kVOCB9Wa1Omn7XBz2kC8S3gmZsYFc4osMg=
Received: from AM6PR08CA0029.eurprd08.prod.outlook.com (2603:10a6:20b:c0::17)
 by VI1PR0802MB2303.eurprd08.prod.outlook.com (2603:10a6:800:a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23; Fri, 15 Nov
 2019 00:00:13 +0000
Received: from DB5EUR03FT059.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::204) by AM6PR08CA0029.outlook.office365.com
 (2603:10a6:20b:c0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23 via Frontend
 Transport; Fri, 15 Nov 2019 00:00:13 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT059.mail.protection.outlook.com (10.152.21.175) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23 via Frontend Transport; Fri, 15 Nov 2019 00:00:13 +0000
Received: ("Tessian outbound 6481c7fa5a3c:v33"); Fri, 15 Nov 2019 00:00:12 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e041e27901d53d18
X-CR-MTA-TID: 64aa7808
Received: from f6613a06988e.2 (cr-mta-lb-1.cr-mta-net [104.47.9.52])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 28CD94E3-8C68-419D-A77B-EEA5B5944FD2.1;
        Fri, 15 Nov 2019 00:00:07 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2052.outbound.protection.outlook.com [104.47.9.52])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f6613a06988e.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 15 Nov 2019 00:00:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XS3ynlO76IJNt76qYfwD5mfEdiOEaa2HsG8Ys7n3U6ZC8mLTQLajHZIa/ooKwUG3H91VH50cBAL9rYVVLffiixIZCmNy0Khj4pqRbA97Im3UN87KpFU1aMZEjHuuv3ryyVfxtJT4iBdP7HOm+FI+lFTT0+HobzUCHUVIZQmfDKeJi2xfYFKctlIvR8nNdMAMlfHuvneJxSuJBnuuzlCBIOTexPOPEWia4TlRVlBXj+R8weveaobK/Tdf/mGI84GWIbJKO2W4SZU7XUPQqObBUmZn8S+dmZeCME3zO+01W/DU2F79qs3vUEY9BcLvP0kT4qSHjiefOeEkcPaaJRYn4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FhtczBPmxxyVFjd6a8jru8FvGOSfJ00gPRNlpS7v00=;
 b=YrxYezxtVYSlUUuicNBKL7mXRw4Hq8NnyndVPV07/R9whBxHf+W2SP2IqiWF2n6V7rZMYp/I7CM8iHhz6vbUnDoahTajXvRwUM5G6uahb83OGvWXF29ezbf9Iy+MeUj9FsdBXK3+JrCM8GFiUG72mDMm886XmuPkOCPi2kZ3e6Otpnw185fWMT+BMJ/Tu03T077BRwFmtEGhzc8AWQCJKwW5rzE410Y3c3Asy2fochhiDOPCXnk+IP6JWJXK5u3aARccRlmwRzM9Oo48fMb5UQZMGjqxXEptElRoukWfo7VS374LAn6DXySAVYRyyCZSQT1odVSMBN4b3RTlSkC12w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FhtczBPmxxyVFjd6a8jru8FvGOSfJ00gPRNlpS7v00=;
 b=l6/juJJJ83U8gpVx2z+v8F+LfP3Dwv/2ZvwqIvhzRjkwyd4wlSwoLtWaNT1oFAF9PU3Y6XgYt6avEEuH13I6JT8+mVUbgKxi12VznyyxV4hRHkYDMoVOxhNB/wVHcnHAyuEZc/19+kVOCB9Wa1Omn7XBz2kC8S3gmZsYFc4osMg=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4383.eurprd08.prod.outlook.com (20.179.28.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Fri, 15 Nov 2019 00:00:01 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2451.027; Fri, 15 Nov 2019
 00:00:01 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
CC:     nd <nd@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>
Subject: Re: [PATCH v3 2/6] drm/komeda: Add side by side plane_state split
Thread-Topic: [PATCH v3 2/6] drm/komeda: Add side by side plane_state split
Thread-Index: AQHVmsbI1HBKXny4TEuz/vJS3/QBiKeLWbCA
Date:   Fri, 15 Nov 2019 00:00:01 +0000
Message-ID: <2843645.837eivR4I8@e123338-lin>
References: <20191114083658.27237-1-james.qian.wang@arm.com>
 <20191114083658.27237-3-james.qian.wang@arm.com>
In-Reply-To: <20191114083658.27237-3-james.qian.wang@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LO2P123CA0036.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::24)
 To VI1PR08MB4078.eurprd08.prod.outlook.com (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fd523683-2eee-4dde-2972-08d7695eca13
X-MS-TrafficTypeDiagnostic: VI1PR08MB4383:|VI1PR08MB4383:|VI1PR0802MB2303:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0802MB230360D4735FA31504B542828F700@VI1PR0802MB2303.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2958;OLM:2958;
x-forefront-prvs: 02229A4115
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(979002)(7916004)(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(189003)(199004)(5660300002)(76176011)(66476007)(3846002)(6116002)(2906002)(81166006)(81156014)(9686003)(6512007)(14454004)(54906003)(6436002)(8676002)(71200400001)(71190400001)(316002)(64756008)(99286004)(8936002)(66446008)(229853002)(66946007)(6486002)(486006)(26005)(476003)(25786009)(6636002)(102836004)(52116002)(66556008)(478600001)(66066001)(6246003)(30864003)(386003)(256004)(7736002)(305945005)(6506007)(4326008)(446003)(11346002)(186003)(6862004)(86362001)(33716001)(14444005)(87944003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4383;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: SN7Lpn6jNyrqnK7YJPG4JWUf4PnUami83KcdJEWc0ySJZDthMbjsVyy5jL5yYfnYpDpEaFdxISWIjOQcVqAr7tBDRK1r+2Nh7vEZQwTx0ZeSUjQ/L5u9YjN/d4GppN+5z+cDfTOsLERCyw5q1aJq2iV/oz5Br/UmMo9cNwOWJXOfs5EQmJ/NXbl2SIGiDr3OhZeW0SHY8Z9KJV81CovSygjABB7Kes4qrXM3bzeXczGKn8PQCVotT+hC4ECeysUBeEWuP9qN5mJ02L/6MVrvJcPQXu443nhE1QwQcZnpjVrZc/lLx1TQ2brynxDudGX0MqNTjL7eLlOZaFTzQHerZ7X5fvLrt/hJa9zSGi/6DtZWaPOUUqmUvtBKXq56AH/SCIlG23TY3gzqAqRFDNC6yvAbvVwpDdBOEuNZMsPEwU3vrIVLwjovsEuRbQwNpIPu
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7D1CD7616721B640B0FC00B6AF507145@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4383
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT059.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(4636009)(7916004)(39860400002)(376002)(346002)(396003)(136003)(1110001)(339900001)(189003)(199004)(4326008)(14444005)(46406003)(26826003)(6636002)(6246003)(76130400001)(50466002)(6862004)(47776003)(70586007)(305945005)(86362001)(386003)(6506007)(70206006)(7736002)(6512007)(9686003)(33716001)(25786009)(30864003)(5660300002)(76176011)(8746002)(8936002)(97756001)(8676002)(22756006)(11346002)(186003)(478600001)(23726003)(446003)(2906002)(476003)(6116002)(14454004)(3846002)(54906003)(486006)(26005)(66066001)(316002)(99286004)(102836004)(126002)(229853002)(336012)(6486002)(356004)(81166006)(81156014)(105606002)(87944003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2303;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: fecc8724-d3b5-4328-be66-08d7695ec294
NoDisclaimer: True
X-Forefront-PRVS: 02229A4115
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pc+EDohEQz5WGW2mBpiB+GdGP+8tU8Ym0t3lGnO9Xom4WLnorJZeQgT2wjpujXP+kL5AIyo4rWB255cu9ZrmEkHA3kmXvAu3AEeOt2kN8lVkWkjESXPF1CRjBLCDtQ3J0ttiNP/h14iAFPC3wwKLhvaE3xMhgPDHAfStf4cTCVirxpwaFiKEIx9Uykmnl1+vAKtHKBggwQBZYlqVhpl8BJpcOqhAUd8lGksgtcIqJVo2L0W4sGmcPYEttLf04SY56BWJkqFQ0RpaPXqDRYhowPe5NvYwv7GgCfogy+TBuEM1qUZFm81BgrJdwvUDzKQpYUoJzus1ryGLjtFOcqilZbvxjJgcZ1O9o1qfUvhWW32c9NTr2ijJqIDWYd1SJkOHSRdGgU+BfTA7LDpYNk2eONDmLPZ8s3L4oJGUCNqZV54ZYY+kgdM7h6iKi+ZG9/rg
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2019 00:00:13.3529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd523683-2eee-4dde-2972-08d7695eca13
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2303
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 14 November 2019 08:37:31 GMT james qian wang (Arm Technology =
China) wrote:
> On side by side mode, The full display frame will be split into two parts
> (Left/Right), and each part will be handled by a single pipeline separate=
ly
> master pipeline for left part, slave for right.
>=20
> To simplify the usage and implementation, komeda use the following scheme
> to do the side by side split
> 1. The planes also have been grouped into two classes:
>    master-planes and slave-planes.
> 2. The master plane can display its image on any location of the final/fu=
ll
>    display frame, komeda will help to split the plane configuration to tw=
o
>    parts and fed them into master and slave pipelines.
> 3. The slave plane only can put its display rect on the right part of the
>    final display frame, and its data is only can be fed into the slave
>    pipeline.
>=20
> From the perspective of resource usage and assignment:
> The master plane can use the resources from the master pipeline and slave
> pipeline both, but slave plane only can use the slave pipeline resources.
>=20
> With such scheme, the usage of master planes are same as the none
> side_by_side mode. user can easily skip the slave planes and no need to
> consider side_by_side for them.
>=20
> Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@ar=
m.com>
> ---
>  .../drm/arm/display/komeda/komeda_pipeline.h  |  33 ++-
>  .../display/komeda/komeda_pipeline_state.c    | 188 ++++++++++++++++++
>  .../gpu/drm/arm/display/komeda/komeda_plane.c |   7 +-
>  3 files changed, 220 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drive=
rs/gpu/drm/arm/display/komeda/komeda_pipeline.h
> index 20a076cce635..4c0946fbaac1 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> @@ -521,6 +521,20 @@ komeda_component_pickup_output(struct komeda_compone=
nt *c, u32 avail_comps)
>  	return komeda_pipeline_get_first_component(c->pipeline, avail_inputs);
>  }
> =20
> +static inline const char *
> +komeda_data_flow_msg(struct komeda_data_flow_cfg *config)
> +{
> +	static char str[128];
> +
> +	snprintf(str, sizeof(str),
> +		 "rot: %x src[x/y:%d/%d, w/h:%d/%d] disp[x/y:%d/%d, w/h:%d/%d]",
> +		 config->rot,
> +		 config->in_x, config->in_y, config->in_w, config->in_h,
> +		 config->out_x, config->out_y, config->out_w, config->out_h);
> +
> +	return str;
> +}
> +
>  struct komeda_plane_state;
>  struct komeda_crtc_state;
>  struct komeda_crtc;
> @@ -532,22 +546,27 @@ int komeda_build_layer_data_flow(struct komeda_laye=
r *layer,
>  				 struct komeda_plane_state *kplane_st,
>  				 struct komeda_crtc_state *kcrtc_st,
>  				 struct komeda_data_flow_cfg *dflow);
> -int komeda_build_wb_data_flow(struct komeda_layer *wb_layer,
> -			      struct drm_connector_state *conn_st,
> -			      struct komeda_crtc_state *kcrtc_st,
> -			      struct komeda_data_flow_cfg *dflow);
> -int komeda_build_display_data_flow(struct komeda_crtc *kcrtc,
> -				   struct komeda_crtc_state *kcrtc_st);
> -
>  int komeda_build_layer_split_data_flow(struct komeda_layer *left,
>  				       struct komeda_plane_state *kplane_st,
>  				       struct komeda_crtc_state *kcrtc_st,
>  				       struct komeda_data_flow_cfg *dflow);
> +int komeda_build_layer_sbs_data_flow(struct komeda_layer *layer,
> +				     struct komeda_plane_state *kplane_st,
> +				     struct komeda_crtc_state *kcrtc_st,
> +				     struct komeda_data_flow_cfg *dflow);
> +
> +int komeda_build_wb_data_flow(struct komeda_layer *wb_layer,
> +			      struct drm_connector_state *conn_st,
> +			      struct komeda_crtc_state *kcrtc_st,
> +			      struct komeda_data_flow_cfg *dflow);
>  int komeda_build_wb_split_data_flow(struct komeda_layer *wb_layer,
>  				    struct drm_connector_state *conn_st,
>  				    struct komeda_crtc_state *kcrtc_st,
>  				    struct komeda_data_flow_cfg *dflow);
> =20
> +int komeda_build_display_data_flow(struct komeda_crtc *kcrtc,
> +				   struct komeda_crtc_state *kcrtc_st);
> +
>  int komeda_release_unclaimed_resources(struct komeda_pipeline *pipe,
>  				       struct komeda_crtc_state *kcrtc_st);
> =20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b=
/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> index 0930234abb9d..5de0d231a1c3 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> @@ -1130,6 +1130,194 @@ int komeda_build_layer_split_data_flow(struct kom=
eda_layer *left,
>  	return err;
>  }
> =20
> +/* split func will split configuration of master plane to two layer data
> + * flows, which will be fed into master and slave pipeline then.
> + * NOTE: @m_dflow is first used as input argument to pass the configurat=
ion of
> + *	 master_plane. when the split is done, @*m_dflow @*s_dflow are the
> + *	 output data flow for pipeline.
> + */
> +static int
> +komeda_split_sbs_master_data_flow(struct komeda_crtc_state *kcrtc_st,
> +				  struct komeda_data_flow_cfg **m_dflow,
> +				  struct komeda_data_flow_cfg **s_dflow)
> +{
> +	struct komeda_data_flow_cfg *master =3D *m_dflow;
> +	struct komeda_data_flow_cfg *slave =3D *s_dflow;
> +	u32 disp_end =3D master->out_x + master->out_w;
> +	u16 boundary;
> +
> +	pipeline_composition_size(kcrtc_st, &boundary, NULL);
> +
> +	if (disp_end <=3D boundary) {
> +		/* the master viewport only located in master side, no need
> +		 * slave anymore
> +		 */
> +		*s_dflow =3D NULL;
> +	} else if ((master->out_x < boundary) && (disp_end > boundary)) {
> +		/* the master viewport across two pipelines, split it */
> +		bool flip_h =3D has_flip_h(master->rot);
> +		bool r90  =3D drm_rotation_90_or_270(master->rot);
> +		u32 src_x =3D master->in_x;
> +		u32 src_y =3D master->in_y;
> +		u32 src_w =3D master->in_w;
> +		u32 src_h =3D master->in_h;
> +
> +		if (master->en_scaling || master->en_img_enhancement) {
> +			DRM_DEBUG_ATOMIC("sbs doesn't support to split a scaling image.\n");
> +			return -EINVAL;
> +		}
> +
> +		memcpy(slave, master, sizeof(*master));
> +
> +		/* master for left part of display, slave for the right part */
> +		/* split the disp_rect */
> +		master->out_w =3D boundary - master->out_x;
> +		slave->out_w  =3D disp_end - boundary;
> +		slave->out_x  =3D 0;
> +
> +		if (r90) {
> +			master->in_h =3D master->out_w;
> +			slave->in_h =3D slave->out_w;
> +
> +			if (flip_h)
> +				master->in_y =3D src_y + src_h - master->in_h;
> +			else
> +				slave->in_y =3D src_y + src_h - slave->in_h;
> +		} else {
> +			master->in_w =3D master->out_w;
> +			slave->in_w =3D slave->out_w;
> +
> +			/* on flip_h, the left display content from the right-source */
> +			if (flip_h)
> +				master->in_x =3D src_w + src_x - master->in_w;
> +			else
> +				slave->in_x =3D src_w + src_x - slave->in_w;

It really bugs me that the order here is w/x/w but in the block above
it's y/h/h.

> +		}
> +	} else if (master->out_x >=3D boundary) {
> +		/* disp_rect only locate in right part, move the dflow to slave */
> +		master->out_x -=3D boundary;
> +		*s_dflow =3D master;
> +		*m_dflow =3D NULL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int
> +komeda_split_sbs_slave_data_flow(struct komeda_crtc_state *kcrtc_st,
> +				 struct komeda_data_flow_cfg *slave)
> +{
> +	u16 boundary;
> +
> +	pipeline_composition_size(kcrtc_st, &boundary, NULL);
> +
> +	if (slave->out_x < boundary) {
> +		DRM_DEBUG_ATOMIC("SBS Slave plane is only allowed to configure the rig=
ht part frame.\n");
> +		return -EINVAL;
> +	}
> +
> +	/* slave->disp_rect locate in the right part */
> +	slave->out_x -=3D boundary;
> +
> +	return 0;
> +}
> +
> +/* On side by side mode, The full display frame will be split to two par=
ts
> + * (Left/Right), and each part will be handled by a single pipeline sepa=
rately,
> + * master pipeline for left part, slave for right.
> + *
> + * To simplify the usage and implementation, komeda use the following sc=
heme
> + * to do the side by side split
> + * 1. The planes also have been grouped into two classes:
> + *    master-planes and slave-planes.
> + * 2. The master plane can display its image on any location of the fina=
l/full
> + *    display frame, komeda will help to split the plane configuration t=
o two
> + *    parts and fed them into master and slave pipelines.
> + * 3. The slave plane only can put its display rect on the right part of=
 the
> + *    final display frame, and its data is only can be fed into the slav=
e
> + *    pipeline.
> + *
> + * From the perspective of resource usage and assignment:
> + * The master plane can use the resources from the master pipeline and s=
lave
> + * pipeline both, but slave plane only can use the slave pipeline resour=
ces.
> + *
> + * With such scheme, the usage of master planes are same as the none
> + * side_by_side mode. user can easily skip the slave planes and no need =
to
> + * consider side_by_side for them.
> + *
> + * NOTE: side_by_side split is occurred on pipeline level which split th=
e plane
> + *	 data flow into pipelines, but the layer split is a pipeline
> + *	 internal split which splits the data flow into pipeline layers.
> + *	 So komeda still supports to apply a further layer split to the sbs
> + *	 split data flow.
> + */
> +int komeda_build_layer_sbs_data_flow(struct komeda_layer *layer,
> +				     struct komeda_plane_state *kplane_st,
> +				     struct komeda_crtc_state *kcrtc_st,
> +				     struct komeda_data_flow_cfg *dflow)
> +{
> +	struct komeda_crtc *kcrtc =3D to_kcrtc(kcrtc_st->base.crtc);
> +	struct drm_plane *plane =3D kplane_st->base.plane;
> +	struct komeda_data_flow_cfg temp, *master_dflow, *slave_dflow;
> +	struct komeda_layer *master, *slave;
> +	bool master_plane =3D layer->base.pipeline =3D=3D kcrtc->master;
> +	int err;
> +
> +	DRM_DEBUG_ATOMIC("SBS prepare %s-[PLANE:%d:%s]: %s.\n",
> +			 master_plane ? "Master" : "Slave",
> +			 plane->base.id, plane->name,
> +			 komeda_data_flow_msg(dflow));
> +
> +	if (master_plane) {
> +		master =3D layer;
> +		slave =3D layer->sbs_slave;
> +		master_dflow =3D dflow;
> +		slave_dflow  =3D &temp;
> +		err =3D komeda_split_sbs_master_data_flow(kcrtc_st,
> +				&master_dflow, &slave_dflow);
> +	} else {
> +		master =3D NULL;
> +		slave =3D layer;
> +		master_dflow =3D NULL;
> +		slave_dflow =3D dflow;
> +		err =3D komeda_split_sbs_slave_data_flow(kcrtc_st, slave_dflow);
> +	}
> +
> +	if (err)
> +		return err;
> +
> +	if (master_dflow) {
> +		DRM_DEBUG_ATOMIC("SBS Master-%s assigned: %s\n",
> +			master->base.name, komeda_data_flow_msg(master_dflow));
> +
> +		if (master_dflow->en_split)
> +			err =3D komeda_build_layer_split_data_flow(master,
> +					kplane_st, kcrtc_st, master_dflow);
> +		else
> +			err =3D komeda_build_layer_data_flow(master,
> +					kplane_st, kcrtc_st, master_dflow);
> +
> +		if (err)
> +			return err;
> +	}
> +
> +	if (slave_dflow) {
> +		DRM_DEBUG_ATOMIC("SBS Slave-%s assigned: %s\n",
> +			slave->base.name, komeda_data_flow_msg(slave_dflow));
> +
> +		if (slave_dflow->en_split)
> +			err =3D komeda_build_layer_split_data_flow(slave,
> +					kplane_st, kcrtc_st, slave_dflow);
> +		else
> +			err =3D komeda_build_layer_data_flow(slave,
> +					kplane_st, kcrtc_st, slave_dflow);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
>  /* writeback data path: compiz -> scaler -> wb_layer -> memory */
>  int komeda_build_wb_data_flow(struct komeda_layer *wb_layer,
>  			      struct drm_connector_state *conn_st,
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/drivers/=
gpu/drm/arm/display/komeda/komeda_plane.c
> index 98e915e325dd..2644f0727570 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> @@ -77,6 +77,7 @@ komeda_plane_atomic_check(struct drm_plane *plane,
>  	struct komeda_plane_state *kplane_st =3D to_kplane_st(state);
>  	struct komeda_layer *layer =3D kplane->layer;
>  	struct drm_crtc_state *crtc_st;
> +	struct komeda_crtc *kcrtc;
>  	struct komeda_crtc_state *kcrtc_st;
>  	struct komeda_data_flow_cfg dflow;
>  	int err;
> @@ -94,13 +95,17 @@ komeda_plane_atomic_check(struct drm_plane *plane,
>  	if (!crtc_st->active)
>  		return 0;
> =20
> +	kcrtc =3D to_kcrtc(crtc_st->crtc);
>  	kcrtc_st =3D to_kcrtc_st(crtc_st);
> =20
>  	err =3D komeda_plane_init_data_flow(state, kcrtc_st, &dflow);
>  	if (err)
>  		return err;
> =20
> -	if (dflow.en_split)
> +	if (kcrtc->side_by_side)
> +		err =3D komeda_build_layer_sbs_data_flow(layer,
> +				kplane_st, kcrtc_st, &dflow);
> +	else if (dflow.en_split)
>  		err =3D komeda_build_layer_split_data_flow(layer,
>  				kplane_st, kcrtc_st, &dflow);
>  	else
>=20


--=20
Mihail



