Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5BBC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 21:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C8D0216C4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 21:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kZ0sGhAL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbfEHVjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 17:39:47 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39540 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfEHVjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 17:39:46 -0400
Received: by mail-lj1-f194.google.com with SMTP id q10so198324ljc.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 14:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x35GHOC+4EYtsgrhdYQQcY08TD8wwwstK0EnEQLGChI=;
        b=kZ0sGhALn3IdcGAoIdKhFQmH3MoaO+qPD1BFqOhJCn9ot837nEvhn/WG31aFznIVPD
         EfJ9Jok5N+3il0QxXYCum4koYryraM6ilb3IcCtM2Cehbfb7PFKOdeG0//7rdbs9zGqM
         usoZSbpUAeD8beJrUyClmY5+lyaW2urpR1XZGgqSwpCkeb8/oQIXUkdQeffC110GNQZE
         Li/xkfjhcBnCt7ZQ+lX+zmiHyNxO15S1MeoMcU0mXj4NTLzK5LbWP7I1ZSnv/YBhin0F
         R3p5JzWyuw1Hv215gYur366/0cKQo0+HrXuYj+WhsT/k8OlHqp/sujpz8fBxx3f3jw8/
         9aSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x35GHOC+4EYtsgrhdYQQcY08TD8wwwstK0EnEQLGChI=;
        b=Qi8EBO5eFqjYHzQnvrfQWcm0okOZokUiaaIc5HYAzoO+Lk0g+ZqDacXGhQtE25/xv0
         P/AGx/rRXMLnKk6iw/ZGZK8TBqaNhVSSQz3hmQ0ZdGUnrBMNSedKw34sHbVWccvx/KAt
         /oa6WI8QbvaZrjYoDq1nm0hQH+7NIDg9NTGfRol93LoQyYkMuPDpa5i59i1XoJU2VdNZ
         F8RYhKi3xyNxOmZx3wPIe1gZdGIbE2W33BZ8zNGjmfTRyAvpqBgjGFEECzE3POfn/HGG
         oQnN+/yj6/ApR9oEUM77nwkJyP81Xr4ggFwY7YZUThGjdgu2IWQ5qGCLkP7ZS6aLHapU
         YnCQ==
X-Gm-Message-State: APjAAAWQhriczOHB0BUx+0VWhvzFdvdBlsL/zYVGGqXP6PPwyeiC6UOn
        IscnPLLtdZtdw6JmIw9gjcXliHzDGnBYfgBBnpHoTw==
X-Google-Smtp-Source: APXvYqxNsEw4hTTxmL8Y4zpll2bZRkk9M8uJxZtl0pjA6EfZbClLaExliTbVd2dOkZbWasN2xHyUAQ33ww1TqOHkJmU=
X-Received: by 2002:a2e:9d12:: with SMTP id t18mr34389lji.163.1557351583857;
 Wed, 08 May 2019 14:39:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190507220115.90395-1-fletcherw@chromium.org>
 <20190507220115.90395-2-fletcherw@chromium.org> <20190508073623.GT14916@sirena.org.uk>
In-Reply-To: <20190508073623.GT14916@sirena.org.uk>
From:   Curtis Malainey <cujomalainey@google.com>
Date:   Wed, 8 May 2019 14:39:32 -0700
Message-ID: <CAOReqxgYV3SdXot84Xa4X7=MCZdzWmb2N+jaWzjxgmdoMRx5Mw@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] ASoC: rt5677: allow multiple interrupt sources
To:     Mark Brown <broonie@kernel.org>
Cc:     Fletcher Woodruff <fletcherw@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Zhang <benzh@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Brown <broonie@kernel.org>
Date: Wed, May 8, 2019 at 12:36 AM
To: Fletcher Woodruff
Cc: <linux-kernel@vger.kernel.org>, Ben Zhang, Jaroslav Kysela, Liam
Girdwood, Oder Chiou, Takashi Iwai, Curtis Malainey,
<alsa-devel@alsa-project.org>

> On Tue, May 07, 2019 at 04:01:13PM -0600, Fletcher Woodruff wrote:
>
> > This patch does not add polarity flipping support within regmap-irq
> > because there is extra work that must be done within the irq handler
> > to support hotword detection. On the Chromebook Pixel, the firmware will
> > disconnect GPIO1 from the jack detection irq when a hotword is detected
> > and trigger the interrupt handler. Inside the handler, we will need to
> > detect this, report the hotword event, and re-connect GPIO1 to the jack
> > detection irq.
>
> Please have a conversation with your firmware team about the concept of
> abstraction - this is clearly a problematic thing to do as it's causing
> the state of the system to change for devices that are mostly managed
> from the operating system.  It's not clear to me that this shouldn't be
> split off somehow so that it doesn't impact other systems using this
> hardware.
>
Pixelbooks (Samus Chromebook) are the only devices that use this part.
Realtek has confirmed this. Therefore we only have to worry about
breaking ourselves. That being said I agree there is likely a better
way to handle general abstraction here. We will need the explicit irq
handling since I will be following these patches up with patches that
enable hotwording on the codec (we will be sending the firmware to
linux-firmware as well that is needed for the process.)
