Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26FBC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8061206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="fnTPfuSO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbfG3RM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:12:28 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:33259 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfG3RM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:12:28 -0400
Received: by mail-yw1-f67.google.com with SMTP id l124so24045479ywd.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 10:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ImY2DybhOrcM2lI55Kc331ajwFUz03xP4fYhf/CoFd4=;
        b=fnTPfuSOS5xpzgI/dQJjNEhuWQ9V5NaVEYODjti6i+5CsuI18ORya/MuBcyjj5rKHw
         OGqBw9FvQA+91ljA6QWTZ+QjMYN6u0YAvnZ6iB6zumCkot1zgc+Ge8Zr36k9WdlYCPIq
         5Qa+Xb7vJCv4lzx1IY48fS1EAyLA9/Pui0xCKvGCSTggjJbOVlLLVggs++kF07g3IQ+O
         MDdhIiresslcCgniwoC9JKTEDXB2NgciRQNn42Sv31gjZ6lsRJdl5wmhwdJ/hRypG8x5
         /ePhj9cW+yWQYFKxEnLr1qEJp1o4qn6Mm25gYkJ3tlQqAsxDseFTGf3giZ5YNxic5xeY
         6ocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ImY2DybhOrcM2lI55Kc331ajwFUz03xP4fYhf/CoFd4=;
        b=d1rjARXc5LCMcv6im5mlWZdQtMO52EjqW5mRyAPsSeRtObr9cm5qZAsTi8p3c5zIQv
         Doqtw5NyiXVi6NiB7TddRdWDUGL5j/njICK/58Ce6gxVQSn96aaTMt6DVfZuiXwjOdn9
         saTvUUQ+fd1ADAmJrwkzeEd2O6Leik77k9FGNQ691qg8aDtO5knByPF70WFTtWKWaO5q
         E/ojM4h0EbcSEP4Ag4BPYeUxVHoKQg/o7tzRw1tKEkWfxzrG8zDBk1JtGOw88v7PKROx
         r07hScrctC6V8C/zP+JK/q/AylX+CD4QZAXL6ZoCaSXCBFLZpdVnduB0Ru0wY2W2Qblz
         u2Fw==
X-Gm-Message-State: APjAAAXwby+PZIcz7k/mCmA3czq0dS6+D5bROnSF4hANfurvzH2fVFn8
        Miikye754Iz4oXAfTDXeXHF6jQ==
X-Google-Smtp-Source: APXvYqyrgMcO6GnWamgao3bXgcKs3QGF2zVbFr+EJ+2MO+luR4eSsfFewIm3vX0bBfYAvjwhDqbgCw==
X-Received: by 2002:a0d:eb89:: with SMTP id u131mr71135814ywe.417.1564506747714;
        Tue, 30 Jul 2019 10:12:27 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id x67sm15128373ywg.70.2019.07.30.10.12.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 10:12:27 -0700 (PDT)
Date:   Tue, 30 Jul 2019 13:12:27 -0400
From:   Sean Paul <sean@poorly.run>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/modes: Fix unterminated strncpy
Message-ID: <20190730171227.GS104440@art_vandelay>
References: <20190730084032.26428-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730084032.26428-1-hslester96@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 04:40:32PM +0800, Chuhong Yuan wrote:
> strncpy(dest, src, strlen(src)) leads to unterminated
> dest, which is dangerous.
> Fix it by using strscpy.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  drivers/gpu/drm/drm_modes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> index 80fcd5dc1558..170fc24e0f31 100644
> --- a/drivers/gpu/drm/drm_modes.c
> +++ b/drivers/gpu/drm/drm_modes.c
> @@ -1770,7 +1770,7 @@ bool drm_mode_parse_command_line_for_connector(const char *mode_option,
>  	}
>  
>  	if (named_mode) {
> -		strncpy(mode->name, name, mode_end);
> +		strscpy(mode->name, name, mode_end + 1);

Shouldn't you be checking that mode_end + 1 is not > than the size of mode->name
(ie: DRM_DISPLAY_MODE_LEN)? This still seems unsafe.

Sean

>  	} else {
>  		ret = drm_mode_parse_cmdline_res_mode(name, mode_end,
>  						      parse_extras,
> -- 
> 2.20.1
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
