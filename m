Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B55C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 15:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A304C21655
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 15:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfKKPxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 10:53:15 -0500
Received: from foss.arm.com ([217.140.110.172]:47370 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726857AbfKKPxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 10:53:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8C0631B;
        Mon, 11 Nov 2019 07:53:14 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9A893F534;
        Mon, 11 Nov 2019 07:53:14 -0800 (PST)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 6FFB2682AC2; Mon, 11 Nov 2019 15:53:13 +0000 (GMT)
Date:   Mon, 11 Nov 2019 15:53:13 +0000
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] drm/komeda: add rate limiting disable to
 err_verbosity
Message-ID: <20191111155313.iiz37se2f7526ehp@e110455-lin.cambridge.arm.com>
References: <20191107114155.54307-1-mihail.atanassov@arm.com>
 <20191107114155.54307-6-mihail.atanassov@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191107114155.54307-6-mihail.atanassov@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 11:42:44AM +0000, Mihail Atanassov wrote:
> It's possible to get multiple events in a single frame/flip, so add an
> option to print them all.
> 
> Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.com>
> Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>

For the whole series:

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
> 
>  v2: Clean up continuation line warning from checkpatch.
> 
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.h   | 2 ++
>  drivers/gpu/drm/arm/display/komeda/komeda_event.c | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> index d9fc9c48859a..15f52e304c08 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> @@ -224,6 +224,8 @@ struct komeda_dev {
>  #define KOMEDA_DEV_PRINT_INFO_EVENTS BIT(2)
>  	/* Dump DRM state on an error or warning event. */
>  #define KOMEDA_DEV_PRINT_DUMP_STATE_ON_EVENT BIT(8)
> +	/* Disable rate limiting of event prints (normally one per commit) */
> +#define KOMEDA_DEV_PRINT_DISABLE_RATELIMIT BIT(12)
>  };
>  
>  static inline bool
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_event.c b/drivers/gpu/drm/arm/display/komeda/komeda_event.c
> index 7fd624761a2b..bf269683f811 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_event.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_event.c
> @@ -119,7 +119,7 @@ void komeda_print_events(struct komeda_events *evts, struct drm_device *dev)
>  	/* reduce the same msg print, only print the first evt for one frame */
>  	if (evts->global || is_new_frame(evts))
>  		en_print = true;
> -	if (!en_print)
> +	if (!(err_verbosity & KOMEDA_DEV_PRINT_DISABLE_RATELIMIT) && !en_print)
>  		return;
>  
>  	if (err_verbosity & KOMEDA_DEV_PRINT_ERR_EVENTS)
> -- 
> 2.23.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
