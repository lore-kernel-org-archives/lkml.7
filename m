Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8764EC468AA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 21:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6025A2133F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 21:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SXwjy3zb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbfGEVqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 17:46:17 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43322 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbfGEVqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 17:46:16 -0400
Received: by mail-lj1-f196.google.com with SMTP id 16so10449096ljv.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 14:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1v61oqHX7c1CBf8OKtP/1BsjhM0sQc4mZ5MbznJNlJ0=;
        b=SXwjy3zb+x7sxSUBJA93el1BrCvxzsbXimpX7BfJP2R9hBZour6fXhPCbzX2YdN4Xq
         DJwQmh92LJQ7dlAk8HHwI7Y/DO2z88DU2ocLtKZBRRMdAPx8MkWi536/unIM153tG4W9
         uxQW9irsTf0ZLiTEN4IFlVhWEuPbtzKfAUWf/4L6fL9IMymXJIR1U89+33VBZNnUdsOZ
         n9koVQKlBn8xSKAvUkk8YTMHXzlJWHYng02RtIA2q55duzaZi/zvNFzBnvw3PyB/xYJr
         cZuJifd1DtiUu80zWejM3NgQPtEp7K/6U87VbCAbmeFjna5DQ/wFRN/XstuS8Lz9wCUN
         MAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1v61oqHX7c1CBf8OKtP/1BsjhM0sQc4mZ5MbznJNlJ0=;
        b=ATB2Dn6tSLxyX7ez/XQBd038vSd23bNeGT7xNJ+il1IVeSACIlMQ2HI+vuJwz135jE
         ACvWv+GlOTmfj/qKT8sdFxqfv73edRbtYLVlpPXLfuudFs2M3P1NauAiXdZV+TySX0In
         14ufe7NMPDWKssRZE9rFJwiNLb5R1jo5Vfmc6rZvivI6G22qiooVcT52kmlA/XOgLEdZ
         fyFa+ErATLom3kgb+qUYXlQI/BojagNf+8XJGATsIJkXezOKtuf1HhIHBMByNe7w4V0r
         8rtWHQ4gRKwdDcBEySXD45IDcfQt668VsLSj2Y5KQzbtsr977V1hJ+gVBx7qv3AEenUM
         pQPw==
X-Gm-Message-State: APjAAAXD6Uea003Cw4yZVYMs7I+fDvuuTPD1IcpUvRmJOqHLTCJitqNG
        MFcCxTKEBXAiPrjJokJR4RlwYfWrkXgII5WhFwRbyA==
X-Google-Smtp-Source: APXvYqy0jVBhDi9Azmj3ALArw1NOW+akz5NAjVXoXrCyDmop7IqnpAqGcqKicSCXLw284lqovEhIGFR9WEBP47tW2+4=
X-Received: by 2002:a2e:9048:: with SMTP id n8mr3271162ljg.37.1562363174296;
 Fri, 05 Jul 2019 14:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190705093031.18182-1-michael.wu@vatics.com> <CAMpxmJUzaEREeUxCu2BCV12Huv7K=yeUSKntA5RGMfOQbnxaFg@mail.gmail.com>
 <5DB475451BAA174CB158B5E897FC1525920E9FD0@MBS-6F-DAG.vivotek.tw>
In-Reply-To: <5DB475451BAA174CB158B5E897FC1525920E9FD0@MBS-6F-DAG.vivotek.tw>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 5 Jul 2019 23:46:02 +0200
Message-ID: <CACRpkda5QuuEJhMwSjJb-pqkKQsn6YpCysDLTx17__meZC52XQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: fix incorrect IRQ requesting of an active-low lineevent
To:     Michael.Wu@vatics.com
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        mvp.kutali@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 5, 2019 at 12:35 PM <Michael.Wu@vatics.com> wrote:

> For example, there is a button which drives level to be low when it is pushed, and drivers level to be high when it is released.
> We want to catch the event when the button is pushed.
>
> In user space we configure a line event with the following code:
>
> req.handleflags = GPIOHANDLE_REQUEST_INPUT;
> req.eventflags = GPIOEVENT_REQUEST_FALLING_EDGE;

But *THIS* is the case that should have
GPIOHANDLE_REQUEST_ACTIVE_LOW, because you push
the button to activate it (it is inactive when not pushed).

Also this should have GPIOEVENT_REQUEST_RISING_EDGE.

> Run the same logic on another board which the polarity of the button is inverted. The button drives level to be high when it is pushed.
> For the inverted level case, we have to add flag GPIOHANDLE_REQUEST_ACTIVE_LOW:
>
> req.handleflags = GPIOHANDLE_REQUEST_INPUT | GPIOHANDLE_REQUEST_ACTIVE_LOW;
> req.eventflags = GPIOEVENT_REQUEST_FALLING_EDGE;

This one should not be active low.

And also have GPIOEVENT_REQUEST_RISING_EDGE.

However I agree that the semantic should change as in the
patch, it makes most logical sense.

The reason it looks as it does is because GPIO line values
and interrupts are two separate subsystems inside the kernel
with their own flags (as you've seen).

But you are right, userspace has no idea about that and should
not have to care.

Yours,
Linus Walleij
