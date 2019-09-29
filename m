Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0228C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 06:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA2A20863
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 06:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ob5wViHF";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ob5wViHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbfI2GU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 02:20:56 -0400
Received: from mail-eopbgr00049.outbound.protection.outlook.com ([40.107.0.49]:19012
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725379AbfI2GU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 02:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1i66CD8zMe2VMNNH4WML4pyxCs7cKHEBPw/SKU1qXlE=;
 b=ob5wViHFYBi8JYZ8aL3EGcfzwCtoTxEnTmenrkfoXrgsnL9A52HzZ87qwgXLNZbVztsQ7WOiOwWMbLR4/k+YNW2nPsKjao4+KnDfBNUH3htl8ap33ppk8fRL4cZDscXn4N4LaaswjPKQj/PcQvowuyBY5GGz8ryJXuf8TZJ/dQg=
Received: from VI1PR0802CA0035.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::21) by AM0PR08MB4561.eurprd08.prod.outlook.com
 (2603:10a6:208:12d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.15; Sun, 29 Sep
 2019 06:19:10 +0000
Received: from VE1EUR03FT052.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::209) by VI1PR0802CA0035.outlook.office365.com
 (2603:10a6:800:a9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.16 via Frontend
 Transport; Sun, 29 Sep 2019 06:19:10 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT052.mail.protection.outlook.com (10.152.19.173) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Sun, 29 Sep 2019 06:19:09 +0000
Received: ("Tessian outbound 081de437afc7:v33"); Sun, 29 Sep 2019 06:19:03 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 72a203cab4710ca1
X-CR-MTA-TID: 64aa7808
Received: from ed6bda481be6.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.2.54])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 16C1A047-E96A-43B2-8E73-6A983D2D6621.1;
        Sun, 29 Sep 2019 06:18:57 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01lp2054.outbound.protection.outlook.com [104.47.2.54])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ed6bda481be6.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Sun, 29 Sep 2019 06:18:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7Q1Es/t3PBsoFS4hTX4j9JMtoLNiyPVc1mwNSUi8Ux0Ks1GIFvknSLnDpSdlNTmqqohjVf8XosLEq36NH1uYdI8Z3imilut2km+4wLY8ccgzRG0Gpggewp+tMsT5BSlP75LzeuZ4PhcYBH2XTnz0TD2ujHY7B0JQzIN5rMuXlUJCa5hyzbF9cEna5yIdVemmvT8UJIM9WKBdKrNmn6dec7TFxiB8/ZyRCF9ojfSXLXKHN8YOUGDgBybeiKx5dX2esB9xRJFkDGsZuiNM08P2cEoPum9+My37Q8VrxYQaaosP+07zxack9UZ0XsDOL3/GgmauqbYyDC1yR+3Shi27Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1i66CD8zMe2VMNNH4WML4pyxCs7cKHEBPw/SKU1qXlE=;
 b=XyCX/VFjk9styitS8xje6up4o1fBLR6tGzZwXjE8P0ARYSa9usQjzkmhNaQhpeKEL4qUp1PiNmumevDNnxAYSd8q+m1S6DNPKykMJz8rHSFd+2RipXPiTwFD8jpO9vG1iNObN+1uCkJ8+FYKTYr1kNXjUYXoV7sUPEzw+wdPcijUq5vpGnwSeLAOTYvhDm5jG/ZCaUSdeZ0F95W0Jf3zelPrTfLMiAeOJDJDr109s2Gs92zG/8LSv99v9vLLoE4DeAWok0lQbdNaSP0C7vOzcxFUOK0Kt4vk32UW+2jwyJGnl7S/LkiHYXCObAX5PZ9X+K7coWUpuf24HaXTHB7f7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1i66CD8zMe2VMNNH4WML4pyxCs7cKHEBPw/SKU1qXlE=;
 b=ob5wViHFYBi8JYZ8aL3EGcfzwCtoTxEnTmenrkfoXrgsnL9A52HzZ87qwgXLNZbVztsQ7WOiOwWMbLR4/k+YNW2nPsKjao4+KnDfBNUH3htl8ap33ppk8fRL4cZDscXn4N4LaaswjPKQj/PcQvowuyBY5GGz8ryJXuf8TZJ/dQg=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5245.eurprd08.prod.outlook.com (20.179.31.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Sun, 29 Sep 2019 06:18:56 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a0a6:ad4c:b7a7:f879]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a0a6:ad4c:b7a7:f879%5]) with mapi id 15.20.2284.028; Sun, 29 Sep 2019
 06:18:56 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>, nd <nd@arm.com>,
        Sean Paul <sean@poorly.run>
Subject: Re: [v2] drm/komeda: Workaround for broken FLIP_COMPLETE timestamps
Thread-Topic: [v2] drm/komeda: Workaround for broken FLIP_COMPLETE timestamps
Thread-Index: AQHVdo3GfdMAC9qVAUSxM4QfhIA3AQ==
Date:   Sun, 29 Sep 2019 06:18:56 +0000
Message-ID: <20190929061849.GA29382@jamwan02-TSP300>
References: <20190923101017.35114-1-mihail.atanassov@arm.com>
In-Reply-To: <20190923101017.35114-1-mihail.atanassov@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0P153CA0040.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::28) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 8bf83097-3933-417e-f23d-08d744a4f06b
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB5245:|VE1PR08MB5245:|AM0PR08MB4561:
X-MS-Exchange-PUrlCount: 1
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB4561A473B8CDD6FBCFBE4B59B3830@AM0PR08MB4561.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:6790;OLM:6790;
x-forefront-prvs: 017589626D
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(346002)(376002)(136003)(366004)(396003)(39850400004)(189003)(199004)(54906003)(305945005)(66446008)(66556008)(6486002)(6636002)(58126008)(81156014)(7736002)(81166006)(229853002)(6116002)(3846002)(64756008)(66946007)(6512007)(6436002)(14454004)(66476007)(8936002)(8676002)(486006)(476003)(11346002)(478600001)(2906002)(33716001)(9686003)(316002)(446003)(14444005)(256004)(186003)(6246003)(26005)(25786009)(86362001)(6862004)(76176011)(1076003)(52116002)(99286004)(102836004)(5660300002)(66066001)(71190400001)(6306002)(71200400001)(4326008)(55236004)(6506007)(386003)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5245;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: ffU22a7RCFoK0CFZI8vnpPjhul7uEqnMgneAG8zjTZdzTYwFGuwATqWBnmZ2kZRtUX1kqJsDtT5r1XVZfmm9qjyEQv0dGM//VJOUYeI2SVY1gDb95XFFSie3eq0B2kUJwF0JIytMpl3jH19iEuEskYocCX6xOooRzpLKZB43+vcxnhw54uvnNN7NU0Mwijvwv/crSQS8X7JvmABN0cR+PYAWzYYXWuqk6K0/EmVi3UO8FOGSLROV7NbEuEiCobrRsSx/HJPHHsIlBImYMrQK5zGj6Mwj3YA4WwXqaJc+tdfsZoGJy80tMryc7Ze0iKfPVRIdvBaTbWkwp+s33pkISJBO5vQHaa7/jbO2IrpCX574p6npcwnwqazQR2gUtjfRM+3xB51/6laqZ+VZMiFX/g0CYuS92wV2u5Nnd8RBQ36WWqxER1EJPNBxWQuT48jhW21t0ljj5uhj9iLrDZId6A==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <19F74D5288858D4B93C4CCB2292F0DAD@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5245
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT052.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(136003)(346002)(39850400004)(376002)(396003)(189003)(199004)(229853002)(46406003)(6636002)(6246003)(6506007)(3846002)(6116002)(47776003)(6486002)(107886003)(386003)(2906002)(14454004)(336012)(54906003)(102836004)(22756006)(23726003)(58126008)(26005)(33656002)(1076003)(50466002)(186003)(356004)(86362001)(7736002)(6306002)(99286004)(14444005)(486006)(70206006)(8936002)(6862004)(70586007)(81156014)(6512007)(476003)(76130400001)(8746002)(81166006)(316002)(11346002)(63350400001)(25786009)(36906005)(4326008)(9686003)(126002)(33716001)(305945005)(97756001)(5660300002)(26826003)(66066001)(478600001)(76176011)(446003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB4561;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 167f86c9-d66f-4ff4-a913-08d744a4e882
NoDisclaimer: True
X-Forefront-PRVS: 017589626D
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4X/GNquyrP/kTrINFPJCAq/mZ5ZFD7IbCeeCoHWQTQPSQAE8kmoobjz32JqoQGUpK6jXPvZICMOzPSXYcZhp3LrJjkHhv9VqyhIGcNXu8leeAMuXzLV/jmA//F5inbfMLqeQEdy/AiWgdWpFELyAlRaf6miH+CkE0qQtEOhsuytEttQE6ZGq2FNYYY1fnQGVwUf3ULZKkLB0S60MAprBdoywFQtNCQxuIDiDRTZ9uVJLFBTw9m1j882H3NmGPsozrpVGIwuHTMp434CzhwMjUMQM3PUlRMQZVFGz4d0ulDnb+N7lZIvVoe4DKwSDu/uKWk0ox1s6zHHsQEGpIphm8zQiZdRpwgAeCbdhlk2Rfg3PyxbWEFEVmTHMKLRZF6jSaK6UGnQFmJzv0qgqf+Zj93I+VzGESQdIehhda6VcPdTQyzv7r7p5oqusVdTWvILFiPfDMr+m26PD7xaCFEwGMg==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2019 06:19:09.4065
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf83097-3933-417e-f23d-08d744a4f06b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4561
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 10:10:26AM +0000, Mihail Atanassov wrote:
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
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_crtc.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/g=
pu/drm/arm/display/komeda/komeda_crtc.c
> index 34bc73ca18bc..d06679afb228 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> @@ -489,6 +489,7 @@ komeda_crtc_atomic_enable(struct drm_crtc *crtc,
>  	pm_runtime_get_sync(crtc->dev->dev);
>  	komeda_crtc_prepare(to_kcrtc(crtc));
>  	drm_crtc_vblank_on(crtc);
> +	WARN_ON(drm_crtc_vblank_get(crtc));
>  	komeda_crtc_do_flush(crtc, old);
>  }
> =20
> @@ -581,6 +582,7 @@ komeda_crtc_atomic_disable(struct drm_crtc *crtc,
>  		komeda_crtc_flush_and_wait_for_flip_done(kcrtc, disable_done);
>  	}
> =20
> +	drm_crtc_vblank_put(crtc);
>  	drm_crtc_vblank_off(crtc);
>  	komeda_crtc_unprepare(kcrtc);
>  	pm_runtime_put(crtc->dev->dev);

Looks good to me.

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>


