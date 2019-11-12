Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADAAC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E8C21872
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oN7K1Rul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfKLUSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 15:18:53 -0500
Received: from mail-eopbgr740085.outbound.protection.outlook.com ([40.107.74.85]:54519
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726008AbfKLUSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 15:18:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFrmW0D4M3IQ5iG0BW5GoHf3CUNp1c6bb1G0flkQEnBe54JX890sbHS17JVcLrZ2xFTLm68knftvKv5robnjnWs56oeGhYBCmbOTIlQBueyq9TuMAoLh2BQXT92Fy1uDjWQoqwO3VcUJddJ5YGXragEZqjoRk/MsmsfGJhxG+dak2mfY7Wojrw2XZ7GV45GDuatUG8aiFD9lqcDd/2nM04gDVqxw3+vDT83EvcorjtaISSiL/JtGfId7lMvHId6Zg7IhuJHSaA4VXrE/sUOylPKZb35HJMpc950h4SSLla/JesCIbA22+phvIzyD6l6S7wsDO7XXR+7SeihnyGFVsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2ncUVZCmHAFEw+E2I3Zad27MSN+In1QbjbiDofyZCs=;
 b=QlRhwV2sq46FYKQ276HiSTszEO7kOfkS56F//5mCeuOExODhlB0LlyFvRPkz7j7IDFJMPf+ImctXDDAaZt1yTtuBoiCtFWA3yy6wsSu37+FzIjYpOXRlgbgdvpgQZg+nfhoL2bpu2RLuD/Lqwh+2PHyAmd7SOTSD0H9yFCkUdVke2tpXiAPCmRRnh7a1No7ecZIHy0Nwo/+jzHvykYgT5P9rZJbKM8po85AvcdsPhbxUthAb8le6ZK3tvIKETbLAQ0dwKkTjdg3d+7gp1Q74zwtW8SWvhDFJzdK+bDbQjSds3BxioCvbBee6F9HrhOEsP8ty9Va5mw8zwh7CTFl8qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2ncUVZCmHAFEw+E2I3Zad27MSN+In1QbjbiDofyZCs=;
 b=oN7K1RulAb9cZ+ebn1b2i6o3D1xF7S8mUqNWum6z8fU6snOzVKYLanZj/OjyWqfMj+7HaTnvzK+d77U+d8PkDgO2F5E8yX6Lau1CNtThRLcC2SaTxqc9lxUz+qod/2f3C9vv6zcvWF2rFy/mW3uP+m5yEmDUCZhy26hD70oSmqM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com (10.172.79.7) by
 CY4PR1201MB0216.namprd12.prod.outlook.com (10.172.76.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Tue, 12 Nov 2019 20:18:48 +0000
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::449d:52a8:2761:9195]) by CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::449d:52a8:2761:9195%5]) with mapi id 15.20.2451.023; Tue, 12 Nov 2019
 20:18:48 +0000
Subject: Re: [PATCH -next] drm/amd/display: Fix old-style declaration
To:     YueHaibing <yuehaibing@huawei.com>, harry.wentland@amd.com,
        sunpeng.li@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, Bhawanpreet.Lakha@amd.com, Jun.Lei@amd.com,
        David.Francis@amd.com, Dmytro.Laktyushkin@amd.com,
        nicholas.kazlauskas@amd.com, martin.leung@amd.com,
        Chris.Park@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20191111122801.18584-1-yuehaibing@huawei.com>
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
Message-ID: <6172e74c-6e85-f904-4284-2ebf9a308d4d@amd.com>
Date:   Tue, 12 Nov 2019 15:18:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
In-Reply-To: <20191111122801.18584-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTBPR01CA0028.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::41) To CY4PR1201MB0230.namprd12.prod.outlook.com
 (2603:10b6:910:1e::7)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 947e170a-c5e0-40e5-c739-08d767ad862e
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0216:|CY4PR1201MB0216:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB02166CAF5892CAED6C20C2ED8C770@CY4PR1201MB0216.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(199004)(189003)(66556008)(81156014)(8676002)(66476007)(81166006)(8936002)(36756003)(99286004)(4001150100001)(58126008)(316002)(2486003)(5660300002)(23676004)(52116002)(6666004)(31696002)(4744005)(25786009)(14444005)(66946007)(6246003)(4326008)(6506007)(305945005)(53546011)(6512007)(229853002)(230700001)(11346002)(50466002)(446003)(7736002)(26005)(3846002)(386003)(14454004)(478600001)(47776003)(31686004)(6636002)(6486002)(76176011)(2906002)(65806001)(65956001)(486006)(66066001)(2616005)(476003)(6116002)(6436002)(186003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR1201MB0216;H:CY4PR1201MB0230.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JVFuRQGbMvOhPnkHa0CMBUGakRYjgzalPsCR1lUWNAxZeL8a0W15ZCA2IDCfbPDCUSdO24R39iQkWQlHVMJhc830sIMW+QTJaDZ4+2gDncrkt92fK/09yoD/iax0sS53pm9RwJI0CW1kIButWuZPrXhyCrVxWV+JoKe0redOvpKv08dSLnH7Nd7MnQn8qhqGHaqqXltMd2oWk4ZohVp20M4SoTv+LPnBPdiuDjj4YosVrlinNBnoqxWgcQ9i4iRVnShvSRVKVG/h+9P/PR5w4CPWRT3RCPC7bP6sD04g3d3L+9j18TJuCvk9j6QqBOL//AVlASTr8wGQ89GNmR2d7qFdX19uAFwp7VM3QZbOMEtOkkeVk2XDD8x/F0cR0pOuOHUMZW5nikP8XE0oWC1yVcHb+jN+bdNHxLvtLsGz8nhD26IrNDhyfOAKH4sS3h+j
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 947e170a-c5e0-40e5-c739-08d767ad862e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 20:18:47.9927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RUtl9MCCSMLCFk3PAQTSjFr5Hg7Hjpau0jXz7fL4p2DUW+BEyih36migHQ2fOvjkt9qT7Ng+KjlRyBNmquAxSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0216
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-11 7:28 a.m., YueHaibing wrote:
> Fix a build warning:
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:75:1:
>  warning: 'static' is not at beginning of declaration [-Wold-style-declaration]
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 1fdba13..0d8c663 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -69,7 +69,7 @@
>  #define DC_LOGGER \
>  	dc->ctx->logger
>  
> -const static char DC_BUILD_ID[] = "production-build";
> +static const char DC_BUILD_ID[] = "production-build";
>  
>  /**
>   * DOC: Overview
> 
