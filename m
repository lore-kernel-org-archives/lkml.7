Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62006ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B43B2133F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="cAh2R1UR";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="cAh2R1UR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389142AbfJAOnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:43:14 -0400
Received: from mail-eopbgr80048.outbound.protection.outlook.com ([40.107.8.48]:37600
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727083AbfJAOnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cR4Vi6LsRyE9uZtNJbvHn1DcYiHfE3r1Jo7fvSP7c0=;
 b=cAh2R1URYWzlcNm+thMFnJXnsSrE5L+tXFgoVXDGfmjSphHo/+tl5B6/CPpdEFDMmaTcDBuisxBVThwpcqunLs6gOhHKO7qau5Izzv7Nab+7vQrmf/BOv+jsvquV+FKmOTl9c+rhFsr86pOfRh5pewkJk4gNGICpTdPo/8DB2L0=
Received: from DB6PR0801CA0048.eurprd08.prod.outlook.com (2603:10a6:4:2b::16)
 by AM6PR08MB3159.eurprd08.prod.outlook.com (2603:10a6:209:46::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.20; Tue, 1 Oct
 2019 14:43:07 +0000
Received: from DB5EUR03FT004.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::203) by DB6PR0801CA0048.outlook.office365.com
 (2603:10a6:4:2b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.17 via Frontend
 Transport; Tue, 1 Oct 2019 14:43:07 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT004.mail.protection.outlook.com (10.152.20.128) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Tue, 1 Oct 2019 14:43:05 +0000
Received: ("Tessian outbound 927f2cdd66cc:v33"); Tue, 01 Oct 2019 14:43:04 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 12af0cd3a3f3367f
X-CR-MTA-TID: 64aa7808
Received: from c0def8049de3.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.9.50])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id EF413FD5-2CEB-4F7D-B433-C7AFE724F04F.1;
        Tue, 01 Oct 2019 14:42:58 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2050.outbound.protection.outlook.com [104.47.9.50])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id c0def8049de3.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Tue, 01 Oct 2019 14:42:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwr7VXLTYR77/yInjW6TGBKULo/zLvH32zjPGmMrUFWqgv9wIIhiuI8fF1sbbrCO5WKBMf2wAlv4eepbYBqvHiYLgWgRpLb4mAhCxhlunUYx7Iw1yvghJvRWGhDglgQTde3MjVz5kHylsCdSVJIkGQiOVmUShv+rKr0DRHkoaLT4UDFnPdZ+m/YuN7zFTgfv4y64lsxm7PRvYyobVK1T+e9xBmBlt0miDJWKfYuiJGGA2yF3ixWSxkVDMQj038C4J3X7OW3cURS+dDXI1dNZmW7ZufxlZDeibZCGe6LqWYD1p4wAmFNK47plUgM4ANwLzZ3UfvmVsraIkmHUjGlWAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cR4Vi6LsRyE9uZtNJbvHn1DcYiHfE3r1Jo7fvSP7c0=;
 b=k9p9PGjP+bckGPzQYMbh1m06HNJxCR6GFpdzdsHNaWpYgVcdSTyoXr/59PhPRRfJ+wYeShT1rq6dFaivWgLGBMXERbE6iQfhOGcI7WI/4P7pexxivgk//6zidKiAfMJ9KVzCv4GHB/VM5mtQh/6znEivZP0p1W0FcYE8v3k2I0xwAV4d8q8ZNnF7KB/kNCdzL1tMrBJ+mdznN1mpjQ7CKWnKfGLXfQAqkePt1yQl8neeANlh6PM219cuFXLsuMwOsaX5uLTKCcXiT/9OuoPOQW4NwjRxuP3E0ZqxqtCxMtckxLQbY/TlIyZpHvBuUz2PGRz5oHH2Y7qYKUSMXI5AHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cR4Vi6LsRyE9uZtNJbvHn1DcYiHfE3r1Jo7fvSP7c0=;
 b=cAh2R1URYWzlcNm+thMFnJXnsSrE5L+tXFgoVXDGfmjSphHo/+tl5B6/CPpdEFDMmaTcDBuisxBVThwpcqunLs6gOhHKO7qau5Izzv7Nab+7vQrmf/BOv+jsvquV+FKmOTl9c+rhFsr86pOfRh5pewkJk4gNGICpTdPo/8DB2L0=
Received: from AM7PR08MB5352.eurprd08.prod.outlook.com (10.141.172.139) by
 AM7PR08MB5477.eurprd08.prod.outlook.com (10.141.174.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Tue, 1 Oct 2019 14:42:57 +0000
Received: from AM7PR08MB5352.eurprd08.prod.outlook.com
 ([fe80::1c78:bb51:3634:9cf0]) by AM7PR08MB5352.eurprd08.prod.outlook.com
 ([fe80::1c78:bb51:3634:9cf0%2]) with mapi id 15.20.2305.022; Tue, 1 Oct 2019
 14:42:57 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        nd <nd@arm.com>
Subject: Re: [PATCH v2 RESEND] drm/komeda: Workaround for broken FLIP_COMPLETE
 timestamps
Thread-Topic: [PATCH v2 RESEND] drm/komeda: Workaround for broken
 FLIP_COMPLETE timestamps
Thread-Index: AQHVeGOXiPfFKQODqkGeQ/wFbMnv8adF3D8A
Date:   Tue, 1 Oct 2019 14:42:56 +0000
Message-ID: <20191001144256.GA15279@arm.com>
References: <20190923101017.35114-1-mihail.atanassov@arm.com>
 <20191001142121.13939-1-mihail.atanassov@arm.com>
In-Reply-To: <20191001142121.13939-1-mihail.atanassov@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0368.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::20) To AM7PR08MB5352.eurprd08.prod.outlook.com
 (2603:10a6:20b:106::11)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.50]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: c1b153b1-4f4c-43a1-cb9b-08d7467dab78
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: AM7PR08MB5477:|AM7PR08MB5477:|AM6PR08MB3159:
X-MS-Exchange-PUrlCount: 2
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB31591F34B2844FF26C241F43E49D0@AM6PR08MB3159.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 0177904E6B
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(189003)(199004)(446003)(6636002)(386003)(6506007)(1076003)(71190400001)(71200400001)(81166006)(476003)(8676002)(6116002)(2616005)(3846002)(81156014)(66066001)(52116002)(486006)(33656002)(6862004)(11346002)(6246003)(102836004)(76176011)(26005)(25786009)(186003)(5660300002)(36756003)(66946007)(66476007)(64756008)(66446008)(316002)(66556008)(229853002)(6306002)(99286004)(6512007)(6486002)(2906002)(7736002)(4326008)(478600001)(966005)(8936002)(44832011)(14444005)(256004)(37006003)(54906003)(6436002)(86362001)(14454004)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM7PR08MB5477;H:AM7PR08MB5352.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: S7kXTijQUDozMwc1zOfAKNkMbd/qoGEGZedJD6VNIaQzAIuHEWsYIkGLTL3ecNqYESpEMm/PywKmblE6UfNmJvUYMi7gr5lQjlhGaG74BePDMlgSIcbKBknzhf5M1kH94dv3fbsMhQDu3IWBelvY8aGtFOLIf+7Rl3o077t2O/KSI1jWxOpuJE1qwD4TGB8qfFqEnkIiksSIY3MICO06Z+koueHki45rhHaMqribafTXfxRk7uJdDfVRy0CUxk5iqdey6uMam6aWlfz7jr/mHVFSFfRi6IRqBrDLeLFpGk8FeRMzv41K7M2ohqBAYUAGNcp4svMtVUwwMi5XcQkLNCjyQJXAhqNpkYAWCxKZygnmjwHvOZ29BAf+VHP5YPb7eBOST3LRlZhRubY/+IbXfNtCF2ZXuAofNyQzYfMEmR9e3JLJzO2vDjYqfahm+HBU4+FVvQtbHt1JdiITzrCkQw==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18C607FB9F328543B2C02E76E696AEA5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5477
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT004.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(136003)(396003)(376002)(199004)(189003)(6862004)(3846002)(356004)(6512007)(33656002)(6246003)(1076003)(86362001)(4326008)(6306002)(22756006)(99286004)(478600001)(966005)(26826003)(23726003)(76176011)(2906002)(14454004)(8936002)(8746002)(46406003)(81156014)(81166006)(8676002)(6116002)(47776003)(386003)(126002)(25786009)(229853002)(66066001)(316002)(186003)(26005)(6506007)(11346002)(5660300002)(54906003)(336012)(446003)(305945005)(63350400001)(6486002)(2616005)(7736002)(36756003)(476003)(97756001)(50466002)(37006003)(6636002)(14444005)(102836004)(70586007)(70206006)(76130400001)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3159;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: b870f7f4-ab5f-497c-65f8-08d7467da608
NoDisclaimer: True
X-Forefront-PRVS: 0177904E6B
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N5nzPBEvZVAy0IYS/fqDU1F5kzFb9QC6owuEXpA+JaC+KWx7RAEHhDyI/r1C8aIAw1O9aK156XkrnkS14XP2n4H1fSyvQEAa9s9bIb9eb4px0dZr/DDs26QF0VnqM1RPn8Xd289G6BuBNmwu+LyijZp2UDNDACEmbCv1Ip4XI8dHHCivfHbDFL4zkmCf/H2mv2/v4zOv5vC8VcXIsa+fXRjrX5Lzo19EP4NFmBnENTMeSWqNJlUTUuzVPm0j185DmLlbp3rSaVjx96LuSA6XciH8PL5I+YnC8AXqObRRfk9sFhlPrM5IoXvbo5J3Ry9RRCXtN0As+QswKSEugeiAQ/qS6lAjHfbJqOEB0T7GqzZva8zrYH9+YWfevTRzwSVk9c0wts1g0eq4mteK9sJnLJ4Pwyu1t7uDQRJ6wBqUSZQbE3EpIOaQUV21i3fN/eNNlUakBIh42UOhhp23j12Kcw==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2019 14:43:05.7320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b153b1-4f4c-43a1-cb9b-08d7467dab78
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 02:21:40PM +0000, Mihail Atanassov wrote:
> When initially turning a crtc on, drm_reset_vblank_timestamp will
> set the vblank timestamp to 0 for any driver that doesn't provide
> a ->get_vblank_timestamp() hook.
>=20
> Unfortunately, the FLIP_COMPLETE event depends on that timestamp,
> and the only way to regenerate a valid one is to have vblank
> interrupts enabled and have a valid in-ISR call to
> drm_crtc_handle_vblank.
>=20
> Additionally, if the user doesn't request vblanks but _does_ request
> FLIP_COMPLETE events, we still don't have a good timestamp: it'll be the
> same stamp as the last vblank one.
>=20
> Work around the issue by always enabling vblanks when the CRTC is on.
> Reducing the amount of time that PL0 has to be unmasked would be nice to
> fix at a later time.
>=20
> Changes since v1 [https://patchwork.freedesktop.org/patch/331727/]:
>  - moved drm_crtc_vblank_put call to the ->atomic_disable() hook
>=20
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Liviu Dudau <Liviu.Dudau@arm.com>
> Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
> Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>

Pushed to drm-misc-next f59769c52cd7d158df53487ec2936f5592073340

Thanks,
Ayan
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_crtc.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/g=
pu/drm/arm/display/komeda/komeda_crtc.c
> index 9ca5dbfd0723..75263d8cd0bd 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> @@ -249,6 +249,7 @@ komeda_crtc_atomic_enable(struct drm_crtc *crtc,
>  {
>  	komeda_crtc_prepare(to_kcrtc(crtc));
>  	drm_crtc_vblank_on(crtc);
> +	WARN_ON(drm_crtc_vblank_get(crtc));
>  	komeda_crtc_do_flush(crtc, old);
>  }
> =20
> @@ -341,6 +342,7 @@ komeda_crtc_atomic_disable(struct drm_crtc *crtc,
>  		komeda_crtc_flush_and_wait_for_flip_done(kcrtc, disable_done);
>  	}
> =20
> +	drm_crtc_vblank_put(crtc);
>  	drm_crtc_vblank_off(crtc);
>  	komeda_crtc_unprepare(kcrtc);
>  }
> --=20
> 2.23.0
>=20
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
