Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6223EC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 12:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3055B218DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 12:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGdRH3Ty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbfIIMuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 08:50:04 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46733 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfIIMuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 08:50:03 -0400
Received: by mail-ed1-f68.google.com with SMTP id i8so12779991edn.13;
        Mon, 09 Sep 2019 05:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kW15KrOSvW9WpLErlquuKLeZEcnhbkdBFaJKzjm2XqU=;
        b=dGdRH3TyQEBBns2NDy+wSx4qiZZHqhJACLMlJyoLQmYz05xthawa0+k7LN96Qw6Mz7
         aOO0prdaRv0z16cxIqTxKOn/00JQgjzml+iKQgaqVjYrZ/sL0QuUf4StsZZbr1yV6SAR
         q+ycLdvM6d8kyzDI7aW1XruXdUtWb+cwAqtGrsNRJkQB+ndeON2MJ54wWAARvvF+Gqqh
         GtHc2HfxA456zL7Jy/S6575AC2SxNq7zL8i/FkSpQCoW4lT0NjwefK5+YavkP6Q4q675
         eJ/wIlIpCNDIsBFYfwPT/6IqJxiRBuT3wCoFY09xjumX24vMdPLdTG/rbaumG0gjrOyG
         O6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kW15KrOSvW9WpLErlquuKLeZEcnhbkdBFaJKzjm2XqU=;
        b=ijWypwctLx4F9swztFoH1zFL+JD5xZJNEm5XEUbcH7gM9urDhfbSzG9Y1TgpbPI7mW
         eUJhQgyu5cR7hSjWMb5nwf2f0wfvZqUwAZn1fw8MqOgndZ2gmFS0+II5WnQo+5EFnGEo
         bpXsFOKjodvCj/pkAws3s1JBXP2GWaMhk54VnsrzeNENNkmeQ9lldM8egbv8j0x1J0xg
         /pL0dlF4Y5/ZBJsgqRnlNQJJlqi2xW/HssSGI8saSXAKLc37oSpVMV6MwTAyiZdMvHg8
         vs0S6s87A+S95Xuea0OaqEwVWKJ80ucTrkvBL4nGeAnch3sNXKhL3KpLfe95oPyrsP1Q
         xGkA==
X-Gm-Message-State: APjAAAUO7vCGsJ3PU1SLTv9bJ7QXMUYunkDtPojnq7by/NE15LqqpC2j
        iU/BlHHqo7PP74udWwRJv3LPriD+YPQy976ZjSNnsmVs
X-Google-Smtp-Source: APXvYqw2QV3V6l2FcVkKtA9g3vp/G9rJbm6Z1GMbqDE18XZgEYh5t8on335dWmsCITRDRapbz13AOQsF2ZjdsTjwOy0=
X-Received: by 2002:a50:ad5b:: with SMTP id z27mr24028370edc.252.1568033402140;
 Mon, 09 Sep 2019 05:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <CADxRZqxmvfE9gYoT+1oLV6-o_BbUsay_U45qmMEYL3vErTCCLA@mail.gmail.com>
 <VI1PR0802MB252826995ECEA2578C1B5C878FB70@VI1PR0802MB2528.eurprd08.prod.outlook.com>
In-Reply-To: <VI1PR0802MB252826995ECEA2578C1B5C878FB70@VI1PR0802MB2528.eurprd08.prod.outlook.com>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Mon, 9 Sep 2019 15:49:51 +0300
Message-ID: <CADxRZqxOwPtaqiVyXR8hBf7VcDxZq5+w3E57YjaxEc=qS31AZQ@mail.gmail.com>
Subject: Re: [sparc64] Kernel unaligned access at TPC lzo1x_1_do_compress
To:     Dave Rodgman <dave.rodgman@arm.com>
Cc:     Sparc kernel list <sparclinux@vger.kernel.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 9, 2019 at 1:11 PM Dave Rodgman <dave.rodgman@arm.com> wrote:
>
> Thanks Anatoly, I'll take a look at this. Could you please let me know the exact hardware you're running on?

Dave,

machine is a LDOM on T5-2 server.

OS is debian unstable/sid linux with latest git kernel, currently :

$ uname -a
Linux ttip 5.3.0-rc8-dirty #1211 SMP Mon Sep 9 10:20:40 MSK 2019
sparc64 GNU/Linux

-dirty cause non-mainline (yet) fix for IPC [1] and reverted
HAVE_GENERIC_GUP patch [2].

$ gcc --version
gcc (Debian 9.2.1-7) 9.2.1 20190905

$ ld -V
GNU ld (GNU Binutils for Debian) 2.32.51.20190821

$ ldd --version
ldd (Debian GLIBC 2.28-10) 2.28


I could give you  account on this box to test or fix kernel if you would like.

Thanks.

1. https://marc.info/?l=linux-kernel&m=156769723218727
2. https://marc.info/?l=linux-sparc&m=156026414826151
