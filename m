Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A65C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB5D2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dw4nOA4Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfCMVXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:23:04 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33237 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbfCMVXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 17:23:03 -0400
Received: by mail-lj1-f196.google.com with SMTP id z7so2940814lji.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 14:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qNEikCodmZqH4zF8Gz55GcHQf7DQSqntUXKPuV9Vin8=;
        b=dw4nOA4YROGvoREvqGV8tMQ4CtVoyh/kk/h+Jtw0pOfwgYTDqNzrSPzvu7J7NFGySY
         zR9ziMTeWSGEKqctkj8EnradHa4zskTl5iBLYiaRWKtMskfToVEN56c1WMr7c9hQxvYM
         r4hKc4h7iAluA2XanuAbHTUPsCfAB/0dvrSJ76pqh1kHCFLlyRCO95mWtcJJbu+/fdNc
         fS4Ygz4vH8LKJptmxJugzXworUgYURnWvNXsihqkZj/uC53QSk2bbSjMP7GeKOuTlga5
         Bp0oInRta9d3zFNQSD1oR/aCreTuTl4F9h4G06G9605ivH4JNIhhO/LXOPyKV5QmWXPw
         x/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qNEikCodmZqH4zF8Gz55GcHQf7DQSqntUXKPuV9Vin8=;
        b=czTNiTsAVT7Llje1zG8R3AvmTxIKsSPKNludClxai+vxE/z0BybRAFKFIZvK56Ji6q
         b2SCp1lzRk9xEz1qk/1cCnS2hLxvFaP1sciaaSi3ifbTB+ezLVtRkFydElZLjqOG++eH
         6eKeDcGS40cf5/k++tJpusQjG3n8cOOEIQxz6tj0Br6XiKSaLCSI67WQAP5ZAUx+segg
         0dX2Z2pnuxAkA3n9x0cDmfCG0LOfQLsBUz5nknUSjjLwGEoU+83i6/hozf2iWCAaUpJs
         KUMgSU/i1SvjLf2cO7gHi8qxZPYfwvMxWWDuZxq+VXBXvY0+gxLzWLILrs1PECxBmS2m
         TIAQ==
X-Gm-Message-State: APjAAAXJefswfY45b8RilGl4vj75t5AmVtyn2mU38U57JJzvFfRTxXHT
        uY8loQ3ovzNBc+4S347wu2rul6RurizJ7qI68X8bKw==
X-Google-Smtp-Source: APXvYqxkA/I+2bG8ZDDwVX2pbXeMPqGzk62G6EJ5BZsx/f4mtwBsyEZnZ/o/c8OixTY6y5mHDSG6D5hvtS2EyzO+2n8=
X-Received: by 2002:a2e:90cd:: with SMTP id o13mr13179047ljg.153.1552512181003;
 Wed, 13 Mar 2019 14:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190313211901.607575-1-arnd@arndb.de>
In-Reply-To: <20190313211901.607575-1-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Mar 2019 22:22:49 +0100
Message-ID: <CACRpkdYeyaahQfE=uKVZQRwJGrhTZqAPHhq9yXEB7pFgwJ8-OA@mail.gmail.com>
Subject: Re: [PATCH] mtd: physmap_of_gemini: remove extranous __xipram annotation
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        linux-mtd@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 10:19 PM Arnd Bergmann <arnd@arndb.de> wrote:

> Marking a local variable as __xipram causes a warning because of the
> noinline attribute:
>
> drivers/mtd/maps/physmap-gemini.c:89:11: error: '__noinline__' attribute only applies to functions [-Werror,-Wignored-attributes]
>         map_word __xipram ret;
>                  ^
> include/linux/mtd/xip.h:34:18: note: expanded from macro '__xipram'
>  #define __xipram noinline __attribute__ ((__section__ (".xiptext")))
>
> I can't see any reason for the anotation anyway, so just remove it here.
>
> Fixes: 9d3b5086f6d4 ("mtd: physmap_of_gemini: Handle pin control")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
