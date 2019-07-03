Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA6BC5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C37218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iLSnAFiM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfGCIkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 04:40:16 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39303 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbfGCIkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 04:40:15 -0400
Received: by mail-lj1-f196.google.com with SMTP id v18so1465689ljh.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 01:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9KQGKN1/JTwYz+i5tykBtO8/dfvkSTRXZ7mV96ulxlo=;
        b=iLSnAFiMtzOcyZkCnNoQdCnKRs/FrQMu9BQk1miyt08q/upQDSxsM5dd/sr+THA+cz
         Ma0puGzE/ZswYwh4FVWRnwkJAgjJiowH28UihrQ5Ew/UvWeQ1X3ci4rGe9jCtXrSXrhu
         VJcSzn2usHUy1hcueneTZAxbX0WIJ/GbSxZcQqCLs5riBu/oyqVMlrHbwbYdGATqrbN6
         XevkFpUuWujEosPpkR/Vjq9lnzSkFDPYZB9dCECqE0OpBr/Bgz2s7iUQBPkcrmFdU3Py
         +LZHudN2XD/KZduddVlkuwmpp3WdxkpwOUshIpl7p6/p7b3bfcWeCi9olwlgW6sw26ku
         wAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9KQGKN1/JTwYz+i5tykBtO8/dfvkSTRXZ7mV96ulxlo=;
        b=FDvMzGkFzHrqeqD6mtGgUvQTz6RX64ighmyQyChZvqFmocVsWNiu3xK0y7qd7CKnnq
         ppc87cYqRTrg69LPDyu5JHye/MAvXEY9YDlkm0u6XOgJC0begpHrPXDbrM92/sQQB5dD
         pENoi13/DauYPU1vd9FtuUgKQaQpH1M/VStQuJ+Y2n9kS5U2198aweLvMt4P/nSt7bsT
         NKzEhsM3GOqWfnmAXv66AFuMzgLQwl+dJhzNzWbFU+pquW+x85DuOm+i4bCOVctrkCkv
         M5FhBQt8RRcPFy/hdl61RnKkgZGPogsRL6io5GHoH2bo0A9rHYBPkZmQY4HolYJrEiWa
         p3xw==
X-Gm-Message-State: APjAAAWmNO9Yai3xzFHUc3lZ9EKfmckmb/LeHif1L9/Fg/JTp2SIq0Ax
        Z5ot5pSlbw2BQN5VObCysgk3k+yDazF6IeGC879mCg==
X-Google-Smtp-Source: APXvYqwjCAdp2pYFgLkejdEEDh9nRCMtaIIni+TVcrXpKnpbZ14+0z+JW8gDE5GUfqGr6bXIV3oih+tOTO8H8yN1rZI=
X-Received: by 2002:a2e:650a:: with SMTP id z10mr20360931ljb.28.1562143213537;
 Wed, 03 Jul 2019 01:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190628023838.15426-1-andrew@aj.id.au>
In-Reply-To: <20190628023838.15426-1-andrew@aj.id.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Jul 2019 10:40:02 +0200
Message-ID: <CACRpkdaxiFR3ezt4FzhRxpqc4DYYjsbBeysPUaaQH+_QgYjudw@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] pinctrl: aspeed: Preparation for AST2600
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Fri, Jun 28, 2019 at 4:39 AM Andrew Jeffery <andrew@aj.id.au> wrote:
>
> Hello!
>
> The ASPEED AST2600 is in the pipeline, and we have enough information to start
> preparing to upstream support for it. This series lays some ground work;
> splitting the bindings and dicing the implementation up a little further to
> facilitate differences between the 2600 and previous SoC generations.
>
> v2 addresses Rob's comments on the bindings conversion patches. v1 can be found
> here:

I have applied this series, I had to strip some changes of the header
because it was based on some SPDX cleanups upstream but no
big deal I think. Check the result please.

Yours,
Linus Walleij
