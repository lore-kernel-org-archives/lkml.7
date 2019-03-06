Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47217C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E0220675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LmeNQd8+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbfCFJgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 04:36:12 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:37086 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729766AbfCFJgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 04:36:12 -0500
Received: by mail-it1-f195.google.com with SMTP id z124so9198829itc.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 01:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hh8UQtscEBvw6DprdZ0uTTjDCcDICspTVW8U6yreZR8=;
        b=LmeNQd8+JmVsE2sJnBxZIrNxZwqcaFVZd0tb5vGaUrYC5dCKbN8YgJUXgIhy62UW+W
         T4cHWw0Bu+jR95ivg1K14+ED9oDNxWZ5WABwhqHCSJrFWpH85Q+K7hVWBTYH7Et/TYGo
         bCSpgKQbgBnoXONkAcMldamY7yRXFYJfkfXFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hh8UQtscEBvw6DprdZ0uTTjDCcDICspTVW8U6yreZR8=;
        b=rLR38wzWeOstOsyt5OzE7zlvjqh1y9RJGB8EuPL5Oxu1txRlqnXFqtRwrzEaQ/ry05
         Z3EXNV3i9Cu1PkyD9wCa/duLHx+ba/9QzN0sLICGmnNPbxjYU2KZOPCEPUx16CYqVMzE
         o7cZNqrttYLbk+8nKtTEbOLT4BcZl6M8EBaFi49fg1FqqAKN2UKD65efHw1rFNZ9ELaa
         aA/OjNWtewGni1ezjGFzDRJtPcl5lkTmsAwnVTBCaqhBl5LoXdc0fwuKCOP44GOyFGlo
         R/v1cHJtivhZuOhdXsNEnopcIpU+LF4oNsKNabPbiMlKGi9HbkpjMQdoFwXKNNCRRpLr
         ELyw==
X-Gm-Message-State: APjAAAWi6vOEeZYJBSen6FvssBVMYgVrQ2lcbIfA6oqUhqlVkHk0iMnZ
        lfxtmcO8AzWJdO/OiUlslxRMLEcELG3I5UxsmqoC9w==
X-Google-Smtp-Source: APXvYqyr+VgThOmOSHXbY24zUFYqE3icQxJsj1fEhCM42KazCwbVZtwlM/ho0p5ieVI3bpnuStm9+5/ED6QRpKXsjoc=
X-Received: by 2002:a24:e4d:: with SMTP id 74mr1435419ite.32.1551864971621;
 Wed, 06 Mar 2019 01:36:11 -0800 (PST)
MIME-Version: 1.0
References: <20190226060240.8783-1-jagan@amarulasolutions.com>
 <20190226060240.8783-2-jagan@amarulasolutions.com> <20190227153346.dwd3stsbsvf7rwly@flea>
 <CAMty3ZDSZvaxMjcQJLNaTDJQ5OjJ9NbjpOJKWMUE5PhRCzYvqw@mail.gmail.com>
 <20190301145724.vhvyoqkkxdflg2g7@flea> <CAMty3ZCUSsN71Q5h_nj6de0Smhqht1S5zq0pLKUqpwq=85XqXw@mail.gmail.com>
 <20190305155919.cm3yrve3vqp7jimh@flea> <CAMty3ZD6Bsu7B6phhf4h7jreoM1uvM-ZQNCaUZKKa=1DNOtb8A@mail.gmail.com>
 <7AB137701821F94BAF7B06C1747BA691011A3FE123@OS01.os.local> <20190306092708.2pjc7uz6wvku4hkb@flea>
In-Reply-To: <20190306092708.2pjc7uz6wvku4hkb@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 6 Mar 2019 15:06:00 +0530
Message-ID: <CAMty3ZDRAqV10u7QkujxkXtJYOUX8zbxkKtb5oxJMt+2jUbaHg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: allwinner: a64: Add Oceanic A64-5inMFD initial support
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Ryan Pannell <ryan@osukl.com>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-amarula@amarulasolutions.com" 
        <linux-amarula@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 2:57 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Tue, Mar 05, 2019 at 04:35:04PM +0000, Ryan Pannell wrote:
> > We don't mind if it has to be:
> > compatible = "oceanic,5inmfd", "allwinner,sun50i-a64";
> >
> > However, to avoid confusion, might it be worth including the part number (We list this as '5205 5" MFD') so this would become:
> > compatible = "oceanic,5205-5inmfd", "allwinner,sun50i-a64";
> >
> > Perhaps this solves the issue. Please let me know thoughts.
>
> Yep, that works for me

A64 instead of part-number 5205 seems less confused isn't it? or we
need to give more priority with real hardware definition?
