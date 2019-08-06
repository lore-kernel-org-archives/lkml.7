Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8021AC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 11:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 310A820880
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 11:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="CGz9N9fI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbfHFLqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 07:46:06 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33756 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfHFLqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 07:46:05 -0400
Received: by mail-ot1-f65.google.com with SMTP id q20so91557382otl.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 04:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+2GLuom5LkEzk75iKp/W/dLLzktwu1z9FB3lzR1vH88=;
        b=CGz9N9fIrOmtsbSaHjVpA+Ay5xvmrIhIp710TV/jZE4ebeccflhTltK6pThFqAUoNz
         7SKf/DRH2L8JHnbihzZBeQ/LT11QTkOA0t4JhIY14g/EnqlOH9aKw1VU3CRk0eqOPV4r
         Cm2dLLmSUPy1r41Y9W2+7c5LrJn+g2OfePzZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+2GLuom5LkEzk75iKp/W/dLLzktwu1z9FB3lzR1vH88=;
        b=NthVOYMwg8jVNP8X0Qr6HL7cDc32VNWnOXXubQLOD00Bk8UIYW6H4/g0rVMkb1MYAW
         9MdoehM5+amSlk54HsmnwjdiU6/LcB0IvzL0mJ2nanLKvbO0zw1/yXt4yLX29ciYBe5J
         fsAI5VgEKTDw1CLYHjlNBEE87BVLOLcI/18yyECIijAGQo0Xz2MpaNjk7jZJOSqgRR3I
         uvnBmF1+yr8TonNlxKOiOVV0KOe4bDAAHFIhm/wlZYfiaLXLA/UfQ1MjxydIvHD4s059
         s7e3Ag468eyQatTg+UeqsjD91+FBiuImKKpflP3XRMru4oAT4WUhYi990wgYHKRUT/VF
         aCEA==
X-Gm-Message-State: APjAAAUB3UD5DO1Ffr+Jo4E2VUfHUB1Uh5FnVqLXlk98W0pb36kaEe/j
        4lFRzNbRWdDlSoGC+vk5VxroPR5PIfH0uTIS3Zp02g==
X-Google-Smtp-Source: APXvYqxsVgZsi3QItTRxougIwHgd9GmIH1aNgoPdpOjOudg5TAf9holb/8M8flURvPkrOcwY2yoQJMmlqESNr+y2wz0=
X-Received: by 2002:a9d:590d:: with SMTP id t13mr2946119oth.281.1565091964657;
 Tue, 06 Aug 2019 04:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190806091233.GX7444@phenom.ffwll.local> <20190806104835.26075-1-brian.starkey@arm.com>
In-Reply-To: <20190806104835.26075-1-brian.starkey@arm.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 6 Aug 2019 13:45:53 +0200
Message-ID: <CAKMK7uHjz=t2dCVwCbEf5qUkcEcyUSqL=hjsHb-ZJ0pD2w7rvQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/crc-debugfs: Add notes about CRC<->commit interactions
To:     Brian Starkey <brian.starkey@arm.com>
Cc:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        nd <nd@arm.com>, dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 6, 2019 at 12:48 PM Brian Starkey <brian.starkey@arm.com> wrote:
>
> CRC generation can be impacted by commits coming from userspace, and
> enabling CRC generation may itself trigger a commit. Add notes about
> this to the kerneldoc.
>
> Signed-off-by: Brian Starkey <brian.starkey@arm.com>

lgtm, my earlier r-b holds. Well maybe should have a v2 here somewhere
with what you changed.
-Daniel
> ---
>  drivers/gpu/drm/drm_debugfs_crc.c | 17 +++++++++++++----
>  include/drm/drm_crtc.h            |  4 ++++
>  2 files changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_debugfs_crc.c b/drivers/gpu/drm/drm_debugfs_crc.c
> index 7ca486d750e9..77159b6e77c3 100644
> --- a/drivers/gpu/drm/drm_debugfs_crc.c
> +++ b/drivers/gpu/drm/drm_debugfs_crc.c
> @@ -65,10 +65,19 @@
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
> + * CRC results must be reliable across non-full-modeset atomic commits, so if a
> + * commit via DRM_IOCTL_MODE_ATOMIC would disable or otherwise interfere with
> + * CRC generation, then the driver must mark that commit as a full modeset
> + * (drm_atomic_crtc_needs_modeset() should return true). As a result, to ensure
> + * consistent results, generic userspace must re-setup CRC generation after a
> + * legacy SETCRTC or an atomic commit with DRM_MODE_ATOMIC_ALLOW_MODESET.
>   */
>
>  static int crc_control_show(struct seq_file *m, void *data)
> diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
> index 128d8b210621..7d14c11bdc0a 100644
> --- a/include/drm/drm_crtc.h
> +++ b/include/drm/drm_crtc.h
> @@ -756,6 +756,9 @@ struct drm_crtc_funcs {
>          * provided from the configured source. Drivers must accept an "auto"
>          * source name that will select a default source for this CRTC.
>          *
> +        * This may trigger an atomic modeset commit if necessary, to enable CRC
> +        * generation.
> +        *
>          * Note that "auto" can depend upon the current modeset configuration,
>          * e.g. it could pick an encoder or output specific CRC sampling point.
>          *
> @@ -767,6 +770,7 @@ struct drm_crtc_funcs {
>          * 0 on success or a negative error code on failure.
>          */
>         int (*set_crc_source)(struct drm_crtc *crtc, const char *source);
> +
>         /**
>          * @verify_crc_source:
>          *
> --
> 2.17.1
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
