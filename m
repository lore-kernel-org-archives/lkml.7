Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F6FC2D0CA
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 20:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A13824676
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 20:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="vIlTcnG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfLOUfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 15:35:08 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40204 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfLOUfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 15:35:07 -0500
Received: by mail-ot1-f67.google.com with SMTP id i15so6251811oto.7;
        Sun, 15 Dec 2019 12:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zbZi4+r1yCXEc/CpcpD0dVQFYFaG6+F9udODBceajHk=;
        b=vIlTcnG35CEORdkR5yB86tv9FbzKRT1W+ELh/GPd3BpXHeuW8hjKrTqgctfag462oH
         tvfUB51YRb9A/TG5liti5EZHwg/9+OS5yC8PuRGNPEeapPi4sOUp9Io45pruYZoz9Qbn
         LeXhxCVCfXq0XTtKbxZd5wmrm6WUeA2iYP2vAyTZVJg6o1uNzecFZ45dUIV+MRK5WuGn
         bFvS0kfl1TPY3ncwhZGaXWeZADtgNNKu73hiqaC10wq+vGJ+/TwEPTbPthyMPJAH9KhL
         ZZcTsK6naGV/rZFj6eZEafwoE9ShfCrsA43y71duQATJaCbLgJfoJ+Ae/E8ayuEvJC5g
         v/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zbZi4+r1yCXEc/CpcpD0dVQFYFaG6+F9udODBceajHk=;
        b=VkV+YqP8kHKZ3H9081y9EQWVFoFHBtzlcb5+a6/c8K9EBpU9ifjgxOw9Fajrj89glk
         bq+e68M67gghlkCYZq5AEsbirTRbKBpa9wax3uhMfTUBTxngeYgM5tbstRj9vpOd9fiz
         itnwIT9yRles90+4r+O2maIayBPuxY16OghnjR3Xg0C5pJDkwVoowlfyptgXu/v8TkP9
         alPzl4IKncJ+MFsh8UDO1ZU/p9pm1S6h1n7yk/JyTx8fCYyXCrCZigx4qkjGwOL7nIQH
         7KgdrQwGKnNg1W5chg9PkEim8xIIFNXV7cSM9ae4LyhBv0FuurA0xpEfXFYodWB0IeAS
         uBgA==
X-Gm-Message-State: APjAAAWlS9QdiWHCtRK+eBBuzKWnIprTY1jCPFjER88K9Gyfe5HKQxtE
        F5E/W436EIrzoHKfZP5DEML4ApvmDCuoF7KeawY=
X-Google-Smtp-Source: APXvYqxIwAW1/JmFMVUr2AzvIDmU4NWd/3e3k+sCn/MyW7UxkkzglVYwDhPDH6T/yFg/ReNTT/nmp+LIKw+NRnoEAGs=
X-Received: by 2002:a9d:7342:: with SMTP id l2mr28007361otk.98.1576442106640;
 Sun, 15 Dec 2019 12:35:06 -0800 (PST)
MIME-Version: 1.0
References: <20191215114705.24401-1-repk@triplefau.lt>
In-Reply-To: <20191215114705.24401-1-repk@triplefau.lt>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 15 Dec 2019 21:34:55 +0100
Message-ID: <CAFBinCAsoE3zFEKbS1Tag=Y_honnpfin625u=N+7QMv4cPy2Wg@mail.gmail.com>
Subject: Re: [PATCH v2] clk: meson: pll: Fix by 0 division in __pll_params_to_rate()
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 15, 2019 at 12:39 PM Remi Pommarel <repk@triplefau.lt> wrote:
>
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
>
> Fixes: 7a29a869434e ("clk: meson: Add support for Meson clock controller")
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

thank you for the patch Remi!


Martin
