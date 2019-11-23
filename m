Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2FFC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 17:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7D020674
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 17:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="EpllWUiL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfKWRz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 12:55:27 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:42993 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbfKWRz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 12:55:27 -0500
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id xANHswW6016507
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2019 02:54:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com xANHswW6016507
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1574531699;
        bh=VCYnfyjXOd5qOGfZ2oZaTZcAsw9LZ5HrJ3sz0oGq9Co=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EpllWUiLFDMBDaxu3b9IXpfjwdQSyU0fahM5lMaSwYIUGzvWaLxwyokUkNMzVBUY1
         2UKyqyDRL4l5bKhQCC0lrWsg12Pw49iCOaRblf35Q4h0EHOmhy9YSIUHOH+88OTZBI
         wydu0KZ5mKD2TdT0OB/sRRNpamin/tfeWv+7V5necop87ztZDX76t7Wg4KIv/yj19R
         8jvxUipQi3XgRDb0XMd25SlgeFwtKN+AXTh97krJjPzjYuGF8cEjoRg0DciYsX2/pN
         jI2pkY/YTsGMEkEC5QxG7RbbJyMZ8vAev4WaHO7pGT2AvGqnWIidlCIZRkn/Krlj8x
         sgVs0gsV5+6uA==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id 190so7127164vss.8
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 09:54:58 -0800 (PST)
X-Gm-Message-State: APjAAAU4H8ZQ1hdgVvzKgvYTyQ2vK8v+ed5r/tYfwhdwMbqNpkDoMsGC
        tGv+gx6x+4T6KcBFmnRlm+DdRPNhWadUI6tSUYQ=
X-Google-Smtp-Source: APXvYqzStVSHnrSaD7dddRuaOtugXvfIPO39FtL0+oXW6OZ9xJZStSqmqEaFCoPnSwr8lOJm/W0r/J/MCfl1z8HfWW4=
X-Received: by 2002:a67:d31b:: with SMTP id a27mr14875702vsj.215.1574531697607;
 Sat, 23 Nov 2019 09:54:57 -0800 (PST)
MIME-Version: 1.0
References: <20191123163633.27227-1-yamada.masahiro@socionext.com> <20191123163633.27227-2-yamada.masahiro@socionext.com>
In-Reply-To: <20191123163633.27227-2-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 24 Nov 2019 02:54:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNATeM-Gz_baR4dHJgnCWNwd_9_i70TxFxwLiNaeXARM3hg@mail.gmail.com>
Message-ID: <CAK7LNATeM-Gz_baR4dHJgnCWNwd_9_i70TxFxwLiNaeXARM3hg@mail.gmail.com>
Subject: Re: [PATCH 2/2] debugfs: remove modular code
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 24, 2019 at 1:37 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> The compilation of the code in fs/debugfs/ is controlled by
> CONFIG_DEBUG_FS, which is a bool type option. Hence it is never
> compiled as a module.
>
> Remove meaningless modular code.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Sorry, this is a build error. Please discard this.


-- 
Best Regards
Masahiro Yamada
