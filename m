Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6772DC32767
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 05:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3203B215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 05:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="B/CwpXbV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgAFF2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 00:28:10 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40595 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgAFF2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 00:28:09 -0500
Received: by mail-pf1-f193.google.com with SMTP id q8so26421962pfh.7
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jan 2020 21:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=ymhTcMEmDFG9TKBAl66QxLJ2ntfziG/odU0UA166lJg=;
        b=B/CwpXbVt3NAU1qBeDI6Lzg+yNnfGsl+vtj89sjvSQ8lJb870b2kZTDO8VFoFr4jW0
         jZ5A7irZ5E6FY0XzFQq8dnv7Wb2CicWzIg4yADZ1boeO+JyCk+hvl+g+cCMRxUyTCfck
         uCgtoNg2zF3IUyVra9q3fmCi/fGbgRfEjefu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ymhTcMEmDFG9TKBAl66QxLJ2ntfziG/odU0UA166lJg=;
        b=YutigQvYyZwxvIyP6KeH+TtWyiHj+d9Q4i2GJv2dL1aT9DFUhg4OVwcfTqQ+WId2Mz
         KElBVBFKaoCL7GwitRZKNjhJ6SpyH+KdXP8zvnJl5xlF5QeQj3Cc5W4s+tkiPXOFHTZF
         xeKZztSpQbPtG9NuFZkViATG91NPa1FmoOQ9cxPo+hSomcl1WggWP3Zu5kU183IYaB7k
         hvXD/w61PRZGBGCzVK9KAPeyRpFcLOoz0CE0giwhiKRcFQw5b/fhWBavecTySs8xKakO
         peOJp0a3ab9rYmr4P0xYp4mtN8slzWLxncOHNcv88PIUskbHgsrIljsE0Om+kg2Nko+3
         Yrnw==
X-Gm-Message-State: APjAAAUw+YMoOviulAVotylPjUULGJmvkJWrmZ3utNDWvwDY+uacDbtF
        p+5/Foar2i6YCN0s78WuOUnO8orHZ1Q=
X-Google-Smtp-Source: APXvYqwLFfLytt/PqtgNJEI4iGFyg7rJ2DqmH5gW6HxA7fBWai+ycfQJPihyxISe4/AIybjVe+vI/g==
X-Received: by 2002:aa7:8e8f:: with SMTP id a15mr105811812pfr.153.1578288489198;
        Sun, 05 Jan 2020 21:28:09 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-3463-e857-4ed0-a740.static.ipv6.internode.on.net. [2001:44b8:1113:6700:3463:e857:4ed0:a740])
        by smtp.gmail.com with ESMTPSA id 5sm23204917pjt.28.2020.01.05.21.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 21:28:08 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/config: Enable secuity features in skiroot
In-Reply-To: <20200102073058.163746-1-joel@jms.id.au>
References: <20200102073058.163746-1-joel@jms.id.au>
Date:   Mon, 06 Jan 2020 16:28:04 +1100
Message-ID: <87k165nogr.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Stanley <joel@jms.id.au> writes:

> This turns on HARDENED_USERCOPY with HARDENED_USERCOPY_PAGESPAN, and
> FORTIFY_SOURCE.
>
> It also enables SECURITY_LOCKDOWN_LSM with _EARLY and
> LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY options enabled.

This will completely disable xmon when combined with 69393cb03ccd
("powerpc/xmon: Restrict when kernel is locked down"). I don't
personally have a problem with this, but I think not disabling xmon has
come up before as a requirement of some developers.

Is forcing integrity not sufficient? What confidential data held by the
skiroot kernel are you trying to protect? If you just force integrity
you'll get xmon in read-only mode, which should be fine for most
debugging...

Regards,
Daniel

>
> MODULE_SIG is selected by lockdown, so it is still enabled.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  arch/powerpc/configs/skiroot_defconfig | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/configs/skiroot_defconfig b/arch/powerpc/configs/skiroot_defconfig
> index 069f67f12731..0a441c414a57 100644
> --- a/arch/powerpc/configs/skiroot_defconfig
> +++ b/arch/powerpc/configs/skiroot_defconfig
> @@ -33,7 +33,6 @@ CONFIG_JUMP_LABEL=y
>  CONFIG_STRICT_KERNEL_RWX=y
>  CONFIG_MODULES=y
>  CONFIG_MODULE_UNLOAD=y
> -CONFIG_MODULE_SIG=y
>  CONFIG_MODULE_SIG_FORCE=y
>  CONFIG_MODULE_SIG_SHA512=y
>  CONFIG_PARTITION_ADVANCED=y
> @@ -297,5 +296,15 @@ CONFIG_WQ_WATCHDOG=y
>  CONFIG_XMON=y
>  CONFIG_XMON_DEFAULT=y
>  CONFIG_ENCRYPTED_KEYS=y
> +CONFIG_SECURITY=y
> +CONFIG_HARDENED_USERCOPY=y
> +# CONFIG_HARDENED_USERCOPY_FALLBACK is not set
> +CONFIG_HARDENED_USERCOPY_PAGESPAN=y
> +CONFIG_FORTIFY_SOURCE=y
> +CONFIG_SECURITY_LOCKDOWN_LSM=y
> +CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=y
> +CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY=y
> +# CONFIG_INTEGRITY is not set
> +CONFIG_LSM="yama,loadpin,safesetid,integrity"
>  # CONFIG_CRYPTO_ECHAINIV is not set
>  # CONFIG_CRYPTO_HW is not set
> -- 
> 2.24.1
