Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50679C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 19:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22DEA206A2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 19:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HWMrmaJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfF1TJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 15:09:06 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44100 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfF1TJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 15:09:06 -0400
Received: by mail-io1-f67.google.com with SMTP id s7so14674251iob.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 12:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=denpEz7Y25tPYld+8szHUZUn70KyumHMuU5ZgYCdiKI=;
        b=HWMrmaJnz5V8Ac64W9ltGnhij2/onexK3xCea2eFyAXK6JVJnwj62PwageLoaznljr
         lVtZWieElekXXI6Q4uto5rBOs5y5+Y+oEhsPTyrfK/jawOxPcID1zg2pkEYUErrhcwJB
         aszK3rXIb3zpoK6myJKG5S0dwok2xahK5qCTGgIkyiJIZXoRbIwMC/T+A04ynBDaa7BH
         hrEXqsOvUf285Gj4q/Vnqx2FcdDFpiK+Iaa3nU5B1d3yP/hh7wB2rHg3xnWWrSZTkWn+
         Q8Ff3Ayu/GN5pDCx+2ZM3PNc7q0wBMyQInqc2hToFVqvI2Nn3mimmdf2GreNGgeTmOwr
         KdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=denpEz7Y25tPYld+8szHUZUn70KyumHMuU5ZgYCdiKI=;
        b=ETM89ubDjWVqTmFOrOPVfVeVtENJMKTjsiXUvAGianC3yZpr9qr3eJ9L7pVOjp8nPf
         Qbbnmmf+YZzaTRcuk9Zv3UIcyQcsqryHx+uBHLY6gGjndDDrRJvSEfZn/Yh5RXvAmK/2
         m7N2rhZBnTsLPet2XIguPqMLhOyOHziLeaizYw9RWNVJ54T5aKu06gYV7yUNIv+Ppw/3
         VVEjBf1c+aXYUtDr6f7+Cf2dxhW/aeyEhquFKqtbqYHIboasSaeF4pQkWUi2eR74udsc
         ndyWwxpAYoB2MnMdxSSxFRzvgYsEQtDNDLcI2cELEwtWgwijAHXGzAXYLo2IxWYkN+30
         WiVA==
X-Gm-Message-State: APjAAAW9L6Dq4U13m54h1dW2zJ22Gy7bBlk6rUT4+f2S3LyJPbShkfln
        nc2f9srur0fBnPTI7V/Pg03//w==
X-Google-Smtp-Source: APXvYqyCiWd28x6ejKIVj1HQUvQbmY2IcCFzFG/uYivQu5hxZZBjfMnIAX99mg22opfTcrJJ/QIWog==
X-Received: by 2002:a05:6638:281:: with SMTP id c1mr13074518jaq.43.1561748945460;
        Fri, 28 Jun 2019 12:09:05 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id x13sm2623367ioj.18.2019.06.28.12.09.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 12:09:05 -0700 (PDT)
Date:   Fri, 28 Jun 2019 12:09:04 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Atish Patra <atish.patra@wdc.com>
cc:     linux-kernel@vger.kernel.org, Karsten Merker <merker@debian.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <Anup.Patel@wdc.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Nick Kossifidis <mick@ics.forth.gr>,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "trini@konsulko.com" <trini@konsulko.com>
Subject: Re: [PATCH v4] RISC-V: Add an Image header that boot loader can
 parse.
In-Reply-To: <20190606230800.19932-1-atish.patra@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1906281207290.3867@viisi.sifive.com>
References: <20190606230800.19932-1-atish.patra@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jun 2019, Atish Patra wrote:

> Currently, the last stage boot loaders such as U-Boot can accept only
> uImage which is an unnecessary additional step in automating boot
> process.
> 
> Add an image header that boot loader understands and boot Linux from
> flat Image directly.

...


> +#if __riscv_xlen == 64
> +	/* Image load offset(2MB) from start of RAM */
> +	.dword 0x200000
> +#else
> +	/* Image load offset(4MB) from start of RAM */
> +	.dword 0x400000
> +#endif

Is there a rationale behind these load offset values?


- Paul
