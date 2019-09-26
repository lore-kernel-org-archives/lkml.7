Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C96C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 18:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79244222C9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 18:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rhH02Nuw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbfIZSrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 14:47:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33989 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728376AbfIZSrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 14:47:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id a11so3954197wrx.1;
        Thu, 26 Sep 2019 11:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ryqJFjqhK0qsWEG3QQBKixHuvJqyJfJ4Aw/rVEE5A9I=;
        b=rhH02NuwoF9VoOpkaOIAFbN0LHsg6S/M7cW3o30H2SjDGioOJxljZr3z+Xro466V6C
         TR6OYMADRkzLOLlSwAnwgqypOA/XrAsJkzaVPf21EbG6N8zXpRD2NQgEauXdw39k0MWy
         ZvjJsy4yi1Ex6dJouPRhfm7eMjYYdfkaJaxyaC9Q+g8/j0edbVgdS7x2nu0a9r1GlL4k
         IZ5p3WMb/emJOyAV0CMvPFU11c9GNjP/zu1OpjQdFxgYGF5+W+sesnTRTAePXdu9Q7Fq
         Lqh+MByPQuGeuSdbJTMM0tnGj+Dhw0AFVneMDH7XcVTCcl4sqruVRUsShZ1a8YN7TacV
         ++4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ryqJFjqhK0qsWEG3QQBKixHuvJqyJfJ4Aw/rVEE5A9I=;
        b=i5B5TBxK8RjIPu/faaLbwHsqVYxbxHw7JcOYMcf8FwXbWqVvpIi6apkunYWjgtXB/C
         jmT9bnuWojW9R3bl5zLxTYK4d1lGBVWdSFXN+NLbLWad7M8jn24e0LmDrwk5oD7rljl+
         KaAWZc7SayZUPE5jEC4/kTnT23sPs9LjEzdUjKfOga/D+HcaSfSpcbW4g/KyxXRaSMfP
         XETubfo8jE/MkcWL1Pu+LKAPLKkhgFp8jo7epgMMYoNrkcu0o+nmcMXeAWXs7QWkV0DF
         RHyJCfLLq9B7j8mi2OeDUoAHkmw0lN7c3nkR4p6zaePYz89r8tN8u/BG0FLGH7p77OqO
         4drQ==
X-Gm-Message-State: APjAAAVCl/FJ+mLjfijoFnjqMw0AQ8FxdU5c+XJyRj2c0tMgCZupQ0KO
        VVLufpy3a/dqa/qllv2RmeQ7y0cqHyqDs9ayyNM=
X-Google-Smtp-Source: APXvYqyYUPV6BJDRNjwwq/QqSYvhg3ArB4udbRCgUSBEgbDKcOU11wjoomX4G43wIUkvOH+ytNEARQblrcA73bh/qss=
X-Received: by 2002:adf:ef05:: with SMTP id e5mr3941816wro.127.1569523665464;
 Thu, 26 Sep 2019 11:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190926101754.23106-1-chris.paterson2@renesas.com>
In-Reply-To: <20190926101754.23106-1-chris.paterson2@renesas.com>
From:   Ramesh Shanmugasundaram <rashanmu@gmail.com>
Date:   Thu, 26 Sep 2019 19:47:08 +0100
Message-ID: <CAJWpUEcNV_ZWE1WBGq5P2MOTmwzxCrn8s0eo6q0UcAtEeTUrTQ@mail.gmail.com>
Subject: Re: [PATCH] [media] MAINTAINERS: Update MAX2175 & R-Car DRIF driver
 maintainer email
To:     Chris Paterson <chris.paterson2@renesas.com>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

Thank you for updating this.

On Thu, 26 Sep 2019 at 11:18, Chris Paterson
<chris.paterson2@renesas.com> wrote:
>
> Ramesh is now using a new email address. Update the maintainer entry for
> the MAX2175 SDR tuner and the Renesas R-Car DRIF drivers.
>
> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>

Acked-by: Ramesh Shanmugasundaram <rashanmu@gmail.com>

Thanks,
Ramesh

> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 37dca6d70d87..948612fcf60b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9873,7 +9873,7 @@ F:        Documentation/hwmon/max16065.rst
>  F:     drivers/hwmon/max16065.c
>
>  MAX2175 SDR TUNER DRIVER
> -M:     Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
> +M:     Ramesh Shanmugasundaram <rashanmu@gmail.com>
>  L:     linux-media@vger.kernel.org
>  T:     git git://linuxtv.org/media_tree.git
>  S:     Maintained
> @@ -10135,7 +10135,7 @@ F:      drivers/media/platform/renesas-ceu.c
>  F:     include/media/drv-intf/renesas-ceu.h
>
>  MEDIA DRIVERS FOR RENESAS - DRIF
> -M:     Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
> +M:     Ramesh Shanmugasundaram <rashanmu@gmail.com>
>  L:     linux-media@vger.kernel.org
>  L:     linux-renesas-soc@vger.kernel.org
>  T:     git git://linuxtv.org/media_tree.git
> --
> 2.17.1
>
