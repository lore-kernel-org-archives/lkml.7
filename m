Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3373C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 02:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A9420818
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 02:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfKLCjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 21:39:35 -0500
Received: from smtprelay0079.hostedemail.com ([216.40.44.79]:46010 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726928AbfKLCjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 21:39:35 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 7B961181D3026;
        Tue, 12 Nov 2019 02:39:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: end54_35f6dbbf31b05
X-Filterd-Recvd-Size: 2553
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Tue, 12 Nov 2019 02:39:30 +0000 (UTC)
Message-ID: <01c630e6d4c58b3f6184603e158f53fb9aaeae7d.camel@perches.com>
Subject: Re: [PATCH -next] drm/amd/display: Fix old-style declaration
From:   Joe Perches <joe@perches.com>
To:     YueHaibing <yuehaibing@huawei.com>, harry.wentland@amd.com,
        sunpeng.li@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, Bhawanpreet.Lakha@amd.com, Jun.Lei@amd.com,
        David.Francis@amd.com, Dmytro.Laktyushkin@amd.com,
        nicholas.kazlauskas@amd.com, martin.leung@amd.com,
        Chris.Park@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 11 Nov 2019 18:39:15 -0800
In-Reply-To: <20191111122801.18584-1-yuehaibing@huawei.com>
References: <20191111122801.18584-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-11-11 at 20:28 +0800, YueHaibing wrote:
> Fix a build warning:
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:75:1:
>  warning: 'static' is not at beginning of declaration [-Wold-style-declaration]
[]
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
[]
> @@ -69,7 +69,7 @@
>  #define DC_LOGGER \
>  	dc->ctx->logger
>  
> -const static char DC_BUILD_ID[] = "production-build";
> +static const char DC_BUILD_ID[] = "production-build";

DC_BUILD_ID is used exactly once.
Maybe just use it directly and remove DC_BUILD_ID instead?

---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 1fdba13..803dc14 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -69,8 +69,6 @@
 #define DC_LOGGER \
 	dc->ctx->logger
 
-const static char DC_BUILD_ID[] = "production-build";
-
 /**
  * DOC: Overview
  *
@@ -815,7 +813,7 @@ struct dc *dc_create(const struct dc_init_data *init_params)
 	if (dc->res_pool->dmcu != NULL)
 		dc->versions.dmcu_version = dc->res_pool->dmcu->dmcu_version;
 
-	dc->build_id = DC_BUILD_ID;
+	dc->build_id = "production-build";
 
 	DC_LOG_DC("Display Core initialized\n");
 


