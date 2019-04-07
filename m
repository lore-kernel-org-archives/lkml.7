Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D43C10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 22:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B91F2087F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 22:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BYaL3/4z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbfDGW1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 18:27:12 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33620 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfDGW1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 18:27:11 -0400
Received: by mail-lj1-f196.google.com with SMTP id f23so9531923ljc.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 15:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3KRrlEke/H6J1LD72SPEhb7Dk0Tudzv8yTbNbrjV3zg=;
        b=BYaL3/4zKn/eARcXnUdczX/bC6PHCzNT/Jjkhg+Kr8SB+g1dzzmTznNvMfGoMhnKCy
         mS/eiWbKUbK9X6XE7VeMQaMLbZ1y9jKnG85KFLcjHAa31Lfig3wP9+NOWPxOARGaffkM
         doQiu39ihkBau97LC202c1m+aoGcsuIALEUVFg+zZ5MzdH44ccnLyQgFJwa4dRKemVDK
         6jD/AyKzw1zBSCX2DzDBpYg6FnvkiWr0fc8CHJPITIqyRJILp1d70VYI2nQ1MSaM1jJP
         +xjCZ+TN954JS+LPZhquejFiZIxdTGK/lsPsdK4mh9uT92EnCVtw5DhWmQMM/Xb9lHS+
         nHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3KRrlEke/H6J1LD72SPEhb7Dk0Tudzv8yTbNbrjV3zg=;
        b=iv9/CGmFzgfzeRalSDJYygoB0XVShCH/Ys0hsdDnmfs6RjiE/5oSViqiO3Z4dNCA9/
         cJ58ZsSz/2VkI7urJQHgYpNFPOcqNxRSc9xtPdw6Z1T+QIsOa9C5cDqCsrdB/uAJG6ZX
         3GGzG0ijL7WjVK3Q9EbP7HC54wWdsNzueTSwL+5BdA53Izt3Gt1mjEAQqm3H4LPz7q08
         bpH0qtswFhzjKFQoNgldR4ND3aPAXQalPgzt9TASQ+1p+ntJllCrLEogHuYa3FIkyZp8
         XyJ/MvWeeRLqU1dgDfe7tdOUIHC/y/ZUc3MQcFHP8yrLKk60FNkkRcsCs+P7RJhMzGB9
         mxpA==
X-Gm-Message-State: APjAAAXaVrCM8ScyOZ4RxDiPQzrNrEKW74qOjxTgtuCNMtc4GNAm5Mb1
        OBKD/KkgbPZsr5Fr1LvxYGN6mjvEslfBP8Mv7tPefA==
X-Google-Smtp-Source: APXvYqw6+VIEB6M9tdOHI6Y06dzPRhB/OuNep+lW94BJtLo13hOMrfel++G4/ywQhBuJ/6sNG5e8NhYxZbNnm4vn8K0=
X-Received: by 2002:a2e:844a:: with SMTP id u10mr14326883ljh.41.1554676029606;
 Sun, 07 Apr 2019 15:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190404171007.160878-1-ncrews@chromium.org> <20190404171007.160878-2-ncrews@chromium.org>
 <20190405201534.GA4426@roeck-us.net> <20190406084157.GA27043@amd>
 <CAE_wzQ9WG1+K1ZzVoii8ukDe_g+4Ha0bh6YvsRhceinwPjC+Kw@mail.gmail.com> <20190407221846.GB6327@amd>
In-Reply-To: <20190407221846.GB6327@amd>
From:   Dmitry Torokhov <dtor@google.com>
Date:   Sun, 7 Apr 2019 15:26:58 -0700
Message-ID: <CAE_wzQ_5Ha6hNt28_+j-pF3mAdXXifv9CuotDCeXff8KC1DNmA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] platform/chrome: Add Wilco EC keyboard backlight
 LEDs support
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Nick Crews <ncrews@chromium.org>, enric.balletbo@collabora.com,
        Benson Leung <bleung@chromium.org>, linux-leds@vger.kernel.org,
        jacek.anaszewski@gmail.com, alexandre.belloni@bootlin.com,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        dlaurie@chromium.org, sjg@google.com,
        Guenter Roeck <groeck@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 7, 2019 at 3:18 PM Pavel Machek <pavel@ucw.cz> wrote:
>
>
> > > > This document also states "The naming scheme above leaves scope
> > > > for further attributes should they be needed". It does not permit,
> > > > however, to redefine one of the fields to mean "location", much less
> > > > the declaration that a devicename of "platform" shall refer to an
> > > > "internal" backlight, or that there shall be no more than one
> > > > "internal" backlight in a given system.
> > >
> > > "platform" is as good devicename as "wilco" or "chromeos".
> >
> > No, because "platform" is not a device, it is something that you are
> > trying to assign a magic meaning to.
>
> "chromeos" is not a device, either.

I agree, it is not a device name. We do not assign any specific
meaning to it though. We could change it to "cros_ec" if so desired
and nothing should break.

Thanks.

-- 
Dmitry
