Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413EFC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14884206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="fp3HzWJA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfFEQAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 12:00:45 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40488 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfFEQAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 12:00:45 -0400
Received: by mail-pg1-f196.google.com with SMTP id d30so12621564pgm.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 09:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=UKzg+DCRQdvZVV0IXkzVXeynq1ptXUJceOTdTsX6Gl4=;
        b=fp3HzWJAxjvdFoCskFMW0CsmQbIUx9erbqizUvfclUhHxGf+Erb+WctD9tdHvPc110
         JcTZ1Jrj3cEXaY3oRw+lKZAxo2afB9jZNL425d6yl/xh2Q4coGKZe1nlURSRV5tNZ6i6
         6icO1zrReJmPy7Du5sTkxfslAWn6noDKs/PrMyNUtOVkwOJpkPIQe3dijIExYyfN/ZCu
         i1wSJCUH6EXOHXB1+broOTrpsq0NDHU6pZXot1zH/+qGeGZeHWd8wJmfmHx5m8lSJFZ8
         aT+E7HnrfPIakIqleI4JD6nj+pq/wnrl7M07QdrRxCNeapcqe4RkT702f9AqOz1d2G6Y
         RanQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=UKzg+DCRQdvZVV0IXkzVXeynq1ptXUJceOTdTsX6Gl4=;
        b=KCCLSdltwY4/UfCvuuIWra7eX6W0CFPZG2qON+2WFJURA+leU66F0xkjt7p+uixhbH
         kVZY57Sdirjq4p+qOyfQ3ApEjdnkkutwOb+quPveh2skd0OzL8c6Q6R0yNPBWrlz2h0w
         3A3PbIcok/BpZK3LfdNSvLTlvim9OSLQIbD70BmnS4gQEokANrX0D0kzUiSBdyVkJ5O6
         CT4n9qeN/6hsJbrYTIZI5owCe9+WN/As4aHo/Jil/P1/ZuFu1+sHSV9r0Xv+3UoGCX+H
         8419wJo4WoBBgLVYMIY4jWUfIcykG8eJCS4kRKyyIg9ZYRaw86Lj6DrXxxzLLQqedJNS
         qcoA==
X-Gm-Message-State: APjAAAU8YylSobbY7yHD7bb/KlPoTFToW9V6KE55Ue7vK+sXnN1B9n3g
        FoVoA3CYPQVjgbNKhlKV56k7xA==
X-Google-Smtp-Source: APXvYqzi9Aq/IOPhUaYi+lh6Xpc7UtaCrRzBvBPL1qB9kcuXVFYBuo3Q0o7uDyHQkyOEJiRLQ5MIlA==
X-Received: by 2002:a63:5457:: with SMTP id e23mr5607600pgm.307.1559750444418;
        Wed, 05 Jun 2019 09:00:44 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:b195:645b:2f67:9ebb])
        by smtp.googlemail.com with ESMTPSA id a12sm21837874pgq.0.2019.06.05.09.00.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 09:00:43 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Atish Patra <atish.patra@wdc.com>, linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <Anup.Patel@wdc.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Nick Kossifidis <mick@ics.forth.gr>,
        Palmer Dabbelt <palmer@sifive.com>,
        Zong Li <zong@andestech.com>,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        marek.vasut@gmail.com, catalin.marinas@arm.com,
        will.deacon@arm.com, trini@konsulko.com, paul.walmsley@sifive.com
Subject: Re: [v3 PATCH] RISC-V: Add a PE/COFF compliant Image header.
In-Reply-To: <20190523183516.583-1-atish.patra@wdc.com>
References: <20190523183516.583-1-atish.patra@wdc.com>
Date:   Wed, 05 Jun 2019 09:00:42 -0700
Message-ID: <7hef48ggyd.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Atish Patra <atish.patra@wdc.com> writes:

> Currently, last stage boot loaders such as U-Boot can accept only
> uImage which is an unnecessary additional step in automating boot flows.
>
> Add a PE/COFF compliant image header that boot loaders can parse and
> directly load kernel flat Image. The existing booting methods will continue
> to work as it is.
>
> Another goal of this header is to support EFI stub for RISC-V in future.
> EFI specification needs PE/COFF image header in the beginning of the kernel
> image in order to load it as an EFI application. In order to support
> EFI stub, code0 should be replaced with "MZ" magic string and res5(at
> offset 0x3c) should point to the rest of the PE/COFF header (which will
> be added during EFI support).
>
> This patch is based on ARM64 boot image header and provides an opprtunity
> to combine both ARM64 & RISC-V image headers.
>
> Tested on both QEMU and HiFive Unleashed using OpenSBI + U-Boot + Linux.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>

Tested booti support on HiFive Unleashed using OpenSBI + U-Boot (master
branch) + Linux.

Tested-by: Kevin Hilman <khilman@baylibre.com>
