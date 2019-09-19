Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B85C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4EFB21928
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="JDnZKZQB";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="JDnZKZQB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389603AbfISOpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 10:45:35 -0400
Received: from mail-eopbgr80082.outbound.protection.outlook.com ([40.107.8.82]:56899
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389041AbfISOpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 10:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEVWTGLbSwNUJqcuIjqq7IqSQBK1jSMGipGpujHsPRA=;
 b=JDnZKZQBLg+m0d+oYRTBdyjNVSXRqwhd4/jUCDTHChp/FrxvVFckE7AiXYQl6wAudeOuvJflKvM+PYr9hW1PnAr0u+l0CYlK+NReN6sLmKYSg7+aGv0X7Uvv2tPbTFm/VIXHEjyHoz1/EN+epvAMKBH09fMdvyEN8Sd5AZ8DV2c=
Received: from VI1PR08CA0226.eurprd08.prod.outlook.com (2603:10a6:802:15::35)
 by AM0PR08MB3794.eurprd08.prod.outlook.com (2603:10a6:208:103::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.17; Thu, 19 Sep
 2019 14:43:49 +0000
Received: from VE1EUR03FT024.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::205) by VI1PR08CA0226.outlook.office365.com
 (2603:10a6:802:15::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.17 via Frontend
 Transport; Thu, 19 Sep 2019 14:43:49 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT024.mail.protection.outlook.com (10.152.18.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20 via Frontend Transport; Thu, 19 Sep 2019 14:43:47 +0000
Received: ("Tessian outbound d5a1f2820a4f:v31"); Thu, 19 Sep 2019 14:43:43 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f985572841a05ff6
X-CR-MTA-TID: 64aa7808
Received: from f75c82ad0c16.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.8.58])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 3538D5D3-4880-4593-9DF2-03AAEBFD2C93.1;
        Thu, 19 Sep 2019 14:43:37 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-am5eur03lp2058.outbound.protection.outlook.com [104.47.8.58])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f75c82ad0c16.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 19 Sep 2019 14:43:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ka0OKV2pdlb7aueWSmOx4zBuO8MLmsylyz/2OFZiLJg2R34K4q6D1R9aVWRPev/B2PqAoMRjI2u4alB5JXRc26ue0Uo1KxGivxt2R8Pav2YUcDVvKp+KAPV6DBkbh2ufVFLy3qPj0eNBfDmTJNMpEok+BQIbUcg9DC3uImi0RL484LBNK8R0/l8NmPmRnEzPOK+cbv/T1OcjP/yd/Zz2Pj1ebCpKLtErFiokMM+XJoqnfFjQVcVZgz1sql8R1dzPGMeeNy8QKgZ8Da6xbqeQceofIpwN7JihtSEe8IDasTzdCuAVPaBsHLV2QPAx4GAYKlDMWw/6/sty1VdSCLDt3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEVWTGLbSwNUJqcuIjqq7IqSQBK1jSMGipGpujHsPRA=;
 b=aH98PUTow9puKowVYYOR814PZo59TMDuskDThNCTgjWSQWg7YNFzklZsNuDBAPZk/tmIK9PnaeDFadwxaOH9VvrTFcyLPc0grFAt/qzvBo+PtbeJS0q9OrOUbuQTaWxP+aNWwQt27Z0J3occuxlUXCISoGb6LgHj3UD2738qXGdmgCf4KkpyoL2karfxolhWaI25uYSNJgPlOlA6wz8/3EkeNlEkdDWOyCMzbDCjxG4nbzyILK/TnWE3lsPiv0B+WXKyfQgPoXUQ2xHHmUyPx7rt5DTHHXw5pKDh4XITSYT6/1vsLKLA++taO2yoL1TAjD2g9IkcYPq4HPJtVrzG2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEVWTGLbSwNUJqcuIjqq7IqSQBK1jSMGipGpujHsPRA=;
 b=JDnZKZQBLg+m0d+oYRTBdyjNVSXRqwhd4/jUCDTHChp/FrxvVFckE7AiXYQl6wAudeOuvJflKvM+PYr9hW1PnAr0u+l0CYlK+NReN6sLmKYSg7+aGv0X7Uvv2tPbTFm/VIXHEjyHoz1/EN+epvAMKBH09fMdvyEN8Sd5AZ8DV2c=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4206.eurprd08.prod.outlook.com (20.178.205.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Thu, 19 Sep 2019 14:43:36 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::f164:4d79:79f:dc6f]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::f164:4d79:79f:dc6f%7]) with mapi id 15.20.2263.023; Thu, 19 Sep 2019
 14:43:36 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     nd <nd@arm.com>, Daniel Vetter <daniel@ffwll.ch>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/komeda: Fix FLIP_COMPLETE timestamp on CRTC enable
Thread-Topic: [PATCH] drm/komeda: Fix FLIP_COMPLETE timestamp on CRTC enable
Thread-Index: AQHVbu5XybbezBNH+kaEyHcWelehf6czE10A
Date:   Thu, 19 Sep 2019 14:43:35 +0000
Message-ID: <1731001.VqgqlKjhFN@e123338-lin>
References: <20190919132759.18358-1-mihail.atanassov@arm.com>
In-Reply-To: <20190919132759.18358-1-mihail.atanassov@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LO2P265CA0255.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::27) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: da97205d-5078-4e06-f260-08d73d0fc7ac
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB4206;
X-MS-TrafficTypeDiagnostic: VI1PR08MB4206:|VI1PR08MB4206:|AM0PR08MB3794:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB3794CA8DA7A6D4DE9D1B15EF8F890@AM0PR08MB3794.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:7691;OLM:7691;
x-forefront-prvs: 016572D96D
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(366004)(346002)(39860400002)(396003)(136003)(376002)(189003)(199004)(256004)(6916009)(81156014)(81166006)(7736002)(8676002)(54906003)(8936002)(478600001)(14454004)(486006)(11346002)(305945005)(2351001)(86362001)(476003)(71190400001)(64756008)(3846002)(25786009)(102836004)(6486002)(229853002)(6436002)(5640700003)(99286004)(4326008)(6246003)(66556008)(5660300002)(76176011)(33716001)(66476007)(66066001)(446003)(71200400001)(2501003)(386003)(6116002)(6506007)(66946007)(6512007)(66446008)(26005)(52116002)(2906002)(186003)(9686003)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4206;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: Buht71Y+RSTNYcfHzmMTQyCAc91Ht9wmJyNCscTA+sIfCqwpp7aV2FuXVU3DGh49vIC3PSSZxhcAF4zkYxppy0jQ/GJcTP2kGhd71FIcnIDz1lQ/+7xxJVSXXMjGHdslRy5jn2e6Fi5t427Wt19X2AflV3mN47pzEsNRKLlEmaEhVucJFdO8yJRIii1zHvkB69ikB0criqDQ0Q+n4EmOAOPM05XE2QLe6KZ3BE/JJzv5LmlL1NNcjfapYUNGUwotE4kIRbS6dgE89l+yS6cxpS31WThAcn+7YUoXKZ9hL5zx6P018xMODU8eYjl8yZ9V9D4vm/seE1Trgk/Br3Pt5sxCKb0FqxuSSQrxA8hqnGfCI2qLJYoqtIbZO10qlE+uin9lJkBQ0AqiMVlg35n9unzlAg/5dwaDljPVaX1IrFg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DD02967929B48648A4B3100FECF50639@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4206
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT024.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(39860400002)(136003)(346002)(396003)(376002)(189003)(199004)(2501003)(229853002)(478600001)(22756006)(99286004)(5660300002)(4326008)(316002)(36906005)(9686003)(6116002)(3846002)(97756001)(6506007)(386003)(63350400001)(26826003)(70586007)(2351001)(76176011)(23726003)(305945005)(25786009)(86362001)(2906002)(70206006)(336012)(47776003)(11346002)(5640700003)(6512007)(476003)(446003)(356004)(6486002)(54906003)(50466002)(8746002)(8676002)(126002)(76130400001)(186003)(8936002)(66066001)(33716001)(46406003)(102836004)(486006)(7736002)(26005)(6246003)(14454004)(81166006)(6862004)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3794;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: deb039be-0761-4974-8241-08d73d0fc05d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR08MB3794;
NoDisclaimer: True
X-Forefront-PRVS: 016572D96D
X-Microsoft-Antispam-Message-Info: IEOtOMYO0cscpmuK8gDoIm2El4jJtHehaIJeT1k5Ib7D3s8D1L1YkZYCs5FP+vAf0P/hLfK9CbnwL0BsUTqj+QHRKdqoRu3u+apjzPmnuCVNBqdv+gRafaXRfcE+BgSU6VhNoe3OSlAWpFhsPP8xNOSLJsBX47zy/ZULIlGIi+h52lOm7CrHVKx27DVhnONyVO2McIAqQ2VbVaIofr1nveipuhDd5Wxe2pMh+NkDSOWc1GusgX3CMCCHyqSc79JB9/qlFOXUkGp3yKiwY8cXgDEerqsyrMVoOL9aTycMAF4dodvtRV0j7m6deR4w3xkhCBfaFPZ9sD3q30niAFUt0AMzRvn5pGeGh4IB/T8UB1mvilYUs1keEswajiNvR6bpqP06pszUNyekthyXIvugSE77IidOyyoYsvMIyZAGO4I=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2019 14:43:47.9017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da97205d-5078-4e06-f260-08d73d0fc7ac
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3794
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 19 September 2019 14:30:02 BST Mihail Atanassov wrote:
> When initially turning a crtc on, drm_reset_vblank_timestamp will
> set the vblank timestamp to 0 for any driver that doesn't provide
> a ->get_vblank_timestamp() hook.
>=20
> Unfortunately, the FLIP_COMPLETE event depends on that timestamp,
> and the only way to regenerate a valid one is to have vblank
> interrupts enabled and have a valid in-ISR call to
> drm_crtc_handle_vblank.
>=20
> Wrap the call to komeda_crtc_do_flush in ->atomic_enable() with a
> drm_crtc_vblank_{get,put} pair so we can have a vblank ISR prior to
> the FLIP_COMPLETE ISR (or more likely, they'll get handled in the same
> ISR, which is equally valid).
>=20
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Liviu Dudau <Liviu.Dudau@arm.com>
> Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_crtc.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/g=
pu/drm/arm/display/komeda/komeda_crtc.c
> index f4400788ab94..87420a767bc4 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> @@ -258,7 +258,9 @@ komeda_crtc_atomic_enable(struct drm_crtc *crtc,
>  {
>  	komeda_crtc_prepare(to_kcrtc(crtc));
>  	drm_crtc_vblank_on(crtc);
> +	WARN_ON(drm_crtc_vblank_get(crtc));
>  	komeda_crtc_do_flush(crtc, old);
> +	drm_crtc_vblank_put(crtc);
>  }
> =20
>  static void
>=20

Please ignore, this doesn't work (page flips after 5 seconds don't get
an updated timestamp because of the delayed vsync disable). I'll push
a v2 soon where vsync on/off tracks crtc enable/disable.

--=20
Mihail



