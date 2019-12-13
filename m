Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4F3C3B1A6
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E13246B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VB0Qc7V7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfLMPdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 10:33:55 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51642 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbfLMPdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 10:33:55 -0500
Received: by mail-wm1-f66.google.com with SMTP id d73so487wmd.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 07:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SAYkCWa+UKUtmAHpxZPtyf0202Fu23Y0TOqeEazyr/Q=;
        b=VB0Qc7V7S5H1KmeOm9KBILALqgHQYmF0aObNiHutpNEkYKmbpAjtI6JvdXopT8ToXQ
         qm9DbdizY6eiF3/gk9eh3FqiObj0x6V2jvz6Ylw/I73linNPmdpuQtck7H3uv4ntHObE
         zQqLulojG9AR9iQ3V4qz2nPme4DxxHaa4KFNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SAYkCWa+UKUtmAHpxZPtyf0202Fu23Y0TOqeEazyr/Q=;
        b=mTi2pNMUZi5X53O2i9vvtUek2fTZ3hcoAXPCeimjkOYUk2paqAdFs7xtwu2Nwg2SvJ
         zn7nV1iG4w+5MAtxP0x9yp9Eilnj7MQjdgPyKLqQddaJ02LNhqo/iTalgD6w7gG+cmLT
         cEIQk0RzWZ/skbvYu7g0kJ8CEY6Pei+Y+iT5m7RRvfx0hV53NYeefidjWQgfWsp0XLjp
         ZZ03wnuVzYdyCAFKBIM9+a1SDPqPxb/KrkABDhGfX+IpoHdRzr9oY8jZDN33INQAYHZt
         MDly6wjWWOZxC+T2vu8BnQo3oOPODE5X5F7z/35mlDLTEU8RZDmrNLHKWccNZQP80SH1
         mEhA==
X-Gm-Message-State: APjAAAVqQCwsJZaby7a+pJOpYNCrNHVdygGahh6aaKH6nPai1Bp3Yeu5
        S0BIHZpOYxyuuqemQRt/0iMvGLbdXNFUmwXE5pcGLllI
X-Google-Smtp-Source: APXvYqzG07t8L0rdT/jCMyiZ1bizG1mmA/UGnwTTkXBgBiB92Pia9cOilPnt362sCSti1OdNCJDkL78l3OzGZ3Q6Gso=
X-Received: by 2002:a7b:c051:: with SMTP id u17mr13988989wmc.174.1576251232755;
 Fri, 13 Dec 2019 07:33:52 -0800 (PST)
MIME-Version: 1.0
References: <20191212231213.29061-1-jquinlan@broadcom.com> <20191213114138.GB4644@sirena.org.uk>
In-Reply-To: <20191213114138.GB4644@sirena.org.uk>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Fri, 13 Dec 2019 10:33:41 -0500
Message-ID: <CA+-6iNz4WVJzfntJ5CUXBYvqQG4kEj8g8g_HOxZN5rFWTUvv3g@mail.gmail.com>
Subject: Re: [PATCH] spi: bcm2835: don't print error on clk_get() DEFER
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 6:41 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Dec 12, 2019 at 06:12:13PM -0500, Jim Quinlan wrote:
> > Otherwise one may get multiple error messages for normal
> > operation of a clock provider.
>
> >       if (IS_ERR(bs->clk)) {
> >               err = PTR_ERR(bs->clk);
> > -             dev_err(&pdev->dev, "could not get clk: %d\n", err);
> > +             if (err != -EPROBE_DEFER)
> > +                     dev_err(&pdev->dev, "could not get clk: %d\n", err);
>
> On the other hand if the clock isn't there and never appears then there
> won't be anything saying why the driver isn't loading which won't be
> helpful when trying to figure out what's going on.

Understood; I could do a dev_dbg() on -EPROBE_DEFER and dev_err() on
all other errors -- would that work for you?
