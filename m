Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF048C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2B02077C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555312413;
	bh=xvJYTcX2FmKHQwG0HimVxWO54y8+pKvJGT0FmNj6Ldw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=o0BzHP268Rc6cFwmbakQJTWPB+NgRlB2LndUTrXIW4jZpoVBKGt+UwN3AApcaWxda
	 XBp9CFaQd4W0Rv7BrREuSfvwjxy9Ei372J5SR3pwP6kcuk20jhyYARMPdND0Y5dkvl
	 JGcoHr+Vkr1fx0n7zGIKw/CKt75zqoGILDumIoQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfDOHNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 03:13:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:55464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfDOHNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 03:13:32 -0400
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DC9720833;
        Mon, 15 Apr 2019 07:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555312411;
        bh=xvJYTcX2FmKHQwG0HimVxWO54y8+pKvJGT0FmNj6Ldw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rVICFYKUK16xkz/4d1xHNAXtxUvyadnzhuTXXNjQk6ejIbxpwUJDgRI4k2oEDNJUF
         ATH7X1AH+ZKG4eLUsZzo7aDBbFwnuYdEBTeN390ldvt8de9RVrzYLCxjeHHJFwkZAN
         GM6KXUx5wQ1MNw6IxUoqWbY9i9nCnZAhUovKqPYQ=
Received: by mail-lj1-f173.google.com with SMTP id r24so14614818ljg.3;
        Mon, 15 Apr 2019 00:13:31 -0700 (PDT)
X-Gm-Message-State: APjAAAX6cjc20NMJP2cIysFV+G79LXbOkI8C6deeolcEnpkuaGulo1wo
        5B9gG0YBziXQ1GVVXVqzzZXIDKdwUUEGjBsA2yQ=
X-Google-Smtp-Source: APXvYqwYynekLkG4P4RHwBZaUYosP+1e6oxvbKPW6TxDN8Clhej2Q3m9fR8ltxyoWfxIR3r6ucc6Eu4AE/jJ5bS+qu0=
X-Received: by 2002:a2e:9d99:: with SMTP id c25mr13388960ljj.159.1555312409392;
 Mon, 15 Apr 2019 00:13:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAJKOXPfvs=uETF0-xpwCWc5khSpWjpz2zz354Jcx1bVjm9cG2A@mail.gmail.com>
 <20190415012635.6369-1-matheus@castello.eng.br> <20190415012635.6369-3-matheus@castello.eng.br>
In-Reply-To: <20190415012635.6369-3-matheus@castello.eng.br>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 15 Apr 2019 09:13:18 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfk5CYnaTmrxs+CFYXcB61t0ONQb11xDuqZnyA6AtkqVw@mail.gmail.com>
Message-ID: <CAJKOXPfk5CYnaTmrxs+CFYXcB61t0ONQb11xDuqZnyA6AtkqVw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: power: supply: Max17040: Add low
 level SOC alert threshold
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Apr 2019 at 03:50, Matheus Castello <matheus@castello.eng.br> wrote:
>
> For configure low level state of charge threshold alert signaled from
> max17040 we add "maxim,alert-soc-level" property.
>
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  .../power/supply/max17040_battery.txt         | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/max17040_battery.txt
>
> diff --git a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
> new file mode 100644
> index 000000000000..9b2cc67d556f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
> @@ -0,0 +1,24 @@
> +max17040_battery
> +~~~~~~~~~~~~~~~~
> +
> +Required properties :
> + - compatible : "maxim,max17040" or "maxim,max77836-battery"
> +
> +Optional properties :
> +- maxim,alert-soc-level :      The alert threshold that sets the state of
> +                               charge level where an interrupt is generated.
> +                               Can be configured from 1 up to 32. If skipped
> +                               the power up default value of 4 will be used.
> +- interrupt-parent :           The GPIO bank from the interrupt line.

It does not have to be GPIO so:
"phandle of the parent interrupt controller"

> +- interrupts :                         Interrupt line see Documentation/devicetree/
> +                               bindings/interrupt-controller/interrupts.txt
> +
> +Example:
> +
> +       battery-charger@36 {

It is a fuel gauge, not battery charger.

Best regards,
Krzysztof

> +               compatible = "maxim,max17040";
> +               reg = <0x36>;
> +               maxim,alert-soc-level = <10>;
> +               interrupt-parent = <&gpio7>;
> +               interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
> +       };
> --
> 2.17.0
>
