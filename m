Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD5FC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 392AD2133D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpeGXLFv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfDCSQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:16:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34971 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfDCSQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 14:16:47 -0400
Received: by mail-pg1-f194.google.com with SMTP id g8so8730883pgf.2;
        Wed, 03 Apr 2019 11:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3gEgRK4OgXC5g0LnmPAwaAVG1D2rzi0B/jXz3s7AndQ=;
        b=OpeGXLFvJFVliRnAZwEKPEnpTEEKD425WL/UX+OOvMlVVQG4+UCwxNitRvME6oohHl
         C3W9QLBwD9xsUpBRuLcu2xp9t4yiHXAuQICpTyHiSJQcTrqvNyw8G/sicZO1Z2LFSr0X
         qMbp9v2UuVZtVCry83zMVOWXPhkcBZygqj45qyQWmNI7kdM4UyA3ok3VqQGWOC+rm6Lz
         7b1Cdoin553+N2+AxcElcA/edRPf1h7gRvIcZXgoSxoe4P3GLFn1w10re4cfNMmVP7vv
         ZoDFXJEnoOo/H6E7Tq6GJ7etbikte+/Rb8ptEUvr0Mg6z9a0ED9HyJAM63oiJcRzUAqH
         B8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3gEgRK4OgXC5g0LnmPAwaAVG1D2rzi0B/jXz3s7AndQ=;
        b=T6kblM3bPUGvMF5hXBbLty68iOQElHMG1IrijaX4vdZffTGRT9O0aMcugUTq1q1y/S
         g4EEVP2ezWJeejHh0da/AYei8k/L12Jr6GrsZVfSIva7e8UGuInWMmxhalsLsJwPxlxE
         9BQjUwRwQJAxofmbWaZ0GEmHh4RYDgekUhIVRWDBob/EXixHAiA6NiurrnfAhEH2vX8a
         ni9uoUjZVescUUXYyOuMN+ryoaVnb2lR+8KayL9hIv+UyNJRp1TQzRN/KNdlix3hrk2A
         +yBR2Geo/WFsTFi683TCUwNS+Bc8wqSnaHuRoVpIr2NMHubEEcLEgTotUR0gGbLvC83m
         9WRQ==
X-Gm-Message-State: APjAAAXTdoXn2J0M6DtdKv8QIQJbAKY+AkNYiIcKoxP/YMRO9Kxcc19Y
        OehGR28jBmlz2LcZgYJyLVk=
X-Google-Smtp-Source: APXvYqwwHBxx8MvsnUcKgZeN1YdDjEmxqRV8jOVr2K5bz0gJPOBoJvgKnIRfr84VCtN3V4hyKMu+Jg==
X-Received: by 2002:a63:e70c:: with SMTP id b12mr1027672pgi.399.1554315405753;
        Wed, 03 Apr 2019 11:16:45 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id b8sm19197648pgq.33.2019.04.03.11.16.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 11:16:44 -0700 (PDT)
Date:   Wed, 3 Apr 2019 11:16:43 -0700
From:   "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
To:     Ken Sloat <KSloat@aampglobal.com>
Cc:     "josephl@nvidia.com" <josephl@nvidia.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [BUG REPORT] linux-input: keyboard: gpio_keys: False Button
 Press Event on Wake
Message-ID: <20190403181643.GC53104@dtor-ws>
References: <BL0PR07MB41151EC4B770F6A7396C152EAD570@BL0PR07MB4115.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR07MB41151EC4B770F6A7396C152EAD570@BL0PR07MB4115.namprd07.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ken,

On Wed, Apr 03, 2019 at 05:50:09PM +0000, Ken Sloat wrote:
> Hello Dmitry,
> 
> I may have found a potential bug in the "gpio_keys" driver. FYI, I am
> running the 4.14 LTS kernel on my system, but from my understanding of
> the issue, it seems that this would still occur in the latest version
> of the kernel.
> 
> The problem: In the 4.14 LTS kernel, both key press and release events
> can generate a wake event. In the 5.x kernel, wake events are
> configurable for press only, release only or "both" (see
> "wakeup-event-action" binding). The issue can occur in the "both" case
> or release/deasserted case. Let's imagine that a system is suspended
> when a gpio key button is pressed, and subsequently resumed when the
> button is released. If we look at the sequence of actions and events
> reported by the input system, we can see the potential problem:
> 
> Button Pressed
> Event Value 1
> System Suspend
> Button Released
> System Wake & Resume
> Event Value 0
> Event Value 1
> Event Value 0
> 
> As you can see the input system will report an extra button
> event/press. This appears to be caused in gpio_keys_gpio_isr by the
> following statement:
> 
> if (bdata->suspended  &&
>     (button->type == 0 || button->type == EV_KEY)) {
>         /*
>          * Simulate wakeup key press in case the key has
>          * already released by the time we got interrupt
>          * handler to run.
>          */
>         input_report_key(bdata->input, button->code, 1);
> }
> 
> This code does not seem to take into account that the wake event may
> have been caused by a button release action, and just assumes we must
> have a button press.
> 
> This can obviously be problematic in the use case I mentioned, as the
> system would be put in a constant loop between waking and sleeping.
> While there are other ways to deal with or react to this issue in the
> userspace, it seems that the driver should probably take this into
> account.
> 

I believe the expectation is that we do not go to sleep with button
still pressed, as we expect it to be released momentarily. Given that we
do not know which edge woke us it is not clear if we can avoid
simulating the keypress event, as this definitely causes "missed press",
at least on some Android devices, where by the time we get to run this
ISR user has already released the button.

Thanks.

-- 
Dmitry
