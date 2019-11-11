Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E62DC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFCF62196E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cXokiSRG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfKKNiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 08:38:05 -0500
Received: from mail-eopbgr720082.outbound.protection.outlook.com ([40.107.72.82]:44576
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726834AbfKKNiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 08:38:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CX9ncJ3LcPluIUM9pX+e/bEAPOW5v7QRJH5/KiPMAzMVuarr6Xji5/E3xSnAliHaSm/IsEvZJFTaJntNQ6Fkp+87pxkt9QvBM7DLBA77wRjuJuSfIuYi0e9HvQKudz2vdoK1hrsRj7IBOHCyJJaUH1WxLp+5V3BgU1FbkGpfY1KODSP9DtZi54HHNA8qdvzj3Ck8Vt0S0qD6u/gB9BWxtcY+AlArEUAH6p+w/azaXX18HZ6IO1hckaVhWY8/Rzr7iJoj25Y0gnMN//ImEuW5mohxO0SSjEO50PoayIcSA6lqsyghr/tT3YkFtA6tMPpiMK5deD0D8QhwfTz0FS/moA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uj2Qxwf3mbDDRGyd1MWlhc7wK/G4blXWm54Q6HY5Pek=;
 b=kr9fPzQDAzXmkaSHid3lp40pXPqLIAzK3EqPbClIoqjoKjyLPCqBjHOor+kb5DZ8DSJeVdXYOUYkVX8E0mF9VTHkavUi/g632QutLIHd9HGv6jIKzi3jpt7pfKFUKikV/Gt92J18GclfbCTCciDGlMPJOdTTK154RzCcCTv76ngcKPUlXT9K5QPDoG1rICK83aY5ttoo1mfxtdPW0V/2RpvybewM2hczuOH5GmsFxEs9WZput7EO8t70E0cnwAf3nOIw/nZ7iK20aFixnWJ/MLZW7moRO9BECbxD8pHwMg60ZfZIRZ4mh9jUJ8VustzDc9/EFjZAqP3fvdHqKP4ueA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uj2Qxwf3mbDDRGyd1MWlhc7wK/G4blXWm54Q6HY5Pek=;
 b=cXokiSRGRI64x4fkXWnx2MwkPdtrYG88S1B8Lrn1sGkOcKLu7XeDEK+4GeNdfnrI3zTc7DVXovoS0tDSHWMWf4+PTOjfpBKWvR19o8rWMIU+sBcQ2iTpupE44Id+P7kcODO79hXRa3lvps2v9CRrbGcD813zPy+D7YMQnyZ5Xw8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nicholas.Kazlauskas@amd.com; 
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (20.178.197.10) by
 BYAPR12MB2920.namprd12.prod.outlook.com (20.179.93.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Mon, 11 Nov 2019 13:38:01 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::f950:f7be:9139:7c26]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::f950:f7be:9139:7c26%7]) with mapi id 15.20.2408.025; Mon, 11 Nov 2019
 13:38:01 +0000
Subject: Re: [PATCH] drm/amd/display: remove duplicated comparison expression
To:     Colin King <colin.king@canonical.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Charlene Liu <Charlene.Liu@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191109154921.223093-1-colin.king@canonical.com>
From:   "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <0700f347-8590-7ab7-411d-0ae08fe9263d@amd.com>
Date:   Mon, 11 Nov 2019 08:37:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <20191109154921.223093-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTBPR01CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::29) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 29520764-70d2-42a1-531e-08d766ac5eb9
X-MS-TrafficTypeDiagnostic: BYAPR12MB2920:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB29203C87FEB51EDDC90F2A73EC740@BYAPR12MB2920.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 0218A015FA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(189003)(199004)(3846002)(6116002)(2906002)(6436002)(8936002)(81156014)(230700001)(81166006)(229853002)(6486002)(99286004)(8676002)(58126008)(316002)(110136005)(66946007)(6246003)(50466002)(5660300002)(66556008)(66476007)(31686004)(14454004)(478600001)(52116002)(2486003)(23676004)(66066001)(76176011)(65956001)(4326008)(47776003)(65806001)(6666004)(14444005)(25786009)(11346002)(446003)(86362001)(36756003)(31696002)(305945005)(486006)(7736002)(186003)(476003)(6506007)(2616005)(26005)(6512007)(53546011)(386003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2920;H:BYAPR12MB3560.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cnhoeMt1UjS7XOhdbjD7hO8wWTSsN/GlCtNMZnctoZQiKoexS+w+xQ1kXbIxTIxpZ0lVRvapPcBaLIYBM+G2VUovf7/epVikHPqwqMU2c3eyipdXY4kpQHduv3Y9InI2odLXSBjEYg9p8JAjkfGkZSBJrxQ2zAY7pi5h5WUTf36t7YhOn4gVMIWEWJhfEwgc1rDLlDL9GeyKNxnRW+axXMva4dU/HZrUVhKibFiKcugcK3D5WT+9Cp2iGW2SeGy8jlIZt9oxj8LYxAh7OrqDoFezUpJwsJ/zJqkppE4yWefx9wLspYt6LkyOLiEb8HzMIGVQoL0IuHPEnIImzi+21VCXKVDxPEFScTKjx/mMp8/UFD2/D11QPlSf0ISlQpHNErj8ElxSy2jxrq4InmT4zZ5za3j1EWxPeIU0P5W7yZ80oL05eOjsFwg4MgPP5z0d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29520764-70d2-42a1-531e-08d766ac5eb9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2019 13:38:00.9943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: srPZb1CArSf/Ki9QmGi0t29J0n5myVI+EJcS+AKzxghiEXfqF44xWpsEJp3I68VfIh3aw/Lsl2tRc83U/7+5wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2920
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-09 10:49 a.m., Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is comparison expression that is duplicated and hence one
> of the expressions can be removed.  Remove it.
> 
> Addresses-Coverity: ("Same on both sides")
> Fixes: 12e2b2d4c65f ("drm/amd/display: add dcc programming for dual plane")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Thanks!

Nicholas Kazlauskas

> ---
>   drivers/gpu/drm/amd/display/dc/core/dc.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 1fdba13b3d0f..1fa255e077d0 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -1491,7 +1491,6 @@ static enum surface_update_type get_plane_info_update_type(const struct dc_surfa
>   	}
>   
>   	if (u->plane_info->plane_size.surface_pitch != u->surface->plane_size.surface_pitch
> -			|| u->plane_info->plane_size.surface_pitch != u->surface->plane_size.surface_pitch
>   			|| u->plane_info->plane_size.chroma_pitch != u->surface->plane_size.chroma_pitch) {
>   		update_flags->bits.plane_size_change = 1;
>   		elevate_update_type(&update_type, UPDATE_TYPE_MED);
> 

