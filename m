Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122BCC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F1C205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20150623.gappssmtp.com header.i=@fooishbar-org.20150623.gappssmtp.com header.b="OV6v4RpJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfHNLqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 07:46:30 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45583 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfHNLq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 07:46:29 -0400
Received: by mail-lj1-f194.google.com with SMTP id t3so15963416ljj.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 04:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HVIUs4ZIQVm7b7SR1n38pcFhXz6C3M2CIhWpAxdt8LQ=;
        b=OV6v4RpJEGTSaeN9WjacjemHo7ZUtwknpaHLLy+MEre+zyB39wCwfeJtTg+FZ8IZ+B
         OcJGOV/93rJokdOIQwig6ROI8s46ddhjgNFjuNQIRHDFv0ccHr12uxB9mmYTVVx67gy1
         s8hLywCYXHwDkDbFXcF0V4TeSFIfT3tVWiVJTVB7XNHhkoelxy83LEM1tJcaxshNsR7G
         nbvYUYuPB2OPUjvHesf9PtA8fp6EqjxvwKx+GijgH5csPsIWsi1CddxxpdnawisyZMAF
         G1GvqKTt8QXGUkeS0wAZzBsBRXx6kryesDbVbLTprqrHNM3bOGm2jgMnuynRAAZzCWXS
         SI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HVIUs4ZIQVm7b7SR1n38pcFhXz6C3M2CIhWpAxdt8LQ=;
        b=JVwJbyluNB5yS5yRVCtrkWh2VeTrhpy0ir8aC8qyNibP1QcYJgGrFOmDqKFIdk/pOJ
         raLkKkOL/J2OwAcajFIBNjaZggTKHeafW9qmeio+m9un+wb2PGc3fREzIZx7PFNSh2Hj
         DB6zB0MjOKplEU1Dz4BBljvOkqxWUiodwoiWrb2nJqaYSOF2R4mZyvRc3+lVJLxqGSLL
         jT3MwcdRT8h0ws/VypDHbqsOMhW8BjXWjRAzoE4sDcwYDBKnUzSecCc5aX5sTV9SPMH7
         v0DY0ub7QTTyCa309q8wm+c2rR0MpjW/eQzLeHWDw5rGBZz1tPFCqS9sHdoN38EjItr4
         RyDg==
X-Gm-Message-State: APjAAAUl30JT5cjjyZbS/FH3f33tnYAB6NUBzJA1eQtughLyWQzeB/yG
        kexMKVcw4Q5JWmlya13Py4qfucCFt18RNKmrgEHBluna
X-Google-Smtp-Source: APXvYqx8H8wf2cUfndKRitBxUVt4PunZZn7bV5z50HzDJV5mvhAjxp+vVMjixTxwiL4xvtZ+Nynqmt1s1BQ2RX367ts=
X-Received: by 2002:a2e:b4e6:: with SMTP id s6mr11087965ljm.169.1565783187372;
 Wed, 14 Aug 2019 04:46:27 -0700 (PDT)
MIME-Version: 1.0
References: <1565779731-1300-1-git-send-email-robert.chiras@nxp.com> <1565779731-1300-7-git-send-email-robert.chiras@nxp.com>
In-Reply-To: <1565779731-1300-7-git-send-email-robert.chiras@nxp.com>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Wed, 14 Aug 2019 12:44:34 +0100
Message-ID: <CAPj87rMFG=RGmfVnawbE7qX4zU7vdYxLJB__K4E3B8jcJ764KQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] drm/mxsfb: Update mxsfb with additional pixel formats
To:     Robert Chiras <robert.chiras@nxp.com>
Cc:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On Wed, 14 Aug 2019 at 11:49, Robert Chiras <robert.chiras@nxp.com> wrote:
> +       case DRM_FORMAT_BGR565: /* BG16 */
> +               if (mxsfb->devdata->ipversion < 4)
> +                       goto err;
> +               writel(CTRL2_ODD_LINE_PATTERN(CTRL2_LINE_PATTERN_BGR) |
> +                       CTRL2_EVEN_LINE_PATTERN(CTRL2_LINE_PATTERN_BGR),
> +                       mxsfb->base + LCDC_V4_CTRL2 + REG_SET);
> +               /* Fall through */
> +       case DRM_FORMAT_RGB565: /* RG16 */
> +               ctrl |= CTRL_SET_WORD_LENGTH(0);
> +               ctrl &= ~CTRL_DF16;
> +               ctrl1 |= CTRL1_SET_BYTE_PACKAGING(0xf);
> +               break;

For non-BGR formats, do you need to write RGB line-pattern back to the
CTRL2 register? Otherwise, if you start with BGR565 then switch back
to RGB565, presumably CTRL2 would still be programmed for BGR so you
would display inverted channels.

Same goes for all the other BGR/RGB format pairs below.

Cheers,
Daniel
