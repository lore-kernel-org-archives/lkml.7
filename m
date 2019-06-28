Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE00FC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 14:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FDF62064A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 14:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DFuhj31W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfF1OrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 10:47:03 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39141 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfF1OrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 10:47:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id 196so2693121pgc.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 07:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MwGMwQa0G/r0N9HiU2KjRnzuNoH3qkDbvB9SbT9xcMI=;
        b=DFuhj31WvjS1maruyeOPRyArwIYhnuJfd6DwmEtFlpKJd8/W2horJSRpa3GXxE4K/w
         QXphemyhIjyJ/5IEjpP2vLJVB3yYL0sgNKoSj5IwMxH/OpepgVMz89lcukvaQ+dDeWh1
         vukZX12Lfx+Zog2RXhI3BXyQhWY355bSMt3gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MwGMwQa0G/r0N9HiU2KjRnzuNoH3qkDbvB9SbT9xcMI=;
        b=p24Bzw+8PbRhVReoqEPsy4CwnJaVbwcqqa/+TlfzwBKWsR5LD9VMK347XGph7IBW4T
         OD65SYuyKSQnrbmjMn49KV1R9yfWAraBhTWhwusiYihprnPhumLWp6UfQzdvVfDC1BNk
         IKozvXzSgaoWPbM1BoF3OC8YU8Rwisx3dOLqxUKvsN36BLjfH21AFQkhKodSn2daAZmE
         CpLaFlvodd0fBgR1K82rRoEwL/8HzYgjTpsR1ad6Ckqryj7KfxMsQtPGWjhEzNMklKoN
         Xuww9gQE2/BNhbYvjCanBXF3t38iUsL3P9ocGWIp2B8gKWY3rD27F4adEe13FKgI4N9i
         +E6g==
X-Gm-Message-State: APjAAAWPNrvVUj0Q/FUf/tGxgQqLSZDMX6DPWQ6boIAYgJxjlwVs+RBC
        27sB3IFR23nTpoYN1xiNOcWv5Q==
X-Google-Smtp-Source: APXvYqx/YtJNkaWkOhhcnCWh/GzwPzF2GLiMrEce/L5zDSI8K77ctT1sePVpDioXIYmJKYtrfK1d9A==
X-Received: by 2002:a63:e317:: with SMTP id f23mr9511704pgh.39.1561733222145;
        Fri, 28 Jun 2019 07:47:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u20sm2610199pfm.145.2019.06.28.07.47.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Jun 2019 07:47:01 -0700 (PDT)
Date:   Fri, 28 Jun 2019 07:47:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Emese Revfy <re.emese@gmail.com>
Subject: Re: [PATCH 42/43] docs: move gcc_plugins.txt to core-api and rename
 to .rst
Message-ID: <201906280746.883AF572C9@keescook>
References: <cover.1561723979.git.mchehab+samsung@kernel.org>
 <bfcbd5a6cbbbdb10122b30176c3bb907bf1731fc.1561723980.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfcbd5a6cbbbdb10122b30176c3bb907bf1731fc.1561723980.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 09:20:38AM -0300, Mauro Carvalho Chehab wrote:
> The gcc_plugins.txt file is already a ReST file. Move it
> to the core-api book while renaming it.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  Documentation/{gcc-plugins.txt => core-api/gcc-plugins.rst} | 0
>  Documentation/core-api/index.rst                            | 2 +-
>  MAINTAINERS                                                 | 2 +-
>  scripts/gcc-plugins/Kconfig                                 | 2 +-
>  4 files changed, 3 insertions(+), 3 deletions(-)
>  rename Documentation/{gcc-plugins.txt => core-api/gcc-plugins.rst} (100%)
> 
> diff --git a/Documentation/gcc-plugins.txt b/Documentation/core-api/gcc-plugins.rst
> similarity index 100%
> rename from Documentation/gcc-plugins.txt
> rename to Documentation/core-api/gcc-plugins.rst
> diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
> index 2466a4c51031..d1e5b95bf86d 100644
> --- a/Documentation/core-api/index.rst
> +++ b/Documentation/core-api/index.rst
> @@ -35,7 +35,7 @@ Core utilities
>     boot-time-mm
>     memory-hotplug
>     protection-keys
> -
> +   gcc-plugins
>  
>  Interfaces for kernel debugging
>  ===============================
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2cf8abf6d48e..7ba6d174f49f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6609,7 +6609,7 @@ S:	Maintained
>  F:	scripts/gcc-plugins/
>  F:	scripts/gcc-plugin.sh
>  F:	scripts/Makefile.gcc-plugins
> -F:	Documentation/gcc-plugins.txt
> +F:	Documentation/core-api/gcc-plugins.rst
>  
>  GASKET DRIVER FRAMEWORK
>  M:	Rob Springer <rspringer@google.com>
> diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
> index e9c677a53c74..d33de0b9f4f5 100644
> --- a/scripts/gcc-plugins/Kconfig
> +++ b/scripts/gcc-plugins/Kconfig
> @@ -23,7 +23,7 @@ config GCC_PLUGINS
>  	  GCC plugins are loadable modules that provide extra features to the
>  	  compiler. They are useful for runtime instrumentation and static analysis.
>  
> -	  See Documentation/gcc-plugins.txt for details.
> +	  See Documentation/core-api/gcc-plugins.rst for details.
>  
>  menu "GCC plugins"
>  	depends on GCC_PLUGINS
> -- 
> 2.21.0
> 

-- 
Kees Cook
