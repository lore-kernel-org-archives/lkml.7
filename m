Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21D8C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 18:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9203520748
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 18:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OYblEIOj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbfKYSRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 13:17:52 -0500
Received: from mail-eopbgr720082.outbound.protection.outlook.com ([40.107.72.82]:2496
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727832AbfKYSRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 13:17:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3VT7lV7ayJ0HQofIGOzIpO6sm6Il9GEJ+mpEueDUm/FlebdogJfKTB9nfx/YQSb1TQp/qkLYvg6ptP1wSmjD7VSsCiCwhFrLA0o01cKJFBkAaMWd3izjKYXNWv2EI9fiCWPjvptGXuF+Y+nOFvkOsYsKjhkF5kf2r7fsBesaQ1xtMhWx0WkytcXBZHFerUICaSW+wpIIt+25dR+4RFka2XRi2JDrjlMTko3FrpET+8CRhYFvAkVURSV+B5DIUbFma4XO5AAPldiHBHEWlsWDqMHevVv2bo2hAn3gVXxBrwiuiDF/krUshoW0Uo4oMWKCoWcelZ7D9vzBF4WY1C0Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6x45HsbEAwtTDDlxhblZo7TGlNXJMARRv9iJ0YlQ6qY=;
 b=ku/ZoQw+EKTL1Kku8JseTF4mC84pfsKhoVaIq74v9zJG3WScHVE6y78+YZtJAS+qnPPU82xHM5hbu9vaN4+eixE7wlkf+uyBlXBvyZdp9zCKbShb+uhu0KOUYr1kcu10reSEtxJ/+TIdiv12Kk8ZL89I/42b4f+Pz89n81Xr38J1cNvhF8/DVgukF/cQVTlwOoXdWc22WCAm1G9hZJ5uPVf7A+jg43zT+XLVvqhR75570W4pDUz29uGBOlUA3G6YxpzOL7OENv+mTJ71GWoEo2Hus2L8CeD1VETtlAAXYME08QVrK13TRd35AjZ0BkEoSyWVfDVDThgOA3Pk4XmqeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6x45HsbEAwtTDDlxhblZo7TGlNXJMARRv9iJ0YlQ6qY=;
 b=OYblEIOjxH9dtZE147LfIJgIc1vYD5X9yFcxvO01seewD9ShSIqyfwcyDUpgUCXXRv8O6BxyLPM/q2ZXbdH/jzCIr0IH24BcfYV1xQkhs/esyz2QPx1ATvJzevWLPzm1pkTSYiZxsU7NMboqshwera0DnaDEgsBCuCdyBO5nfTI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com (10.172.79.7) by
 CY4PR1201MB0104.namprd12.prod.outlook.com (10.172.78.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.22; Mon, 25 Nov 2019 18:15:01 +0000
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::449d:52a8:2761:9195]) by CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::449d:52a8:2761:9195%5]) with mapi id 15.20.2474.023; Mon, 25 Nov 2019
 18:15:01 +0000
Subject: Re: [PATCH] drm/edid: Add modes from CTA-861-G
To:     Thomas Anderson <thomasanderson@google.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, Daniel Vetter <daniel@ffwll.ch>,
        "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
Cc:     David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20191123055053.154550-1-thomasanderson@google.com>
From:   Harry Wentland <hwentlan@amd.com>
Autocrypt: addr=hwentlan@amd.com; keydata=
 mQENBFhb4C8BCADhHHUNoBQ7K7LupCP0FsUb443Vuqq+dH0uo4A3lnPkMF6FJmGcJ9Sbx1C6
 cd4PbVAaTFZUEmjqfpm+wCRBe11eF55hW3GJ273wvfH69Q/zmAxwO8yk+i5ZWWl8Hns5h69K
 D9QURHLpXxrcwnfHFah0DwV23TrD1KGB7vowCZyJOw93U/GzAlXKESy0FM7ZOYIJH83X7qhh
 Q9KX94iTEYTeH86Wy8hwHtqM6ySviwEz0g+UegpG8ebbz0w3b5QmdKCAg+eZTmBekP5o77YE
 BKqR+Miiwo9+tzm2N5GiF9HDeI2pVe/egOLa5UcmsgdF4Y5FKoMnBbAHNaA6Fev8PHlNABEB
 AAG0J0hhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPokBNwQTAQgAIQUC
 WFvgLwIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRAtWBXJjBS24xUlCAC9MqAlIbZO
 /a37s41h+MQ+D20C6/hVErWO+RA06nA+jFDPUWrDJKYdn6EDQWdLY3ATeAq3X8GIeOTXGrPD
 b2OXD6kOViW/RNvlXdrIsnIDacdr39aoAlY1b+bhTzZVz4pto4l+K1PZb5jlMgTk/ks9HesL
 RfYVq5wOy3qIpocdjdlXnSUKn0WOkGBBd8Nv3o0OI18tiJ1S/QwLBBfZoVvfGinoB2p4j/wO
 kJxpi3F9TaOtLGcdrgfghg31Fb48DP+6kodZ4ircerp4hyAp0U2iKtsrQ/sVWR4mbe3eTfcn
 YjBxGd2JOVdNQZa2VTNf9GshIDMD8IIQK6jN0LfY8Py2uQENBFhb4C8BCAC/0KWY3pIbU2cy
 i7GMj3gqB6h0jGqRuMpMRoSNDoAUIuSh17w+bawuOF6XZPdK3D4lC9cOXMwP3aP9tTJOori2
 8vMH8KW9jp9lAYnGWYhSqLdjzIACquMqi96EBtawJDct1e9pVgp+d4JXHlgIrl11ITJo8rCP
 dEqjro2bCBWxijsIncdCzMjf57+nR7u86SBtGSFcXKapS7YJeWcvM6MzFYgIkxHxxBDvBBvm
 U2/mAXiL72kwmlV1BNrabQxX2UnIb3xt3UovYJehrnDUMdYjxJgSPRBx27wQ/D05xAlhkmmL
 FJ01ZYc412CRCC6gjgFPfUi2y7YJTrQHS79WSyANABEBAAGJAR8EGAEIAAkFAlhb4C8CGwwA
 CgkQLVgVyYwUtuM72Qf+J6JOQ/27pWf5Ulde9GS0BigA1kV9CNfIq396TgvQzeyixHMvgPdq
 Z36x89zZi0otjMZv6ypIdEg5co1Bvz0wFaKbCiNbTjpnA1VAbQVLSFjCZLQiu0vc+BZ1yKDV
 T5ASJ97G4XvQNO+XXGY55MrmhoNqMaeIa/3Jas54fPVd5olcnUAyDty29/VWXNllUq38iBCX
 /0tTF7oav1lzPGfeW2c6B700FFZMTR4YBVSGE8jPIzu2Fj0E8EkDmsgS+nibqSvWXfo1v231
 410h35CjbYDlYQO7Z1YD7asqbaOnF0As+rckyRMweQ9CxZn5+YBijtPJA3x5ldbCfQ9rWiTu XQ==
Message-ID: <fcba3169-13a1-6368-60c6-bfc9d9ad62c1@amd.com>
Date:   Mon, 25 Nov 2019 13:14:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20191123055053.154550-1-thomasanderson@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTXPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::39) To CY4PR1201MB0230.namprd12.prod.outlook.com
 (2603:10b6:910:1e::7)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1aa22d12-51c7-4f5a-646b-08d771d362bb
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0104:|CY4PR1201MB0104:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0104A5C018A751CEE48CE8358C4A0@CY4PR1201MB0104.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0232B30BBC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(199004)(189003)(30864003)(66066001)(65956001)(65806001)(66946007)(5660300002)(47776003)(7736002)(66556008)(66476007)(81156014)(81166006)(6512007)(229853002)(6486002)(316002)(6436002)(230700001)(36756003)(99286004)(8936002)(110136005)(4326008)(14454004)(58126008)(6666004)(8676002)(6636002)(478600001)(186003)(52116002)(23676004)(76176011)(2486003)(4001150100001)(31696002)(2616005)(11346002)(446003)(6246003)(3846002)(6116002)(305945005)(31686004)(2906002)(386003)(53546011)(26005)(25786009)(50466002)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR1201MB0104;H:CY4PR1201MB0230.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V/GzV0+H5v8BbgIwO9gxbpKDRQkNvIye123RbwUg9k1hnIzEuicEVA0zHLzBdDUiofyQZMRBFEbUt/k4QCdINaRLxYzupgQKbmJS83IVv1/4QU9HNpBtelSrPTj3EiWT9a8FlqTdAYjHxkbeZsWThsI+WyuxkS0pArszArIOKgQHoYlshVUvLuym4WiL4Z8xx6PCd4qmPL/I+HGX/bbA0NKNz4OqESUUUFcMmeJpsoABcXqHL2ovbnwu087jwFj8l4b2ZF4Nl76l7iXMwojAl6mEhbzPk/f5UkKz0oA/Gdsp5OU4X40RCxRR5iOyMBA/LILsAotFEP4/52xMScXMvCM1L8iFu2FaGODmX6YUgBnALyHxgmV9d4EM8RqVxt/d5IcwvEEmuRn7YkDnfMk0kCJ+6cnY8dkjUkVJGNeJ48Sq2U76oH3+ThDKgi0RPiBy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa22d12-51c7-4f5a-646b-08d771d362bb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2019 18:15:01.1057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oS+hS7LwB3WDFrj9PInqllfAwknFBaK77dRMx/c+ocB4zLtn6pRCKN783EPs7W7OnuiVm/8y1E5kN0mJ54SUjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Bhawan who has been looking at this from our side.

Harry

On 2019-11-23 12:50 a.m., Thomas Anderson wrote:
> The new modes are needed for exotic displays such as 8K. Verified that
> modes like 8K60 and 4K120 are properly obtained from a Samsung Q900R.
> 
> Signed-off-by: Thomas Anderson <thomasanderson@google.com>
> ---
>  drivers/gpu/drm/drm_edid.c  | 388 +++++++++++++++++++++++++++++++++++-
>  include/drm/drm_connector.h |  16 +-
>  2 files changed, 391 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 6b0177112e18..ff5c928516fb 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -1278,6 +1278,374 @@ static const struct drm_display_mode edid_cea_modes[] = {
>  		   4104, 4400, 0, 2160, 2168, 2178, 2250, 0,
>  		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
>  	  .vrefresh = 60, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> +	/* 108 - 1280x720@48Hz 16:9 */
> +	{ DRM_MODE("1280x720", DRM_MODE_TYPE_DRIVER, 90000, 1280, 2240,
> +		   2280, 2500, 0, 720, 725, 730, 750, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 48, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
> +	/* 109 - 1280x720@48Hz 64:27 */
> +	{ DRM_MODE("1280x720", DRM_MODE_TYPE_DRIVER, 90000, 1280, 2240,
> +		   2280, 2500, 0, 720, 725, 730, 750, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 48, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> +	/* 110 - 1680x720@48Hz 64:27 */
> +	{ DRM_MODE("1680x720", DRM_MODE_TYPE_DRIVER, 99000, 1680, 2490,
> +		   2530, 2750, 0, 720, 725, 730, 750, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 48, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> +	/* 111 - 1920x1080@48Hz 16:9 */
> +	{ DRM_MODE("1920x1080", DRM_MODE_TYPE_DRIVER, 148500, 1920, 2558,
> +		   2602, 2750, 0, 1080, 1084, 1089, 1125, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 48, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
> +	/* 112 - 1920x1080@48Hz 64:27 */
> +	{ DRM_MODE("1920x1080", DRM_MODE_TYPE_DRIVER, 148500, 1920, 2558,
> +		   2602, 2750, 0, 1080, 1084, 1089, 1125, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 48, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> +	/* 113 - 2560x1080@48Hz 64:27 */
> +	{ DRM_MODE("2560x1080", DRM_MODE_TYPE_DRIVER, 198000, 2560, 3558,
> +		   3602, 3750, 0, 1080, 1084, 1089, 1100, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 48, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> +	/* 114 - 3840x2160@48Hz 16:9 */
> +	{ DRM_MODE("3840x2160", DRM_MODE_TYPE_DRIVER, 594000, 3840, 5116,
> +		   5204, 5500, 0, 2160, 2168, 2178, 2250, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 48, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
> +	/* 115 - 4096x2160@48Hz 256:135 */
> +	{ DRM_MODE("4096x2160", DRM_MODE_TYPE_DRIVER, 594000, 4096, 5116,
> +		   5204, 5500, 0, 2160, 2168, 2178, 2250, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 48,
> +	  .picture_aspect_ratio = HDMI_PICTURE_ASPECT_256_135, },
> +	/* 116 - 3840x2160@48Hz 64:27 */
> +	{ DRM_MODE("3840x2160", DRM_MODE_TYPE_DRIVER, 594000, 3840, 5116,
> +		   5204, 5500, 0, 2160, 2168, 2178, 2250, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 48, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> +	/* 117 - 3840x2160@100Hz 16:9 */
> +	{ DRM_MODE("3840x2160", DRM_MODE_TYPE_DRIVER, 1188000, 3840, 4896,
> +		   4984, 5280, 0, 2160, 2168, 2178, 2250, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 100, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
> +	/* 118 - 3840x2160@120Hz 16:9 */
> +	{ DRM_MODE("3840x2160", DRM_MODE_TYPE_DRIVER, 1188000, 3840, 4016,
> +		   4104, 4400, 0, 2160, 2168, 2178, 2250, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 120, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
> +	/* 119 - 3840x2160@100Hz 64:27 */
> +	{ DRM_MODE("3840x2160", DRM_MODE_TYPE_DRIVER, 1188000, 3840, 4896,
> +		   4984, 5280, 0, 2160, 2168, 2178, 2250, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 100, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> +	/* 120 - 3840x2160@120Hz 64:27 */
> +	{ DRM_MODE("3840x2160", DRM_MODE_TYPE_DRIVER, 1188000, 3840, 4016,
> +		   4104, 4400, 0, 2160, 2168, 2178, 2250, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 120, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> +	/* 121 - 5120x2160@24Hz 64:27 */
> +	{ DRM_MODE("5120x2160", DRM_MODE_TYPE_DRIVER, 396000, 5120, 7116,
> +		   7204, 7500, 0, 2160, 2168, 2178, 2200, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 24, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> +	/* 122 - 5120x2160@25Hz 64:27 */
> +	{ DRM_MODE("5120x2160", DRM_MODE_TYPE_DRIVER, 396000, 5120, 6816,
> +		   6904, 7200, 0, 2160, 2168, 2178, 2200, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 25, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> +	/* 123 - 5120x2160@30Hz 64:27 */
> +	{ DRM_MODE("5120x2160", DRM_MODE_TYPE_DRIVER, 396000, 5120, 5784,
> +		   5872, 6000, 0, 2160, 2168, 2178, 2200, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 30, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> +	/* 124 - 5120x2160@48Hz 64:27 */
> +	{ DRM_MODE("5120x2160", DRM_MODE_TYPE_DRIVER, 742500, 5120, 5866,
> +		   5954, 6250, 0, 2160, 2168, 2178, 2475, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 48, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> +	/* 125 - 5120x2160@50Hz 64:27 */
> +	{ DRM_MODE("5120x2160", DRM_MODE_TYPE_DRIVER, 742500, 5120, 6216,
> +		   6304, 6600, 0, 2160, 2168, 2178, 2250, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 50, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> +	/* 126 - 5120x2160@60Hz 64:27 */
> +	{ DRM_MODE("5120x2160", DRM_MODE_TYPE_DRIVER, 742500, 5120, 5284,
> +		   5372, 5500, 0, 2160, 2168, 2178, 2250, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 60, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> +	/* 127 - 5120x2160@100Hz 64:27 */
> +	{ DRM_MODE("5120x2160", DRM_MODE_TYPE_DRIVER, 1485000, 5120, 6216,
> +		   6304, 6600, 0, 2160, 2168, 2178, 2250, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 100, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> +	/* 128 - dummy */
> +	{ },
> +	/* 129 - reserved for native timing 1 */
> +	{ },
> +	/* 130 - reserved for native timing 2 */
> +	{ },
> +	/* 131 - reserved for native timing 3 */
> +	{ },
> +	/* 132 - reserved for native timing 4 */
> +	{ },
> +	/* 133 - reserved for native timing 5 */
> +	{ },
> +	/* 134 - reserved for native timing 6 */
> +	{ },
> +	/* 135 - reserved for native timing 7 */
> +	{ },
> +	/* 136 - reserved for native timing 8 */
> +	{ },
> +	/* 137 - reserved for native timing 9 */
> +	{ },
> +	/* 138 - reserved for native timing 10 */
> +	{ },
> +	/* 139 - reserved for native timing 11 */
> +	{ },
> +	/* 140 - reserved for native timing 12 */
> +	{ },
> +	/* 141 - reserved for native timing 13 */
> +	{ },
> +	/* 142 - reserved for native timing 14 */
> +	{ },
> +	/* 143 - reserved for native timing 15 */
> +	{ },
> +	/* 144 - reserved for native timing 16 */
> +	{ },
> +	/* 145 - reserved for native timing 17 */
> +	{ },
> +	/* 146 - reserved for native timing 18 */
> +	{ },
> +	/* 147 - reserved for native timing 19 */
> +	{ },
> +	/* 148 - reserved for native timing 20 */
> +	{ },
> +	/* 149 - reserved for native timing 21 */
> +	{ },
> +	/* 150 - reserved for native timing 22 */
> +	{ },
> +	/* 151 - reserved for native timing 23 */
> +	{ },
> +	/* 152 - reserved for native timing 24 */
> +	{ },
> +	/* 153 - reserved for native timing 25 */
> +	{ },
> +	/* 154 - reserved for native timing 26 */
> +	{ },
> +	/* 155 - reserved for native timing 27 */
> +	{ },
> +	/* 156 - reserved for native timing 28 */
> +	{ },
> +	/* 157 - reserved for native timing 29 */
> +	{ },
> +	/* 158 - reserved for native timing 30 */
> +	{ },
> +	/* 159 - reserved for native timing 31 */
> +	{ },
> +	/* 160 - reserved for native timing 32 */
> +	{ },
> +	/* 161 - reserved for native timing 33 */
> +	{ },
> +	/* 162 - reserved for native timing 34 */
> +	{ },
> +	/* 163 - reserved for native timing 35 */
> +	{ },
> +	/* 164 - reserved for native timing 36 */
> +	{ },
> +	/* 165 - reserved for native timing 37 */
> +	{ },
> +	/* 166 - reserved for native timing 38 */
> +	{ },
> +	/* 167 - reserved for native timing 39 */
> +	{ },
> +	/* 168 - reserved for native timing 40 */
> +	{ },
> +	/* 169 - reserved for native timing 41 */
> +	{ },
> +	/* 170 - reserved for native timing 42 */
> +	{ },
> +	/* 171 - reserved for native timing 43 */
> +	{ },
> +	/* 172 - reserved for native timing 44 */
> +	{ },
> +	/* 173 - reserved for native timing 45 */
> +	{ },
> +	/* 174 - reserved for native timing 46 */
> +	{ },
> +	/* 175 - reserved for native timing 47 */
> +	{ },
> +	/* 176 - reserved for native timing 48 */
> +	{ },
> +	/* 177 - reserved for native timing 49 */
> +	{ },
> +	/* 178 - reserved for native timing 50 */
> +	{ },
> +	/* 179 - reserved for native timing 51 */
> +	{ },
> +	/* 180 - reserved for native timing 52 */
> +	{ },
> +	/* 181 - reserved for native timing 53 */
> +	{ },
> +	/* 182 - reserved for native timing 54 */
> +	{ },
> +	/* 183 - reserved for native timing 55 */
> +	{ },
> +	/* 184 - reserved for native timing 56 */
> +	{ },
> +	/* 185 - reserved for native timing 57 */
> +	{ },
> +	/* 186 - reserved for native timing 58 */
> +	{ },
> +	/* 187 - reserved for native timing 59 */
> +	{ },
> +	/* 188 - reserved for native timing 60 */
> +	{ },
> +	/* 189 - reserved for native timing 61 */
> +	{ },
> +	/* 190 - reserved for native timing 62 */
> +	{ },
> +	/* 191 - reserved for native timing 63 */
> +	{ },
> +	/* 192 - reserved for native timing 64 */
> +	{ },
> +	/* 193 - 5120x2160@120Hz 64:27 */
> +	{ DRM_MODE("5120x2160", DRM_MODE_TYPE_DRIVER, 1485000, 5120, 5284,
> +		   5372, 5500, 0, 2160, 2168, 2178, 2250, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 120, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> +	/* 194 - 7680x4320@24Hz 16:9 */
> +	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 1188000, 7680, 10232,
> +		   10408, 11000, 0, 4320, 4336, 4356, 4500, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 24, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
> +	/* 195 - 7680x4320@25Hz 16:9 */
> +	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 1188000, 7680, 10032,
> +		   10208, 10800, 0, 4320, 4336, 4356, 4400, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 25, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
> +	/* 196 - 7680x4320@30Hz 16:9 */
> +	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 1188000, 7680, 8232,
> +		   8408, 9000, 0, 4320, 4336, 4356, 4400, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 30, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
> +	/* 197 - 7680x4320@48Hz 16:9 */
> +	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 2376000, 7680, 10232,
> +		   10408, 11000, 0, 4320, 4336, 4356, 4500, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 48, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
> +	/* 198 - 7680x4320@50Hz 16:9 */
> +	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 2376000, 7680, 10032,
> +		   10208, 10800, 0, 4320, 4336, 4356, 4400, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 50, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
> +	/* 199 - 7680x4320@60Hz 16:9 */
> +	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 2376000, 7680, 8232,
> +		   8408, 9000, 0, 4320, 4336, 4356, 4400, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 60, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
> +	/* 200 - 7680x4320@100Hz 16:9 */
> +	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 4752000, 7680, 9792,
> +		   9968, 10560, 0, 4320, 4336, 4356, 4500, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 100, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
> +	/* 201 - 7680x4320@120Hz 16:9 */
> +	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 4752000, 7680, 8032,
> +		   8208, 8800, 0, 4320, 4336, 4356, 4500, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 120, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
> +	/* 202 - 7680x4320@24Hz 64:27 */
> +	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 1188000, 7680, 10232,
> +		   10408, 11000, 0, 4320, 4336, 4356, 4500, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 24, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> +	/* 203 - 7680x4320@25Hz 64:27 */
> +	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 1188000, 7680, 10032,
> +		   10208, 10800, 0, 4320, 4336, 4356, 4400, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 25, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> +	/* 204 - 7680x4320@30Hz 64:27 */
> +	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 1188000, 7680, 8232,
> +		   8408, 9000, 0, 4320, 4336, 4356, 4400, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 30, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> +	/* 205 - 7680x4320@48Hz 64:27 */
> +	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 2376000, 7680, 10232,
> +		   10408, 11000, 0, 4320, 4336, 4356, 4500, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 48, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> +	/* 206 - 7680x4320@50Hz 64:27 */
> +	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 2376000, 7680, 10032,
> +		   10208, 10800, 0, 4320, 4336, 4356, 4400, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 50, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> +	/* 207 - 7680x4320@60Hz 64:27 */
> +	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 2376000, 7680, 8232,
> +		   8408, 9000, 0, 4320, 4336, 4356, 4400, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 60, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> +	/* 208 - 7680x4320@100Hz 64:27 */
> +	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 4752000, 7680, 9792,
> +		   9968, 10560, 0, 4320, 4336, 4356, 4500, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 100, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> +	/* 209 - 7680x4320@120Hz 64:27 */
> +	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 4752000, 7680, 8032,
> +		   8208, 8800, 0, 4320, 4336, 4356, 4500, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 120, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> +	/* 210 - 10240x4320@24Hz 64:27 */
> +	{ DRM_MODE("10240x4320", DRM_MODE_TYPE_DRIVER, 1485000, 10240, 11732,
> +		   11908, 12500, 0, 4320, 4336, 4356, 4950, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 24, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> +	/* 211 - 10240x4320@25Hz 64:27 */
> +	{ DRM_MODE("10240x4320", DRM_MODE_TYPE_DRIVER, 1485000, 10240, 12732,
> +		   12908, 13500, 0, 4320, 4336, 4356, 4400, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 25, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> +	/* 212 - 10240x4320@30Hz 64:27 */
> +	{ DRM_MODE("10240x4320", DRM_MODE_TYPE_DRIVER, 1485000, 10240, 10528,
> +		   10704, 11000, 0, 4320, 4336, 4356, 4500, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 30, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> +	/* 213 - 10240x4320@48Hz 64:27 */
> +	{ DRM_MODE("10240x4320", DRM_MODE_TYPE_DRIVER, 2970000, 10240, 11732,
> +		   11908, 12500, 0, 4320, 4336, 4356, 4950, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 48, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> +	/* 214 - 10240x4320@50Hz 64:27 */
> +	{ DRM_MODE("10240x4320", DRM_MODE_TYPE_DRIVER, 2970000, 10240, 12732,
> +		   12908, 13500, 0, 4320, 4336, 4356, 4400, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 50, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> +	/* 215 - 10240x4320@60Hz 64:27 */
> +	{ DRM_MODE("10240x4320", DRM_MODE_TYPE_DRIVER, 2970000, 10240, 10528,
> +		   10704, 11000, 0, 4320, 4336, 4356, 4500, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 60, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> +	/* 216 - 10240x4320@100Hz 64:27 */
> +	{ DRM_MODE("10240x4320", DRM_MODE_TYPE_DRIVER, 5940000, 10240, 12432,
> +		   12608, 13200, 0, 4320, 4336, 4356, 4500, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 100, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> +	/* 217 - 10240x4320@120Hz 64:27 */
> +	{ DRM_MODE("10240x4320", DRM_MODE_TYPE_DRIVER, 5940000, 10240, 10528,
> +		   10704, 11000, 0, 4320, 4336, 4356, 4500, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 120, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> +	/* 218 - 4096x2160@100Hz 256:135 */
> +	{ DRM_MODE("4096x2160", DRM_MODE_TYPE_DRIVER, 1188000, 4096, 4896,
> +		   4984, 5280, 0, 2160, 2168, 2178, 2250, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 100,
> +	  .picture_aspect_ratio = HDMI_PICTURE_ASPECT_256_135, },
> +	/* 219 - 4096x2160@120Hz 256:135 */
> +	{ DRM_MODE("4096x2160", DRM_MODE_TYPE_DRIVER, 1188000, 4096, 4184,
> +		   4272, 4400, 0, 2160, 2168, 2178, 2250, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 120,
> +	  .picture_aspect_ratio = HDMI_PICTURE_ASPECT_256_135, },
>  };
>  
>  /*
> @@ -3030,6 +3398,12 @@ cea_mode_alternate_timings(u8 vic, struct drm_display_mode *mode)
>  	return false;
>  }
>  
> +static bool drm_valid_cea_vic(u8 vic)
> +{
> +	return (vic > 0 && vic < 128) ||
> +	       (vic > 192 && vic < ARRAY_SIZE(edid_cea_modes));
> +}
> +
>  static u8 drm_match_cea_mode_clock_tolerance(const struct drm_display_mode *to_match,
>  					     unsigned int clock_tolerance)
>  {
> @@ -3046,6 +3420,9 @@ static u8 drm_match_cea_mode_clock_tolerance(const struct drm_display_mode *to_m
>  		struct drm_display_mode cea_mode = edid_cea_modes[vic];
>  		unsigned int clock1, clock2;
>  
> +		if (!drm_valid_cea_vic(vic))
> +			continue;
> +
>  		/* Check both 60Hz and 59.94Hz */
>  		clock1 = cea_mode.clock;
>  		clock2 = cea_mode_alternate_clock(&cea_mode);
> @@ -3085,6 +3462,9 @@ u8 drm_match_cea_mode(const struct drm_display_mode *to_match)
>  		struct drm_display_mode cea_mode = edid_cea_modes[vic];
>  		unsigned int clock1, clock2;
>  
> +		if (!drm_valid_cea_vic(vic))
> +			continue;
> +
>  		/* Check both 60Hz and 59.94Hz */
>  		clock1 = cea_mode.clock;
>  		clock2 = cea_mode_alternate_clock(&cea_mode);
> @@ -3103,11 +3483,6 @@ u8 drm_match_cea_mode(const struct drm_display_mode *to_match)
>  }
>  EXPORT_SYMBOL(drm_match_cea_mode);
>  
> -static bool drm_valid_cea_vic(u8 vic)
> -{
> -	return vic > 0 && vic < ARRAY_SIZE(edid_cea_modes);
> -}
> -
>  /**
>   * drm_get_cea_aspect_ratio - get the picture aspect ratio corresponding to
>   * the input VIC from the CEA mode list
> @@ -3117,6 +3492,9 @@ static bool drm_valid_cea_vic(u8 vic)
>   */
>  enum hdmi_picture_aspect drm_get_cea_aspect_ratio(const u8 video_code)
>  {
> +	if (!drm_valid_cea_vic(video_code))
> +		return HDMI_PICTURE_ASPECT_NONE;
> +
>  	return edid_cea_modes[video_code].picture_aspect_ratio;
>  }
>  EXPORT_SYMBOL(drm_get_cea_aspect_ratio);
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 681cb590f952..0a90efa0246e 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -188,19 +188,19 @@ struct drm_hdmi_info {
>  
>  	/**
>  	 * @y420_vdb_modes: bitmap of modes which can support ycbcr420
> -	 * output only (not normal RGB/YCBCR444/422 outputs). There are total
> -	 * 107 VICs defined by CEA-861-F spec, so the size is 128 bits to map
> -	 * upto 128 VICs;
> +	 * output only (not normal RGB/YCBCR444/422 outputs). The max VIC
> +	 * defined by the CEA-861-G spec is 219, so the size is 256 bits to map
> +	 * upto 256 VICs.
>  	 */
> -	unsigned long y420_vdb_modes[BITS_TO_LONGS(128)];
> +	unsigned long y420_vdb_modes[BITS_TO_LONGS(256)];
>  
>  	/**
>  	 * @y420_cmdb_modes: bitmap of modes which can support ycbcr420
> -	 * output also, along with normal HDMI outputs. There are total 107
> -	 * VICs defined by CEA-861-F spec, so the size is 128 bits to map upto
> -	 * 128 VICs;
> +	 * output also, along with normal HDMI outputs. The max VIC defined by
> +	 * the CEA-861-G spec is 219, so the size is 256 bits to map upto 256
> +	 * VICs.
>  	 */
> -	unsigned long y420_cmdb_modes[BITS_TO_LONGS(128)];
> +	unsigned long y420_cmdb_modes[BITS_TO_LONGS(256)];
>  
>  	/** @y420_cmdb_map: bitmap of SVD index, to extraxt vcb modes */
>  	u64 y420_cmdb_map;
> 
