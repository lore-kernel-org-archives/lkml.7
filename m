Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62E2C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC5C20896
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VwfILO09"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408376AbfFLMhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:37:00 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37003 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404384AbfFLMg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:36:57 -0400
Received: by mail-lf1-f68.google.com with SMTP id d11so4130032lfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 05:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W5ZcUb3ZYYyqexpun8Qj0H696dbroHsPGYQhJd7Effk=;
        b=VwfILO09T4Z5Vgxg5LLncNH+Qmr7pUmjfT+5Jzb3WzyN6G7A2tBfEgXyftXagfT8Du
         s6akg89YgtZnGgiA+o++zwTAO8XQmO0IDJGtMmUvUGY3nn76Ej3S5XXdZ/81lWVUPtlS
         s+ToGxwqYWUZFi/Il+qYx2HotqrkUDbrxWg8OgHZ1q6Cv6W9S04F8AK4BjAakKzgCdeE
         2Hab1EhG3q99Md/eLX9voBH8EpSdv4tefeLKacQaIyA/2ry0SG9gi9mZL/zs1vXk/BfZ
         w0TIRRKQZVbfLUkD5SMr/h+O1GZWPU/lMQtC4rt3K7JTj8f9apLM7tSL58gdgQ1LHG8U
         Bmjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W5ZcUb3ZYYyqexpun8Qj0H696dbroHsPGYQhJd7Effk=;
        b=Ht/eKAjwhRfdmUtBRXzqmM799datrz+k6OedgTcgGuiVkPDg0BqG484XGqWtTUW85O
         9+7Z9Qz6SgyddVzpDvY3jUiIpZg/b3uzIUJu6epVQgFkDA6izC7D8GL9mMtkBY/tTktg
         IP+LA3DRuwrD3Lnwr9Ic7iPcIKQQm2Thn4hsGM+7yqnXNNk5GTLRDlHBULrzrMxcVo30
         LsADQr+8mnD+Roaf1J04RBSwDpQ2bmKtGSkWPDBPB/B2uRt9NcUwOXwsuhfUDTA+UTgh
         Z/57sUKI5clyoz/qeq3Vcv4t8HRu9y5mTDgUy+X5R5LgJuG/JLrbKZAEH7Zld894cSQO
         oWTQ==
X-Gm-Message-State: APjAAAVL4I8MDRDVCaHo6oEQbpHpYVzkVhE0ibHJCejQusPCJEFBZxr0
        UMFw4G3iR4dNWLdI0JsxdrbFvXr9s0ghkaH8qvEuUw==
X-Google-Smtp-Source: APXvYqwItuntklbPWZ740m/jW/60/m/o5TFEDtlKeNXqgWJx53OWmMyLvLS322F9vXpV1FpMsEDBzyjEugWzC7+3ics=
X-Received: by 2002:ac2:598d:: with SMTP id w13mr39607037lfn.165.1560343016604;
 Wed, 12 Jun 2019 05:36:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190612081147.1372-1-anders.roxell@linaro.org>
In-Reply-To: <20190612081147.1372-1-anders.roxell@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Jun 2019 14:36:44 +0200
Message-ID: <CACRpkdbhRAdybqKdMgyM9Jy=eSJaRHjTpuOZO=KBgeaCbcP88Q@mail.gmail.com>
Subject: Re: [PATCH v2] drivers: net: dsa: fix warning same module names
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 10:11 AM Anders Roxell <anders.roxell@linaro.org> wrote:

> When building with CONFIG_NET_DSA_REALTEK_SMI and CONFIG_REALTEK_PHY
> enabled as loadable modules, we see the following warning:
>
> warning: same module names found:
>   drivers/net/phy/realtek.ko
>   drivers/net/dsa/realtek.ko
>
> Rework so the driver name is rtl8366 instead of realtek.
>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Sorry for giving bad advice here on IRC... my wrong.

> -obj-$(CONFIG_NET_DSA_REALTEK_SMI) += realtek.o
> -realtek-objs                   := realtek-smi.o rtl8366.o rtl8366rb.o
> +obj-$(CONFIG_NET_DSA_REALTEK_SMI) += rtl8366.o
> +rtl8366-objs                   := realtek-smi.o rtl8366-common.o rtl8366rb.o

What is common for this family is not the name rtl8366
(there is for example rtl8369 in this family, we just haven't
added it yet) but the common technical item is SMI.

So I would suggest something like:

obj-$(CONFIG_NET_DSA_REALTEK_SMI) += realtek-smi.o
realtek-smi-objs := realtek-smi-core.o rtl8366.o rtl8366rb.o

I.e. rename the realtel-smi.c to realtek-smi-core.c instead
and go with that.

With that change:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
