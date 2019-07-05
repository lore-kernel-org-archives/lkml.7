Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84093C5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 07:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461F121852
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 07:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gh/Toz6V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfGEHIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 03:08:50 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43413 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfGEHIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 03:08:49 -0400
Received: by mail-ot1-f67.google.com with SMTP id q10so8090980otk.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 00:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0IIqKWzRaNse3XXjc9VJC174hdKsP3di+1IIb5DajLs=;
        b=gh/Toz6V7CixdKGLGkGy9rPXkrdYpbSEI9toJWHRYaf4kHmQ/0QfMBxGBHsJtDl9i9
         ZwjZg2XdbTSBvk5L41Rc7GwtWbT43JorS2dYawqFZq0UF8xiHjUn30KcpEdiKuzYv91k
         2BB6vbDpC26WiSr5OAiV+1AjkluoSR+vFoFQMvBNdGLTUnZXsqoqP7zX8GOOFaR7IoFU
         P+hfc0NAZuTMJOgudDmWkfHCqRRGjxoW92AgSBMRCJlCTYcgBMm4iLSXUKDrvBhMNGUj
         kOa6/YuH0gC2IBEeHA1yriXC0QfOWUIpElqf+l3HO/EvIv3/ubknXhnXBQU+SJadHsUV
         kP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0IIqKWzRaNse3XXjc9VJC174hdKsP3di+1IIb5DajLs=;
        b=lQYTCXRRDJQyV/vJQV8hkG9+LYEkroKYKX686HANYCH83Er0j2AGwD793Ixw/KToGc
         SkvNgYIkSi5ORykPhyEc3OHnE2Tk23O4Q/rKsnq+s6eT1fmhvfws9I10DwrFJFmCTbD1
         ucgEdoFLw4e3qfsNlaINjq4OzWZydFKrNPH2shR9G8RpMzdDnhe4ZZDJb6eoG7163l7i
         wOyiD6sc+fv01PsL5deopL+XLIAamUnt47XjoXvDAnuAxb1AWGjuorP5rbOkBfqx9Z8M
         V4DxGrHl4bw9lGpAjd9sc7PSrGViclPTJQV5hS7gKol5xhjIvrfdkJzEowxfguOMJPqg
         XBRQ==
X-Gm-Message-State: APjAAAVrBQAPHqoLhLMYEXssGuppTQcajtPJzVx9b5HOJk1pCwhi+SEP
        nMoEnCcSC7EpPbc6E9v1EPM+2twLFKlOn99inRnADw==
X-Google-Smtp-Source: APXvYqzldGMEKIRPPEJ0vaUfI2lFQ29kQgI2QwiHDaDqpSbGSw2Xx3CIMBQjB6qsF1gXZ8S1OcSQCm9TeiE6wueHYB4=
X-Received: by 2002:a9d:4f02:: with SMTP id d2mr1738812otl.328.1562310528818;
 Fri, 05 Jul 2019 00:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190705042623.129541-1-cychiang@chromium.org> <20190705042623.129541-2-cychiang@chromium.org>
In-Reply-To: <20190705042623.129541-2-cychiang@chromium.org>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Fri, 5 Jul 2019 15:08:37 +0800
Message-ID: <CA+Px+wXtmf9dQQP7ywPLp7Qbbvqau=WnO3qhZ8+qmbJD1gjx+A@mail.gmail.com>
Subject: Re: [PATCH 1/4] ASoC: hdmi-codec: Add an op to set callback function
 for plug event
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        ALSA development <alsa-devel@alsa-project.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 5, 2019 at 12:26 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
> diff --git a/include/sound/hdmi-codec.h b/include/sound/hdmi-codec.h
> index 7fea496f1f34..26c02abb8eba 100644
> --- a/include/sound/hdmi-codec.h
> +++ b/include/sound/hdmi-codec.h
> @@ -47,6 +47,9 @@ struct hdmi_codec_params {
>         int channels;
>  };
>
> +typedef void (*hdmi_codec_plugged_cb)(struct platform_device *dev,
> +                                     bool plugged);
> +
The callback prototype is "weird" by struct platform_device.  Is it
possible to having snd_soc_component instead of platform_device?

>  struct hdmi_codec_pdata;
>  struct hdmi_codec_ops {
>         /*
> @@ -88,6 +91,13 @@ struct hdmi_codec_ops {
>          */
>         int (*get_dai_id)(struct snd_soc_component *comment,
>                           struct device_node *endpoint);
> +
> +       /*
> +        * Hook callback function to handle connector plug event.
> +        * Optional
> +        */
> +       int (*hook_plugged_cb)(struct device *dev, void *data,
> +                              hdmi_codec_plugged_cb fn);
>  };
The first parameter dev could be removed.  Not used.
