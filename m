Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F5DC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 05:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 533092064A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 05:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="sa1k39v1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409030AbfIXFPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 01:15:48 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:42346 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406301AbfIXFPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 01:15:48 -0400
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x8O5FgX5017381
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 14:15:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x8O5FgX5017381
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1569302142;
        bh=yJVcfbXm8bwbIhA7O2G8+Wo9uDFS5iImUS2XKJYvsqs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sa1k39v194T+NX81PwOLznPxjRYoAUqMA8gwEqdjeUwW4SmRpo6dJeS6mioXmvyRx
         H3gUG2AYrv89Ry/N470IZUaX89IRTBl+8o1FB44s9Yoj7CvvIrXdkHkBtchF898lR+
         KoaDSvcojnW73IDdbK+Qh0zCbHHYnCcJm7eT+zjGN8n9MEx6LG1k4XwJ4VB/UvTx/g
         ZDCf0h6dGUHyAPTzk7DtS2QMc7TA0jlCQq93tPAGBX5ghfJ2aPKa55ml7VogUKlMXL
         DZfREWvTKd2yVesqR4zEP9bNIfxqWLZG7uSthQuvDWZ5Pb8LUZe7l0N1PrSANUo1z/
         LTOBP3zoj2ZGw==
X-Nifty-SrcIP: [209.85.222.52]
Received: by mail-ua1-f52.google.com with SMTP id i13so144394uaq.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 22:15:42 -0700 (PDT)
X-Gm-Message-State: APjAAAUZUYdaDVX6f4ilFLjVR58MafB78qwVOA04NoaCnjgFHCD5WPGv
        8Zm7twhUzatLtgJTJFrhKmjlj7oCYytWxhgRc6o=
X-Google-Smtp-Source: APXvYqycZkFXxUtuCiaFK7tO7624d22noNkPp4N52/TNUs4ni+jnjoZOcuWC+nNyCZvsMU302A3GBHoUcX2XSmdw/Ms=
X-Received: by 2002:a9f:21f6:: with SMTP id 109mr469799uac.109.1569302141394;
 Mon, 23 Sep 2019 22:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190906154706.2449696-1-arnd@arndb.de>
In-Reply-To: <20190906154706.2449696-1-arnd@arndb.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 24 Sep 2019 14:15:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNASSL3=A2F0SZJNkxxHLxWJmNJgJxJfk3LWmaDYvDZTi3A@mail.gmail.com>
Message-ID: <CAK7LNASSL3=A2F0SZJNkxxHLxWJmNJgJxJfk3LWmaDYvDZTi3A@mail.gmail.com>
Subject: Re: [PATCH] ARM: don't export unused return_address()
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 7, 2019 at 12:47 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Without the frame pointer enabled, return_address() is an inline
> function and does not need to be exported, as shown by this warning:
>
> WARNING: "return_address" [vmlinux] is a static EXPORT_SYMBOL_GPL
>
> Move the EXPORT_SYMBOL_GPL() into the #ifdef as well.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>


Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>



-- 
Best Regards
Masahiro Yamada
