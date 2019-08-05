Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CDCC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D3C220856
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ciULGFpa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbfHEKrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 06:47:47 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37761 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbfHEKrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 06:47:46 -0400
Received: by mail-lj1-f193.google.com with SMTP id z28so24672779ljn.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 03:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y8ev7idhhRdfNKj1s1Ry4AVA7oMVl5Zr3nXpss1zKaI=;
        b=ciULGFpaKJGyGIn8DOiYc74jQEChvVXjT78X89byv515QioWQ8LKIbfQAuDjjBHX0u
         2v96i5afuwQhBnrogqn47DxIdQ6IXLNkLuZlMVG4x6a1f5+CocddiYovSrGgDzIeaYl9
         eh3plobRFsDauaUG3bJ8BELTRTjE8G/gGmjrGwh7GJiYkb3tJLJcGkGeVT1dsHYihhl3
         GYFXPEWHP48uVedVSlamsufiFTMi4tv93b+CpDlI5z2Hw/Ov2d5mulyYBb78YzfeZOVC
         J9cIbZmLoNriGN4BVqAx2ZWMRZuB77qLfRD3VaDOLL88RFAs7lNl5JDiiDfL67UkuCtD
         u1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y8ev7idhhRdfNKj1s1Ry4AVA7oMVl5Zr3nXpss1zKaI=;
        b=YhKHCEm1qhve4F2KH9Jt+PTLCt8OzbKxfTl9oeJ9JirWHj8dVG9NfLF6HUjRqc6xo4
         kEQUuyReS5cE8JGNqGm3WQcwz9rKDToNE4D5dWEBoQkZSB9YhDEQQdbSUQ0xj2X0k55H
         MPQtRUaYIOHqnI5y4qpOQBrS6BDvQ2kzv3WOnv2LS17g2LHhS1mcVaGG4EuvhtbJJRDe
         Hq8LZIpHV1Vi3c/TrwPgyH8PlHEYv/A2jWsvof79QavfkRy9oXDv0etvXo+MptWN0gWx
         P3VvjHMQScfHgqiealC9NGCEFZBJQyneiHzikdtgAMinryfGrm0YAJSBzcqCjGHsu5h+
         LbFQ==
X-Gm-Message-State: APjAAAWiMfGH5aMdj5A8weDpTbU+2MxuoKTBYlBz14fJwazv86mJ3dIL
        6RUExzFyXVOs+laWDmoQ894zEHvK6wEhRjnWn5t1EQ==
X-Google-Smtp-Source: APXvYqwLJr3uamyVrePIy7GYeTGTKZVVFmuCgCeDV0lQp/Tg1tMYwqSStWcsZi8QVF2EtXjzVZWC8D1lN3Mn23V8cVg=
X-Received: by 2002:a2e:2c14:: with SMTP id s20mr16495379ljs.54.1565002064570;
 Mon, 05 Aug 2019 03:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190724081313.12934-1-andrew@aj.id.au> <20190724081313.12934-3-andrew@aj.id.au>
In-Reply-To: <20190724081313.12934-3-andrew@aj.id.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 5 Aug 2019 12:47:32 +0200
Message-ID: <CACRpkdYoiWwm7SeXxWgpJcoiRcNV28CDC3F8FVx5my2Q0KSvvA@mail.gmail.com>
Subject: Re: [PATCH 2/3] pinctrl: aspeed: Document existence of deprecated compatibles
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 10:13 AM Andrew Jeffery <andrew@aj.id.au> wrote:

> Otherwise they look odd in the face of not being listed in the bindings
> documents.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Patch applied to the pinctrl tree.

Yours,
Linus Walleij
