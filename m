Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0012FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F1320684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zAA7E6f8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfCHJLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 04:11:51 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46928 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfCHJLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 04:11:50 -0500
Received: by mail-lj1-f193.google.com with SMTP id v16so16733693ljg.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 01:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sRHti0Uq1p2tbyjOiwcZxzseK+6mNQaP2BRe5nYQitM=;
        b=zAA7E6f89kqNN6TvTUsKyt80OfGmUOq34E23BdS2y0/Jx5SWkfrfL1q9lVtur1i+5D
         Yhyz+WK0rnCcYOyHLLXPDxOzbInDJS3AF9U0qqOI8KTpmDzv0jPO90ALxS3PB+KLunPk
         8ZtKIjmBddBeCKW0D2lg8vMP+DvlqgWUmzMtoLDqpQEuDfueF6rtscP37T/lCePruB9r
         M0sZ3/rvvDnCh+0T5TxCUeudLsdAQ136UM0bupRsYyThY029/jSWttFLyv9V2u/NjqPh
         M2qU2JG8GDK182QlCTAXvyWntmQSTyXWYM4mYWOyBoLxYD0ZHp5hx2iWSHZh2XlhktNq
         BFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sRHti0Uq1p2tbyjOiwcZxzseK+6mNQaP2BRe5nYQitM=;
        b=iMN/o8MVc9qEdhasVummmDI04QrUc9+yjolUpa4PDn5HHU5GaKL2AP1ioYa9whc3vi
         QU1CUsrblB3coikdQJsGaeDnQQdnuXZYjGuB2nLnZDxXqSZ5poIwI45uOJ0J1CXRsl8P
         PwdsBli+VUKaDyLhc0yU/NC601CMsa6atnV1bUM23K4cOAUKukSyduSw+tJbqjjb1KW8
         yJFiGsEwP/AZrgGRyNHWFDpCU1hiN+xqwB7eBSCY3tEWPiHYBBWPqroC0kOJ4HMlJWzl
         bnBg/wFotp9n76MejznmAjcegIr0X/JZ5hCZb7W5O5BOEnrTXkIqs0l34+slsenZfT/i
         z9nw==
X-Gm-Message-State: APjAAAU0uy45ysCo0eO0NCUfYbiP6F5fCmLNsg0JyyXSQpFcU077Kvmy
        cy7Ih7evWzVMdo/1xwfgYbQR9ZYL+MJXQzZfzh4Jhw==
X-Google-Smtp-Source: APXvYqw26YMo7M49COSiMcwGgPtEcpmCZgzTg+LUdMoKj3z/mJCV57ew9MRX0IqVokmUcPu/xJv9Db9OLJ2Hqasuaek=
X-Received: by 2002:a2e:2ce:: with SMTP id y75mr8195765lje.126.1552036308362;
 Fri, 08 Mar 2019 01:11:48 -0800 (PST)
MIME-Version: 1.0
References: <20190304200918.1444050-1-arnd@arndb.de>
In-Reply-To: <20190304200918.1444050-1-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 8 Mar 2019 10:11:37 +0100
Message-ID: <CACRpkdZmNbPcSQXU6mosQJk1j9k+vQfJbs2KUZcXTUo172_cCQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86: apuv2: remove unused variable
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86 <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 9:09 PM Arnd Bergmann <arnd@arndb.de> wrote:

> The driver was newly introduced but the version that got merged
> produces a harmless compiler warning:
>
> drivers/platform/x86/pcengines-apuv2.c: In function 'apu_board_init':
> drivers/platform/x86/pcengines-apuv2.c:211:6: error: unused variable 'rc' [-Werror=unused-variable]
>
> Remove the evidently useless variable.
>
> Fixes: f8eb0235f659 ("x86: pcengines apuv2 gpio/leds/keys platform driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

As Torvalds did not yet pull the GPIO tree (maybe because of this
and other bugs, who knows) I applied this to my GPIO tree for
now.

Yours,
Linus Walleij
