Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EF1C4646B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 22:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D4220674
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 22:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sUkqpU7C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfFXWgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 18:36:52 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41401 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbfFXWgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 18:36:52 -0400
Received: by mail-lj1-f196.google.com with SMTP id 205so5397205ljj.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 15:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J6mvSj9HIBsk8EjLGW0hTzAQhZMarT0YB1g8io943NY=;
        b=sUkqpU7CRPJa8WBRq9dbfWldit0lSlp++W1TdZzD9bsloqAAyiyEYnZaN9j8hCqVWl
         GnY52VMS/EfwfuyHSPAbY8sXyWOlrq9hBe0WvJOkwiwUmSTxlvXQTQQD3hzW71xRMNlW
         ARtdmVHxPGokOAbn1kaJQ1A6sdL/+y6PVTl+Sq1TETju8ACSE4oSpHruEkgvJmwHDOt4
         l7eCeJjOSarS8Vu/mcSXrgxukP1PUYswqgCYOcFqC6ULrw6sb2Cwy4GF79yDm/UtFml9
         TGKYDZYVHNSjsjlPkUPtS1QeFDe/laWx10l4FrczaNx+MKYryXO7+IBoAO4pb/KdpUXF
         F3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J6mvSj9HIBsk8EjLGW0hTzAQhZMarT0YB1g8io943NY=;
        b=M/1LvCjRDS+g2mgnfpVE7gQ091VKCCPdXGW7QBH316+TB87gnbneYGSbpFIYxt64mn
         jhj3C5jNMfy/Ja4xJYHX7W8Wbh2G/Goq0G1sR2kVZbU3CHM1Sy2J+cbZBa2FUX4e/XlE
         G+jqgSxqtAHzhm0fUZBOCnZfQf2g39h++CIMP7KqjWag/6slACCQqEOdtiZVQklFn+8h
         h00CNJ2iMR2pwtJ7kW5c6Zo2agqruuO9pRmM39dweCHOLaDqlj5CzJu3/NSUhqpMKkjv
         Ng3EPr9OlVPptNLXmbLD/4/i/TKVjJ1RPhS3bECK1vykXkURAUN3r4NEj7nmCJ5d2OsE
         OaAw==
X-Gm-Message-State: APjAAAUFHSBr229DQVTLpewTXRsbRaOqRMUamLCLJEbcXsg1zOSb4IoK
        9MWj88c4cFhJHv8ko88CXwvX0b0oMlMc4051cYDJdtXQ
X-Google-Smtp-Source: APXvYqzwcsIfU2fhhMg3DeSXFdWRcU2jq1WdvPR6NAlR0GJdjSA/p8p4eNDenRfaMzxDWDGYenzTX1Bjfkox3wK+5/I=
X-Received: by 2002:a2e:8756:: with SMTP id q22mr52904734ljj.108.1561415810154;
 Mon, 24 Jun 2019 15:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190621152413.21361-1-thierry.reding@gmail.com>
In-Reply-To: <20190621152413.21361-1-thierry.reding@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Jun 2019 00:36:38 +0200
Message-ID: <CACRpkdZMP3hfAdcJjs1EUMnB5naN7NHsrKFHi9xJ4k5XWCnFFw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: Add device link between pin controller and GPIO
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 5:24 PM Thierry Reding <thierry.reding@gmail.com> wrote:

> From: Thierry Reding <treding@nvidia.com>
>
> When a GPIO controller registers a pin range with a pin controller,
> establish a device link between them in order to keep track of the
> dependency, which will help keep the right suspend/resume ordering.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

This make sense.

> +               link = device_link_add(range->gc->parent, pctldev->dev,
> +                                      DL_FLAG_AUTOREMOVE_CONSUMER);

What about parentless GPIO chips now again?
The parent field is optional, sad to say (yes I wish I could just
fix it all).

> +                       device_link_remove(range->gc->parent, pctldev->dev);

And here again.

Yours,
Linus Walleij
