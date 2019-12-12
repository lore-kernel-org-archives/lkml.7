Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B167C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B554206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iKPEiMkK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbfLLP2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 10:28:09 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44321 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729003AbfLLP2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 10:28:06 -0500
Received: by mail-lf1-f66.google.com with SMTP id v201so1984560lfa.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 07:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a3HoIlbnDsQ+bG9LL9JaGOgzii63aNDgW55yKpCip9Q=;
        b=iKPEiMkKQgBQ4g2yPLGxQjeGhMyleGCLknPgXerp//TZbCetjQRPk0GwMRD1WJWWh+
         nrTwHEIOkBB34TYXuOi9YObv2wC3fdH8p08IfQLU9LUXhNp1ObJACUNQryh4iw/iN7/J
         oCIvUcHOAR6nY3v4xCJEPkm5FKaOWK5fGZEvnN8WVIqtXw48XWCRpddOiN/OlQ2aRqgo
         6ZhVx6Nlt4upYgtta0Yyos1/+smXER5q20OgjRzSWGBMxYavvyZjdM+H5G9HKjXJvlBE
         OBVTQb3i0yF0Ljjqvd5Rt/U8xxg8LDV0m91fNszkUwKDKlVtlWupOQ9+ZvGmKAdeg7Cp
         //Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a3HoIlbnDsQ+bG9LL9JaGOgzii63aNDgW55yKpCip9Q=;
        b=gE5dXK81wfVvr+y55IQ4gPnLTST6ZxQyk+WfiQ3DpM6qGUNSrlsfOUmm18F1j3xKSJ
         bCzicAxYu8jF0Oo0LgxrUN9Qq9E0Zg5cfuokTm+vYHtUGZrIqVytMSCADD/Z6+XPsGlt
         x+/Kd1XW52E7Lmv8sCx1Y9x2du8LIXxnWMK2sLb8DiJUVXLuZzRzXT+w9q2dnoE2JgeB
         fnBuuARIN8U7dBN7Rgu7JI7Xb75hS9x2ijc9n2QxMatV96kVYFRYx07+753iI8GunmzF
         Izk170EJcW5PX2lcF6dBRSa0bR/bEjX07Dy6jNF0el5qQXI1ZuhQ0NhRgjzJk8RettCx
         WY5A==
X-Gm-Message-State: APjAAAW3SA6Ax0S3bkBT2ODFOYThnd+puoQxEsYdFzn3M7e3E0WKs88V
        Tij7sCEDRQqqmTRMAgmBRtVL6WNLBd3Vr8zKlr1NXQ==
X-Google-Smtp-Source: APXvYqxiy9bV88GGh0k1LLBojYnrA1fLF0F8FrE5iWdwSwTFvk+H0DElw5XdBSrCzUI8nlHvxA8+NcTHLRbEJpbUXLc=
X-Received: by 2002:a19:2389:: with SMTP id j131mr5789532lfj.86.1576164484490;
 Thu, 12 Dec 2019 07:28:04 -0800 (PST)
MIME-Version: 1.0
References: <20191202050110.15340-1-andrew@aj.id.au>
In-Reply-To: <20191202050110.15340-1-andrew@aj.id.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Dec 2019 16:27:52 +0100
Message-ID: <CACRpkdaHXYdHOtCE=_e549rP5DpzP0ayOR4nJmq055Ftiorr-A@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: aspeed-g6: Fix LPC/eSPI mux configuration
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 2, 2019 at 5:59 AM Andrew Jeffery <andrew@aj.id.au> wrote:

> Early revisions of the AST2600 datasheet are conflicted about the state
> of the LPC/eSPI strapping bit (SCU510[6]). Conversations with ASPEED
> determined that the reference pinmux configuration tables were in error
> and the SCU documentation contained the correct configuration. Update
> the driver to reflect the state described in the SCU documentation.
>
> Fixes: 2eda1cdec49f ("pinctrl: aspeed: Add AST2600 pinmux support")
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Patch applied for fixes.

Yours,
Linus Walleij
