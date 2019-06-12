Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34CBC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB2720684
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kyXw3a62"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436721AbfFLH5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 03:57:09 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:36289 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436684AbfFLH5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 03:57:09 -0400
Received: by mail-lj1-f170.google.com with SMTP id i21so14231803ljj.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 00:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AXA5+gru4alxNYEnUDfWlNEf8IzRnyf79cJH1pZ+38A=;
        b=kyXw3a62hPc8udfYOuMAFQYc8Fccbdh+faAsJI+P80Pmxk1yzP+yGX3iYvLw6rKGmd
         Hq5U0d+axsu6EW2le0gAyQbKtW9kf/Ivndl6VImX75cPGL0Fcs+i59EUswbIX/VS2Xhe
         k76atnR56cJ9m+Gc7s2SUb6x7P9Xlwnk6yWRJ6MECQ6KIz0SlTN9IRrgopyv/Fh0563I
         S0qhrdQi0Ej8Uh/vBVyPDklESV3Z2hMmmSJoYCP9VMLofhElWe2ZL1d5PDyzXiWkUKIM
         83GyzWzjMVmFDkjFDTb9Ku1+kYkQvONmgcpVTlTkjGsljU7iz7h6TkDrpbNNxmcilk0v
         2zzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AXA5+gru4alxNYEnUDfWlNEf8IzRnyf79cJH1pZ+38A=;
        b=qCyOjXwyIwkfI1afcsLpaAchwM1AHStve2Kb4NAL4cfiEBGABZ29wmO//CP+TNgepL
         dwZ/t2l5AVNxnBvCXZw+ywHLp1ST371QPfGmfEtpYx3KTm8a/F7R6PRyLwYeSyWGL2G3
         ug11FRzZLvQATYTyYv+8PCNgYtcT0MWXE/dQhMFrfEAjvsBwVjAN8BorvC3rgyl9wq8Z
         x8p0fL1SnIqdMurG2hboG1WolCrpmqnVi9ANm0tkYpcY12fOmASim0cy/ZKQ2+1ekvWo
         sb4vTs8GcK018/djNPxWD364D5HBdg7vudresse3EzOLuEp9vcYzog1IHjZ2QaTg0M9X
         IcrA==
X-Gm-Message-State: APjAAAU6UWnzQ4PX5Z6JjDaP87TEisvUXR0URRKutR4E3FJkeN9Ap1/Q
        F46IWBQJjVlbDt+Ocj9GhDWR1y7YZfk0YStGK+pA5w==
X-Google-Smtp-Source: APXvYqyB3zRR+puZuMgastRuk2Y+CVJpnyH92tVnnNrgusklC+mEKSu4OgiVQhvUTB626b3d5lUUV2RAlvRSInwCGJ8=
X-Received: by 2002:a2e:5d54:: with SMTP id r81mr5507217ljb.104.1560326227130;
 Wed, 12 Jun 2019 00:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190610171103.30903-1-grygorii.strashko@ti.com> <20190610171103.30903-4-grygorii.strashko@ti.com>
In-Reply-To: <20190610171103.30903-4-grygorii.strashko@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Jun 2019 09:56:55 +0200
Message-ID: <CACRpkdaH6mE8GoLGJfZFTQZntBdOLqJ3GxSGMX8xyi5nRzXhug@mail.gmail.com>
Subject: Re: [PATCH-next 03/20] gpio: gpio-omap: remove remainder of list management
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Russell King <rmk@arm.linux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 7:11 PM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> From: Russell King <rmk+kernel@armlinux.org.uk>
>
> Commit c4791bc6e3a6 ("gpio: omap: drop omap_gpio_list") removed the
> list head and addition to the list head of each gpio bank, but failed
> to remove the list_del() call and the node inside struct gpio_bank.
> Remove these too.
>
> Fixes: c4791bc6e3a6 ("gpio: omap: drop omap_gpio_list")
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Patch applied.

Yours,
Linus Walleij
