Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC51C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8240C2184B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wStOR+6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731538AbfDERZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:25:33 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37559 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731133AbfDERZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:25:33 -0400
Received: by mail-lf1-f68.google.com with SMTP id o19so4932086lfl.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 10:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pJRBVyuiCCfrlbGs6icGtD5XMIrTL9vQqsY+931hxqs=;
        b=wStOR+6jt3F8Y4gZrOUGErlq4WOrdAD3T+qW45g7esdNf8lham0REh94WH4nGHX3Yr
         c8Kk5ET9Rq5NzoNUEVbRP4maGHfoRjmS5fLlQX6rFs2J/fZGjSff0EJVh0iT1VJvv73s
         pf1QFS89NK2huLunASaxUnGqWGCjHVgbuarFX1wYCgbJieqBbJfR/On6vJe4rdsLrn+D
         jnoLb+/ltb7Mj5j77QazAU6kVBNWXQcYDAR7FN3OK+JhTyDfFLwTmh2WwnCky8+ir+ix
         qRcacs2yU71dyIz9gpw6q5YFZh1VmPNp5TNKa04SXWIKZD4Gav1ElBBJHcf/KGwQVe5p
         5grQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pJRBVyuiCCfrlbGs6icGtD5XMIrTL9vQqsY+931hxqs=;
        b=TqSp778chmxKWlL8xY8WR/Z6cn17dP3u+Rudf4qccrsZ3CuMeetM4Gg29SQBkdn2hO
         5lEM88R2X2jseAAp36ulvYir0TMtE81FWUSbL67i1e3CgwTvj20HupudIwiqDXVEA84a
         7Je+cIz90n3veTKIZhvetB5ll04MftttKhWXHsJ1lVJuhjd8vYLhUGKbAGetbuRK/fFE
         9YR1YIUpFX1XjSLcceVzoVe2mNx8WRCmS+pJ78a/8gao6tR9rXLpmWAA88HuFfCQitgK
         p3bwyNFD1sLBaF8Cq+/5n1j69c9B/in3fr/ZFqZSixicmTFyp+NQXGtgFgu/Nl/77rjx
         G8tg==
X-Gm-Message-State: APjAAAVhTqGIYZlu5t4iV7/z/FU+Wik6rbpU5DNNTfEl0EvDvBb1xmZu
        a9w+slp4O/m3RhGiFKLVifoZufdqHvDnDOugx7rHIw==
X-Google-Smtp-Source: APXvYqxq6H6Bu8prNuZq9su0PaTlbyYvdZUriLYmGK3PyqFI0hukBbQ2NPHTN3AbDBM8wt940pdzR95teWhulccakgE=
X-Received: by 2002:ac2:54b0:: with SMTP id w16mr7661706lfk.138.1554485130792;
 Fri, 05 Apr 2019 10:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAFDyS3Nuq8FPx4z5GW1Ht+NBGd+8O9rjPZ+DaMU1XU1QYgA=2g@mail.gmail.com>
 <1438432079-11704-1-git-send-email-tal.shorer@gmail.com> <1438432079-11704-4-git-send-email-tal.shorer@gmail.com>
 <20190327161158.GA26067@taurus.defre.kleine-koenig.org>
In-Reply-To: <20190327161158.GA26067@taurus.defre.kleine-koenig.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 6 Apr 2019 00:25:19 +0700
Message-ID: <CACRpkdY62aXDOZm7cK4ND-RSnr9Ynz0DxS8-PHSF7i7diRG=WA@mail.gmail.com>
Subject: Re: [Patch v3 2/2] tracing: gpio: add Kconfig option for
 enabling/disabling trace events
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Tal Shorer <tal.shorer@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 11:12 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:

> It happened a few times to me since this patch was merged (in 4.4-rc1)
> that I worked on a system with tracing enabled but
> /sys/kernel/debug/tracing/events/gpio were missing because of
> CONFIG_TRACING_EVENTS_GPIO=3Dn. This is annoying and I wonder what is the
> motivating purpose of allowing to disable gpio events. There is no other
> event type that can be disabled with kconfig symbols. Theoretically the
> overhead should be so small, that having these events enabled
> unconditionally should be fine, shouldn't it?

You have a good point. We should not do anything special.

I guess by the time this was merged I believed it was customary
for trancepoints to live behind a Kconfig option.

I guess it is not.

I happily merge  a patch removing this again if no case
can be made for it.

Yours,
Linus Walleij
