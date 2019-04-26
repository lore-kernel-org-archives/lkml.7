Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA17C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 00:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A3B2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 00:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YoG5sPR8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbfDZAC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 20:02:27 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45187 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfDZAC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 20:02:26 -0400
Received: by mail-ed1-f65.google.com with SMTP id k92so1599897edc.12;
        Thu, 25 Apr 2019 17:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qNWt+yHzCcOv3Jkt0k4++Eg836NGwpnCiiqTDO4DKCk=;
        b=YoG5sPR8OvXAv2y5kn+zIqjMqVTEKq+9UR6+LtWSe+S1izDVM5cdHzzRvFmiXc8z4E
         EV+rq93GLb/Y1Mm16bDrBHlA5OH9Q/rrZWuvjDnrLt9CK5fV1JgCZWFmPSOnW0BBPFdn
         j+sIeI5C6aVJmouDTqDAd0HeDBMri2YEZ2rib61jiK/qfiiahZY2jBntVEYISD4zjlgx
         LufHI9Hp80akQ5BEfZuihoVdotdD9lXWlJLrxYTHZwJoo2M2YR5uPboRnQi/Bh0ru1Sr
         vT/XVBtstSdRpve32DZflm68qDZVRixL65sx7/2SahGTFgkxNUDNCx6g2rCnIQt0S12+
         muOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qNWt+yHzCcOv3Jkt0k4++Eg836NGwpnCiiqTDO4DKCk=;
        b=Xkh+m2TAg0iqwMeewD4aoyAZkCtEc4y+NCFEs0I+weeQyW6SU8yebtBdtj2S68+Mq/
         w8HD3qMl0Yn7lf+rS+C7AeF8IPFEiEf/Q86OGxjn9Y+Zow0OYatEy1YP09GzoVWPz4o4
         OF++JdHm0u2ZL5YT4umJR3d/Iz62PjIVLOc85++wOL1HFYhv0BvgizB5j+2G65fgX5EJ
         Lsn1OMFHCnwnUY+U01V3PsPGXX65ZRcb/IggK87WREkx9lAZSUrNgMj/cuFmDE9NSHQ4
         A+XFv+1hV9lJwKZVzbzDet2JSapd0JqyzgXLo17ytnHKU3iXabsDwbaVikZPoz+8UGRN
         V82w==
X-Gm-Message-State: APjAAAWuaGM6EKYj2fr+ztnF2jR7tSb1XL6Pwr+dWaecLhUNj+kxoK1h
        Lz5EDz8YdxOuqgs7nr0B6US9M7aitWdgLZYslVw=
X-Google-Smtp-Source: APXvYqxYQsFr5rROO/Sk5UTDGRlWF8obB2Jsuu25fCWW1QWOIkLHOG19fnwRkd7JEv/BAT2S7n+uOPedVK5ih7Xet+c=
X-Received: by 2002:a17:906:d28c:: with SMTP id ay12mr20393489ejb.51.1556236944559;
 Thu, 25 Apr 2019 17:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <1556201031-3676-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1556201031-3676-1-git-send-email-hofrat@osadl.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 25 Apr 2019 17:02:14 -0700
Message-ID: <CAF6AEGu80YyDeGkShhrSSysmiHkNMWTL6H_uC1UJKzy88mwyGA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: check for equals 0 only
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Archit Taneja <architt@codeaurora.org>,
        Daniel Mack <daniel@zonque.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 7:09 AM Nicholas Mc Guire <hofrat@osadl.org> wrote:
>
> wait_for_completion_timeout() returns 0 on timeout and aleast 1 otherwise
> so checking for < makes no sense here.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> ---
>
> Problem located with an experimental coccinelle script
>
> While this check does no harm in this form - it should be fixed anyway
> to comply with the API see: kernel/sched/completion.c
>
> Also noticed that get_maintainer.pl will not list linux-kernel@vger.kernel.org
> when run on drivers/gpu/drm/msm/dsi/dsi_host.c - is that intentional ?

Thanks, I'll pull this in for -fixes

as far as get_maintainer.pl.. I'm not entirely sure.. we don't list
linux-kernel@vger.kernel.org explicitly, but neither do a lot of the
other driver entries.  Possibly this is a oversight in the MAINTAINERS
entry?  Either way, I guess I'd say that it isn't intentional.

BR,
-R

>
> Patch was compile-tested with: qcom_defconfig (implies DRM_MSM_DSI=y)
>
> Patch is against v5.1-rc6 (localversion-next is next-20190424)
>
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 610183d..dc16067 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -1049,7 +1049,7 @@ static void dsi_wait4video_done(struct msm_dsi_host *msm_host)
>         ret = wait_for_completion_timeout(&msm_host->video_comp,
>                         msecs_to_jiffies(70));
>
> -       if (ret <= 0)
> +       if (ret == 0)
>                 DRM_DEV_ERROR(dev, "wait for video done timed out\n");
>
>         dsi_intr_ctrl(msm_host, DSI_IRQ_MASK_VIDEO_DONE, 0);
> --
> 2.1.4
>
