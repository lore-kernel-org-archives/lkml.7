Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502E2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 02:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E582082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 02:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732114AbfC0CQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 22:16:38 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44728 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbfC0CQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 22:16:37 -0400
Received: by mail-ed1-f67.google.com with SMTP id x10so12545786edh.11;
        Tue, 26 Mar 2019 19:16:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gYHbp01eX5seNE5ry9J+KD7vQHicSnzNBTRk3Ajk1+w=;
        b=GFe8Tzp11dIDcfXL7S2yAcPsgH5LdwEpnlEENnEXq3S5CZ+IFO6YI51fyMwNvn5kQM
         cYxIVrNZxUbhDamYHgAKR5wPIOHqyPUWSblQPb5F5tMKG2DvZNzzQWn/NPcN8fcXo0WN
         rOiO0u1pFsO+s/KzCfN95p79QrtBY++SvYOFzI70fCrYHrkiQeWZU+3pdqTz5M3WK6wx
         IMJVAsTn688Ts3r+HPj7JDbc/iJ8C57QnnIAB2jjqvw08GPjM9F8x3nfRXJLweXetNsk
         YC5Pneg64pQYuGUtSjlqRc15m6Hd0wxVJC7Vx78SxHW0cYYfwHZH7PEOXEh/N65iadAA
         XyYg==
X-Gm-Message-State: APjAAAV3GxPjv4w1KqI4e0qaoD34V5gBQhZlJTeliROSq6UXYDOBwRRx
        aCxMOviZAf8rK4gHGyx67kLDz8msABA=
X-Google-Smtp-Source: APXvYqwcXfhGMAYeoOfLCQWKM7NS9r9NEE1CFELYM6UiKcBi2LdLaGWNdgTJXzXaKbfcnnRaYTqAZQ==
X-Received: by 2002:a50:8589:: with SMTP id a9mr21904048edh.76.1553652995685;
        Tue, 26 Mar 2019 19:16:35 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id d55sm1994851edb.5.2019.03.26.19.16.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 19:16:34 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id r4so8941650wrq.8;
        Tue, 26 Mar 2019 19:16:34 -0700 (PDT)
X-Received: by 2002:adf:ec87:: with SMTP id z7mr21323016wrn.44.1553652994246;
 Tue, 26 Mar 2019 19:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190327002501.4630-1-megous@megous.com>
In-Reply-To: <20190327002501.4630-1-megous@megous.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 27 Mar 2019 10:16:24 +0800
X-Gmail-Original-Message-ID: <CAGb2v649vo4Neudau+jmE_7egsL6nuTgOezjgfO08w0rQCpbPw@mail.gmail.com>
Message-ID: <CAGb2v649vo4Neudau+jmE_7egsL6nuTgOezjgfO08w0rQCpbPw@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Add support for lradc on A83T
To:     =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>
Cc:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ziping Chen <techping.chan@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 8:25 AM <megous@megous.com> wrote:
>
> From: Ondrej Jirman <megous@megous.com>
>
> This series implements r_lradc (low res ADC) support for A83T.
>
> This is a continuation of v3 patch series from 2017 by Ziping Chen. I've
> rebased it on top of linux-next and changed the compatibe string as
> requested back then.[1]
>
> There was some talk of iio based lradc driver back then[2], but noone
> stepped forward to make it. Let's finish this series, so that it's
> at least possible to add support for tablet keys on various A83T tablets
> as that's the main use of lradc module.
>
> [1] https://lkml.org/lkml/2017/6/26/558
>
> [2] https://lkml.org/lkml/2017/6/27/877
>
> Please take a look, and apply the patches if you have no objections.

You need to send this series to the input subsystem maintainer, Dmitry
Torokhov, and CC the input mailing list. Otherwise the driver and binding
changes won't be picked up.

ChenYu
