Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17582FA372B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D4021848
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZE6OEgnZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392702AbfJPLTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 07:19:17 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37626 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389534AbfJPLTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:19:17 -0400
Received: by mail-lf1-f65.google.com with SMTP id w67so17149187lff.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 04:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1AlVFzVNzLFhybDABbQIP7y9fwuWZqgdiTuBdrVDMgU=;
        b=ZE6OEgnZ8yrNuwOpjQUl1DrdrhOJcU/OfJQ+UWAJV5VSuBLt4kobSn90ZvkwKhz3/W
         DmWuNa8o4L6xpUpEA32J5Ft1QTqgjgdu1dbOpgk5naABVzkOtVTLGgWzYWNTzQ0WgTbb
         Y5niXn2s+/QyNMl5FrZPP125aQ4QKxA3TA4Lw+iuOCQIhfIOlJhBFdeOJIR1GZ+oDqDq
         hCnZiK17J2nBsS8Ybej2tVBY0I7+6EKSRi0R6PvzZFSb1ptl6XnMGK+lHRNew2QPY1xJ
         KNOCbpWsHgotFI3zRLMVcXg5iQytMnF3Gq7qsWWyjGRj8Jo3TTknxKUco7I816TsaM43
         NMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1AlVFzVNzLFhybDABbQIP7y9fwuWZqgdiTuBdrVDMgU=;
        b=Pcf2J6vW3XBrunanob1wA5cw3Lbe3Li5MMhbXabFMXcu36miWVbj4LDwwksjlYJdyh
         Qm7stzRgJPEy1lkr1GajvwvucYMJrjd9TWFxWFjls4ks/TfOPF8+IiOb+XKvEQ59fVyt
         naG0Ki/pBCBHB03959h2QxWb4zRGcl4HKyOplPn8J1jfFHzhSsLzLsJHgjeRZyZSOocy
         hyCDesrG3npXYlqNxyDAvuWbFeGnyxDfYqo3Iv/JD+VDF3GUhFB6k/uS51nPIsbny4O2
         X0Zw6OIR9ICJfnExklK7qW7/kvxsYQoBAIwi4EXRksLoav+n0/CLbHx4M1DGVpq9PAUU
         eJ+Q==
X-Gm-Message-State: APjAAAWKPZV3jmE8lH+YkHhKGOe8936tDIS6Y/MwgIHdFJy4mQJglMSP
        4gJzoZL2EFgPmWgTkTo7hWDAaJAmPMwRauc+XuUv2A==
X-Google-Smtp-Source: APXvYqzpMNbiy51j6vtkjPuuhusjbti4CJFbH8pcmfYvGpawltJmnzSIwtrjLRWD8kgfIxeJjRT4UBofz6S6sUNLEa8=
X-Received: by 2002:ac2:4345:: with SMTP id o5mr4806342lfl.60.1571224755662;
 Wed, 16 Oct 2019 04:19:15 -0700 (PDT)
MIME-Version: 1.0
References: <20191008044153.12734-1-andrew@aj.id.au>
In-Reply-To: <20191008044153.12734-1-andrew@aj.id.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 16 Oct 2019 13:19:01 +0200
Message-ID: <CACRpkda5cWaA7R3XzyiERCCgwUrjnXd+wCBeKvt-wtjex7wNDg@mail.gmail.com>
Subject: Re: [PATCH 0/7] pinctrl: Fixes for AST2600 support
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        johnny_huang@aspeedtech.com, ryanchen.aspeed@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 8, 2019 at 6:41 AM Andrew Jeffery <andrew@aj.id.au> wrote:

> This series resolves several issues found in testing by Johnny Huang from
> ASPEED, who also contributed the patches to fix them. We'll have more patches
> from him in the near future (which I'm pretty happy about).
>
> The major issue resolved is the way I grouped the eMMC pins. What I had was
> ugly and I want to get rid of it before the binding is solidified with the 5.4
> release.

Should some of these go in with fixes? All of them? Or just some?
I applied them to devel right now (for v5.5).

> The remaining fixes are minor issues that stem from lack of documentation or
> understanding on my part, and at least one brain-fart.

Do they need to go in to v5.4 or not?

I need a shortlist of anything that should go into v5.4 if anything.

Yours,
Linus Walleij
