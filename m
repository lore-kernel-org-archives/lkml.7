Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B914C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DAAE20B7C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfJAS6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 14:58:07 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46058 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfJAS6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 14:58:06 -0400
Received: by mail-qk1-f193.google.com with SMTP id z67so12294464qkb.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 11:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7EY66jo6PvKaSsJh31JkxqgQFmjMunJ0Kvj/PM6tpU0=;
        b=PcdoUCulTNV/AY4s47R9/60DLDt/DTGSAiwPBfdGyI6Vdd7YRjtDlUW17XIuz4dy6D
         GhhNGFR/zLXO4CVkruFlnibh1W6L7hktJ9TffmqomOhzk/ye5qXJDwpbUa8w9+1u/8Hp
         pYJYnXYzU8o/Gh2o2FqrTImzO91I/gRAltYH1OUEmN5CoJIYrfgGRTP9pxQPqEUZZHvn
         7u8OQtDRYEZCLMz233B+/qzPd6usHNwO0dBzR4NaFd/Jyi1gbmMTz6NsdXUsg28xGR7c
         cDEGKjBFMalvyl4/nyTDF5v1wS9aPaHGdaJDm9TJJbjdBZN9/QWrEPi8pAhIMNQhehqb
         hVpQ==
X-Gm-Message-State: APjAAAVe1UvTAw6nLtxXYJaf+LO0bpd7XSJBOhqIkBEr7HxhSRhwwQsN
        rA5lydj5LgjBFEmU9Pabq3Riphr1qO0o2Lix1Ck=
X-Google-Smtp-Source: APXvYqyDB8xPt1kofeJ9vy4DjGVaLfhn0UKXBeJHpGI6/IjnKwTQqHsuDY0fC/wEA0lObfyGUxpteBLFU4gleCtca20=
X-Received: by 2002:a37:a858:: with SMTP id r85mr7732418qke.394.1569956285225;
 Tue, 01 Oct 2019 11:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190906153948.2160342-1-arnd@arndb.de> <alpine.DEB.2.21.1910011032500.20899@sstabellini-ThinkPad-T480s>
In-Reply-To: <alpine.DEB.2.21.1910011032500.20899@sstabellini-ThinkPad-T480s>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 1 Oct 2019 20:57:49 +0200
Message-ID: <CAK8P3a3Nhh1isvm--U8-s5F0bH1DHQ8pYR_+yB9xckhzyV=x3Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: xen: unexport HYPERVISOR_platform_op function
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     Emil Velikov <emil.l.velikov@gmail.com>,
        Denis Efremov <efremov@linux.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Russell King <linux@armlinux.org.uk>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 1, 2019 at 7:38 PM Stefano Stabellini
<sstabellini@kernel.org> wrote:

> Thank you for the patch. HYPERVISOR_platform_op() is an inline function,
> the underlying function that should be exported is
> HYPERVISOR_platform_op_raw. So, instead of removing
> HYPERVISOR_platform_op, we should change it to
> HYPERVISOR_platform_op_raw.

Ok, that makes sense.

> For convenience, and for testing I cooked up a patch. Arnd, if you are
> happy with it (in the sense that it solves your problem) we'll check it
> in the xentip tree, unless you would like to get it in your tree?
>

Please merge it through your tree.

> @@ -437,7 +437,7 @@ EXPORT_SYMBOL_GPL(HYPERVISOR_memory_op);
>  EXPORT_SYMBOL_GPL(HYPERVISOR_physdev_op);
>  EXPORT_SYMBOL_GPL(HYPERVISOR_vcpu_op);
>  EXPORT_SYMBOL_GPL(HYPERVISOR_tmem_op);
> -EXPORT_SYMBOL_GPL(HYPERVISOR_platform_op);
> +EXPORT_SYMBOL_GPL(HYPERVISOR_platform_op_raw);
>  EXPORT_SYMBOL_GPL(HYPERVISOR_multicall);
>  EXPORT_SYMBOL_GPL(HYPERVISOR_vm_assist);
>  EXPORT_SYMBOL_GPL(HYPERVISOR_dm_op);

Note that there are obviously no callers from any loadable modules in the
kernel, all users are in built-in code at the moment. As an API definition
it still makes sense though.

      Arnd
