Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB04EC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 21:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8829B206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 21:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w024gHcn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387594AbfGPVm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 17:42:29 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42150 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfGPVm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 17:42:29 -0400
Received: by mail-lj1-f194.google.com with SMTP id t28so21457196lje.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 14:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qWj58+e/GjA5oMIqEIz1bPYBPJn9YmCmo/2qZtRrpEc=;
        b=w024gHcn0gesOXAZgGhjMOSeHWAdbhYgBj5nJQy3TyzpuVcOUB0dpA/Rf+UZfQe+Us
         uqcVDbPLMYbUQ2+IC4rDAMPid53e8k9hw46TcnYvmJsMsfwuPR4zZtE0wKslCRXWiUFo
         eyGgE8NxI9ZDEjDa3FEgobW/1xAd2/6zVSEUhlKRFj0X0t4/y8oqu3t6JeZdywvWDXUB
         dqwzq/TlOoNUg/8u8ngdBqU+p6P+ury1IzDezKULQRL83FnNEoTqvGnA+45ZMnZrygfu
         U5me3APF1mYNJAIDdQIblqKtCYqI9xHeo9W/Onltp52RLoPO+0aXdYUCiImmanz0nOmK
         tUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qWj58+e/GjA5oMIqEIz1bPYBPJn9YmCmo/2qZtRrpEc=;
        b=bFtvaRJEx3xYPyZ1N8mWeAUuQi2Yn7C/cMBleqBqhSzHTsqCZXMFeP+RfZm3WS6i3g
         sN7wMIg/fGU7jRMCusnm6GBIAi0MMpY33c/IsyhWIF/HPbOm0EYCWhTnN220x5Yn/m/H
         zge2DUrxcNtS9rG6jlhVA8PSHoR6Mm92DPocwErblbVaAwSzq25YWfTBXyoNMorjiVCG
         cRErqtU/IFAk3cf6J83vn0SgB5Eomg/c3l9Svw46aP6Ym0notYCBe0GTwaRn7wQafQp/
         Dyd6auJgwdmWxGbAuF+Yx4QBCUx/7RRV+CHQxO6YY0PD6AcuI50b4nkwhT0l9n1bTYJ3
         UkQg==
X-Gm-Message-State: APjAAAX0MiLHyFiTtTxrj8pJo/J9mI9M0DEq7P/vuxLY2+Xik/5NDJNE
        /7hK6kLZn4dnIQl/VoJf1RiqsAIIurlhWdKXBPJWsw==
X-Google-Smtp-Source: APXvYqzBU+OF8WyuGSMhycQxTCXJMVlzUxq526tx+EUSt2YvSRHnOvaDWvH6LAh9iDOjQgOm1Pk2VmywMwT+wLy2Fvk=
X-Received: by 2002:a2e:8195:: with SMTP id e21mr18010935ljg.62.1563313347087;
 Tue, 16 Jul 2019 14:42:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190710121518.GR17490@shao2-debian>
In-Reply-To: <20190710121518.GR17490@shao2-debian>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 16 Jul 2019 23:42:15 +0200
Message-ID: <CACRpkdYmtgO_E-KKE8zjA04POawJ=4RN3xFUPY__7GF+gSNbNQ@mail.gmail.com>
Subject: Re: [gpio] f69e00bd21: unixbench.score -24.2% regression
To:     kernel test robot <rong.a.chen@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     David Woods <dwoods@mellanox.com>,
        Shravan Kumar Ramani <sramani@mellanox.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKP <lkp@01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 2:15 PM kernel test robot <rong.a.chen@intel.com> wrote:

> FYI, we noticed a -24.2% regression of unixbench.score due to commit:
> commit: f69e00bd21aa6a1961c521b6eb199137fcb8a76a ("gpio: mmio: Support two direction registers")
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git master

That's pretty bogus since the test doesn't even seem to be using GPIO.
Further AFAIK Intel chips don't even use that driver.

Can you provide some rootcausing?

If you are using GPIOs from userspace in the test somehow I am
sure both me and Bartosz would be interested to hear how.

Yours,
Linus Walleij
