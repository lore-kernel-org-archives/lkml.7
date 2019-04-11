Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E025C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2142184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="d/RYmzN6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfDKIvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:51:07 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:58321 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbfDKIvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:51:04 -0400
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x3B8okCr023453;
        Thu, 11 Apr 2019 17:50:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x3B8okCr023453
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554972647;
        bh=F5UI1sOsF59TtjXlusyUA329j5S/sWWuTeBpDyNH8dk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d/RYmzN6ST5N/YsSzVgPcQzH3cyMqb8TuE5NCl98a5Pywu8I2QhoF1yIJsnDNWvN3
         s1eZAkZj6g1zGj6dTA8hu8KD0QUKzqDE5Bo0smp5Ir6SOhAIDz560UGV/0LNSUDdAv
         kigIIlBa0f3Bk4Dr/DZo/RLNdOJOouhRLFm+lHWi9BPPhCTLO8UKyycuc2DYAQvCHN
         L9gu0/jcZ/P6gzqEOLh/KG9vmLuMIztEqyiqaDmTJ9823wo6P+Q4RMTlNLrPNf84D3
         BiPs80CJ79s/xtTfvLBtKnAvhvPJn3QHCT5WTPDa9Yrr9HrE3YcB8NhVqzTnSGnWM1
         zEYA7NEhb0V4Q==
X-Nifty-SrcIP: [209.85.221.177]
Received: by mail-vk1-f177.google.com with SMTP id s80so1197332vke.6;
        Thu, 11 Apr 2019 01:50:47 -0700 (PDT)
X-Gm-Message-State: APjAAAUZTjqQ14TMhFukVZB2QSpWcw0Ygt7KjvpqHW8LxqAWVYg+Rnn0
        ilh8ofUSzwQUIiYr3AegKvKvqQQrAYBiUBKwpic=
X-Google-Smtp-Source: APXvYqzwcW+9zJIIvdmhRqXhqVxtLBKGueKPNN9kaKRMJ559bumruRRn0ZJt5oR6zgA2KIvhg+Gtre24QbvHZQdMfc8=
X-Received: by 2002:a1f:793:: with SMTP id 141mr14474270vkh.31.1554972646242;
 Thu, 11 Apr 2019 01:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190410161612.18545-1-keescook@chromium.org> <20190410161612.18545-2-keescook@chromium.org>
In-Reply-To: <20190410161612.18545-2-keescook@chromium.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 11 Apr 2019 17:50:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNASLdZKNNM-Gft5bfVxKOG=4Ak-LBMnjb2E-QR4q_5GmEQ@mail.gmail.com>
Message-ID: <CAK7LNASLdZKNNM-Gft5bfVxKOG=4Ak-LBMnjb2E-QR4q_5GmEQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] Kconfig: Create "kernel hardening" config area
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Alexander Popov <alpopov@ptsecurity.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Emese Revfy <re.emese@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 1:16 AM Kees Cook <keescook@chromium.org> wrote:
> diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
> index 74271dba4f94..01874ef0f883 100644
> --- a/scripts/gcc-plugins/Kconfig
> +++ b/scripts/gcc-plugins/Kconfig
> @@ -13,10 +13,11 @@ config HAVE_GCC_PLUGINS
>           An arch should select this symbol if it supports building with
>           GCC plugins.
>
> -menuconfig GCC_PLUGINS
> -       bool "GCC plugins"
> +config GCC_PLUGINS
> +       bool


This will flatten the plugin config options.

If you want to keep the current menu structure, you can do:

menu "GCC plugins"
...
endmenu




Another side-effect is Kbuild will descend into scripts/gcc-plugins/
even when no plugin is selected.
It is not a big build speed regression, though.



> diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> new file mode 100644
> index 000000000000..8223a8ab1a12
> --- /dev/null
> +++ b/security/Kconfig.hardening
> @@ -0,0 +1,94 @@
> +menu "Kernel hardening options"
> +
> +config GCC_PLUGIN_STRUCTLEAK
> +       bool
> +       depends on GCC_PLUGIN_STRUCTLEAK_USER || GCC_PLUGIN_STRUCTLEAK_BYREF || GCC_PLUGIN_STRUCTLEAK_BYREF_ALL


I think this 'depends on' is unnecessary.


> +menu "Memory initialization"
> +
> +choice
> +       prompt "Initialize kernel stack variables at function entry"
> +       depends on CC_HAS_AUTO_VAR_INIT || GCC_PLUGINS

Nit:
CC_HAS_AUTO_VAR_INIT does not exist at this point.
I will be added by 3/3.


-- 
Best Regards
Masahiro Yamada
