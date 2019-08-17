Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CBCC41514
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 06:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69BE2173B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 06:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D7TXpxzO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfHQGwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 02:52:15 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47474 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfHQGwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 02:52:14 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7H6mtdD048231;
        Sat, 17 Aug 2019 06:52:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=sNBRZOs5LKC7xx0kA1ScFH42yymHCWiRh5XDdeQ+kxE=;
 b=D7TXpxzOWLogWmGrKsF/Tjx82bGLPIjsAr60TBoJoMSQcuQqs6VI3vVbhmKJ6FqtVoPl
 nvsDGTT4PjwCyhii8qaktPAonzV/fp8zKFbHDMBngppsr9ZOpbJPv78/mn+1ZqbFYK7Y
 bHVhL6D63srVJs+4jgYOoqiX114mbcju8qNLcY3hlQAW8zC5pcPtW9VkDR3V1ps1FDD9
 H8dIvKAAAe9gPQ/g/SR4gjFl9HMfrU8IGOHgPlqcXAzOdPa1fMMS+BtOrX5rD49N3Duf
 GU3XFJJvyi154ANpOtrUmNInHc6GOlhwIVFNyZEcxqOfG3uM/pqkxTkW4IvdsSHt9dR5 ww== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2ue9hp0hd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Aug 2019 06:52:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7H6nFi3153042;
        Sat, 17 Aug 2019 06:52:04 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2ue9dsm3um-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Aug 2019 06:52:04 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7H6pvHW029889;
        Sat, 17 Aug 2019 06:51:58 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 16 Aug 2019 23:51:57 -0700
Date:   Sat, 17 Aug 2019 09:51:46 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][drm-next] drm/amd/display: fix a potential null pointer
 dereference
Message-ID: <20190817065146.GA4451@kadam>
References: <20190816221011.10750-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816221011.10750-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9351 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908170073
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9351 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908170073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 11:10:11PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the pointer init_data is dereferenced on the assignment
> of fw_info before init_data is sanity checked to see if it is null.
> Fix te potential null pointer dereference on init_data by only
> performing dereference after it is null checked.
> 
> Addresses-Coverity: ("Dereference before null check")
> Fixes: 9adc8050bf3c ("drm/amd/display: make firmware info only load once during dc_bios create")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> index bee81bf288be..926954c804a6 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> @@ -1235,7 +1235,7 @@ static bool calc_pll_max_vco_construct(
>  			struct calc_pll_clock_source_init_data *init_data)
>  {
>  	uint32_t i;
> -	struct dc_firmware_info *fw_info = &init_data->bp->fw_info;
> +	struct dc_firmware_info *fw_info;
>  	if (calc_pll_cs == NULL ||
>  			init_data == NULL ||
>  			init_data->bp == NULL)

init_data can't be NULL.  I'm mostly pointing this out because that NULL
check is written so higgledy-piggledy.  At first I thought this was
staging code so I was planning to ignore the patch.  :P

regards,
dan carpenter

