Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47222ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D7ED21A4A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="nsU0TBpJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfJKFQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 01:16:38 -0400
Received: from mout.web.de ([212.227.15.4]:46871 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfJKFQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 01:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570770956;
        bh=bdfZdfv0kDFiJjag8bHGUhUdVn4C4VGy8330bt1MT9A=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=nsU0TBpJW+ShOJ5XqcmvvjFyUy3YPVdNAxGWs0rsbaTBqSE9gfVFB+eXtOYXr60nR
         BkLXSpBY8xJina3TRetCdM5Bj6LIFw35GjCgcUt5pnvUReffnrez6OHgAuvilOiCom
         e1yf6aRNS2exOhMAlp8EQVXacRHHd/npa1Jy9Pkc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.164.92]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MaJc8-1icfbw0kEi-00Jsim; Fri, 11
 Oct 2019 07:15:56 +0200
Subject: Re: Searching for missing variable checks
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        kernel-janitors@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Aditya Pakki <pakki001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Coccinelle <cocci@systeme.lip6.fr>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <75f70e5e-9ece-d6d1-a2c5-2f3ad79b9ccb@web.de>
 <954c5d70-742f-7b0e-57ad-ea967e93be89@rasmusvillemoes.dk>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <dd1adf86-1bc1-2ffe-1af8-3d7082c5a468@web.de>
Date:   Fri, 11 Oct 2019 07:15:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <954c5d70-742f-7b0e-57ad-ea967e93be89@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:T/VUbhIi6SXgqdz3828YL5FmNXv409l4EkBDA1njed6Ts4T1WRY
 1h86oiKchdYB9Q8OkV5VT9oqYRsggXOkXJLGdWo5ativOnLHqXB486YFdX0i+m/gMtUH0B9
 urb4LWdfCHfsSiZt2E3EROGQpl2IezgPrrBZ1DYpeP2PjODj5D+YijBeLELtDEEIFki+ewH
 mYT3pjEdAxjdQ2qTnp+MA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zfP7ojbHTrg=:vep1Nd6qZ0lRDogOPNrJy3
 Zscr2NbH2d1CJCAiCzoNi7Zly+nIy2oIvKDQ7jcDvjUEHl/a6YyicJrCdOVx5Cbq8EZqAfrLB
 vsUSElXYc9vE10r1EBbDmSSpQ+ENSK6ivo4b9HB7r/ub8oQ26h5F/1SSNYeQGHvjbs0YS6GiD
 6FP3+Z5ZBMyMEJmpVZ7w0igzm4LOhUaqWG3bJz1xywz0AMOnJBpAZCjNLEWizdIP84+MH6Sqg
 46S1fZb9MjjY1qU438rL6/ARnJCkrf1wh9dv3+NnfiIFkPw7U4ljDcvhXJodoDvFkTrMMrCoI
 CXh3k+I2MeUXrKym/vEGYI7kJArI4r6zsDncxkrUU8l3ZkTYo05orSiSxb2BUeAZWszjbrJlc
 JG/zKgVAzCHzGMGFoA+nKxFXIItj5JGukQqPbAy39I6x/sTxBGS/mU7CIH/CPtXtDTkbz7xHY
 25CGw11S7rHbAurQ5k5yFgsEXkISGOCTZvwrAPODx/JcfJDoWMgjIVDWF8pRO9rT1zWbORr0r
 tR1ByF01qjbL8jr0NrBjgusmvG3EQm5nuwaztCzNZWYEMJrgbCwJ37e+niiJYZc97nw4FTtBC
 GDagekI3qTR6MA65gZGZiF+zn34TyRvQHc5XoEMfzBEsrp8g2QVpxVGfUYrcy/AqoDzOssnh6
 BONJ52aymyqyHbO/SXS0Qlb56BG6KWLFn4BXy41bRY8kDNVTKR3uqewVEaHinPXuGoOc4C9Rg
 dal02KTBnjmZyvTsmiL6jCJt+81/wLhZXtgBQr/xFy2l4ZFh+zjiMmQ8YaRnTal5XkjnFzM4V
 cQhn4+FLB+E0B3XcfF5awn57xhZA5wEYtPx80BL+fM9PKV6Td5eg5m+2EP7v0wLgsPcJggfiJ
 UCm56y3infpr2IQs+PVGLyVDcjCW2T2jDEPp+x/hAekc2UAp55WbC9Sr3Ag8G0/S25IdAYEUt
 L9w8Snez1W2gOGVu8Xh/IywBGoDUDRgQijcHGuUG7eYiv2ZGbjkXeJphnYl4nl0oyxFlqi/3R
 MhetKoiDS0GRUCh+a9VitXGdTvlEI7dUuPHYccRNuzI8i8YVHWyLl9p+wYB7wCu0V7DTejOe+
 ZcBRM2bn0TbrR3ybEVCJiJGt+e3EZfPqcLUdOqiG93AJOaq9/NttPdAzqPbEwPSMcOBeXDkBt
 y6SSqBEOPmyjFQF/queYieKDh/YO0H5bZZuwuZ+S7xC2gL01OplRnc2O1qszEAAMT0BOGp3HI
 9N1WxzcCPAtaDGoWzSEsBCbSASZgGfZaGfb+7XMzf40tu++7DJS7/0jc8jeY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The problem is the __must_check does not mean that the
> return value must be followed by a comparison to NULL and bailing out
> (that can't really be checked), it simply ensures the return value is
> assigned somewhere or used in an if(). So foo->bar = kstrdup() not
> followed by a check of foo->bar won't warn.

Higher level source code analysis tools like the semantic patch language
(Coccinelle software) can help to find such missing checks.
Would you like to point any additional development tools out
for this purpose?

Regards,
Markus
