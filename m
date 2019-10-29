Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC18CCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 22:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D6C20679
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 22:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="csZSXMal"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfJ2WU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 18:20:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33111 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfJ2WU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 18:20:26 -0400
Received: by mail-wm1-f65.google.com with SMTP id 6so2959065wmf.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 15:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=razW+Flqe0osf5dKak/H2XuFxr228C/l2kIAAwUTuGk=;
        b=csZSXMalom5E5HgQVJhg4cX8a87qqS9Xo9MfkzoMevMI1ZQIOw8PfH5I9pM4vIBaVi
         /8kXDbH0jx+HV/G3F4AMdzZ6sEwEjolgZUxXOsnRT7/a4nipe+arkXjyBtlcia6C3ryY
         jCT4M+oVg3U2c0zUF8QAMdMHVbri9rsjSdpMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=razW+Flqe0osf5dKak/H2XuFxr228C/l2kIAAwUTuGk=;
        b=s/7gwmpftBimZe7okM3ugcEwzul0DLfskaqwiul7c8+5239An23dW3HrhJn9n4Q5wa
         zZaXl26UCHMuYH/0Yv/nwriEJeY9f86A0lV1EeZ42/24d0/JjoZ/cHhQK4B6ZfTZdcsA
         b9E28JbYOmEzSFnj5oueH912WoctHocCBKCB+iQ1sZ8oJ7IBMoSsVIXhR52Z5PP8FWA3
         zOLsXAJNYQ641L2u2GDH/bRukmu2xf8vDUz57yQQBxdQ+ilNexFDJoJ+yngk8hqt1NLN
         wAyPEuK6Al0EC025qWMINZlBCg9hkXda9yK4yTk/hSC1kNILfhaNmpH/GVrUCfAddag/
         5WfQ==
X-Gm-Message-State: APjAAAWC3ABWRtbREmVuh2tzKqIE/DFnBiG0kE1xGCR0ZACuJ7ctZUUE
        /2yNZivD73NodJ8pTTI/VvzjTMdl+5sYr/Ww
X-Google-Smtp-Source: APXvYqwp+t/1Tr3f8FhaYd6lfEekG3CNML5zp1y+zNpsVeTjQFAZa2t7Nptm1VRwDBMlHFBkEpnDkQ==
X-Received: by 2002:a7b:c05a:: with SMTP id u26mr6142666wmc.128.1572387624169;
        Tue, 29 Oct 2019 15:20:24 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id i3sm263717wrw.69.2019.10.29.15.20.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 15:20:23 -0700 (PDT)
Subject: Re: [PATCH] clk: mark clk_disable_unused() as __init
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20191004094826.8320-1-linux@rasmusvillemoes.dk>
 <CAMuHMdXSb0mgsqJgNFWqJXywQJLsqvasj7P_bUj4MBvyrAUgVw@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <97cb0b95-72e9-7aff-28de-637310d66caa@rasmusvillemoes.dk>
Date:   Tue, 29 Oct 2019 23:20:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXSb0mgsqJgNFWqJXywQJLsqvasj7P_bUj4MBvyrAUgVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2019 14.02, Geert Uytterhoeven wrote:
> On Fri, Oct 4, 2019 at 12:30 PM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>> clk_disable_unused is only called once, as a late_initcall, so reclaim
>> a bit of memory by marking it (and the functions and data it is the
>> sole user of) as __init/__initdata. This moves ~1900 bytes from .text
>> to .init.text for a imx_v6_v7_defconfig.
>>
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Friendly ping. Will this be picked up?

Thanks,
Rasmus
