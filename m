Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16151C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57792084D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387944AbfKGJyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:54:38 -0500
Received: from smtprelay0130.hostedemail.com ([216.40.44.130]:59943 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726734AbfKGJyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:54:38 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id F0F76182CED34;
        Thu,  7 Nov 2019 09:54:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: ring31_45311ab5a8d41
X-Filterd-Recvd-Size: 1775
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Thu,  7 Nov 2019 09:54:35 +0000 (UTC)
Message-ID: <4c74db2614cefe23f888d0643c2d7c356086745a.camel@perches.com>
Subject: Re: [PATCH] drm/rockchip: use DRM_DEV_ERROR for log output
From:   Joe Perches <joe@perches.com>
To:     Wambui Karuga <wambui.karugax@gmail.com>, hjc@rock-chips.com,
        heiko@sntech.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 07 Nov 2019 01:54:22 -0800
In-Reply-To: <20191107092945.15513-1-wambui.karugax@gmail.com>
References: <20191107092945.15513-1-wambui.karugax@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-11-07 at 12:29 +0300, Wambui Karuga wrote:
> Replace the use of the dev_err macro with the DRM_DEV_ERROR
> DRM helper macro.

The commit message should show the reason _why_ you are doing
this instead of just stating that you are doing this.

It's not that dev_err is uncommon in drivers/gpu/drm.

$ git grep -w dev_err drivers/gpu/drm | wc -l
1950
$ git grep -w DRM_DEV_ERROR drivers/gpu/drm | wc -l
756

> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
[]
> @@ -916,7 +916,7 @@ static int dw_mipi_dsi_rockchip_probe(struct platform_device *pdev)
>  	}
>  
>  	if (!dsi->cdata) {
> -		dev_err(dev, "no dsi-config for %s node\n", np->name);
> +		DRM_DEV_ERROR(dev, "no dsi-config for %s node\n", np->name);
>  		return -EINVAL;
>  	}



