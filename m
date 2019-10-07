Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299E0ECE58E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 20:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 034A821835
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 20:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUy3Ey2j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbfJGUFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 16:05:36 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35292 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbfJGUFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 16:05:35 -0400
Received: by mail-wm1-f66.google.com with SMTP id y21so788388wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 13:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zpqh/2Usq3AQxv2p5u7LDb/DJaQ2+JAq8e1TQs5MjIc=;
        b=JUy3Ey2jTcYGxo1a3RKyPGVHKSZg0MdMVS6VDUkQncyrHMHWIOK4wO5cQi1mFbjx7M
         dK6VYs7bNPOXZEsSxoKbOlowrzIPN1iZew9DehDc5t5LTkuOMeiFZj06m6wOv89o5O4H
         Gp+GD3E7QUoBKBMBRNyfjTIo0HnVYAZZ+y1oEKZPGTeJznnYLRDStzdVFCvLKTsRCUS9
         hWlDDCz95RwpKkgA0XSD98ytFyrUtIIbuMko88UgdqghuA/ZSW8xptyMIIfZjT7LhSJw
         o1MFQYP0mD09l4C/fM884An4ltxkww60ctJr43XKz4t0I+4+asNaZBVGcI1ZfkON/81W
         NY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zpqh/2Usq3AQxv2p5u7LDb/DJaQ2+JAq8e1TQs5MjIc=;
        b=iZIAU6GCOt0INqbsf1NZwSzL3s9kn0j3EU2BnZTgNX9nBE/2P+Jrqev8sAP4EW4Q3p
         65yQ1FcAme1o8Cwu0w6fvgu9PxypG0iGoz+FG0u1NEuR2uRAJL81j6QNYHqBkoHtHbEt
         xV33UyxrkJh2d5RGfyXsm3q3qIb7c9gyn4/uHLIwWbpn+Ia+T9UaZK9ibfbBBcZgpSU+
         EhdCoyKHYm0lUIe/0+GEXU6Tc8OmYrEzW+uIjngtHHJVWueQRt0/9+NCmx17KKX21JKV
         f19ljX59t0ymeorahO/5tEAycrFka2rXwHtqOPUJh4H+i6TEScbRqaa09fO+t7+Mu0YQ
         gojA==
X-Gm-Message-State: APjAAAUDUvNX6WsWwokbjMmJ9lcrL2ZJ4brGc3QPKbfOGFE9RGHc4+vF
        3qbaeW0X98LZ/I5OvQTHBgU=
X-Google-Smtp-Source: APXvYqwT9NNae5yTfGzWZon12eSyue2k4QZ82NnQVN/PtM/hc4G5XodmY1g0tfNd91RbgSt1q32sZw==
X-Received: by 2002:a1c:1bd8:: with SMTP id b207mr752943wmb.62.1570478731663;
        Mon, 07 Oct 2019 13:05:31 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id h7sm16302556wrt.17.2019.10.07.13.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 13:05:30 -0700 (PDT)
Date:   Mon, 7 Oct 2019 13:05:29 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Arvind Sankar <nivedita@alum.mit.edu>, x86@kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] x86/purgatory: Make sure we fail the build if
 purgatory.ro has missing symbols
Message-ID: <20191007200529.GA716619@archlinux-threadripper>
References: <20191007175546.3395-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007175546.3395-1-hdegoede@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 07:55:46PM +0200, Hans de Goede wrote:
> Since we link purgatory.ro with -r aka we enable "incremental linking"
> no checks for unresolved symbols is done while linking purgatory.ro.
> 
> Changes to the sha256 code has caused the purgatory in 5.4-rc1 to have
> a missing symbol on memzero_explicit, yet things still happily build.
> 
> This commit adds an extra check for unresolved symbols by calling ld
> without -r before running bin2c to generate kexec-purgatory.c.
> 
> This causes a build of 5.4-rc1 with this patch added to fail as it should:
> 
>   CHK     arch/x86/purgatory/purgatory.ro
> ld: arch/x86/purgatory/purgatory.ro: in function `sha256_transform':
> sha256.c:(.text+0x1c0c): undefined reference to `memzero_explicit'
> make[2]: *** [arch/x86/purgatory/Makefile:72:
>     arch/x86/purgatory/kexec-purgatory.c] Error 1
> make[1]: *** [scripts/Makefile.build:509: arch/x86/purgatory] Error 2
> make: *** [Makefile:1650: arch/x86] Error 2
> 
> This will help us catch missing symbols in the purgatory sooner.
> 
> Note this commit also removes --no-undefined from LDFLAGS_purgatory.ro
> as that has no effect.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/x86/purgatory/Makefile | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> index fb4ee5444379..0da0794ef1f0 100644
> --- a/arch/x86/purgatory/Makefile
> +++ b/arch/x86/purgatory/Makefile
> @@ -14,7 +14,7 @@ $(obj)/sha256.o: $(srctree)/lib/crypto/sha256.c FORCE
>  
>  CFLAGS_sha256.o := -D__DISABLE_EXPORTS
>  
> -LDFLAGS_purgatory.ro := -e purgatory_start -r --no-undefined -nostdlib -z nodefaultlib
> +LDFLAGS_purgatory.ro := -e purgatory_start -r -nostdlib -z nodefaultlib
>  targets += purgatory.ro
>  
>  KASAN_SANITIZE	:= n
> @@ -60,10 +60,16 @@ $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
>  
>  targets += kexec-purgatory.c
>  
> +# Since we link purgatory.ro with -r unresolved symbols are not checked,
> +# so we check this before generating kexec-purgatory.c instead
> +quiet_cmd_check_purgatory = CHK     $<
> +      cmd_check_purgatory = ld -e purgatory_start $<

I think this should be $(LD) -e ... so that using a cross compile prefix
(like x86_64-linux-) or an alternative linker like ld.lld works properly.

> +
>  quiet_cmd_bin2c = BIN2C   $@
>        cmd_bin2c = $(objtree)/scripts/bin2c kexec_purgatory < $< > $@
>  
>  $(obj)/kexec-purgatory.c: $(obj)/purgatory.ro FORCE
> +	$(call if_changed,check_purgatory)
>  	$(call if_changed,bin2c)
>  
>  obj-$(CONFIG_KEXEC_FILE)	+= kexec-purgatory.o
> -- 
> 2.23.0
> 

Cheers,
Nathan
