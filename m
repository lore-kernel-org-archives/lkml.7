Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F62C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 15:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D832721E6F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 15:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfKKPn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 10:43:28 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38855 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfKKPn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 10:43:28 -0500
Received: by mail-oi1-f196.google.com with SMTP id a14so11863852oid.5;
        Mon, 11 Nov 2019 07:43:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z6HV/05PdJu45/hjcLEgqCV/MZrUUiKc/hGTBlNfe2o=;
        b=lS7wmM84K+nqv6P7kCkOCFHebPJJTnPUS0IqRB1NV0HqL9HzAa1FK9UAIySx4+DCCT
         B4GKd9QqPIhorz4mxOGWMJ3FHuR+CRIoQ0/i5OA/LKJrAuUWjEo/TdOs9WViA44Zb8VY
         S8KnaM0Dxi8tW8fcHtvJj0lI87b+2F2QoNpPgetL0dfhfpAoUZkewoP73VpK2MAuwyv3
         GW+YEhV96Zl6kdrDSVHZsMnBm43WLhLt02sF81f+i8tZeai9smtu4srf4RSQKikajx9o
         Y0aetk1p8lElkpe3lxFpFs2xLRvzE+KjprNWrc0n5PVh+FhvQuR8EIx5hl7uoFbEHb0p
         DRzA==
X-Gm-Message-State: APjAAAVpbKGcLJd4Ma7c1thaa+8n17mxl7zlH54vUZJ2GoihJs8oPzv+
        PWvxTNf2QtekGYBuQ5bzHWgB+YZIIvR0zd23mUWzALqE
X-Google-Smtp-Source: APXvYqw4gi4nZZm2xB7kPcwoljXBgj5176ujC7Yt4McOjXIfa4RgNiSfcPXRGbvEXmIiQzj40xZCa+zJEl1fnriA0cc=
X-Received: by 2002:aca:882:: with SMTP id 124mr1163674oii.54.1573487006964;
 Mon, 11 Nov 2019 07:43:26 -0800 (PST)
MIME-Version: 1.0
References: <20191111151344.7401-1-geert@linux-m68k.org>
In-Reply-To: <20191111151344.7401-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Nov 2019 16:36:18 +0100
Message-ID: <CAMuHMdXenPQJQn1qVL494cB89GZAcZqXMVhw4PW+ZgSqdgtAyQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.4-rc7
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     linux-s390 <linux-s390@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 4:18 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.4-rc7[1] to v5.4-rc6[3], the summaries are:
>   - build errors: +0/-2
>   - build warnings: +48/-70

  + /kisskb/src/fs/ubifs/orphan.c: warning: format '%lu' expects
argument of type 'long unsigned int', but argument 4 has type 'ino_t'
[-Wformat]:  => 140:3, 132:3

s390x/s390-all{mod,yes}config

Why is ino_t unsigned int on s390x and alpha, while it's unsigned long
everywhere else?

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/31f4f5b495a62c9a8b15b1c3581acd5efeb9af8c/ (232 out of 242 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/a99d8080aaf358d5d23581244e5da23b35e340b9/ (232 out of 242 configs)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
