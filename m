Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0B3C7618F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 23:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2FE2070D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 23:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mecH4Vht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfG1XOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 19:14:51 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41367 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfG1XOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 19:14:50 -0400
Received: by mail-lj1-f195.google.com with SMTP id d24so56685383ljg.8
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 16:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uqbaLb+DoYfmkQkeju/D4dfpefzvGhqE/NA7IyXYHDs=;
        b=mecH4VhtykhjOehOVm7m8Pa5YP6LbhZHxuLFQA2XocGjWKuVwaUD5JKujEe9aVixYW
         cawoMpzpCuo6PsH/Y5+Y7tXwV3d7SoDRDfjjcoukQScCk9CzzHAMPo1pS4yrzvyXmqyJ
         2yMjXxSUUQvzemHru0Os3ufWRvyApCPQMYjePIqEYdIr8dqIpeHbncxd/W99X2KbFg2j
         jbwANzOROhAvP10F0iLcxqbviHMgDbZ6aAMO7bHOLzMbrE+YgCLY6qUQqtoboNujm0Gj
         U73hnvjkMlVYKlUDbpdLF67Z+MpbkHJo3vfCQ+e8YPRfhiYgmC3LZ5+TDpH4eiTfU3zX
         7Iyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uqbaLb+DoYfmkQkeju/D4dfpefzvGhqE/NA7IyXYHDs=;
        b=X3ChG2zq9nim9P/V6J0wmegXEy9O1pRvxmQJ/Vv1KZ3nnkPDQ0qo80fSPhsfaUoVWn
         K377/SZh2KlTqJtELu1vpnjR4ER0kceLcIKeajJ4zITdJ/MOs08ck3eIGVTAdNBazFMQ
         ZJx1wik0hIisvCQsIlfmC0lEgwLD2uHi6WoOYnoJizOVexMhHfJOZ4AbA0skM3Py/cn1
         RreYWjVN1zWlNznJIw3LKyKjeoDWTuZTwwL2frKgSF7jh/PbK+5fJUxNnuzVl0ezdneC
         xL4zS05zJ5MZYs00k8UN6ryDvBCk4/BaLhcUDx+IOJbEGsp9OHzoxQIUiUr5iANLUE1I
         qMCg==
X-Gm-Message-State: APjAAAXXNacsczUyIodBbVnchSpV9HoxyRbala/iaAXU3dwcp+P/SYE0
        UimTrmmtknvFlGCGDLaPL0bQOvvJ50XZu7c7L39r3Q==
X-Google-Smtp-Source: APXvYqxZn/ye7KzmbCXTelv16sXPVMTT2jnKOOv6eVhlkoDzFB17aRJoEaL7U1kzdaeMP7q7K+fcGcM99btdobKE65w=
X-Received: by 2002:a2e:9593:: with SMTP id w19mr8822011ljh.69.1564355688739;
 Sun, 28 Jul 2019 16:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190711041942.23202-1-andrew@aj.id.au>
In-Reply-To: <20190711041942.23202-1-andrew@aj.id.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 29 Jul 2019 01:14:37 +0200
Message-ID: <CACRpkdb4pEdPHbo=3+fJXe9WG8K7A2_xVMtKWCJCfEawDO5wBw@mail.gmail.com>
Subject: Re: [PATCH 0/6] pinctrl: aspeed: Add AST2600 pinmux support
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>, ryanchen.aspeed@gmail.com,
        johnny_huang@aspeedtech.com, linux-aspeed@lists.ozlabs.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 6:19 AM Andrew Jeffery <andrew@aj.id.au> wrote:

> This series adds pinmux support for the AST2600. Some more rework was required
> on top of the previous cleanup series, but this rework was focussed on
> supporting features of the AST2600 pinmux rather than fixing issues with the
> existing infrastructure for the ASPEED drivers. Due to the dependences it's
> based on top of pinctrl/devel, so should avoid any more SPDX issues.
>
> ASPEED have been testing the patches on hardware, so even for an initial pass
> there's some confidence in the implementation.

I'm unsure if I need to wait for the DT bindings to be fixed on this
series?

Yours,
Linus Walleij
