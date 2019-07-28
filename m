Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5044C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 23:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB7C62075B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 23:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nqe53c1o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfG1XGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 19:06:05 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45055 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfG1XGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 19:06:05 -0400
Received: by mail-lf1-f68.google.com with SMTP id r15so23720372lfm.11
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 16:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lwz4q2+szKTu4Ft4q7DE+NRgcxDusAz+Lo48bkTTfVs=;
        b=nqe53c1oBRmoMa5ivnh0qXiEubDFJreYPg8EhzLADL+Qil8rlxjmbc4rnNbdAuW5xI
         wxQ+La1VKcLxJdH9oQ55nVWWEk4ozIYfHyDhEQJkQS32fX7mJFZj4iFEyaqZVbD2Gjax
         5NPfJst7iuaAlYxYiu/ioTzM/CV6Hvai1b3FP2OUnCexJyuWLz/ddEoE5srcPRLcaHST
         YBU3Z/YNMr6IVtJkqciglGOEdWZ8movdNpkrys/AvR5PgamTvbji5Li8Oh7iFJ1jk9uh
         ERwjpP6Rh/TvMpg5jQRZbNSG+IokHU47CAcml4CsmXcfTE5L1HGln+jcyL+gytiZueFq
         tt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lwz4q2+szKTu4Ft4q7DE+NRgcxDusAz+Lo48bkTTfVs=;
        b=bhT3pMfYWiNHbVEQhqTg/veZ/5kP9r87M1Ls4cSx+O4XmdMkHUH0VQL83e6w/+klj1
         JsOOkyn9BUpaZRlxjPvmpxgQ9jll/qK1kegrqFY+FWxKeCVj7UTkiDtDK5jugiqU7DjA
         xzsCg1lNFk9IMsIYXWUPwLBTYdhYcYKUcnaOtUcH5C6psEiMj49jbrQ2u7IaLCmkZPEU
         GSsNhJ6YQUAAgTXdQGM8YzOC45CiHTAjAp7GVg+7ceWii80DAy7e18xeLPCLeQUeb5kT
         7odFXpjszqRGSvsqX/1lJEwHEbktBc6ajiwP7+sqI98RxHcgzJuEuBaBB5wN0feGyxbN
         4PeQ==
X-Gm-Message-State: APjAAAXvzNriqITLyOuaErdD1O7k78d634qQrmEr8OnLISyKkr1gyzL5
        EjCg86C8cMHtqT7tHyuIe9IiQb6T3f6XklwZ8ED8/Q==
X-Google-Smtp-Source: APXvYqxO1ZShAsIw0HaFz8MRuajoyCEfOeK9aViZSPPZIHqcFUGTcVHBzvKwcuq0oXYGpEIw8+BgiZr/2ww+IkqsjVs=
X-Received: by 2002:ac2:5382:: with SMTP id g2mr48403745lfh.92.1564355163192;
 Sun, 28 Jul 2019 16:06:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190708211123.16495-1-jcline@redhat.com>
In-Reply-To: <20190708211123.16495-1-jcline@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 29 Jul 2019 01:05:51 +0200
Message-ID: <CACRpkdYaHd8ZhkRSRMWXSrasaMuCk=LDU40y0NkQXpeWDHAEZA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: gpio: fix function links in the HTML docs
To:     Jeremy Cline <jcline@redhat.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 11:11 PM Jeremy Cline <jcline@redhat.com> wrote:

> The shorthand [_data] and [devm_] cause the HTML documentation to not
> link to the function documentation properly. This expands the references
> to the complete function names with the exception of
> devm_gpiochip_remove() which was dropped by commit 48207d7595d2 ("gpio:
> drop devm_gpiochip_remove()").
>
> Signed-off-by: Jeremy Cline <jcline@redhat.com>

This does not apply to v5.3-rc1 can you rebase and resend?

Thanks!
Linus Walleij
