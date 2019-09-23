Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F84C4740C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 09:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7D621907
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 09:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="aHR6Zeby"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393628AbfIWJEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 05:04:45 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39518 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393166AbfIWJEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 05:04:42 -0400
Received: by mail-lf1-f68.google.com with SMTP id 72so9485841lfh.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 02:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0JN1h+SdmbTH3kP7+d/LSAM256ls91/0oIY0PsAnI9c=;
        b=aHR6ZebyZ8DZpvzN5FPwizkSeWcTkugKWZ3zU5/wa6l5Q54ddMLdKKjzClEkVBcAIr
         R9Q0bAQBeD134Z05K7waWJ3GB31hRmYeoFBRNl9zeHVJguBN1TqCMfcnOhtE6FKLfkxC
         CB14f/dGMHvj7B3B1ElGiiHTXvRW9zUSm2oWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0JN1h+SdmbTH3kP7+d/LSAM256ls91/0oIY0PsAnI9c=;
        b=NGnGZrpiHCQkKq/9WOoGz4Je7WVFevIZv//RZccnFgaCOR2oEPffjqf3Mc85JQ/bEF
         /Rk63P6bHdPIG6To7uQax48AZV6i2U0tM0OWl4zf9ZaDJojxIn2hljNcNZOa0kwQ0N04
         2xUIzZ4i7+JffcvkVI0YHclkazDBCFlut8WD6QT4Pze20VlQ1e3cpVY9ybvZ9BI/ebtp
         CZyr89iBfclGZTded8WX35QSRqEr7rGaoWzDOLS8Bhz2jG1SPO4qmjR9k0/3c17hjt3/
         /vIdk4P3tfFVsmrrkszuX47Hm1ROo1tktcBFgXCGAXWnqqafHjFvOOz75OaWADarRn70
         HWBw==
X-Gm-Message-State: APjAAAURyTbkbe9zIljcgTM6riE6Ev23mrox+2HWCa2KLHmRnFvLBVH9
        MvD8BauHh/wWEYe05Q3+fJ+N0A==
X-Google-Smtp-Source: APXvYqxE0UImPNGet4+HJgvkP3IVnXfnoznq6mWvl/4K5U7NnkgngpqSc4uPgwZPAR8lLmN00SF+gg==
X-Received: by 2002:ac2:5091:: with SMTP id f17mr16518413lfm.107.1569229480930;
        Mon, 23 Sep 2019 02:04:40 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id g26sm2174673lje.80.2019.09.23.02.04.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 02:04:40 -0700 (PDT)
Subject: Re: [PATCH 1/4] pwm: mxs: implement ->apply
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20190923081348.6843-1-linux@rasmusvillemoes.dk>
 <20190923081348.6843-2-linux@rasmusvillemoes.dk>
 <20190923082459.huqpbz5eseonkscv@pengutronix.de>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <a6407644-0b5b-ba46-9435-0d14be9066a5@rasmusvillemoes.dk>
Date:   Mon, 23 Sep 2019 11:04:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190923082459.huqpbz5eseonkscv@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/2019 10.24, Uwe Kleine-König wrote:
> Hello Rasmus,
> 
> On Mon, Sep 23, 2019 at 10:13:45AM +0200, Rasmus Villemoes wrote:
>> In preparation for supporting setting the polarity, switch the driver
>> to support the ->apply method.
>>
> 
> Maybe it would be easier to review when converting from .config +
> .enable + .disable to .apply in a single step. (Note this "maybe" is
> honest, I'm not entirely sure.)

I tried to make .apply do exactly what the old sequence of calls from
the core to the individual methods would do, and for that it seemed a
little easier to keep the old methods around - but yes, I do need to be
more careful than that to provide the atomicity guarantee that the
legacy methods did not. It's also much easier to squash than to split,
so for now I'll leave them separate - if somebody prefers them squashed,
I'll do that.

> There is a bug: If the PWM is running at (say) period=100ms, duty=0ms
> and we call
> pwm_apply_state(pwm, { .enabled = false, duty=100000, period=1000000 });
> the output might get high which it should not.

Ah, yes. So I suppose that if we're changing from enabled to disabled,
we should simply disable it in the CTRL register before changing the
duty/period.

> Also there is a bug already in .config: You are not supposed to call
> clk_get_rate if the clk might be off.

Interesting, I didn't know that. So the prepare_enable logic needs to be
moved before we start computing the period/duty cycles. Do you know why
it has apparently worked so far? I would have thought such a rule would
be enforced by the clock framework, or at least produced a warning.

Thanks for the fast review. I'll wait a day or two to see if there are
other comments before sending out a v2.

Rasmus
