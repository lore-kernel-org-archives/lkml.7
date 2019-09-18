Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E98C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 01:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B586C2053B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 01:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568770854;
	bh=B+mcMFY1lW5YzcNDF1nV15MQ42KQMb+AHEFiuEvs7F4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RqjyMjHFXH7dG60UkUuiDWHvRus4sPUINztMeCVT9logLqtyZWIqKfoz6fRGk0sdE
	 UzM+EYv/k+f/7vg8YcpTJeW4vxO/VOgvIvmUc4hjCedor2cmlWvWZJKse3lA88Keap
	 XVy+uKWkGHLVGjokgUOZgBfsS6gPnCtMnQxvIk74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbfIRBky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 21:40:54 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43426 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfIRBkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 21:40:53 -0400
Received: by mail-lj1-f193.google.com with SMTP id d5so5460904lja.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 18:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fxZxgQXB1oaMwYliKzbFMQ3wWmFlE3pkMrUM3WHegTI=;
        b=gll0QwYPhJXC5RJZMPEoVL65l3AwY9HheCrApLkuz9bM8z5Y6nQmWdcjiFnXXZD66l
         wbKE8dQqumz0IA0gcfqzd7tQEKcaTkP2a0TZtm2uaU1XJ4P4e2jMjulleFNtwgmEhhT2
         wZmpXrgJ61REEDlo/x/getB7PUdm6g7R/DNGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fxZxgQXB1oaMwYliKzbFMQ3wWmFlE3pkMrUM3WHegTI=;
        b=JulcHireEYqV2+REXeiGlWrExQp2ok2UOdyJjAO1Q1NPycXCralbgfTqYEeBzzv8W+
         W+sbbLUZVhpLUtz3KslvB7zbeGU+qdmIa+jEH8YURXkLaNtLKJYBXP5CbSluDJTz0FTM
         wTrLo8z9z+0YsGsc5qKd6PcBBhIQKHT0gG/5nkEMiZ+86ux/pXRLxvgsezMkzRXdCizj
         efHXwTuQKbtq8NHy6rIvY42EjcJObzLLRWwKGqelNiu7XtUSiA/jzcnsNWUNL9SK1cQf
         1tbtEEQ2jNJ6ixkpAh2Eh6HBSLGpsQnJg7GzO+NRE2Ct+G7YBhHJOab4P9jeol+lKQVC
         gayQ==
X-Gm-Message-State: APjAAAXfwfyDoWx1sf53KQxqW8ig0wC/CSs/VqcsZS9ilQDeIUGLveCH
        GqCiAicVZEQgQahiWcyCHzEkqo4bPkA=
X-Google-Smtp-Source: APXvYqxEw4aYFJ5sSfHfLaeqbA9zXsVXYRs9uCqVOEdd1qNMGqzRTdaJ01XqhmqCKzUVIlwS0u9B8w==
X-Received: by 2002:a2e:84d0:: with SMTP id q16mr643887ljh.106.1568770851031;
        Tue, 17 Sep 2019 18:40:51 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 207sm847348lfn.0.2019.09.17.18.40.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 18:40:49 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id m13so5426036ljj.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 18:40:49 -0700 (PDT)
X-Received: by 2002:a2e:2c02:: with SMTP id s2mr678446ljs.156.1568770848787;
 Tue, 17 Sep 2019 18:40:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190916222133.9119-1-jacek.anaszewski@gmail.com>
 <CAHk-=wgxNj_RBpE0xRYnMQ9W6PtyLx+LS+pZ_BqG31vute1iAg@mail.gmail.com> <CAHk-=wjAVTCZ9-X6ETA7SASNhrOyJuCgn792E_Wmn+JaEQ8N0Q@mail.gmail.com>
In-Reply-To: <CAHk-=wjAVTCZ9-X6ETA7SASNhrOyJuCgn792E_Wmn+JaEQ8N0Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Sep 2019 18:40:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjm422bg+ZPuKkjU6NffbAyysY2n8iLRFyiNKin4cvWgg@mail.gmail.com>
Message-ID: <CAHk-=wjm422bg+ZPuKkjU6NffbAyysY2n8iLRFyiNKin4cvWgg@mail.gmail.com>
Subject: Re: [GIT PULL] LED updates for 5.4-rc1
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-leds@vger.kernel.org, ada@thorsis.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        christophe.jaillet@wanadoo.fr, dmurphy@ti.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>, info@metux.net,
        Joe Perches <joe@perches.com>, kw@linux.com,
        Linus Walleij <linus.walleij@linaro.org>,
        nishkadg.linux@gmail.com, nstoughton@logitech.com, oleg@kaa.org.ua,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Tony Lindgren <tony@atomide.com>, wenwen@cs.uga.edu,
        wsa+renesas@sang-engineering.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 6:14 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Famous last words. I now get a new warning:
>
> drivers/i2c/i2c-core-acpi.c:347:12: warning:
> =E2=80=98i2c_acpi_find_match_adapter=E2=80=99 defined but not used [-Wunu=
sed-function]

Commit 00500147cbd3 ("drivers: Introduce device lookup variants by
ACPI_COMPANION device") removed the use of that matching function, but
didn't remove the function.

It also removed the use of i2c_acpi_find_match_device(), but in that
case it _did_ remove the function.

And apparently nobody bothers checking warnings. Tssk tssk.

                Linus
