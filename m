Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BD4C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6782183E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aX1vl5fE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387462AbfDXUyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 16:54:39 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:35510 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbfDXUyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 16:54:39 -0400
Received: by mail-vk1-f195.google.com with SMTP id 204so3027911vkv.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 13:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QP8Hc+J9bLOvU9VxugoQ7hP5ILoXmgE+r1pugIzV97s=;
        b=aX1vl5fEcLju7Z1ua5drliBhRHpy3K0lvoVqYdOoEdJudxv5U5gk44og5wO77E2pkg
         YdZjRBeRRzzoMNkvXK8nW/egirdI1rYIxjkVN0auYiXmPrpam+UaVeRBta5djYNxWi2a
         +JirJ25+SvLEwmGWIuicpkC3d36xA+6f2Gp5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QP8Hc+J9bLOvU9VxugoQ7hP5ILoXmgE+r1pugIzV97s=;
        b=iGr2crOQ5OiSL0CCS6GKWsdsUxto59DUVa/OiRnk0WVKjvuE3YAcYlR0KccAwblG9k
         BBxUNKyo8Xt8rhJXC2pBTjV1eXkPgAI/LLL/CVyPhF8S4lfO9663A+odq7ty/hBRYxXe
         75qp6tKk+n+qBOt1q0nh9Iv+EKeeMrr7uP3qmKG+RgD41jtOk5gk+8NPFGU1PKTNlvEf
         nd6Ijl7lDaMDg9BCcP0gDiDdtqe+xJGV7wyNeMtgN5GnpSUNORLQiYF4mVmSf7Lq87t3
         piUybXDnJFhTmLE/bqDkNad4PSto9AzTEzWXNxXgMnqGcbDrsNX7oxUSFAL4thmmqE7/
         bDGw==
X-Gm-Message-State: APjAAAVYQbTzhxpcKYUbrgKdgkTpmof5PdoT5pazjdflx0Tzurm0IfKM
        BTTNVVqLuxLW92T5KMs8wGxc5CZUlNc=
X-Google-Smtp-Source: APXvYqyiUQcbi+UXkX/iu9pDRBJBmhoGsi8mRDqzAntOtLaB9SilnghmK3S8BW9DIC4z2LYisqrWCg==
X-Received: by 2002:a1f:1604:: with SMTP id 4mr10469450vkw.3.1556139277498;
        Wed, 24 Apr 2019 13:54:37 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id p6sm8413472vke.16.2019.04.24.13.54.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 13:54:36 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id c6so6549084uan.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 13:54:36 -0700 (PDT)
X-Received: by 2002:a9f:2e06:: with SMTP id t6mr2928496uaj.112.1556139275758;
 Wed, 24 Apr 2019 13:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190424203408.GA11386@beast> <20190424205117.GA5291@brain-police>
In-Reply-To: <20190424205117.GA5291@brain-police>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 24 Apr 2019 13:54:24 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJzzku0xjJAyD3T5SDeeoxVtA51wfHPGPrejjn_tNfJ4w@mail.gmail.com>
Message-ID: <CAGXu5jJzzku0xjJAyD3T5SDeeoxVtA51wfHPGPrejjn_tNfJ4w@mail.gmail.com>
Subject: Re: [PATCH v2] binfmt_elf: Update READ_IMPLIES_EXEC logic for modern CPUs
To:     Will Deacon <will.deacon@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Jason Gunthorpe <jgg@mellanox.com>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 1:51 PM Will Deacon <will.deacon@arm.com> wrote:
> Don't you need to hack fs/compat_binfmt_elf.c to pick this up, or am I
> missing some trick? Should just be something like below.
>
> Will
>
> --->8
>
> diff --git a/fs/compat_binfmt_elf.c b/fs/compat_binfmt_elf.c
> index 15f6e96b3bd9..694bc3ee77eb 100644
> --- a/fs/compat_binfmt_elf.c
> +++ b/fs/compat_binfmt_elf.c
> @@ -116,6 +116,11 @@
>  #define        arch_setup_additional_pages compat_arch_setup_additional_pages
>  #endif
>
> +#ifdef compat_elf_read_implies_exec
> +#undef elf_read_implies_exec
> +#define elf_read_implies_exec compat_elf_read_implies_exec
> +#endif
> +
>  /*
>   * Rename a few of the symbols that binfmt_elf.c will define.
>   * These are all local so the names don't really matter, but it

Argh. I thought I already saw stuff like this somewhere, but I think I
must have been looking at some other compat silliness. I'll fix this
and split up the series...

-- 
Kees Cook
