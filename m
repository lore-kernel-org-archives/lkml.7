Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411C8C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 16:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D9F2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 16:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="XR2Db8aN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbfHEQYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 12:24:24 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43219 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfHEQYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 12:24:23 -0400
Received: by mail-ed1-f68.google.com with SMTP id e3so79309966edr.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 09:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JXeUZYg/9AJUDSihciUvJprkRBIRGJYxSA84S9jr6q0=;
        b=XR2Db8aNX3U0yinlF4xRpe2Z0CZc48/D6+huDhKJ1zdxAe0Vr4yoVMRR+j5xxwaCNK
         bvVyF3Zn1J8UC+6KdhglbaxP0Ma2sECYDkvhmhdmvZBJbKPRx35uT9pL0UFNGPN4CI3/
         EBrnaGNBnFGhQt9JAjOSD0IL3HMeXhXC4jx8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=JXeUZYg/9AJUDSihciUvJprkRBIRGJYxSA84S9jr6q0=;
        b=SJHL5YJZG94m9FjtKZEm+6f+0k686Zz5kp9FdueYNjcIFKA5I9/lXaTk1NcKcqYKgU
         o89Er8Ii8fK1VJExFIvkCWWy719eM6cv46imHz2Q1z7/oRs4NuFIDn4zBFR9Nux+atfA
         kyg0FCBOsJ76Esd4RSwP6KqfVV66fpWI7n3YwDfObl9zgXwpCLrbMA+sXXdsj2fpU1M7
         9uC/Gswn6Zi5frfTA7Um5Y5KBEOZYs+6M0bRUELzaSEajnfgDc3rv6Vbmzk9M5TQlVgH
         oysp9BpdvGcYOujBBrM+RqoEL+bUEyCpQAjSGvDZlf5mHIliKdktKBm057TnyKGVLiZ3
         7raA==
X-Gm-Message-State: APjAAAXlHrcWTHGMBS4FGRROjoidQ+gXaPuqY/AjcCX3BBDK6ZuGxGt+
        4N0qCzx3OchOm3UqokSySFU=
X-Google-Smtp-Source: APXvYqzgJgILAzLMJsokj9kmScwkFDvPXiNr49lKrcQbCyNQcxvTyfxcKovhyfweN3oJywoKAzHT0A==
X-Received: by 2002:a17:907:2101:: with SMTP id qn1mr120566592ejb.3.1565022261086;
        Mon, 05 Aug 2019 09:24:21 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id h10sm19069052edn.86.2019.08.05.09.24.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 09:24:19 -0700 (PDT)
Date:   Mon, 5 Aug 2019 18:24:17 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Brian Starkey <brian.starkey@arm.com>
Cc:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>, nd@arm.com,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/crc-debugfs: Add notes about CRC<->commit
 interactions
Message-ID: <20190805162417.GS7444@phenom.ffwll.local>
Mail-Followup-To: Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>, nd@arm.com,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20190802140910.GN7444@phenom.ffwll.local>
 <20190805151143.12317-1-brian.starkey@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805151143.12317-1-brian.starkey@arm.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 04:11:43PM +0100, Brian Starkey wrote:
> CRC generation can be impacted by commits coming from userspace, and
> enabling CRC generation may itself trigger a commit. Add notes about
> this to the kerneldoc.
> 
> Signed-off-by: Brian Starkey <brian.starkey@arm.com>
> ---
> 
> I might have got the wrong end of the stick, but this is what I
> understood from what you said.
> 
> Cheers,
> -Brian
> 
>  drivers/gpu/drm/drm_debugfs_crc.c | 15 +++++++++++----
>  include/drm/drm_crtc.h            |  3 +++
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_debugfs_crc.c b/drivers/gpu/drm/drm_debugfs_crc.c
> index 7ca486d750e9..1dff956bcc74 100644
> --- a/drivers/gpu/drm/drm_debugfs_crc.c
> +++ b/drivers/gpu/drm/drm_debugfs_crc.c
> @@ -65,10 +65,17 @@
>   * it submits. In this general case, the maximum userspace can do is to compare
>   * the reported CRCs of frames that should have the same contents.
>   *
> - * On the driver side the implementation effort is minimal, drivers only need to
> - * implement &drm_crtc_funcs.set_crc_source. The debugfs files are automatically
> - * set up if that vfunc is set. CRC samples need to be captured in the driver by
> - * calling drm_crtc_add_crc_entry().
> + * On the driver side the implementation effort is minimal, drivers only need
> + * to implement &drm_crtc_funcs.set_crc_source. The debugfs files are
> + * automatically set up if that vfunc is set. CRC samples need to be captured
> + * in the driver by calling drm_crtc_add_crc_entry(). Depending on the driver
> + * and HW requirements, &drm_crtc_funcs.set_crc_source may result in a commit
> + * (even a full modeset).
> + *
> + * It's also possible that a "normal" commit via DRM_IOCTL_MODE_ATOMIC or the
> + * legacy paths may interfere with CRC generation. So, in the general case,
> + * userspace can't rely on the values in crtc-N/crc/data being valid
> + * across a commit.

It's not just the values, but the generation itself might get disabled
(e.g. on i915 if you select "auto" on some chips you get the DP port
sampling point, but for HDMI mode you get a different sampling ploint, and
if you get the wrong one there won't be any crc for you). Also it's not
just any atomic commit, only the ones with ALLOW_MODESET.

Maybe something like the below text:

"Please note that an atomic modeset commit with the
DRM_MODE_ATOMIC_ALLOW_MODESET, or a call to the legacy SETCRTR ioctl
(which amounts to the same), can destry the CRC setup due to hardware
requirements. This results in inconsistent CRC values or not even any CRC
values generated. Generic userspace therefore needs to re-setup the CRC
after each such modeset."

>  
>  static int crc_control_show(struct seq_file *m, void *data)
> diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
> index 128d8b210621..0f7ea094a900 100644
> --- a/include/drm/drm_crtc.h
> +++ b/include/drm/drm_crtc.h
> @@ -756,6 +756,8 @@ struct drm_crtc_funcs {
>  	 * provided from the configured source. Drivers must accept an "auto"
>  	 * source name that will select a default source for this CRTC.
>  	 *
> +	 * This may trigger a commit if necessary, to enable CRC generation.

I'd clarify this as "atomic modeset commit" just to be sure.

With these two comments addressed somehow:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>


> +	 *
>  	 * Note that "auto" can depend upon the current modeset configuration,
>  	 * e.g. it could pick an encoder or output specific CRC sampling point.
>  	 *
> @@ -767,6 +769,7 @@ struct drm_crtc_funcs {
>  	 * 0 on success or a negative error code on failure.
>  	 */
>  	int (*set_crc_source)(struct drm_crtc *crtc, const char *source);
> +
>  	/**
>  	 * @verify_crc_source:
>  	 *
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
