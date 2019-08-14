Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BE9C0650F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69280216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r2pSn+Kr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfHNIlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 04:41:31 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46850 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfHNIlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 04:41:31 -0400
Received: by mail-lf1-f66.google.com with SMTP id n19so10351181lfe.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 01:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KzpALMQhsAYiuMs6y6iJLV3dLZWeIJlGmnisMykIAis=;
        b=r2pSn+KrIj0p/r1Jh1Qa8oRX30gNZzgGkBpwKkDEJNczG7E+VnEvwitjkTtXDi+iiY
         4quGEaWmppl+rGwEtCxpw/UZ3hBqlm+OVntmnenzCFo/I6+LXJxNE7F5nzZUYPGfUZiM
         xiG/6RYIi+mV1854OvRiWUXHkXNDPIzy+8pHNKtKmSgN6mwGISjCmBFoX1/xBh582HPF
         0rE/0WduaDy2igRu2LN3eXNSIweY7DEhtBe8nqhlALJP8Xv3yu9U1R/0vGBigFAmvlLa
         PAsFJPhwguzevp0v5g/p6gMTOOiq08hxCCU/MhScC+UZSJVOlkN0kzs35xo7Oo+fvBp+
         LgMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KzpALMQhsAYiuMs6y6iJLV3dLZWeIJlGmnisMykIAis=;
        b=kJWqHd3b9kzDxnJsG79w7otD1ndXyVpx0wZhbAkUxPoU71fdqGRVauXmgh0ghpMrAW
         Pyrrk/2+qUEhbU/jtmDTYQmwIOZxf9NUFCWvmH/Yy4zGdOMv/vAEtYPnPMpA91hn3lcZ
         YUo4UoA0ZNYtiPdLG8CqxH+zj9LbBrlDtzOXu04871RAfuNGqdkton//08vo8UJuHO39
         ddDn0PJloYPZakS1i07elDQ98zGYH8pcRotE3vO5BUUy0+2qi6oXzvfq8n4GfgoWy3yO
         LVqHIurYfzIn2ko2Rejugeha1ZpGGPjJNJMXGkZhHZPGVXoDo8++6F/kEQzzGhuimVcG
         zfuA==
X-Gm-Message-State: APjAAAUYiS8jpYZaYeGS35rii9EUKnc87A0wqDtC2eECfm3uIbvp9EGs
        rE5TkAVZsLpwe3FpQpdS6dpVtQ9L9JZMJ4yapLjYbQ==
X-Google-Smtp-Source: APXvYqx5nqnXeVYMCMOMXqQ9fV6cH2bSPFPCrhICg/SdR9VyEVww1xueQTgGw2t8u9djOnijC0ljUID4vf6sSeDgNCQ=
X-Received: by 2002:ac2:4c07:: with SMTP id t7mr22886155lfq.152.1565772089303;
 Wed, 14 Aug 2019 01:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190724081313.12934-1-andrew@aj.id.au> <20190724081313.12934-4-andrew@aj.id.au>
 <CACRpkdZCJWeZO6CFvkq4uhnX+o_q_AfkDZ=a2kmUgbS3JtDqfA@mail.gmail.com> <20190812101504.GF26727@dell>
In-Reply-To: <20190812101504.GF26727@dell>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 14 Aug 2019 10:41:17 +0200
Message-ID: <CACRpkdapA_-yp4ihY3S+CHMmDMKU2b0u=sj2UhJ-cvv39Dji_g@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: aspeed: Remove mention of deprecated compatibles
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
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

On Mon, Aug 12, 2019 at 12:15 PM Lee Jones <lee.jones@linaro.org> wrote:
> On Mon, 05 Aug 2019, Linus Walleij wrote:
>
> > On Wed, Jul 24, 2019 at 10:13 AM Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> > > Guide readers away from using the aspeed,g[45].* compatible patterns.
> > >
> > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> >
> > Patch applied to the pinctrl tree.
>
> With my Ack?

Sorry no. :( Was I too trigger-happy?

Usually I take Rob's ACK as authoritative for anything under
Documentation/devicetree but if you have concerns about the
patch from an MFD point of view I will revert it pending further
discussion.

Yours,
Linus Walleij
