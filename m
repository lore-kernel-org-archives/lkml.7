Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0676BC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 21:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D04502190F
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 21:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569879161;
	bh=ahrG45JXVtUfkKqLUmvU7THmziQbpk9vQeSUmrjpTn4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qxK5Q/SZR5qNgPSR1o7BTRsiUuawE+B5Pb2+uV06VcnIH2nHGH54aqurL+UsQKMBA
	 Dw8g1nVdJU48d/d9cNXgBJ1NFD1KQL+9DnTDekX0RYchZVzn6kM1jp65MeM9fN0O2A
	 o0acZ3udmEc53nKH3ZDBb4GiI8WgXRBYA8z8FkiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730902AbfI3Vcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 17:32:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:51700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbfI3Vcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 17:32:41 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 621A621A4C;
        Mon, 30 Sep 2019 21:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569879159;
        bh=ahrG45JXVtUfkKqLUmvU7THmziQbpk9vQeSUmrjpTn4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZHq9Iid0BbcFZon6JAJa0Ns1LeLXWyA3y3CHxpLnMmZQP4jE0ySqZl79ZhI5AAMj7
         k7GDfiQmnUIPLDhpRZZUhEp9WeAj6gnl4VG9oem/NCq4OxW5YBNSdgo3FERubtHHSt
         hAUhe7ijMx3TQOa4lXjRRfhAnkprImxZy6Eiivw4=
Received: by mail-qk1-f172.google.com with SMTP id 4so9212925qki.6;
        Mon, 30 Sep 2019 14:32:39 -0700 (PDT)
X-Gm-Message-State: APjAAAU5kSyGZQWuDbnXpqf6ooq9zBW9I3Qr9IWpzdILpDdPTZlRgEYJ
        /BtKdKaokNBxOyUUtp6M/9Rw4z7/oNen1nmDKA==
X-Google-Smtp-Source: APXvYqwmdAG0zihvbA/HDPLGoFaCcqTkPDudG+MUypShjhLGzz8mxUI+We5DRSX0QT0g6JWF+E3QA4gzC4d8PIMbsA0=
X-Received: by 2002:a05:620a:7da:: with SMTP id 26mr2286889qkb.119.1569879158412;
 Mon, 30 Sep 2019 14:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190930130430.GA9080@localhost.localdomain>
In-Reply-To: <20190930130430.GA9080@localhost.localdomain>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 30 Sep 2019 16:32:27 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLXJNvWOOajS4JVVek=h+v_Fxrx58ogQ0Cz+5n5Sh0+=g@mail.gmail.com>
Message-ID: <CAL_JsqLXJNvWOOajS4JVVek=h+v_Fxrx58ogQ0Cz+5n5Sh0+=g@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: serial: document LiteUART bindings
To:     Mateusz Holenko <mholenko@antmicro.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org, Karol Gugala <kgugala@antmicro.com>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 8:04 AM Mateusz Holenko <mholenko@antmicro.com> wrote:
>
> From: Filip Kokosinski <fkokosinski@internships.antmicro.com>
>
> Add documentation for LiteUART devicetree bindings.
>
> Signed-off-by: Filip Kokosinski <fkokosinski@internships.antmicro.com>
> Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
> ---
>  .../devicetree/bindings/serial/litex,liteuart.txt    | 12 ++++++++++++
>  MAINTAINERS                                          |  6 ++++++
>  2 files changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/litex,liteuart.txt

Please make this a schema. See
Documentation/devicetree/writing-schema.rst (or .md before 5.4).

>
> diff --git a/Documentation/devicetree/bindings/serial/litex,liteuart.txt b/Documentation/devicetree/bindings/serial/litex,liteuart.txt
> new file mode 100644
> index 000000000..13c71a0c9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/litex,liteuart.txt
> @@ -0,0 +1,12 @@
> +LiteUART serial controller
> +
> +Required properties:
> +- compatible: should be "litex,liteuart"

Only 1 version?

> +- reg: base address and length of the register set for this device

Is there really no interrupt line? That should be added if there's h/w
support even if the driver doesn't yet support it.

> +
> +Example:
> +
> +uart0: serial@f0001000 {

Wrong unit address. Should be "@e0001800".


> +       compatible = "litex,liteuart";
> +       reg = <0xe0001800 0x100>;
> +};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b2326dece..65a6cf296 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9462,6 +9462,12 @@ F:       Documentation/misc-devices/lis3lv02d.rst
>  F:     drivers/misc/lis3lv02d/
>  F:     drivers/platform/x86/hp_accel.c
>
> +LITEX PLATFORM
> +M:     Karol Gugala <kgugala@antmicro.com>
> +M:     Mateusz Holenko <mholenko@antmicro.com>
> +S:     Maintained
> +F:     Documentation/devicetree/bindings/serial/litex,liteuart.txt
> +
>  LIVE PATCHING
>  M:     Josh Poimboeuf <jpoimboe@redhat.com>
>  M:     Jiri Kosina <jikos@kernel.org>
> --
> 2.23.0
>
