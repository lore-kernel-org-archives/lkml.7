Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5582C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 04:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715072067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 04:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lnQz8Id5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbfGaEwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 00:52:05 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33345 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728764AbfGaEwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 00:52:04 -0400
Received: by mail-ot1-f67.google.com with SMTP id q20so68736087otl.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 21:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=xIj00IIxzXm35iWcbJEEMjex/0c7NldacFp3fkJRa7A=;
        b=lnQz8Id5tT7vpViGceKAZWJgiylaDdwMd6Ah4vJWFKirI3VN60C6xnujVSxldwpb9F
         44eZBlATamxo+MJWsMO4oEU7HThWc44+Gj2GoGn6SwJVSd7/l3j7QzZJdXCaCvaGGkre
         GDV4049M8sCt381STog0f3sKV/mtgVRzkyZB4ME3XVJG+op+9jvUBe5GNdmY/CJooFBo
         rqdFI8CgyNrFpnmoDrgICBxUPHbRGSJmuMuZHu0NAH+ddU+kKw3GwM+ToqedTGG9q3da
         +s0mq6vQd2sPmDFu/+TCOjGFJsslIvDbmIVLFLNloKd7BqNyNZ4wfUXfEFOXPjzB31Fb
         W8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=xIj00IIxzXm35iWcbJEEMjex/0c7NldacFp3fkJRa7A=;
        b=oSQn2/fdjaIBJ2EQ411/9haN9YWEplRfCG5txGN+P9PTcymFwyuNIJuR5ANUbd9sEF
         8WXvaKXUb+GdX/auSawl4F6VpNFxtsAWHMP+vwzoT0SFR2bGDlTUzoe1NWW2EYca2CO8
         BE/mh2XDEmfZ5ZONdurmjAei0zEae5KhtLvA/Rt+vVam61I8PUPoucEH7vXqctHBEJXY
         ptq0PAffudwdRGFBTyrOEGv9io5Ja4n+3kl7RubFUXBUC1883fLZRhfW/+c1CfbP4D4B
         JiHNdXkOhfFQiSeEXI8VQQEaXwRNNffGRfXOld8gHbdU22wOOpckHu2vd+ajF95HD4T/
         IHqg==
X-Gm-Message-State: APjAAAU/OwaFLKWflWASRimyo2i6xxVdgbnxsCdHPJaboOHEMmQ0EbXL
        5nFPbSpcXv/BlZnH73mDptq6+g==
X-Google-Smtp-Source: APXvYqzKMTKiwt+rmGNMruM+QyuU6sXYvuZ4/b2mUCdPKj/rrkKLhMbecmRKy4JuUPBQ65iIM+zx1g==
X-Received: by 2002:a05:6830:1146:: with SMTP id x6mr89587321otq.86.1564548723780;
        Tue, 30 Jul 2019 21:52:03 -0700 (PDT)
Received: from localhost ([2600:100e:b005:6ca0:a8bb:e820:e6d3:8809])
        by smtp.gmail.com with ESMTPSA id 20sm14543522oth.43.2019.07.30.21.52.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 21:52:03 -0700 (PDT)
Date:   Tue, 30 Jul 2019 21:52:01 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Atish Patra <atish.patra@wdc.com>
cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Anup Patel <anup.patel@wdc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 5/5] dt-bindings: Update the isa string description
In-Reply-To: <20190731012418.24565-6-atish.patra@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1907302124010.15340@viisi.sifive.com>
References: <20190731012418.24565-1-atish.patra@wdc.com> <20190731012418.24565-6-atish.patra@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2019, Atish Patra wrote:

> The yaml documentation description of isa strings section doesn't
> specify anything about the case sensitiveness of the isa strings.
> The RISC-V specification clearly specifies it to be case insensitive.
> However, Linux kernel supports only lower case isa strings.

The DT binding documentation specifies an interface.  As such the binding 
isn't determined by any particular piece of software.  So justifying the 
binding update by referring to what the Linux kernel currently supports 
isn't that relevant.  If you still really believe that software should be 
required to handle mixed-case DT ISA strings, the right answer would be to 
change the software, as your original patches proposed.  The way you've 
written this patch description, it sounds like you still don't agree with 
the conclusion that a strictly lowercase string is a good approach.

If I've misunderstood your intent here, and you do think that specifying 
an all lowercase string is sufficient, then instead of the patch 
description above, how about something like:

"Since the RISC-V specification states that ISA description strings are 
case-insensitive, there's no functional difference between mixed-case, 
upper-case, and lower-case ISA strings.  Thus, to simplify parsing, 
specify that the letters present of riscv,isa must be all lowercase."

That way it's clear that, per the RISC-V specification, there's no 
functional difference associated with case.

However, if what you're saying is that you still don't like this outcome, 
let me know and I'll write the patch myself.  That way you don't have to 
have your name associated with a change that you don't believe in.

> Update the yaml documentation accordingly to avoid any confusion.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> index c899111aa5e3..e22a2b7ebafa 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -46,10 +46,14 @@ properties:
>            - rv64imafdc
>      description:
>        Identifies the specific RISC-V instruction set architecture
> -      supported by the hart.  These are documented in the RISC-V
> +      supported by the hart. These are documented in the RISC-V
>        User-Level ISA document, available from
>        https://riscv.org/specifications/
>  
> +      Linux kernel only supports lower case isa strings. Thus,

In the past, the DT maintainers have pushed back against explicitly 
mentioning the Linux kernel in binding documentation, since the DT 
bindings define an interface that's independent of the underlying software 
implementation.  How about just stating something like "Letters in the 
riscv,isa string must be all lowercase" ?

> +      isa strings must be specified in lower case in device tree
> +      as well.
> +

- Paul
