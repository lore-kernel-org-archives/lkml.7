Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9C1C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C09D2073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jltlGIgb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfLJIB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 03:01:58 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36984 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfLJIB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 03:01:58 -0500
Received: by mail-pl1-f195.google.com with SMTP id c23so1688016plz.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 00:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9dWXNMdJCFNAn4x79bpbL+ytf3BJk+ZTrzu3DtlDPoM=;
        b=jltlGIgbMR/V7IeRWVjfEg9RHlTRUEcLW2osL3et6Smm+ODbpwmwISpaY2FR7AdNi4
         7a338SU6s80Gbe/xYFt9L8VYClJi6zhyf1aCpKvP6ZW2QZXKRBgaEZzJ9/hsXSWawOrI
         QZdz4+Gdb6kT9t+OVRCXNuuzGfyQObquQgbXpwWglbg8R5qnisYBEyQL/oe0Z1hmLdFe
         un5Ee72NBn9E5LRz7hvUi2LLRPHzTaAh+SGjLKHOwV9B0bynu7rF0392dkM9OugK653N
         y/ue0KynC/vzDn9HnLmTfhbvvWc5mbjlNWANXD5+hOZCcAo8u1Js+2em+IgO5U9iROOE
         mfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9dWXNMdJCFNAn4x79bpbL+ytf3BJk+ZTrzu3DtlDPoM=;
        b=fX2coT95l7gZCrf1s/3GTUrQAryTh0kXAugzaaydQycWwE9qLiD53aE3zF7y/gOgsd
         N99wbS2qpYy4Hc1ImI0owVDrju4wyK4fEwv7mA5C3nJDedOjWNN7wznE/1a+AqtEtqSq
         BH4y9flrJyUA5Nb/FgGu8Kb+nnEQWTrdn8FUn5QgaVG5qOhhoXNL2CUBzkpQutP72FOh
         wFFQgRmuP9S/aodHts5CmbEkmLU7FLpWoauFV736TQRiVPITdkec/UAg+SPv8+8yfexG
         meUFxIfojvzHHn8axamooB6VcL0RGpcfGtLgKmgL5LuofxoG5gGYd6IsU17ad2zGTB4W
         cynA==
X-Gm-Message-State: APjAAAUMCGi6kd0JlOGaAIPdmT//Mle5PAOiuyDo/3BEJLU3clGjkQGB
        jvtb1IvBMsywT/7l585kFpc=
X-Google-Smtp-Source: APXvYqyq0Wv8Wi5pDKJnfz/gGcJUsWmpPeccOUAxK/mXzyexVrSeS5FLDDsQZmucMnaMQShHQXwIQg==
X-Received: by 2002:a17:90a:260c:: with SMTP id l12mr4141457pje.58.1575964917321;
        Tue, 10 Dec 2019 00:01:57 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:250d:e71d:5a0a:9afe])
        by smtp.gmail.com with ESMTPSA id f23sm2022613pgj.76.2019.12.10.00.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 00:01:56 -0800 (PST)
Date:   Tue, 10 Dec 2019 17:01:54 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        AlekseyMakarov <aleksey.makarov@linaro.org>
Subject: Re: [RFC/PATCH] printk: Fix preferred console selection with
 multiple matches
Message-ID: <20191210080154.GJ88619@google.com>
References: <b8131bf32a5572352561ec7f2457eb61cc811390.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8131bf32a5572352561ec7f2457eb61cc811390.camel@kernel.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (19/12/10 11:57), Benjamin Herrenschmidt wrote:
[..]
>  - add_preferred_console is called early to register "uart0". In
> our case that happens from acpi_parse_spcr() on arm64 since the
> "enable_console" argument is true on that architecture. This causes
> "uart0" to become entry 0 of the console_cmdline array.

Hmm, two independent console list configuration sources.

[..]
> +++ b/kernel/printk/printk.c
> @@ -2646,8 +2646,8 @@ void register_console(struct console *newcon)
>  		if (i == preferred_console) {
>  			newcon->flags |= CON_CONSDEV;
>  			has_preferred = true;
> +			break;
>  		}
> -		break;
>  	}
>  
>  	if (!(newcon->flags & CON_ENABLED))

Wouldn't this, basically, mean that we want to match only consoles,
which were in the kernel's console= cmdline? IOW, ignore consoles
that were placed into consoles list via alternative path - ACPI.

Hmm.

The patch may affect setups where alias matching is expected to
happen. E.g.:

	console=uartFOO,BAR

Is 8250 the only console that does alias matching?

	-ss
