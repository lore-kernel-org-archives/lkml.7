Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8121EC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5524420708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQQWRgqo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfKVLju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:39:50 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41055 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfKVLjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:39:49 -0500
Received: by mail-pf1-f196.google.com with SMTP id p26so3364409pfq.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 03:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YUGJKVrycnJTlGVKAo+rQ9RRZBSMb8QTIRmNqH2bNwI=;
        b=BQQWRgqowYXJKMkQvn45vZTga2rmiDy03er8pX6KXj/45IWh8+gQ32A0SiRVut4Tpn
         smRhcNpZ1rCFmUOYZWRS4LUnkPBcPYS8yYvH0HwE2M9P2f+D0sKZE8KdhdK9fBcu0+Sv
         9g0BykkVPsFI/txDTfxnbXAKJpNmT+ggjMOuSTgt9eHHGLBg+Xj1cpFmxIaYgr1bsXIs
         qDsDCYEir3HM5CtJC60bhivL1wSvnpFbtfXlEznlS41TDbpjDCa9jloT3Tf/6k3RPlvF
         lQ42SBVbuq+un3Oy116l+5fIwLRwpeBBauWqk+8i5mXSdKSQ7n0SaLa6I8EP5HVKo2eU
         6pgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YUGJKVrycnJTlGVKAo+rQ9RRZBSMb8QTIRmNqH2bNwI=;
        b=kcOv6X84J9/BN8TgOP1kx8EjpbZcGa0XDXgXHJKny3/pyL8rKekH/VhLy/fm5j1BBI
         /A2+zu7ww1FTSuvjA2SzQICIr9lt4KuyE+rqWcRldz3bosB9A/PClIBG6YNHng99TCjs
         VTw7VnigHrAMi/1Emm78ukQUbb3VGCr8LiFON1k4VUZ9WxuAz/xHU4Lm/Z3UquAOqxl4
         m2MOmRAnYgZp9QpWIFwQz24TTKes3iU75H4CNAyji4IPzHH2fI//RL5I3QN6vz8C84e4
         J3wA8KKbOTd+xuWyJIoDOwZ5m6NMlKH13YwJfOp9uoJ5BPYYIjj2RD4nqsgZqsvpFAPI
         ITBA==
X-Gm-Message-State: APjAAAXVjfF6IxXOpDEpioo8zbYgQGwS0Hg4VHCL7Q9u8/KbHHEj06JH
        GzJQHYi9VbNbOzk9S4UrE8s=
X-Google-Smtp-Source: APXvYqwdNHIlJNS7n1P1nOUqGYy2fQ+PEoU+AxoFvydk8nziOOuPaW79miW0+sSOm6bmSQpCqZAkSQ==
X-Received: by 2002:a63:190a:: with SMTP id z10mr11025834pgl.153.1574422788779;
        Fri, 22 Nov 2019 03:39:48 -0800 (PST)
Received: from localhost (g143.222-224-150.ppp.wakwak.ne.jp. [222.224.150.143])
        by smtp.gmail.com with ESMTPSA id z10sm7432600pfr.139.2019.11.22.03.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 03:39:48 -0800 (PST)
Date:   Fri, 22 Nov 2019 20:39:45 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH] openrisc: Fix Kconfig indentation
Message-ID: <20191122113945.GL24874@lianli.shorne-pla.net>
References: <20191120133712.12066-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120133712.12066-1-krzk@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 09:37:12PM +0800, Krzysztof Kozlowski wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Stafford Horne <shorne@gmail.com>

Thanks, I must have forgot to hit the TAB button on a few of these.  I will
queue these up for the next release unless you have a queue you want to merge
them on.

-Stafford

> ---
>  arch/openrisc/Kconfig | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> index bf326f0edd2f..1928e061ff96 100644
> --- a/arch/openrisc/Kconfig
> +++ b/arch/openrisc/Kconfig
> @@ -13,7 +13,7 @@ config OPENRISC
>  	select IRQ_DOMAIN
>  	select HANDLE_DOMAIN_IRQ
>  	select GPIOLIB
> -        select HAVE_ARCH_TRACEHOOK
> +	select HAVE_ARCH_TRACEHOOK
>  	select SPARSE_IRQ
>  	select GENERIC_IRQ_CHIP
>  	select GENERIC_IRQ_PROBE
> @@ -51,12 +51,12 @@ config NO_IOPORT_MAP
>  	def_bool y
>  
>  config TRACE_IRQFLAGS_SUPPORT
> -        def_bool y
> +	def_bool y
>  
>  # For now, use generic checksum functions
>  #These can be reimplemented in assembly later if so inclined
>  config GENERIC_CSUM
> -        def_bool y
> +	def_bool y
>  
>  config STACKTRACE_SUPPORT
>  	def_bool y
> @@ -89,8 +89,8 @@ config DCACHE_WRITETHROUGH
>  	  If unsure say N here
>  
>  config OPENRISC_BUILTIN_DTB
> -        string "Builtin DTB"
> -        default ""
> +	string "Builtin DTB"
> +	default ""
>  
>  menu "Class II Instructions"
>  
> @@ -161,13 +161,13 @@ config OPENRISC_HAVE_SHADOW_GPRS
>  	  On a unicore system it's safe to say N here if you are unsure.
>  
>  config CMDLINE
> -        string "Default kernel command string"
> -        default ""
> -        help
> -          On some architectures there is currently no way for the boot loader
> -          to pass arguments to the kernel. For these architectures, you should
> -          supply some command-line options at build time by entering them
> -          here.
> +	string "Default kernel command string"
> +	default ""
> +	help
> +	  On some architectures there is currently no way for the boot loader
> +	  to pass arguments to the kernel. For these architectures, you should
> +	  supply some command-line options at build time by entering them
> +	  here.
>  
>  menu "Debugging options"
>  
> @@ -185,7 +185,7 @@ config OPENRISC_ESR_EXCEPTION_BUG_CHECK
>  	default n
>  	help
>  	  This option enables some checks that might expose some problems
> -          in kernel.
> +	  in kernel.
>  
>  	  Say N if you are unsure.
>  
> -- 
> 2.17.1
> 
