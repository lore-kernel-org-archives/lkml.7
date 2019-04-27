Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199F7C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 00:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC4C2084F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 00:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMCQTNAt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfD0Ak0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 20:40:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33800 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfD0Ak0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 20:40:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id b3so2486160pfd.1;
        Fri, 26 Apr 2019 17:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=71g7874Dm8GzDB1gp/UmnroMo/FuKzXQ28vDBNXnuLY=;
        b=PMCQTNAti2IUDiu5w5RuV5bzMeagemKbYMycGKukmKSty2oWlxYn9Hxe8q3QjHukn+
         Pt6XDBaP8iA+FIOZk2zfMnhMBvvp07uU7pfO/EJcyd6ysvrlyGsPSqICUaDQ6m8paByp
         /1vutIP6bzqi5/MQftNoq1uNwC+hPZhNQZVuVaJe/0iQIJ3BbJP1llDP1epLk2PnR7y8
         CgS2tnvELBSf/ZTKILC+Ar+ww0rixHMgzMrbQt9VSY7Gte87d4N5dg9xAD7Zv2G4MCkw
         5OPSrO8PBPIpo/TqDWTNvJkBWz5B749Ha9mvv87GuBwW5wIXThaUEs3fuQKaQ+jKWqxw
         SUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=71g7874Dm8GzDB1gp/UmnroMo/FuKzXQ28vDBNXnuLY=;
        b=cvgNY/znl7qcmMW5Z6u/6Pwg9ffah6dHAuNLCS6w26akIapEbtfBAi+gRa2kMg7rFF
         g9Sek7CqeoaL5MZRyODEcbmWYLCenpI5XrnpVmZoUn7bg3IfloKJwdchKg6iRPJ6koTw
         8DftkYc7HWFqJbq3MpYKHYvCzT/FLiXDc0x/L6oN6JsUtcmeVDL+jrqzL9mBfxcDoFIh
         aC7rwh+apXwAfbHmzi78cs4NW0KsaybuiTmxJZMYCL7oXTjoS1vZTb0t3RSAsosAvuuP
         +1/rImngdUHUxPMqCMO7wCGBsz5mnqlSUqyU4xJyhtDlejq/06ZBWf4qRrvaQ3Fmpv4I
         iIuA==
X-Gm-Message-State: APjAAAX2QyArlAKaSPvLxyWZ8Tj/ZpkKqUF3+mCaWz5I/nb5z9u1ycBq
        tWeJliAz2CGTaTmXcN79Vr4=
X-Google-Smtp-Source: APXvYqxHvSvk521QXFirB2vyDQcDxGFNHB+cB0K/N9kLQPlFl5qeuUiIoy/zSQVLOLxfbIoHXsos7A==
X-Received: by 2002:a63:ee15:: with SMTP id e21mr17697767pgi.180.1556325625196;
        Fri, 26 Apr 2019 17:40:25 -0700 (PDT)
Received: from icarus ([2001:268:c1c1:24b4:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id s20sm31884210pgs.39.2019.04.26.17.40.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 17:40:24 -0700 (PDT)
Date:   Sat, 27 Apr 2019 09:41:34 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        akpm@linux-foundation.org
Cc:     linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v14 01/11] bitops: Introduce the for_each_set_clump8 macro
Message-ID: <20190427004134.GB26000@icarus>
References: <cover.1553828158.git.vilhelm.gray@gmail.com>
 <1cc8b30bb3954ca2a0961ffb0a2eed8a005ed670.1553828158.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1cc8b30bb3954ca2a0961ffb0a2eed8a005ed670.1553828158.git.vilhelm.gray@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 12:04:08PM +0900, William Breathitt Gray wrote:
> This macro iterates for each 8-bit group of bits (clump) with set bits,
> within a bitmap memory region. For each iteration, "start" is set to the
> bit offset of the found clump, while the respective clump value is
> stored to the location pointed by "clump". Additionally, the
> bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> respectively get and set an 8-bit value in a bitmap memory region.
> 
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  include/asm-generic/bitops/find.h | 61 +++++++++++++++++++++++++++++++
>  include/linux/bitops.h            |  5 +++
>  2 files changed, 66 insertions(+)

Andrew, Linus,

I reverted your Acked-by/Reviewed-by lines to Cc in this release because
the code has significantly changed from the simplification effort. If
you are satisfied with these changes, please ack to confirm.

William Breathitt Gray
