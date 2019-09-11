Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E0EC5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 13:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1580206CD
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 13:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DLyK/+ak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfIKNr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 09:47:29 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34760 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbfIKNr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 09:47:28 -0400
Received: by mail-lj1-f196.google.com with SMTP id h2so13554703ljk.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 06:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nz4fH/KXhHqij+iKLC+4ZdFFxFYVPPUbmfkrz8PDltg=;
        b=DLyK/+ak64rFlOgLttB4Ar6+FvCSJvNmybyHgUL9jbUvEeVJP4xCwXQub9DeTUYgzQ
         oFIOh4cIsoZgefy7yGqAdOMhQftEPQhmqMAIc/qK/PsPNoiMlBtc+b+Epg4fgRQx8HTl
         tfLuyhv8liTJMMaYuFV7ooLfozyYVY410LYKBnZbnYS53wdNPyggQx/gc2ZGyFUOcPkB
         J28uSaE9cRbADj2qWANkWsow//32yG/JkSeOhgwrI4t8DNQnmXcjFkh2WSOJHEK6tKpH
         ACtkBTUtObT8s1TFO+my597cL5iP9sxoRJfZKL5yHwZmMI6pJGgoq3XPz9nRSZNG7h5V
         satA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nz4fH/KXhHqij+iKLC+4ZdFFxFYVPPUbmfkrz8PDltg=;
        b=WLp7D5YOftcrEjlGD8ocpwDkTx/a55Mr7ss2jZCswlwkrD/2iJxzK3wX82hvVEnoB9
         3NDOATPNiiUxojfNSwPvPn1WCQEDX5C+KNrZvn3yOu+At5+51W+UbSKXNVohJ+SPBhm5
         veZUsUTKXwh+WCzVgBLKGyDfWJHlMpKXHmraWo7pHfJBqiXd3FzIi0ijqGnIAq1ozus3
         JOgrKAkVIT6KFHNoTkm3mtSk1IAB7qIHirSzYvgnaihxPj9l9y2IwRw0FDPW0a9IdYqu
         ycnRzphwu5NKLtD7l1ST9eoF5+meWc53GbE+OMCAqoB3blnMwOAgniM0UUY7Be7lZHxN
         sLEA==
X-Gm-Message-State: APjAAAWLeCxWWu/1Fh0+ctJWD8bjGXuwXRIciXs6+FocKupCs7He550T
        KN/ECg1iKuyUhIrZfdKLbfAZsoyJcFQv+f/E6YaM4Q==
X-Google-Smtp-Source: APXvYqws7ORqRB75L0oY4eDnjG2Wm//MH3lyQsM0QYHLeySy7D/AoJBKfHnVdu6FeiCtY6iZ+Z68Vtiu33mFOJqqeOI=
X-Received: by 2002:a2e:7d15:: with SMTP id y21mr16276037ljc.28.1568209645791;
 Wed, 11 Sep 2019 06:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190906084539.21838-1-geert+renesas@glider.be> <20190906084539.21838-4-geert+renesas@glider.be>
In-Reply-To: <20190906084539.21838-4-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Sep 2019 14:47:14 +0100
Message-ID: <CACRpkdZYbEhyGGoo9P=cnjd8Z+oDLUgqAYhKDeuqtZjspw7sSw@mail.gmail.com>
Subject: Re: [PATCH 3/4] gpio: of: Switch to EXPORT_SYMBOL_GPL()
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 9:45 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> All exported functions provide genuine Linux-specific functionality.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch applied.

Yours,
Linus Walleij
