Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D00CC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5B620643
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gScKYK/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfCGPZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:25:39 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35920 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfCGPZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:25:38 -0500
Received: by mail-ed1-f66.google.com with SMTP id g9so13793313eds.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 07:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d4oCP9D61A30YQhDSKeAS0gHpgsh2C8u7srCjP6Vupg=;
        b=gScKYK/eiNt9bX9fP2HWfvbMQdpaD6on54O61kKCT8N6XvWmrYk6BEorg3NFIPlDJL
         Pbov/ORT0F1rxiPmRyGdpbPkKL5D6lpKNmA5KyAgXflq7ZNKq5z5JGDZrHleQElAJurn
         lEpnrweYT1Vd4eQyDIBXzup/NbrjVZX4XJ964LVYEaRPrOrtJC5/T7VT78XOv+1V2LOL
         U48rESF3pA6Z4i1340rj4LubSAgtl5SNKJRLYvkJHqkZZUMRRulpPdtP7Dn6SDE4d8cn
         JsSDfITDQJlAMll85DYGg1eqYNe1YPO0dE30MVRoE3mBxEd0OUVrYVVJqAQFCy8eZGx6
         pM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d4oCP9D61A30YQhDSKeAS0gHpgsh2C8u7srCjP6Vupg=;
        b=BDEcRRSBD9CXmmBfGjCBV/lz13+F+AHPCs4KVDH7s1ZmqqmR5gGouY1f9GxrlOEWEf
         HSt0vBjshmPi5PCTT/kjZ0xx5zgLGUDetSUQocJBg5oaxrb33atWDlOKPSsIEw1cfmjR
         XA6IETOgVXl3hlMyoUDPyRa2Ie6h1RCojvSi/xQI/oZu9D70ikHSxcf2D2uiC9wPp19X
         2m58rsEDAXJXLzCqm5VsbN/n6aum4PDRsd5zrAgGF8FTcQ/AUAGFysn8o9GfsHEwhMP1
         xoFLntFcP/oxdyB4BEBNjTPseDBI7W/JbZLGTOn204xRHPtFVXhFWC7WsibTQnnIibiP
         6FKA==
X-Gm-Message-State: APjAAAWXOZl69eU+z9+5kJG5uifHFih74c/nWo3t62i6tLFbVD8FVj0o
        GYYV5J4brWtG1OIyXfxiEJw=
X-Google-Smtp-Source: APXvYqwiyqRpa9iPcivYFZcTtv4uiuYwvUClLApNsSSUJc3oQHZG+Vf7cc0rdi5Dm0zNZw2dlt/2+w==
X-Received: by 2002:a50:b482:: with SMTP id w2mr28837696edd.41.1551972336641;
        Thu, 07 Mar 2019 07:25:36 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id n25sm1411854edd.83.2019.03.07.07.25.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 07 Mar 2019 07:25:35 -0800 (PST)
Date:   Thu, 7 Mar 2019 08:25:33 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Tony Lindgren <tony@atomide.com>,
        Kees Cook <keescook@chromium.org>,
        Vishal Thanki <vishalthanki@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: davinci-mcasp: Fix clang warning without CONFIG_PM
Message-ID: <20190307152533.GG20201@archlinux-ryzen>
References: <20190307101145.636705-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307101145.636705-1-arnd@arndb.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 11:11:30AM +0100, Arnd Bergmann wrote:
> Building with clang shows a variable that is only used by the
> suspend/resume functions but defined outside of their #ifdef block:
> 
> sound/soc/ti/davinci-mcasp.c:48:12: error: variable 'context_regs' is not needed and will not be emitted
> 
> We commonly fix these by marking the PM functions as __maybe_unused,
> but here that would grow the davinci_mcasp structure, so instead
> add another #ifdef here.
> 
> Fixes: 1cc0c054f380 ("ASoC: davinci-mcasp: Convert the context save/restore to use array")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  sound/soc/ti/davinci-mcasp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
> index a3a67a8f0f54..9fbc759fdefe 100644
> --- a/sound/soc/ti/davinci-mcasp.c
> +++ b/sound/soc/ti/davinci-mcasp.c
> @@ -45,6 +45,7 @@
>  
>  #define MCASP_MAX_AFIFO_DEPTH	64
>  
> +#ifdef CONFIG_PM
>  static u32 context_regs[] = {
>  	DAVINCI_MCASP_TXFMCTL_REG,
>  	DAVINCI_MCASP_RXFMCTL_REG,
> @@ -68,6 +69,7 @@ struct davinci_mcasp_context {
>  	u32	*xrsr_regs; /* for serializer configuration */
>  	bool	pm_state;
>  };
> +#endif
>  
>  struct davinci_mcasp_ruledata {
>  	struct davinci_mcasp *mcasp;
> -- 
> 2.20.0
> 
