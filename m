Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CACC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3AE205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="rcRzWCPe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731361AbfG3Oaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 10:30:39 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:17204 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbfG3Oaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:30:39 -0400
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x6UEUEHW013457;
        Tue, 30 Jul 2019 23:30:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x6UEUEHW013457
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1564497014;
        bh=JMSt+hweIJak1wcxcE6FJKFOSL1Mxz8lHsp0Ef6quLI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rcRzWCPeijGAGABuSv0gOMMO562JQ0LAMRm5dDhqHIbr7YGcxh1QMBCy7olAFYGsj
         wmpGMvON1FsyFqZcus7JWVqxmFe6hQMCX286NwqdWna+JDXJEU9Ch98Gx+IvFBvS+m
         5IZddcL1CDlputOY7hljZkRmug01BF4+gSdZN7mfVjyA+7wN98AfvBMRGPytaRCUZF
         GCnsEHv5IPyoE2ZjiTD1ugGjiSlbAWNAfMUnLRQjPl30t1xJow+XY0iFvCgj1579YA
         T4JIt1WuxRXIp1cwOlM67yu51q0c/snOKi2WTkZlnNxQk0Tr0m4tPAenXBgCFYiXS9
         40hR+5gYc/epg==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id m8so43678196vsj.0;
        Tue, 30 Jul 2019 07:30:14 -0700 (PDT)
X-Gm-Message-State: APjAAAXnZsnREanfgNd/b7Ad9eeb9+RrT5sEroK2UiuM4rr+FAEnVDO4
        YfqbC29rufK264sM4T2ugsI9oJQ9ODGX9NP1qPQ=
X-Google-Smtp-Source: APXvYqxC686Km/0VHbBnLd+UeAwL8cwY74P1tc2OVLxLH6J+Oxr4y6XeleXfMvfWTJZ5WBmOPpmrhO/o9GyN3LmIvLM=
X-Received: by 2002:a67:fc45:: with SMTP id p5mr11100750vsq.179.1564497013549;
 Tue, 30 Jul 2019 07:30:13 -0700 (PDT)
MIME-Version: 1.0
References: <1564465410-9165-1-git-send-email-hayashi.kunihiko@socionext.com> <1564465410-9165-3-git-send-email-hayashi.kunihiko@socionext.com>
In-Reply-To: <1564465410-9165-3-git-send-email-hayashi.kunihiko@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 30 Jul 2019 23:29:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNARi=zV9dzJ1Pi2buJ7UH8whQwZbJ-z0AB1V3_OypQ519A@mail.gmail.com>
Message-ID: <CAK7LNARi=zV9dzJ1Pi2buJ7UH8whQwZbJ-z0AB1V3_OypQ519A@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] pinctrl: uniphier: Add another audio I/O pin-mux
 settings for LD20
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 2:43 PM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> This adds support for pinmux settings of aout1b group. This group includes
> audio I/O signals derived from xirq pins, and it is equivalent to "aout1"
> in functionality.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>
-- 
Best Regards
Masahiro Yamada
