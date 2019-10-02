Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA56C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D3CE21920
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="e7KQ0Gmm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfJBNCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 09:02:39 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:47728 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfJBNCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 09:02:39 -0400
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x92D2SBY012647
        for <linux-kernel@vger.kernel.org>; Wed, 2 Oct 2019 22:02:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x92D2SBY012647
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1570021349;
        bh=naK8kM5SZ9FnjhI80E7EMP71Bdn5aGS80ykKGF8bPWg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e7KQ0GmmCZL4ZLkjn8OPMjFQ5lmCbzPXwIXK6xTxKl14LwpoQNqMleFaTFj1rLeOA
         wHEL3TgUrgw+Lp5+AfzY4Ez0VrKV7qfd9BYSaQcg4QOzFSrmuKe4PK2o01ZOUmiJsW
         0IyFKjuiEYsEfXH+CbwjwVH1V4Hl8CIDXQmYaxY/0InCEVucoN39caI/luT2IeYvm1
         HzgNp70mA4sEdEUAza1M1CF3GZm3MaaOd3Utoqw+H+1xGB0fOsuzeIhUkD4JDLDr55
         vqrYKqURwSYL7bsjZ6ZbDK+axBeYaaGTM8lEuXzUqkLtrgnYYGzgSsNjIbI6kzHvxg
         hhr2LS1aPYtlQ==
X-Nifty-SrcIP: [209.85.217.46]
Received: by mail-vs1-f46.google.com with SMTP id d3so11861503vsr.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 06:02:29 -0700 (PDT)
X-Gm-Message-State: APjAAAW7aqVS6HQOES9yqKhgP1kbKJZm7b/gqBB0f8+0z/yoHgiIZC6R
        XHJw2xhz/v60zBBGmnaoM5AZxQeVUfl7/zdkliM=
X-Google-Smtp-Source: APXvYqyBenjkYSUxWNp12EkMSkjddqEmAJpImt9JMd2IBuuxcgEX6OeS4Ob+yymPNFD4gVXFz2G7SGNWe3Ro1LO2Q3I=
X-Received: by 2002:a67:1a41:: with SMTP id a62mr1776452vsa.54.1570021348040;
 Wed, 02 Oct 2019 06:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <20191001083701.27207-1-yamada.masahiro@socionext.com> <CAKwvOd=NObDXDL3jz9ZX9wo4tn747peBJPTj0DXyLerixgL+wQ@mail.gmail.com>
In-Reply-To: <CAKwvOd=NObDXDL3jz9ZX9wo4tn747peBJPTj0DXyLerixgL+wQ@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 2 Oct 2019 22:01:51 +0900
X-Gmail-Original-Message-ID: <CAK7LNATvGykFY10mOXez84zPV_k3snefgS9zymcn2_7k3EMxAg@mail.gmail.com>
Message-ID: <CAK7LNATvGykFY10mOXez84zPV_k3snefgS9zymcn2_7k3EMxAg@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: add __always_inline to functions called from __get_user_check()
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kate Stewart <kstewart@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Enrico Weigelt <info@metux.net>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Allison Randal <allison@lohutok.net>,
        Russell King <linux@armlinux.org.uk>,
        Stefan Agner <stefan@agner.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Olof Johansson <olof@lixom.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Wed, Oct 2, 2019 at 2:04 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
> > Since that commit, all architectures can enable CONFIG_OPTIMIZE_INLINING.
> > So, __always_inline is now the only guaranteed way of forcible inlining.
>
> No, the C preprocessor is the only guaranteed way of inlining.


I do not think this is fatal if I understood this correctly:
https://lore.kernel.org/patchwork/patch/1122097/#1331784


For GCC, we at least get a warning if a function with
 __always_inline is not inlined.
I am fine with adding -Werror=attributes to the top Makefile
(unless we have unpleasant side-effects).

You filed the bug for Clang, and hopefully it will be OK
in the future releases?




--
Best Regards
Masahiro Yamada
