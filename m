Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B3DC2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 08:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7707824658
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 08:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a+daNgiQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfLMImY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 03:42:24 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41177 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfLMImX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 03:42:23 -0500
Received: by mail-lf1-f66.google.com with SMTP id m30so1333074lfp.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 00:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+3AGyagak+SsQwMgJI8DqZjJRt+2sRcK1YdTOf2bFE8=;
        b=a+daNgiQiCYJ8MM6UhnHVrWdoGUXOn3GJH0VpgdC9SpDGXCOkLoPmTrlEqRvbWJSWy
         scJgeIUaLdduo9o91tDrNbzuthgAPOM+aFslD2C8TAcTn1tMXB+WFmtOrTcyb+iujSMm
         7oUPcMGhQBLpN99Q5fopI9AB5FHtDFFgTs4hShQap/ML5xXW3jaBZ0I1lvhSAhM1jDPv
         ujjyEpNoH383Drw+a2PgfQ3Yo6URBxeqlRWSJygP0NQJUkP0r2uCOw88AmCK3y5gPvfc
         4JPfg+gDEUV27h+riy/0uIHzNAKSe1b2pC1GVrN+eAOOp5FrGij5sffNU2QagZHee+tA
         xU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+3AGyagak+SsQwMgJI8DqZjJRt+2sRcK1YdTOf2bFE8=;
        b=Cr3F3IS1kQbbgPY29ziIZl1cpUjY8aZcML5fFFOIkeJWVBw+OfjtLFc/hwJlbWiMLr
         exHGqSMw3mxW6GIG7aDXII8YMcbTa4LxdxTApOrPHYVpTic++28ZS1MwoNi34XaJ6gc+
         7FE2izb8qVN+JiBdDisfu6FqnKwRlKz4EBw2LXHv8UDzzrnFqNWutRrvGxwDgT7N4ZXE
         l26Zf8PvrET9amtjrzxVTyV7swnpYYvbz+kKa+8xvAcOhXwRXqkiDtnqiCTPHGss2Wuk
         bGbXBXIiLbqLtnE+m67jmCvvvHdbtJOEk7MJrLKg7bMoDXrIyYkUnXhHw219fqzRtnR1
         vZbQ==
X-Gm-Message-State: APjAAAUPhdMr8whbtqlYUQdBuVeU1RELxg+xNd53QjHMXw7kNBBMMlQY
        bBUfGJ+JayMrpnUjY/UJOnLmQYpDulL/gphlOpXhtQ==
X-Google-Smtp-Source: APXvYqz79bn/tRSB6q2MlLzPdVGXKAD3lMBgrE6UtCaOD5iDixhhmHkxpkSan8geCglyFBt3hCB+ZaEC8V1y5zn49yA=
X-Received: by 2002:ac2:5c4b:: with SMTP id s11mr8062235lfp.133.1576226541430;
 Fri, 13 Dec 2019 00:42:21 -0800 (PST)
MIME-Version: 1.0
References: <20191202061432.3996-1-andrew@aj.id.au>
In-Reply-To: <20191202061432.3996-1-andrew@aj.id.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 Dec 2019 09:42:10 +0100
Message-ID: <CACRpkdZVdP+rfnhF8Dfk+jLsqTEvm_tqv6to2s4nnJh8diaM+A@mail.gmail.com>
Subject: Re: [PATCH 0/7] pinctrl: aspeed-g6: USB and pinconf support
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 2, 2019 at 7:12 AM Andrew Jeffery <andrew@aj.id.au> wrote:

> This series adds USB and pinconf support to the AST2600 pincontrol driver. The
> patches have largely been developed by Johnny Huang from ASPEED and have been
> used for bringup and verification of the chip. The were developed around the
> time of the 5.4 merge window but I got distracted for a while and haven't had
> an opportunity to send them until now. They've had a run in the OpenBMC kernel
> tree and so shouldn't cause any issues, but given where we are for 5.5 I'm just
> getting them in early for 5.6 so we don't miss another release.

All 7 patches applied!

Yours,
Linus Walleij
