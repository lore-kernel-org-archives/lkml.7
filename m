Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11928C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 10:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA8A12243F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 10:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbfKTKVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 05:21:07 -0500
Received: from mga01.intel.com ([192.55.52.88]:65360 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727659AbfKTKVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 05:21:07 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 02:21:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,221,1571727600"; 
   d="scan'208";a="215747961"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga001.fm.intel.com with SMTP; 20 Nov 2019 02:21:03 -0800
Received: by stinkbox (sSMTP sendmail emulation); Wed, 20 Nov 2019 12:21:03 +0200
Date:   Wed, 20 Nov 2019 12:21:03 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, Sean Paul <sean@poorly.run>
Subject: Re: [PATCH] drm/crc-debugfs: fix crtc_crc_poll()'s return type
Message-ID: <20191120102103.GD1208@intel.com>
References: <20191120000754.30710-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191120000754.30710-1-luc.vanoostenryck@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 01:07:54AM +0100, Luc Van Oostenryck wrote:
> crtc_crc_poll() is defined as returning 'unsigned int' but the
> .poll method is declared as returning '__poll_t', a bitwise type.
> 
> Fix this by using the proper return type and using the EPOLL
> constants instead of the POLL ones, as required for __poll_t.

Already fixed. 1ab2a99edb37 ("drm: Fix return type of crc .poll()")

> 
> CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> CC: Maxime Ripard <mripard@kernel.org>
> CC: Sean Paul <sean@poorly.run>
> CC: David Airlie <airlied@linux.ie>
> CC: Daniel Vetter <daniel@ffwll.ch>
> CC: dri-devel@lists.freedesktop.org
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  drivers/gpu/drm/drm_debugfs_crc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_debugfs_crc.c b/drivers/gpu/drm/drm_debugfs_crc.c
> index be1b7ba92ffe..0bb0aa0ebbca 100644
> --- a/drivers/gpu/drm/drm_debugfs_crc.c
> +++ b/drivers/gpu/drm/drm_debugfs_crc.c
> @@ -334,17 +334,17 @@ static ssize_t crtc_crc_read(struct file *filep, char __user *user_buf,
>  	return LINE_LEN(crc->values_cnt);
>  }
>  
> -static unsigned int crtc_crc_poll(struct file *file, poll_table *wait)
> +static __poll_t crtc_crc_poll(struct file *file, poll_table *wait)
>  {
>  	struct drm_crtc *crtc = file->f_inode->i_private;
>  	struct drm_crtc_crc *crc = &crtc->crc;
> -	unsigned ret;
> +	__poll_t ret;
>  
>  	poll_wait(file, &crc->wq, wait);
>  
>  	spin_lock_irq(&crc->lock);
>  	if (crc->source && crtc_crc_data_count(crc))
> -		ret = POLLIN | POLLRDNORM;
> +		ret = EPOLLIN | EPOLLRDNORM;
>  	else
>  		ret = 0;
>  	spin_unlock_irq(&crc->lock);
> -- 
> 2.24.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel
