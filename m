Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEA8C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4BDB2196E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wvGNcApP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfKKNhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 08:37:48 -0500
Received: from mail-eopbgr690074.outbound.protection.outlook.com ([40.107.69.74]:52750
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726834AbfKKNhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 08:37:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ci9mzfIET5HmE9gHa6go6YqlV2iytBlq91/10Zpl5WtEdLokjHOg5NjAnfhJ+uun2YyWbGLVoLoAW+tWtXtOg+dBT9hRRi+7SnEDUAxaXdw2mPuP8iaQl6MIe1O2t8TeWRI5iUmjLo2h17uaV/NrkroVm/RFmndk2wjByLLdaoh1bSV/Pwg7Sfe3Wu/d7LD66jWKfUWNLn3DbxahHNilHOOrXufpXYJQk2qoAROph8UgCN4R7PLoNCKzAjpMaXl6R/SpbhHtY1qInBOQTxOLiQ1O1P7jcynKM/CeDpiSYw3n8pJjag9hzlI6HNyTL807MJo2ViTcMtDWnt0vtw6txg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHUQCWUslgICn8KAxgJOIo8qG3oXQB+1PYLIhSfNOh8=;
 b=AcLD7tzASFByj623gcF2uUq1AHE7FLI4xl5M1YvFaBGTENhrnjG4Nq+z4yWW7DVghTEITsQxJO8hGvXBlDmvOHas64lsLqlY+F8wqzbz4yxNsKB4BHYz8oSUGBaphZcM8mKTYX6VD1KWpCNFyq7f2qPicZR8VCIxjQDzJrCI+vc4aK701xEN2SbzG5WQaJZC1+UraacsFdC6Wf/uO7icLkLffO+fKlTRSZkLRQ/U6afpy+/0t4wWiTNm8hBkr4Y5udcuAIrrrTYI6ifgvnqfgLLSLUwHz8oy989QEye6N6SaweYkCc5442YrIPPI6CDVtJtDOHs1OnYkzm2fM4zuiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHUQCWUslgICn8KAxgJOIo8qG3oXQB+1PYLIhSfNOh8=;
 b=wvGNcApPkjd0O0PUsJoCHU/NAcLQLRD0tKg81+woUgTZVLtbQsJRi691GoInfqU2xICE6EQmMc65fh2hynDL5wknQJIix+L8wrzd39ekKy6WnY9ZaOjMwMAic0x0A38gYqVsuVEtvKiIqITlDbDC2QuRuv/Z/zkWHfkrT4VGi5s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nicholas.Kazlauskas@amd.com; 
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (20.178.197.10) by
 BYAPR12MB2920.namprd12.prod.outlook.com (20.179.93.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Mon, 11 Nov 2019 13:37:43 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::f950:f7be:9139:7c26]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::f950:f7be:9139:7c26%7]) with mapi id 15.20.2408.025; Mon, 11 Nov 2019
 13:37:36 +0000
Subject: Re: [PATCH][next] drm/amd/display: fix spelling mistake "exeuction"
 -> "execution"
To:     Colin King <colin.king@canonical.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191109194923.231655-1-colin.king@canonical.com>
From:   "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <633bbabf-56d4-ad4a-9d4e-9562e7122d17@amd.com>
Date:   Mon, 11 Nov 2019 08:37:31 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <20191109194923.231655-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::42)
 To BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c8826c81-70be-4524-6303-08d766ac501d
X-MS-TrafficTypeDiagnostic: BYAPR12MB2920:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2920FDE24EC60807E806F8B1EC740@BYAPR12MB2920.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0218A015FA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(189003)(199004)(3846002)(6116002)(2906002)(6436002)(8936002)(81156014)(230700001)(81166006)(229853002)(6486002)(99286004)(8676002)(58126008)(316002)(110136005)(66946007)(6246003)(50466002)(5660300002)(66556008)(66476007)(31686004)(14454004)(478600001)(52116002)(2486003)(23676004)(66066001)(76176011)(65956001)(4326008)(47776003)(65806001)(6666004)(25786009)(11346002)(446003)(86362001)(36756003)(31696002)(305945005)(486006)(7736002)(186003)(476003)(6506007)(2616005)(26005)(6512007)(53546011)(386003)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2920;H:BYAPR12MB3560.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A5q2r1zA7tgqVkQmv7BCmm9pNKSB+39nwhhr2AHJ4PLr6qB6nbttNofGUAO5ead5+gABwHOF+N5rc17Pvl/ao6ZLJC7XfvbNGSyhclQ7UlHvRwK6eAZH/gvtv8AmjFPp5WOerwWwqKyHmc6Ke9F6wWGaTovnTDpStEKi5I1HPWsP+XZ2C+xlj/TZR6V3PgJxMim76ElEuPl+TsG4MPA9U9ta42WebBJ6QdBVWfSKiDwP2vqXfPdG/lcUaNLAR0CB9Ns/tqfGLQE7cKcdUqCWjZTECBUSuULQeWOQFiDR8BKW0ZGrOvzWeY5r1/uCbwiTHQ6CArlrytiP+IlATdp5GCh3pdWbDLadUzqPoqbGdSTiXTQHAmqTfg8wVIEKUvEmknKxRnF0SUUEOhNTbT8jBqNum179IKagiQrUazJcnuiUt4BPNWfhVa6rZF9FOly+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8826c81-70be-4524-6303-08d766ac501d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2019 13:37:36.4513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5YFEIXObCDkVE2XEZvAoZ9t8WpijZKIZH1isS6mbx2nY5HG1K6OdSdn3DOo40HRAY8zW+PO2ffpj42DDB3wPbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2920
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-09 2:49 p.m., Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are spelling mistakes in a DC_ERROR message and a comment.
> Fix these.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Thanks!

Nicholas Kazlauskas

> ---
>   drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c    | 2 +-
>   drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> index 61cefe0a3790..b65b66025267 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> +++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> @@ -92,7 +92,7 @@ void dc_dmub_srv_cmd_execute(struct dc_dmub_srv *dc_dmub_srv)
>   
>   	status = dmub_srv_cmd_execute(dmub);
>   	if (status != DMUB_STATUS_OK)
> -		DC_ERROR("Error starting DMUB exeuction: status=%d\n", status);
> +		DC_ERROR("Error starting DMUB execution: status=%d\n", status);
>   }
>   
>   void dc_dmub_srv_wait_idle(struct dc_dmub_srv *dc_dmub_srv)
> diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h
> index aa8f0396616d..45e427d1952e 100644
> --- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h
> +++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h
> @@ -416,7 +416,7 @@ enum dmub_status dmub_srv_cmd_queue(struct dmub_srv *dmub,
>    * dmub_srv_cmd_execute() - Executes a queued sequence to the dmub
>    * @dmub: the dmub service
>    *
> - * Begins exeuction of queued commands on the dmub.
> + * Begins execution of queued commands on the dmub.
>    *
>    * Return:
>    *   DMUB_STATUS_OK - success
> 

