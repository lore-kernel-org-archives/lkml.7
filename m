Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6338DC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35CAA2473C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zwz6SgMY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfFDOhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 10:37:12 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36733 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbfFDOhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:37:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id v22so340674wml.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 07:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=4BkP7vL18hh/Y2SYGfaK20f4ZMauMq57h6342TGfhGs=;
        b=zwz6SgMY3ch+xUVaDLBu8CesXxZYj8excN9ZvfYtO9uZjTtjKhvtwDPZ1Nu9AC1ttH
         nuHWUq+Xf8/Y66jY55H3hHAfYr118Omduae13KxQxUid/39xMjcymjuGI5BdstieMDhw
         SjFgxmqYNp+19t2UYhwSYl70IRKuqajNiu3fJ3GeR02OvaOw1LKwDD889i+aWsUfT5wT
         E5Col1tPqrpUpbOz7ILdjxhdMWGcjuz9kjPqCcIjcuP5AHXmaTFLBLzj1SWlfHa/f2bG
         2WtInzVZJ+H5jzA6gBai6HCAjAeMtP8VWcXRwqPWcSQhJCg+jbkoxwEECL+cYkhiVnum
         Endw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=4BkP7vL18hh/Y2SYGfaK20f4ZMauMq57h6342TGfhGs=;
        b=lWvZh/QWo52UXxqnfeHR4wwajqaAno06iMX0EOGMP9rghHBznsPHc4ai6ygGRfec2+
         JNJ0WN5ktYn3iVr1h0d98tDOkpnWhlxG2UhVtx+Jun60BVQXXdwVErxQ+vXJq+Y+vKLI
         lX5iGdnZyradpAus9hVG3uZIQx10MmyqDA+WnBHPvQGpkpZPQSOA5UevhOqAqmKmyBTm
         G2quAt1CPwZZMJuh9MPl0zLeCE8Rn7zEAwnLTF4RD2KpRX9H4h5FSExOMP+fasEVMEwc
         rlkXvVAgYN0gYqQy/6P0yDWYy95R1TBpe//19iWfEx4w5CoLAlwVc8rhRleZk8L+9Fjh
         wUpw==
X-Gm-Message-State: APjAAAWiVEG+aKdAmC9J9f6eyWErYDZPVooN5YfeWfM3QuqHi0oO3kDN
        JhUrG1UkxtF01FZAVj7GdrBQJQ==
X-Google-Smtp-Source: APXvYqxGadUkWTjW4QvcK05BF6VgFxTONXlpWUID2n0UK6pxnIxdvT5GzX5nOsiVPLz/AMK5qgbF8A==
X-Received: by 2002:a7b:c94a:: with SMTP id i10mr15828555wml.97.1559659029834;
        Tue, 04 Jun 2019 07:37:09 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x129sm14348068wmg.44.2019.06.04.07.37.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 07:37:09 -0700 (PDT)
From:   Loys Ollivier <lollivier@baylibre.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Paul Walmsley <paul@pwsan.com>, Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v3 1/5] arch: riscv: add support for building DTB files from DT source data
In-Reply-To: <20190602080500.31700-2-paul.walmsley@sifive.com>
References: <20190602080500.31700-1-paul.walmsley@sifive.com> <20190602080500.31700-2-paul.walmsley@sifive.com>
Date:   Tue, 04 Jun 2019 16:37:07 +0200
Message-ID: <86v9xlh0x8.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 02 Jun 2019 at 01:04, Paul Walmsley <paul.walmsley@sifive.com> wrote:

> Similar to ARM64, add support for building DTB files from DT source
> data for RISC-V boards.
>
> This patch starts with the infrastructure needed for SiFive boards.
> Boards from other vendors would add support here in a similar form.
>
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> ---
>  arch/riscv/boot/dts/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/Makefile
>
> diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
> new file mode 100644
> index 000000000000..dcc3ada78455
> --- /dev/null
> +++ b/arch/riscv/boot/dts/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +subdir-y += sifive

Always build it ?
Any particular reason to drop ARCH_SIFIVE ?
