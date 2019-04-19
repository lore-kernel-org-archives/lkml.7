Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4D1C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95F2120449
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+cCwQn7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbfDSSiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:38:03 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43806 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbfDSSiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:38:01 -0400
Received: by mail-pg1-f194.google.com with SMTP id z9so2984335pgu.10;
        Fri, 19 Apr 2019 11:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MklF8PNztSjUNEBc1fSmie3GqF6hawXRpqU3LIf0sTM=;
        b=Y+cCwQn7NtR/IVns+wfnccDQ9CUdKrp91cVcDx6KzCyWG56Vrplh7SWsAWgMXZj7e8
         4MW+BGX/zKj4pVofe5TcgT/y5zw0WqN1IOsmEU13TjOb6pO1625rIkbM9iElmFteTn6I
         FRK2dvToa4FIJj2A3UOrGchzBsqH/dCbDJrISMPUsSK2qHR7d9WLdsbKP3GfvzY4PALg
         ARgNE9m65yCdKiDNcrOvd8KvvBtxhle4Fe0ObOlClg5AiMarivk4ufOLH9QPiEJPIbz/
         cWB8w4FdiYXykKG39Rf83GnF3f255I3iFt6F2v4QIk4VZrMf3XUasxjYfk2vnjqtkEou
         Mc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MklF8PNztSjUNEBc1fSmie3GqF6hawXRpqU3LIf0sTM=;
        b=Fo9dJ/sGgRod3r+QteH2wD47wktD/ejIk4xMjSKvpCRWwzNHLy8lUrk1oOSgiLbp5R
         ApgmiR2P1penSbZ6Eb3XDEOxch+YpAF9AOzOgRV7JFM4Ey95bUdlmzOOKHYJU0aYxyw7
         2YaeOeNTTnUNItLn+pSxwG1Q8ons1Y2HK3Rd047WrGI+UtQo+ALVYAJGfaD3MNtHz0cX
         MzaCS3vwCD990vvsPYDTuoZ7xa2nU4n3JhFGMyAC8AYaOxQP7tjBLFHNWD4SwllmIfrT
         NS7AI4CSLMXe1kEPPhZqR1hBkeafPJ4/cKoPOJqb16cfFxmAuT/bEa0WstiNPOZ7sy9k
         A5AA==
X-Gm-Message-State: APjAAAVqoPRR2XV/X3z9tsuMNX8lmD4RgUtVuBz3taamB8byL28Ciz0T
        7bF6ZaFVQkp255oov4yq+eqkzNO1LZ0=
X-Google-Smtp-Source: APXvYqzhd8z3FJAtKC4F5ro6eKxUN7nyJgpV8t0MJSepyVlQLyKWvQYfpRWgLr+xo8vYOy+azxE1MA==
X-Received: by 2002:aa7:8c13:: with SMTP id c19mr2305723pfd.225.1555659627134;
        Fri, 19 Apr 2019 00:40:27 -0700 (PDT)
Received: from localhost ([61.199.190.18])
        by smtp.gmail.com with ESMTPSA id q87sm6583475pfa.133.2019.04.19.00.40.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 00:40:25 -0700 (PDT)
Date:   Fri, 19 Apr 2019 07:40:21 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 1/4] mod_devicetable: helper macro for declaring oftree
 module device table
Message-ID: <20190419074021.tigbyfezmt4erjms@penguin>
References: <1555444645-15156-1-git-send-email-info@metux.net>
 <1555444645-15156-2-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555444645-15156-2-git-send-email-info@metux.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enrico,

On Tue, Apr 16, 2019 at 09:57:22PM +0200, Enrico Weigelt, metux IT consult wrote:
> Little helper macro that declares an oftree module device table,
> if CONFIG_OF is enabled. Otherwise it's just noop.
> 
> This is also helpful if some drivers can be built w/ or w/o
> oftree support.

This should go to OF folks, please.

> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  include/linux/mod_devicetable.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> index 448621c..853e301 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -245,6 +245,15 @@ struct of_device_id {
>  	const void *data;
>  };
>  
> +/*
> + * macro for adding the of module device table only if CONFIG_OF enabled
> + */
> +#ifdef CONFIG_OF
> +#define MODULE_DEVICE_TABLE_OF(name)	MODULE_DEVICE_TABLE(of,name)
> +#else
> +#define MODULE_DEVICE_TABLE_OF(name)
> +#endif /* CONFIG_OF */
> +
>  /* VIO */
>  struct vio_device_id {
>  	char type[32];
> -- 
> 1.9.1
> 

-- 
Dmitry
