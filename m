Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8A2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 04:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 980F6206DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 04:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAN5zy/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfC1EjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 00:39:07 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34930 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfC1EjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 00:39:07 -0400
Received: by mail-pl1-f195.google.com with SMTP id p19so4366718plo.2;
        Wed, 27 Mar 2019 21:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H8r/rPDIdp1bYLW9wSNX+D8mlHRpDf4FGN+0AbSvEfE=;
        b=RAN5zy/f+G552WpqxoPnHecVTkvPuGC+b15Dnkn2RfGy+vGXdf/vxJrgCf1Xpu5d+1
         o5yzxCkTOk2C/dyvyioPdb72xfzNkOBwT2o+oLpNCElU4+Be+CZNOyvZrQ2xwa4NHXzF
         BTcwsyRRz1OJ7OabkOhVsxARsrNgijsy83/7hP9UQjR8ClNLp04RtfKUepxmBuu7neyC
         ecIfLSjnVPmmwy7oo6EBskUhReSiu95d5wRZDNeYgOggBxp7P99TXh41Yc9+vu0iZ2pg
         svrIGDxBGGWrZvaYSIt+0wevscM5R5iGrdLKD+XHLNff8LBe6asbG1AMGmViSWlslk59
         Aexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H8r/rPDIdp1bYLW9wSNX+D8mlHRpDf4FGN+0AbSvEfE=;
        b=NWSctY5ZxYzvIx+JEj0va6bYdUiO/y7pOm2QQ59pwjRgAYwtd6dtHyOttwzT9cC4k9
         3k+5wiAPVglK9qtQX9+G21B1FLXR4KFYSe2LutTBmL3MGgSTxalC/Tyklm7io3zrxyyX
         d3ZhHDH8a5tN6TkDK8BRxMWfFeldwJVQRhBwC2ilFFWTOSz+H02P4QHVp9FbPp7hIbyY
         bOS2ZRweCqalQD11Tpq7KifOTpyp/yllouhrXdd7QizprxyycmMa9wOe1/KbGQRNlytp
         dV4bMiAn//qn9KUVxOCAFEwPNGR9ZxbxwN0yLQOpaW72QBoA04jP9PGVE5b/+oNlNyCq
         B9Fw==
X-Gm-Message-State: APjAAAUSnnAdrFrXe77qYnaYcW07RmbQ55FPc2Y7k13knCYSm99FTyDy
        0RSn1GynoKIq0By5sNHugwg=
X-Google-Smtp-Source: APXvYqw4+w4/HVQXdw9bX68V9rDSUG5OrUi5kuPGYvGmmtQmQyp4oqkB4ZR9X8HLZ9xgRfOJtlw8Mg==
X-Received: by 2002:a17:902:b58f:: with SMTP id a15mr26648596pls.36.1553747946345;
        Wed, 27 Mar 2019 21:39:06 -0700 (PDT)
Received: from icarus ([2001:268:c0a2:ad41:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id e21sm20915179pfd.177.2019.03.27.21.38.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 21:39:05 -0700 (PDT)
Date:   Thu, 28 Mar 2019 13:40:04 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v13 10/11] gpio: 74x164: Utilize the for_each_set_clump8
 macro
Message-ID: <20190328044004.GB3251@icarus>
References: <cover.1553661964.git.vilhelm.gray@gmail.com>
 <645f16f1d1ad3f215e34a82f457e06725fcf8f56.1553661964.git.vilhelm.gray@gmail.com>
 <20190327123314.GJ9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190327123314.GJ9224@smile.fi.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 02:33:14PM +0200, Andy Shevchenko wrote:
> On Wed, Mar 27, 2019 at 02:02:39PM +0900, William Breathitt Gray wrote:
> > Replace verbose implementation in set_multiple callback with
> > for_each_set_clump8 macro to simplify code and improve clarity.
> 
> > +	for_each_set_clump8(offset, bankmask, mask, chip->registers * 8) {
> 
> > +		bank = (chip->registers - 1) - (offset / 8);
> 
> Excessive parens, but it's minor.

Fair point, this could do without parens around (chip->registers - 1).

Since this and renaming 'idx' to 'index' in find_bit.c are such a minor
changes, I'll wait first to see if something else comes up to be fixed
in this review. If so, I'll add these changes to the next version of
this patchset.

William Breathitt Gray

> 
> > +		bitmask = bitmap_get_value8(bits, offset) & bankmask;
> >  
> >  		chip->buffer[bank] &= ~bankmask;
> > +		chip->buffer[bank] |= bitmask;
> >  	}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
