Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90681ECE58C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 00:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C641206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 00:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZxD4EoEu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732088AbfJJAIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 20:08:49 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40038 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731145AbfJJAIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 20:08:48 -0400
Received: by mail-io1-f65.google.com with SMTP id h144so9626355iof.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 17:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=27bPZ5AjHbkAvma41N9WmP13swNHgshH29767ZOGwvE=;
        b=ZxD4EoEu6a0XX57fQ9vuCr2Qdbqb486Yy+eIELlgZpMWd2I1HaiX7iC7Jq5ct1DnzT
         i6A1uNstnxnfaoLOabt8dbFoPCAUoEmXI0aSSZduZw5ByiVNKjG9ayG/ksg0vYYuGcPG
         JC79MRCqUSPJM/BY2C/Vsfya1TawIGSSndPMZgAvaxG/M9J4OkJM5LYCwwtbp8tlLzyA
         O3l39mNFN6sRktrkV1/gU8eAIFxT0MELDrPLBjI6eB9+cHbJANLr4tQSnreXsnNpbMfO
         1/VFr2dIiqCzhh3YWpSQhne6zKR0hlqfH03njxQcCAvNPPAe7wMKVLHAPh8ePGOw5lSr
         IFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=27bPZ5AjHbkAvma41N9WmP13swNHgshH29767ZOGwvE=;
        b=YDKBDyb0IBxJc0JX4OzNySNPzX3S8Uz0nW/2TWoaGTSiRU6BJdJ+rzGWss8X9ldxyr
         Y5rKtTfrsjSTKgWYIteJYkN/5T4U6BK8x6G1BXjVB9n2+/Up14ncT0SjHszW20gv8IG4
         F/JO1PZoG91zWBuWVPmf8OnsFR1wXhGvceEAPdOy/jYPIaYaqxdDLJ5bVuFC5l6CAKEq
         dLGj4xOn0872h2LyYd7KS7RbLiLAySUXR24F/4OaYDyjOyN352/TGGld95dzrKbfqgyE
         WIFbw3jYeCMLStvnNAUZCkJ2sGjuGXHZLmWA0/ajzWHNIe7SlyqxumzVR94ZWE6HQbEA
         pz9w==
X-Gm-Message-State: APjAAAVrHQao5Y6WkQ3shigV/cxKL65dqYSYkjYO7lROdpihMaPOQJgH
        LP/xgOyQKOc344JAE9Xj2nDfUA==
X-Google-Smtp-Source: APXvYqx8WLA6LKnMW9EfBeEKRznNEk0nJV0oAheX1NZ38rElDZ1PT+oHrJ0dYK7NlOJowD+Wsbrqlw==
X-Received: by 2002:a02:6d08:: with SMTP id m8mr6621388jac.34.1570666126079;
        Wed, 09 Oct 2019 17:08:46 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id z20sm1627289iof.38.2019.10.09.17.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 17:08:44 -0700 (PDT)
Date:   Wed, 9 Oct 2019 17:08:43 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Rob Herring <robh@kernel.org>
cc:     Palmer Dabbelt <palmer@sifive.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: riscv: Fix CPU schema errors
In-Reply-To: <20191009234648.2271-1-robh@kernel.org>
Message-ID: <alpine.DEB.2.21.9999.1910091657240.11044@viisi.sifive.com>
References: <20191009234648.2271-1-robh@kernel.org>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Oct 2019, Rob Herring wrote:

> Fix the errors in the RiscV CPU DT schema:
> 
> Documentation/devicetree/bindings/riscv/cpus.example.dt.yaml: cpu@0: 'timebase-frequency' is a required property
> Documentation/devicetree/bindings/riscv/cpus.example.dt.yaml: cpu@1: 'timebase-frequency' is a required property
> Documentation/devicetree/bindings/riscv/cpus.example.dt.yaml: cpu@0: compatible:0: 'riscv' is not one of ['sifive,rocket0', 'sifive,e5', 'sifive,e51', 'sifive,u54-mc', 'sifive,u54', 'sifive,u5']
> Documentation/devicetree/bindings/riscv/cpus.example.dt.yaml: cpu@0: compatible: ['riscv'] is too short
> Documentation/devicetree/bindings/riscv/cpus.example.dt.yaml: cpu@0: 'timebase-frequency' is a required property
> 
> The DT spec allows for 'timebase-frequency' to be in 'cpu' or 'cpus' node
> and RiscV is doing nothing special with it, so just drop the definition
> here and don't make it required.

The RISC-V kernel code does in fact parse it and use it, and we currently 
rely on it being under /cpus:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/riscv/kernel/time.c#n19

The RISC-V user ISA specification also constrains the timebase-frequency 
to be the same across all CPUs, in section 10.1:

  https://github.com/riscv/riscv-isa-manual/releases/download/draft-20190608-f467e5d/riscv-spec.pdf

So the right thing is to require 'timebase-frequency' at /cpus, and forbid 
it in the individual CPU nodes. 

> 
> Fixes: 4fd669a8c487 ("dt-bindings: riscv: convert cpu binding to json-schema")
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: linux-riscv@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/riscv/cpus.yaml       | 28 ++++++++-----------
>  1 file changed, 11 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> index b261a3015f84..925b531767bf 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -24,15 +24,17 @@ description: |
>  
>  properties:
>    compatible:
> -    items:
> -      - enum:
> -          - sifive,rocket0
> -          - sifive,e5
> -          - sifive,e51
> -          - sifive,u54-mc
> -          - sifive,u54
> -          - sifive,u5
> -      - const: riscv
> +    oneOf:
> +      - items:
> +          - enum:
> +              - sifive,rocket0
> +              - sifive,e5
> +              - sifive,e51
> +              - sifive,u54-mc
> +              - sifive,u54
> +              - sifive,u5
> +          - const: riscv
> +      - const: riscv    # Simulator only
>      description:
>        Identifies that the hart uses the RISC-V instruction set
>        and identifies the type of the hart.
> @@ -66,13 +68,6 @@ properties:
>        insensitive, letters in the riscv,isa string must be all
>        lowercase to simplify parsing.
>  
> -  timebase-frequency:
> -    type: integer
> -    minimum: 1
> -    description:
> -      Specifies the clock frequency of the system timer in Hz.
> -      This value is common to all harts on a single system image.
> -
>    interrupt-controller:
>      type: object
>      description: Describes the CPU's local interrupt controller
> @@ -93,7 +88,6 @@ properties:
>  
>  required:
>    - riscv,isa
> -  - timebase-frequency
>    - interrupt-controller
>  
>  examples:
> -- 
> 2.20.1
> 
> 


- Paul
