Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE37C2BD09
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0CC424680
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1QP8E5rE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfLIJvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 04:51:17 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52210 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfLIJvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 04:51:16 -0500
Received: by mail-wm1-f66.google.com with SMTP id g206so14729931wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 01:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=/lV4JOds+hQfSWH7coNmWVW3vJirPTXEaWuWEYduTYk=;
        b=1QP8E5rEnnpU1XZQRU97MeWENs2Clw1QWJ71vLW8hAfEkhPVRwKXiPNjy/x0GSLHYy
         iEBd0l9DIz9rS1Oyx0EPugmBekdTVFsgULtW+CLZXn6/HjLgmtUzplUdlOsDM5LAUDj0
         ZcxA33nqqE0xugQ3p8BMXNCeyP1AYFooYXFa5XI0QPTEhBKECdxMuXuvxVKG7YuiLuvu
         HcyR3Y2Qfj6WJ/wDGu3KhySAy/so+P9mJ6kfLB8OW3wCl4ZRytOKZZXu2Ml1Q45RY5jB
         fTuVR/SzH8ZWZBk7CdkFP5J3sdSMCEMFKPUnlAg2AJyR7r3onPgGF9+GTHCkZZdD9moJ
         1SZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=/lV4JOds+hQfSWH7coNmWVW3vJirPTXEaWuWEYduTYk=;
        b=bCcYrZQkWHIqsYGCu8+QwWGhesd7ldBhao2ky9ZN5iMgVGXnRe7EXeYGIkXRz0MYUh
         /IBFnPaK/28BIRzykn8dRo8wQ1jUJ7A/g5WyzgjmqgmXuMHi68HTs+8SZpgko8ILCZfZ
         MNO9ih8TYRcj3k0LI23ErRtaIG2Xa/Nx+kYat2qauAqwGrKM4thn51majwiTbHzQnNhh
         A2fJ/qAYaA7QPI9nek6RsfUBWTtezuatoIhKlU5jMaLPjLZpu4HjjbhU1Y+/empf/nwq
         PeuqH6PKIMz2vXUCdPtLR5rrZHhRnpEB1GfpAFaodYXa168R/GvtZQxhTdm6NX/Awy8x
         kZ6A==
X-Gm-Message-State: APjAAAV3QfHJCO8a+iHn7EPws7XECqdp2OBRopj+vq1j4MTLGB8hWQAZ
        4SEiV9kSGpt6vutlMLWvNzzhmA==
X-Google-Smtp-Source: APXvYqyJrZdhijAo9WBhDx6CQX/GMWF1YJMIkaeUQIf7KJnAzbt8wQFio/hP1vuXx3Nyfi9YFWG7zg==
X-Received: by 2002:a1c:238c:: with SMTP id j134mr24393284wmj.151.1575885074948;
        Mon, 09 Dec 2019 01:51:14 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y6sm25826838wrl.17.2019.12.09.01.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 01:51:14 -0800 (PST)
References: <20191208212206.16808-1-repk@triplefau.lt>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Remi Pommarel <repk@triplefau.lt>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: meson: pll: Fix by 0 division in __pll_params_to_rate()
In-reply-to: <20191208212206.16808-1-repk@triplefau.lt>
Date:   Mon, 09 Dec 2019 10:51:13 +0100
Message-ID: <1jo8whesj2.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun 08 Dec 2019 at 22:22, Remi Pommarel <repk@triplefau.lt> wrote:

> Some meson pll registers can be initialized with 0 as N value, introducing
> the following division by 0 when computing rate :
>
>   UBSAN: Undefined behaviour in drivers/clk/meson/clk-pll.c:75:9
>   division by zero
>   CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.4.0-rc3-608075-g86c9af8630e1-dirty #400
>   Call trace:
>    dump_backtrace+0x0/0x1c0
>    show_stack+0x14/0x20
>    dump_stack+0xc4/0x100
>    ubsan_epilogue+0x14/0x68
>    __ubsan_handle_divrem_overflow+0x98/0xb8
>    __pll_params_to_rate+0xdc/0x140
>    meson_clk_pll_recalc_rate+0x278/0x3a0
>    __clk_register+0x7c8/0xbb0
>    devm_clk_hw_register+0x54/0xc0
>    meson_eeclkc_probe+0xf4/0x1a0
>    platform_drv_probe+0x54/0xd8
>    really_probe+0x16c/0x438
>    driver_probe_device+0xb0/0xf0
>    device_driver_attach+0x94/0xa0
>    __driver_attach+0x70/0x108
>    bus_for_each_dev+0xd8/0x128
>    driver_attach+0x30/0x40
>    bus_add_driver+0x1b0/0x2d8
>    driver_register+0xbc/0x1d0
>    __platform_driver_register+0x78/0x88
>    axg_driver_init+0x18/0x20
>    do_one_initcall+0xc8/0x24c
>    kernel_init_freeable+0x2b0/0x344
>    kernel_init+0x10/0x128
>    ret_from_fork+0x10/0x18
>
> This checks if N is null before doing the division.

Thanks for reporting this

>
> Fixes: 8289aafa4f36 ("clk: meson: improve pll driver results with
> frac")

In mainline, the commit above went in with sha1 3c4fe763d64d.

Also, this commit is not really responsible for the problem. Having HW
initialized with N = 0 would have failed since the beginning, I believe.

In this case the correct fixes would be:
Fixes: 7a29a869434e ("clk: meson: Add support for Meson clock controller")


> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
>  drivers/clk/meson/clk-pll.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
> index ddb1e5634739..6649659f216a 100644
> --- a/drivers/clk/meson/clk-pll.c
> +++ b/drivers/clk/meson/clk-pll.c
> @@ -66,6 +66,10 @@ static unsigned long __pll_params_to_rate(unsigned long parent_rate,
>  					 (1 << pll->frac.width));
>  	}
>  
> +	/* Avoid by zero division */
> +	if (n == 0)
> +		return 0;

This can only really happen after init, in recalc() rate.

I would much prefer if you could check the n value right after it is
read (meson_parm_read()) in .recalc_rate() and add a comment explaining
that some HW may have this parameter set 0 on init.

> +
>  	return DIV_ROUND_UP_ULL(rate, n);
>  }

