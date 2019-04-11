Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278BEC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA3F7217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EaYHhhuu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfDKNeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:34:13 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34109 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbfDKNeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:34:12 -0400
Received: by mail-lj1-f193.google.com with SMTP id j89so5560226ljb.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 06:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RBn384/aUwYWTyiacyJg4sFYf1wr1uFnvwXOLo50pak=;
        b=EaYHhhuuCeb7QaiTnNh/McktaLLfttCrv0UrglGuRGWy8tbQIX6cxLR6aj2K/Z6t0P
         FF/36yS0VOwm8lmBzG0tgwSy0rLfpXiU6m3kJn+DzG0KmO5ZPVkA5tz/QiUuzr5UlVp9
         PxdfZjwlw/s0irm+YGPFOVRytgJaF+QU/UlVldiSWGy0lPSm3xd+Idz7Hm7chu9NBcTU
         U9+CExLZT3Gwx8gwDjsk55vEKWJurgMxE9Nz+Rx6sZeAsXa+FyYQPkX/eZBa7UCn9eoe
         kVnB0IV36EqH7bwAvB1jIR5nUSHMObPOVoPRqbDKqzoETMMzdpO7TE6qnX3ayJSnIzH+
         m/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RBn384/aUwYWTyiacyJg4sFYf1wr1uFnvwXOLo50pak=;
        b=XeMb88e6+cIWgJKKZcmLuPbyzMHhiZ6J2InUWU9M7B+wXfRfbxuJru7/eY9xKUcd74
         57V0geanBL4fZiISX74R1+1+7/YEWua0NXwtEc56n63QYrDuOsqPpWPeS01h9/rAVd24
         P7Sj60hp/VSPnOKkP/63uzkiivetv+KUo4gIdLhEKVExGvy9JS/C3vpuXG2r3xo0GYrK
         hcgvgGZ3sVSKe5gA4k2ojGug9XsnV4ESdUAXl1tTo/l7sxIGJmpHkJ9ni5F3Fyzug5Hi
         nbOzhBepvnIs9Ws6Jr7NVrCmHXPuahlrs1SmyD7MwLd3fwTpoQFGBbuLO+s0auKl159i
         FMng==
X-Gm-Message-State: APjAAAUD9vAY8cS/LIdD+zo5vrZIAqqdtAYEihRJF82D3c43y5AlDTkd
        5MQK82fngfvUsknQqDauyM+QCJe2H375rCouFZ/gag==
X-Google-Smtp-Source: APXvYqxqtr3lcIkvnSSol987jSf4oVQ/Lu9U3sBfXlBRquI2wnJH2abszJfdNvEFiQcN7qA05ZK3AoQTGHTXOPssnoY=
X-Received: by 2002:a2e:5d56:: with SMTP id r83mr26761913ljb.74.1554989649912;
 Thu, 11 Apr 2019 06:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190409102517.6468-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20190409102517.6468-1-alexandre.belloni@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Apr 2019 15:33:58 +0200
Message-ID: <CACRpkdYZduLLnE7XxcVgjajQzMH5XCTQM9RU-jt_xXoBT4faXQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: pca953x: add pcal6416 to the of_device_id table
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 12:25 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> When adding support for the pcal6416, the of_device_id table was left out,
> add the proper entry.
>
> Fixes: aac1e3c9680b ("gpio: pca953x: add support for pcal6416 type")
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Patch applied.

Yours,
Linus Walleij
