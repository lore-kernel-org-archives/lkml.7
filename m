Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36E8ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 19:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79810215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 19:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfJATCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 15:02:39 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46577 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfJATCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 15:02:39 -0400
Received: by mail-qk1-f196.google.com with SMTP id 201so12319395qkd.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 12:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RtRzWD7zEbjJ2A4VYjRF/6/NQuaf29B5zVdZT4/GSfc=;
        b=C8KPrTv2SlYVkVWEF/Od2J35ndIKL9JxeeXf7/PEMeZx1lA27C4zAEtiZ92WBasZYq
         cyPjXvZUhv6aFK0t0Yld1WRnHzrTnaJuGw1hVsPsqreZS2JEMSrAHocqESIS6fv6g7Ph
         Mozd56x8KXxIWzLogsrRAgI7CBwzxE+JLt/Ye3/rl11ADoQz7hqdJSqHKUxDXQNz1uaj
         DwxzgvK2Bl8AaNVuzNqM2mu78HndNDbQA9ogqBo4/ngpDTY1pH+AhDn1RYP4lYelfAOB
         cX5h1XzB6z5NSnzjr4GbY5Yx86Jlh9bYWt7h7MyvK7tYyacViSw0iqYYv7pgRxHVo+lD
         6YtA==
X-Gm-Message-State: APjAAAU2TrhhfWzdEFzm+psC31iLWpVA8RZYdDJ9xzArvRsuVjvXsIYo
        tTCV9R1WLn495Qe/KfqhjzQw6CxnAcXwU4tVFCw=
X-Google-Smtp-Source: APXvYqyKVBTpwzORgepB82eF9G6BF0XWbuGMTxfsXAs4ovRtl9RXDG3EDKzynC6mRl7lAXlZww4fFPocBSuw3EMLKmw=
X-Received: by 2002:a37:a858:: with SMTP id r85mr7757595qke.394.1569956558234;
 Tue, 01 Oct 2019 12:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20191001142116.1172290-1-arnd@arndb.de> <20191001175501.GA14762@sirena.co.uk>
In-Reply-To: <20191001175501.GA14762@sirena.co.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 1 Oct 2019 21:02:22 +0200
Message-ID: <CAK8P3a2idD4as-9ns0NrLjYGYSEc0=6A67VaNXDacA3-tJEr0Q@mail.gmail.com>
Subject: Re: [PATCH] ASoC: atmel: fix atmel_ssc_set_audio link failure
To:     Mark Brown <broonie@kernel.org>
Cc:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 1, 2019 at 7:55 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Oct 01, 2019 at 04:20:55PM +0200, Arnd Bergmann wrote:
> > The ssc audio driver can call into both pdc and dma backends.  With the
> > latest rework, the logic to do this in a safe way avoiding link errors
> > was removed, bringing back link errors that were fixed long ago in commit
> > 061981ff8cc8 ("ASoC: atmel: properly select dma driver state") such as
>
> This doesn't apply against current code, please check and resend.

I looked at "git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
for-next"
as well as the for-linus branch in the same place, but found no
conflicting changes
in there compared to v5.4-rc1. Am I looking at the right tree?

       Arnd
