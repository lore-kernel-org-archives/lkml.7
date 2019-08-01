Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCBFC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 10:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A715206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 10:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbfHAKOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 06:14:06 -0400
Received: from mga11.intel.com ([192.55.52.93]:62752 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbfHAKOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 06:14:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2019 03:14:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,333,1559545200"; 
   d="scan'208";a="191590542"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.150])
  by fmsmga001.fm.intel.com with ESMTP; 01 Aug 2019 03:14:02 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] drm/i915: fix possible memory leak in intel_hdcp_auth_downstream()
In-Reply-To: <20190704104534.12508-1-weiyongjun1@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190704104534.12508-1-weiyongjun1@huawei.com>
Date:   Thu, 01 Aug 2019 13:18:23 +0300
Message-ID: <87k1bxmbo0.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Jul 2019, Wei Yongjun <weiyongjun1@huawei.com> wrote:
> 'ksv_fifo' is malloced in intel_hdcp_auth_downstream() and should be
> freed before leaving from the error handling cases, otherwise it will
> cause memory leak.


Thanks for the patch, sorry for the delay, pushed to
drm-intel-next-queued.

BR,
Jani.

>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/gpu/drm/i915/display/intel_hdcp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c b/drivers/gpu/drm/i915/display/intel_hdcp.c
> index bc3a94d491c4..27bd7276a82d 100644
> --- a/drivers/gpu/drm/i915/display/intel_hdcp.c
> +++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
> @@ -536,7 +536,8 @@ int intel_hdcp_auth_downstream(struct intel_connector *connector)
>  
>  	if (drm_hdcp_check_ksvs_revoked(dev, ksv_fifo, num_downstream)) {
>  		DRM_ERROR("Revoked Ksv(s) in ksv_fifo\n");
> -		return -EPERM;
> +		ret = -EPERM;
> +		goto err;
>  	}
>  
>  	/*
>
>
>

-- 
Jani Nikula, Intel Open Source Graphics Center
