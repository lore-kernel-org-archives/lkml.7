Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727A3C2D0B1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 23:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D94E206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 23:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uQsVwqfR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbfLDXqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 18:46:06 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36469 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbfLDXqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 18:46:05 -0500
Received: by mail-lf1-f66.google.com with SMTP id n12so970883lfe.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 15:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1oLuXTqP88AIJllnfUv70RaPKExVa3V8VYnwKFzXr90=;
        b=uQsVwqfRLCAJ44cXxreDwyi2t/pF9+6ktyX482qqhirs8nOUetXz3CJa6gX0d+StLI
         4hrMtR2KUPZJw5V9yHYkuSxlHVrR0NcTxV66wok3kLyVEuiOdQ+87ZkDHjo1SaVe3qUt
         ExxMY9tZrB37RkXAXo4+S8vuXV0/TIiZ+XYFCBFZcfDXc3VafGj58nQzO9kGCJoKepaQ
         45rWBnslFVJvwRITTvab0lm9wGC+o0gvis1jyeSwupr14EAS+0r5nhMkr0FKXIXS8wql
         EzUis/tSIFpQC3T4HIAyyWycETuiTV5ec3iLux8doePS9L+H9xv35IDJsOa4ul4uNfwO
         BGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1oLuXTqP88AIJllnfUv70RaPKExVa3V8VYnwKFzXr90=;
        b=hWNlvjEKN61rjTd8KduXO2Ko2SGnnyOVaIJ7e+LQlKaQ4770H9xtXeOl5STq1I20FO
         kN31ZYmTg6ntIwAAcYG7xDJZ1fkthnERUX9e3U+MESY1zqJIz+u9ih11Go3h2k0dlH72
         sUyteEYDrD+tyUtlcBL+hE1FQGoz184pbg88JFZjhyFeG90mFYZJ7lbH1gcTik8lL1ZP
         oDzUy11xO660zHPC0Fc/btalV7+PZBRGt5udBgXYOmBQzps5mggYIlRnftIXMPDJ4ywv
         yizaDEsUUDSWAA1Rdq1+EJ42Ua75d9tC4YxxN29leY/ccTaTUe/jDBflI9o3ZkhPjTC2
         qS+Q==
X-Gm-Message-State: APjAAAWllzJFu7O15+6dYkzTNvmglpOHAbJYS7v4ymkIPCDPL9y2V/N6
        TjGoiPCnKQy4GmHaauZ/fJzCRaIj3sCUvRMPa37/+w==
X-Google-Smtp-Source: APXvYqyqVwBh7QLOCMY5WcVcMFSXciWG0BZOqFwPI5/16XD9DuCX7jpZucNx06M4rxkCfx9c/Kf2nRnArTuT/U4S8QM=
X-Received: by 2002:ac2:5b86:: with SMTP id o6mr3552742lfn.44.1575503163840;
 Wed, 04 Dec 2019 15:46:03 -0800 (PST)
MIME-Version: 1.0
References: <20191204110219.GV25745@shell.armlinux.org.uk> <fb88206c-a094-df37-04af-71a1174fb0f6@gmail.com>
In-Reply-To: <fb88206c-a094-df37-04af-71a1174fb0f6@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 5 Dec 2019 00:45:51 +0100
Message-ID: <CACRpkdZzzaaDM_Y8-Zf8AQrmfcVd+i0Uk0vYccnizG73cjEooA@mail.gmail.com>
Subject: Re: "leds: gpio: Use generic support for composing LED names" breaks
 gpio debugfs
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Pavel Machek <pavel@ucw.cz>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 4, 2019 at 9:52 PM Jacek Anaszewski
<jacek.anaszewski@gmail.com> wrote:

> It seem that the only proper solution would be introducing a new
> pre_register_cdev(const char *name) op to the LED core, that would allow
> drivers to come up with their implementation thereof. In this particular
> case leds-gpio driver would need to put there gpiod initialization.

I don't know the particulars but if it helps you can at any point
call:
int gpiod_set_consumer_name(struct gpio_desc *desc, const char *name);

For any successfully obtained descriptor, to set the consumer name,
i.e. the text appearing in debugfs and the GPIO character device.

Yours,
Linus Walleij
