Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1EFC10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 02:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 373862082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 02:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554862855;
	bh=f28MH2lJ5p3lrlUegVvu0keFjVwQ1/gHvgoKScPAJSs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vBXsQbiuIqOzcLbvn1UolFXNhRf43G2nv8AiHxg52QSFF2NvU0fVtcVXZRm3nHA0m
	 /CXqpMMvChcEIhaINTeArH47rBSLYxpzDkkpMsKJBZUUzLfiRewJkKeRPIhUOikFX2
	 5eL9EED8EtNagT4qcw8tMIL28H6oc4HTbnD9ebcw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfDJCUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 22:20:53 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:41924 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfDJCUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 22:20:53 -0400
Received: by mail-lj1-f173.google.com with SMTP id k8so575673lja.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 19:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pLSNy3bJVp7BVkl1lok4xvwCW7Pgx33X0n0klEhHpDY=;
        b=R/yJ0NqvG2dizompCKzG3qNxsiQbuNUrBTTXiRnFNdf3JI8lEtwd1xtH/hDURLbE1p
         V7ODjFobkMGn6g/4qihlqUe+K0HczVWL6o4Ok3UECfNv03El/Pug+ROR5m6kT7qt0gSH
         iIv/8/0OJzKa7ZJKMxJ18a/bY5a1ry5OzHkZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pLSNy3bJVp7BVkl1lok4xvwCW7Pgx33X0n0klEhHpDY=;
        b=bN2jBunAJEE5220BcHiFrZmG8tFfOVWQsiAaPLu//Uo4IyEFLUBjV+k0CnPv9xvZy0
         dm8BUHyoenHiVt43UTQRaBntsmHOf8DmCRwm+q24NuhDVW3Xvaer+uATPwosjYJIIHfL
         TZgjKL1C3Q+iP/ZVNNgbZD6udvKGQZ+dukR7+Hhlq7b2Lef2eqo0wmk/9e9Up7RFGgsm
         k7XOVFjXheH2qvDQ0TvpHFNMczyIreF7HzUemAzkh8AuN0WEdURth4aBnESbfIX6jJBD
         Hu1smZmwShK4NEkNxYUyuRPnzFCDroYKcAHMGbIiaix4TkkLAI1pOId8D4D7olw1/oPH
         yPEQ==
X-Gm-Message-State: APjAAAU6jWWffxt9ACQUUOcoFtoBhb0DH/jDCnMw8YgadXmHC1GYUchs
        3SsUnoY6nzRMtj6k+EIQjrshk73YiFg=
X-Google-Smtp-Source: APXvYqwHaBux0nrmPOTI4Qh7OK1X4ZqDiYKXnXU1BItP/8A9mJZoBnZ773HbE8gB/qgsBafIyDOTfA==
X-Received: by 2002:a2e:99d2:: with SMTP id l18mr20918526ljj.27.1554862850340;
        Tue, 09 Apr 2019 19:20:50 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id u17sm7386911lfu.63.2019.04.09.19.20.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 19:20:49 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id r24so600541ljg.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 19:20:49 -0700 (PDT)
X-Received: by 2002:a2e:8108:: with SMTP id d8mr20942979ljg.57.1554862848913;
 Tue, 09 Apr 2019 19:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190409184917.65062-1-briannorris@chromium.org>
In-Reply-To: <20190409184917.65062-1-briannorris@chromium.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Apr 2019 16:20:33 -1000
X-Gmail-Original-Message-ID: <CAHk-=wg6_i9WcqiGu4kg97yAg1du26RpXdxd=uEjo4yXjotdiQ@mail.gmail.com>
Message-ID: <CAHk-=wg6_i9WcqiGu4kg97yAg1du26RpXdxd=uEjo4yXjotdiQ@mail.gmail.com>
Subject: Re: [PULL -- 5.1 REGRESSION] Bluetooth: btusb: request wake pin with NOAUTOEN
To:     Brian Norris <briannorris@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 8:49 AM Brian Norris <briannorris@chromium.org> wrote:
>
> Badly-designed systems might have (for example) active-high wake pins
> that default to high (e.g., because of external pull ups) until they
> have an active firmware which starts driving it low. This can cause an
> interrupt storm in the time between request_irq() and disable_irq().

Why is the fix not to move the request_irq() down to below the proper
initialization sequence?

That's what drivers *should* do: initialize their hardware first,
request interrupts only after that. Initializing the interrupt handler
before the hw is actually up seems wrong..

              Linus
