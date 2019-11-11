Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C905AC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 15:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E5821783
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 15:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfKKPwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 10:52:12 -0500
Received: from foss.arm.com ([217.140.110.172]:47350 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726857AbfKKPwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 10:52:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5936331B;
        Mon, 11 Nov 2019 07:52:11 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1434B3F534;
        Mon, 11 Nov 2019 07:52:11 -0800 (PST)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id C954D682AC2; Mon, 11 Nov 2019 15:52:09 +0000 (GMT)
Date:   Mon, 11 Nov 2019 15:52:09 +0000
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
Subject: Re: [PATCH v2 1/5] drm/komeda: Add debugfs node to control error
 verbosity
Message-ID: <20191111155209.zxkgqj4m4x6mphd7@e110455-lin.cambridge.arm.com>
References: <20191107114155.54307-1-mihail.atanassov@arm.com>
 <20191107114155.54307-2-mihail.atanassov@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191107114155.54307-2-mihail.atanassov@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 11:42:28AM +0000, Mihail Atanassov wrote:
> Named 'err_verbosity', currently with only 1 active bit in that
> replicates the existing level - print error events once per flip.
> 
> Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.com>
> Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.c   |  4 ++++
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.h   | 14 ++++++++++++--
>  drivers/gpu/drm/arm/display/komeda/komeda_event.c |  9 +++++++--
>  drivers/gpu/drm/arm/display/komeda/komeda_kms.c   |  2 +-
>  4 files changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> index 14d5c5da9e3b..4e46f650fddf 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> @@ -58,6 +58,8 @@ static void komeda_debugfs_init(struct komeda_dev *mdev)
>  	mdev->debugfs_root = debugfs_create_dir("komeda", NULL);
>  	debugfs_create_file("register", 0444, mdev->debugfs_root,
>  			    mdev, &komeda_register_fops);
> +	debugfs_create_x16("err_verbosity", 0664, mdev->debugfs_root,
> +			   &mdev->err_verbosity);
>  }
>  #endif
>  
> @@ -273,6 +275,8 @@ struct komeda_dev *komeda_dev_create(struct device *dev)
>  		goto err_cleanup;
>  	}
>  
> +	mdev->err_verbosity = KOMEDA_DEV_PRINT_ERR_EVENTS;
> +
>  #ifdef CONFIG_DEBUG_FS
>  	komeda_debugfs_init(mdev);
>  #endif
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> index 414200233b64..b5bd3d5898ee 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> @@ -202,6 +202,14 @@ struct komeda_dev {
>  
>  	/** @debugfs_root: root directory of komeda debugfs */
>  	struct dentry *debugfs_root;
> +	/**
> +	 * @err_verbosity: bitmask for how much extra info to print on error
> +	 *
> +	 * See KOMEDA_DEV_* macros for details.
> +	 */
> +	u16 err_verbosity;
> +	/* Print a single line per error per frame with error events. */
> +#define KOMEDA_DEV_PRINT_ERR_EVENTS BIT(0)
>  };
>  
>  static inline bool
> @@ -219,9 +227,11 @@ void komeda_dev_destroy(struct komeda_dev *mdev);
>  struct komeda_dev *dev_to_mdev(struct device *dev);
>  
>  #ifdef CONFIG_DRM_KOMEDA_ERROR_PRINT
> -void komeda_print_events(struct komeda_events *evts);
> +void komeda_print_events(struct komeda_events *evts, struct drm_device *dev);
>  #else
> -static inline void komeda_print_events(struct komeda_events *evts) {}
> +static inline void komeda_print_events(struct komeda_events *evts,
> +				       struct drm_device *dev)
> +{}
>  #endif
>  
>  int komeda_dev_resume(struct komeda_dev *mdev);
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_event.c b/drivers/gpu/drm/arm/display/komeda/komeda_event.c
> index a36fb86cc054..575ed4df74ed 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_event.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_event.c
> @@ -107,10 +107,12 @@ static bool is_new_frame(struct komeda_events *a)
>  	       (KOMEDA_EVENT_FLIP | KOMEDA_EVENT_EOW);
>  }
>  
> -void komeda_print_events(struct komeda_events *evts)
> +void komeda_print_events(struct komeda_events *evts, struct drm_device *dev)
>  {
> -	u64 print_evts = KOMEDA_ERR_EVENTS;
> +	u64 print_evts = 0;
>  	static bool en_print = true;
> +	struct komeda_dev *mdev = dev->dev_private;
> +	u16 const err_verbosity = mdev->err_verbosity;
>  
>  	/* reduce the same msg print, only print the first evt for one frame */
>  	if (evts->global || is_new_frame(evts))
> @@ -118,6 +120,9 @@ void komeda_print_events(struct komeda_events *evts)
>  	if (!en_print)
>  		return;
>  
> +	if (err_verbosity & KOMEDA_DEV_PRINT_ERR_EVENTS)
> +		print_evts |= KOMEDA_ERR_EVENTS;
> +
>  	if ((evts->global | evts->pipes[0] | evts->pipes[1]) & print_evts) {
>  		char msg[256];
>  		struct komeda_str str;
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> index d49772de93e0..e30a5b43caa9 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> @@ -48,7 +48,7 @@ static irqreturn_t komeda_kms_irq_handler(int irq, void *data)
>  	memset(&evts, 0, sizeof(evts));
>  	status = mdev->funcs->irq_handler(mdev, &evts);
>  
> -	komeda_print_events(&evts);
> +	komeda_print_events(&evts, drm);
>  
>  	/* Notify the crtc to handle the events */
>  	for (i = 0; i < kms->n_crtcs; i++)
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
