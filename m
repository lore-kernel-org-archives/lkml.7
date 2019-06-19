Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370AEC43613
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 21:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066A72084A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 21:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P5V/sT+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbfFSVZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 17:25:42 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36404 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfFSVZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 17:25:42 -0400
Received: by mail-pf1-f196.google.com with SMTP id r7so342328pfl.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 14:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y9mMQK9sKtWkYVn2tTLrqE2pA0vjVcq3E0qdtFwjDm0=;
        b=P5V/sT+i6r81AGxDHVHYVwgTBdH9hf/mud3jTlfe52eCS6W+5ngfmHBS5Z0sHkjZdw
         P/hyp+SElxNTgemRSGOtbTDIUYWWHxkBwrIyTDtPXANTdBjE7SWyRMT0/BHQiAkYqtPc
         CSlOqLbY6l+1vYT1oVdeGzUXQmPLiA74Y4dL0y1Zj8En/UvVab1vDGuLxQtsk4rddVhb
         OcAr5e4o52ldWylZ/rrctkX2uy8M7eUQyGn8gsZDMCHYREcdFW24LXs34IwCBkBGl5ae
         N8iqEYxxI6acRivHQIYSUz5sAU6zqbAlhwwRES74c0CoBDLOtl1msA3bIVAvdRuQwNoZ
         KoRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y9mMQK9sKtWkYVn2tTLrqE2pA0vjVcq3E0qdtFwjDm0=;
        b=OPPv6fNdEIMdY0rD0WG/KagNBzt5mstz/D+0BbMJWXdW8viQs+/3XtDlnzBdu7oHlz
         Yr2wzv5ptqqC6BKZhmeThZ94dStkPtXHlxST/SwgMSj5Nmkv956hgSUxxGDjwfVmWWgD
         R2U1Apx4/DnEOMVWT4WiD6oVUbYx0mODyPZs7ZIi9VJJ7HzU4+Tet4jRWg3hfOhZGLlo
         neWGc0d8+2Tp3ezIUqNoo2noh6NY4O6ik4Y9SYM4dpKbPC8f7nu0lDDXwZMeu82/rTmG
         /3qTUP7eyaN/p1yICHzAvWAhstgcfCWZopBqW8DoddpuwZbjk6IKLzxO18tvppy4t0We
         bKHA==
X-Gm-Message-State: APjAAAXkMrlc79u4b8kmLZN5FNvO3Fha2z2kXCLaJZOg/d+5zt3wfNSB
        AvhtuKs3QD+ujOeLxSD+KM8w5Sv2g3dvQSz+KW+8wA==
X-Google-Smtp-Source: APXvYqztE1b64ddvyGSTrs/viqOnx1s8V4PiJRCg0njvbgRaqHL43xEmtPe+sNLTtcWqmb9QiWUsUoMuerCidUN8TiA=
X-Received: by 2002:a63:c94f:: with SMTP id y15mr9670654pgg.159.1560979540781;
 Wed, 19 Jun 2019 14:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190619205009.4176588-1-taoren@fb.com>
In-Reply-To: <20190619205009.4176588-1-taoren@fb.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 19 Jun 2019 14:25:29 -0700
Message-ID: <CAFd5g45TMtXcuqONdkpN_K+c0O+wUw8wkGzcQfV+sO8p5Krc9w@mail.gmail.com>
Subject: Re: [PATCH 1/2] i2c: aspeed: allow to customize base clock divisor
To:     Tao Ren <taoren@fb.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 2:00 PM Tao Ren <taoren@fb.com> wrote:
>
> Some intermittent I2C transaction failures are observed on Facebook CMM and
> Minipack (ast2500) BMC platforms, because slave devices (such as CPLD, BIC
> and etc.) NACK the address byte sometimes. The issue can be resolved by
> increasing base clock divisor which affects ASPEED I2C Controller's base
> clock and other AC timing parameters.
>
> This patch allows to customize ASPEED I2C Controller's base clock divisor
> in device tree.

First off, are you sure you actually need this?

You should be able to achieve an effectively equivalent result by just
lowering the `bus-frequency` property specified in the DT. The
`bus-frequency` property ultimately determines all the register
values, and you should be able to set it to whatever you want by
refering to the Aspeed documentation.

Nevertheless, the code that determines the correct dividers from the
frequency is based on the tables in the Aspeed documentation. I don't
think the equation makes sense when the base_clk_divisor is fixed; I
mean it will probably just set the other divisor to max or min
depending on the values chosen. I think if someone really wants to
program this parameter manually, they probably want to set the other
parameters manually too.

[snip]
