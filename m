Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD78C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 04:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66DB206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 04:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhH1uQ0b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfC1E32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 00:29:28 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34150 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfC1E32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 00:29:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id v12so11027916pgq.1;
        Wed, 27 Mar 2019 21:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ra5qmltG1yR3IdkeijZjpsAfDYs4Hq4slA9oLR568/4=;
        b=KhH1uQ0bV+hRHzZ8P11Mhg/zCj6P2VBRf5TAnF0uvC3WoHy/i1cCkO5V5ld9tnt71c
         okHXFlf8k6mjbqX1zL4qUKX6DbKdbpH77hNBuTbXZIbsdPhT64sXJCWuwCK8xOahlJUM
         bJUWtpf/TZ/TQCnsYoa7WqAxJuzQxX7dwyT+ZqF9F8+wDOPLB5q5S2RJVh5VC5kJcM2T
         S6Y56NL2x7Fd4Sw9pZJjWR2UwdsxtOqwNXTmsFggt8Usm5CGip3XsJ9V+JfXTI8U3qjH
         1VmtJiBWhhK8A8ItZmDDrgkajrJ2+QjqqwYW5wIttBdJn50na42eA7FrHwXCGSbTdqT7
         7/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ra5qmltG1yR3IdkeijZjpsAfDYs4Hq4slA9oLR568/4=;
        b=QBRUA07dyPJtEUa69BFyCY2BfpDql5qMxQytUto6DAq0pPrnQyTGO5iuJLTEQUfo1Z
         S14aC98jKZLjj2YONpVDObF3jn/lNRFVxbbm12RsiY/HaquJLFJSbKqPWIhQQ5K4dvS3
         BZnw9Q5jzqVfZBlRIZ7QRJz0VvN4W/cqP0nXyC1gxSAvxftWn+MBabFEHAgp+5UJnUTO
         MJ9Y7LxbKzTPqxXnrwV72D50PZFkX9ZzbxIIpvOGSHPntm4E7X+lvNbyLk5G0ZkhfS1b
         o3AWMWArJvHOxD4MLQeXFWw9O8TZepD4hvKp05n52xcW4LV7Ql2ffKvdTvxY/vkLXL6L
         yMaw==
X-Gm-Message-State: APjAAAVZQp67jR2uuZaVlAoQF/xdyRAFFea3rzlk7fqOMGhDCzBcnGmX
        W8jIn6r1TPAlDHqzHpxada0=
X-Google-Smtp-Source: APXvYqzo3Z15BMuwUzNMNG5EvcqXYjfaHuaLiOGQkwFx1doRSjsCPVtA4pk5V4BuZETA0dgqr8pZEg==
X-Received: by 2002:aa7:83ca:: with SMTP id j10mr38775736pfn.50.1553747367375;
        Wed, 27 Mar 2019 21:29:27 -0700 (PDT)
Received: from icarus ([2001:268:c0a2:ad41:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id j20sm28222283pff.22.2019.03.27.21.29.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 21:29:26 -0700 (PDT)
Date:   Thu, 28 Mar 2019 13:30:13 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v13 01/11] bitops: Introduce the for_each_set_clump8 macro
Message-ID: <20190328043013.GA3251@icarus>
References: <cover.1553661964.git.vilhelm.gray@gmail.com>
 <497dc4b5b1f668b54e008e10a43d4108f4a41213.1553661964.git.vilhelm.gray@gmail.com>
 <20190327064254.lwj7ew37mxphieco@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190327064254.lwj7ew37mxphieco@wunner.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 07:42:54AM +0100, Lukas Wunner wrote:
> On Wed, Mar 27, 2019 at 01:58:45PM +0900, William Breathitt Gray wrote:
> > This macro iterates for each 8-bit group of bits (clump) with set bits,
> > within a bitmap memory region. For each iteration, "start" is set to the
> > bit offset of the found clump, while the respective clump value is
> > stored to the location pointed by "clump". Additionally, the
> > bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> > respectively get and set an 8-bit value in a bitmap memory region.
> 
> I would have preferred static inlines for bitmap_get_value8(),
> bitmap_set_value8() and find_next_clump8() to make this as fast
> as possible in the callers because I've personally worked with
> an industrial application where the GPIO pins of a 74x164 are
> written every 250 usec.
> 
> But apart from that I like this series a lot, thanks for working on it.
> 
> Lukas

I'm not sure these can be static inline since the symbols are exported
for use outside this file. However, in theory I have no objection from a
performance standpoint. Since my devices don't have such strict realtime
requirements as your 74x164 application, I'll defer this decision to
someone more knowledgeable in this area; perhaps someone else can
comment in this thread with their advice and suggestions.

William Breathitt Gray
