Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9DCECE58E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 08:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DFFE206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 08:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rwJgS7yX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbfJIIC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 04:02:57 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39353 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfJIIC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 04:02:56 -0400
Received: by mail-lj1-f195.google.com with SMTP id y3so1486463ljj.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 01:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qIcuMqyribGNxdL5/KfaR/0W6xo7KhmFZDC62GSR9uw=;
        b=rwJgS7yXEf0+np6sEo73SubMwqxNdp4RcAX+jWJULZ3fSRrC1cOhANBPgDq/MHmTqc
         JFh13IiBSmC44y2+YQGvoQo1N9WvINr38BqrID75SDFU4ztKk4Cr6igNdJS4kJzI5+49
         pxW7/hEyoeoZF8AShMROjgLKBRoOpICQPs9jrfNOYkESk1LtzP17RhO8jHt8ZVd4xEuo
         CN60C2uE3+ThAkaX6W99cbN5hve3MQsxbrAf+8O43IfZNSz/tvXBanSJOxIGHnirbV4q
         8xSs0S8jpBpllANxVKbndvxTaBYdkIW0/xyno71RKh1Fo+8y10HchWjvn3s477Q/XYAE
         lXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qIcuMqyribGNxdL5/KfaR/0W6xo7KhmFZDC62GSR9uw=;
        b=hax29Y0q6R3K695uNMErVicK9FYDwl1LT8+E5J827gyfuulOuOW/lFWbkbbXxPTvAp
         B/hrOiQUnWf3AIZNbRYLVxyduPFGb35Y2EWrjEeRwTnd6HC9KIUb8UbagEk+GIkC9T1B
         ujtQyrz3NkOm8S7kt5+lOdwM/vsgf72yCrGQUw5M1UqwApJvhcNc6J7m2a42a5xELbmo
         FqiEcUSYePnheTzGVoJ+/0sJov0YBryKAqMuRvaMfrrGJ8t6BV30hvsVSccuucGtR+dZ
         lSmQtpNNWRY4o3MiCo6La2JcfUGpys2oV5Ew3TKfJ0HM491gbN00FG71BKtcRUske6Iq
         6Klg==
X-Gm-Message-State: APjAAAWOklNWWKpgbfe/OIURyoMYyLa5VgdwzHYcqoGNSCwPk56VLQhh
        nL+KtvE/h8qJ5lzv45Ki6ZG/OB/HZHlodenDDufwYg==
X-Google-Smtp-Source: APXvYqzkxO27nVgr+ezF6wWyRFhgeKlah+nA5MKVsuIlBHud+OOcCa69nMnvbinUrxjWWXwcTj43OmtOXQIUqoB6N90=
X-Received: by 2002:a2e:a415:: with SMTP id p21mr1418505ljn.59.1570608175035;
 Wed, 09 Oct 2019 01:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <20191001155154.99710-1-alpawi@amazon.com>
In-Reply-To: <20191001155154.99710-1-alpawi@amazon.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Oct 2019 10:02:43 +0200
Message-ID: <CACRpkdah=ofrdEeYUbp6ea+2S+EuN_XhUCXpCbDgm7p5R-Z6_g@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: armada-37xx: swap polarity on LED group
To:     Patrick Williams <alpawi@amazon.com>
Cc:     Patrick Williams <patrick@stwcx.xyz>,
        stable <stable@vger.kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 1, 2019 at 5:52 PM Patrick Williams <alpawi@amazon.com> wrote:

> The configuration registers for the LED group have inverted
> polarity, which puts the GPIO into open-drain state when used in
> GPIO mode.  Switch to '0' for GPIO and '1' for LED modes.
>
> Fixes: 87466ccd9401 ("pinctrl: armada-37xx: Add pin controller support for Armada 37xx")
> Signed-off-by: Patrick Williams <alpawi@amazon.com>
> Cc: <stable@vger.kernel.org>

Patch applied for fixes.

Linus Walleij
