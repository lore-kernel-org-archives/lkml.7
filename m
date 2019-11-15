Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85004C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D90020730
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573829564;
	bh=cAugVQqnfOJDIZQAyQVPIYP8CjsNR+kKtTc6VBr8RPE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xh5If5D3FlaSzmHdyPskTiiBC3Le2dGuyDRQ1iwAfq/bHrkaQV2CSkA/6A97Yw9LZ
	 VvGDGsYAIEr4mJd0OMdfFGjowFLxkdo6Q1RP9V8Ir4FIvqzwedmStdlqcToS2cpmAX
	 Ci7+Z2eymzjPTU1/HdiJknGYuNCeJJfC5i444bfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfKOOwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 09:52:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:55058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727588AbfKOOwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 09:52:42 -0500
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DFC02075E;
        Fri, 15 Nov 2019 14:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573829561;
        bh=cAugVQqnfOJDIZQAyQVPIYP8CjsNR+kKtTc6VBr8RPE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NfKnZ0wShweb+o//n4ef+q6txsUq189RZ43VQyzN1eTtfXSMUbQsqdvf0mFLu/1eh
         gB22P6aGgHdHrbSSuCNkwHlfVDdUszFB1CZ/IZ9LJcealpcA3j4NFIC7VC8PH2GDAH
         OA/MRNQ4rvSh2tsgssWUogkCRu9fOHCAPNUYGhbQ=
Received: by mail-qk1-f174.google.com with SMTP id m16so8261134qki.11;
        Fri, 15 Nov 2019 06:52:41 -0800 (PST)
X-Gm-Message-State: APjAAAV2HISZ92dB4jC3eTgq9sI8EvecsW6lyJ3IBYU7dnNnKfHP/MB9
        dCmMIxokb/njThtwmBzsM9QpBN9r37DsM+bNcg==
X-Google-Smtp-Source: APXvYqyXpGPFd9dzp+nyir0q1Fm0wlWrqJRPWRpg47RGzyTiBMtJ1tJy2r+lUTTrK8LCwu5o2Zx4RL0nnwj49ZakawM=
X-Received: by 2002:a05:620a:205d:: with SMTP id d29mr12885993qka.152.1573829560581;
 Fri, 15 Nov 2019 06:52:40 -0800 (PST)
MIME-Version: 1.0
References: <20191113210544.1894-1-robh@kernel.org> <30b73f89-1ba1-6052-53bd-414ebdfa142c@codeaurora.org>
 <CAL_Jsq+WFvwBy4rpZkT=_KMYzzvrsLcaTMFSydY_euuFLAsZEQ@mail.gmail.com> <CAK7LNASNugzCjzgObh8+fMvDhUNspapZy9rCA57eX3cLs6NW_g@mail.gmail.com>
In-Reply-To: <CAK7LNASNugzCjzgObh8+fMvDhUNspapZy9rCA57eX3cLs6NW_g@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 15 Nov 2019 08:52:29 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+iTrSPsnAJyN9TVhqWzX4vv9KizTvHV08D7gCUTmEv+A@mail.gmail.com>
Message-ID: <CAL_Jsq+iTrSPsnAJyN9TVhqWzX4vv9KizTvHV08D7gCUTmEv+A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Improve validation build error handling
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 11:59 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Fri, Nov 15, 2019 at 1:34 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, Nov 14, 2019 at 9:21 AM Jeffrey Hugo <jhugo@codeaurora.org> wrote:
> > >
> > > On 11/13/2019 2:05 PM, Rob Herring wrote:
> > > > Schema errors can cause make to exit before useful information is
> > > > printed. This leaves developers wondering what's wrong. It can be
> > > > overcome passing '-k' to make, but that's not an obvious solution.
> > > > There's 2 scenarios where this happens.
> > > >
> > > > When using DT_SCHEMA_FILES to validate with a single schema, any error
> > > > in the schema results in processed-schema.yaml being empty causing a
> > > > make error. The result is the specific errors in the schema are never
> > > > shown because processed-schema.yaml is the first target built. Simply
> > > > making processed-schema.yaml last in extra-y ensures the full schema
> > > > validation with detailed error messages happen first.
> > > >
> > > > The 2nd problem is while schema errors are ignored for
> > > > processed-schema.yaml, full validation of the schema still runs in
> > > > parallel and any schema validation errors will still stop the build when
> > > > running validation of dts files. The fix is to not add the schema
> > > > examples to extra-y in this case. This means 'dtbs_check' is no longer a
> > > > superset of 'dt_binding_check'. Update the documentation to make this
> > > > clear.
> > > >
> > > > Cc: Jeffrey Hugo <jhugo@codeaurora.org>
> > > > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > >
> > > I injected a syntax error into a random binding file, and compared the
> > > output with and without this patch.  This patch makes a massive
> > > improvement in giving the user the necessary information to identify and
> > > fix issues.  Thanks!
>
>
> Could you show me an example of the injected syntax error,
> and how this commit will improve the diagnostic?
>
>
> For example, I changed as follows:
>
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
> b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
> index 47bc1ac36426..358cb1fa4bb6 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
> @@ -89,7 +89,7 @@ required:
>    - clocks
>
>  allOf:
> -  - if:
> +  - if2:
>        properties:
>          compatible:
>            contains:
>
>
>
> The tool clearly explains the cause of the error.
> I am struggling to understand what the current problem is.
>
>
>
> masahiro@pug:~/ref/linux$ make -j8  ARCH=arm  dt_binding_check

Before this patch, you should see processed-schema.yaml built first.
Clean your tree and do:

make -j8  ARCH=arm
DT_SCHEMA_FILES=Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
dt_binding_check

Building processed-schema.yaml will fail because it will be empty as
the 1 file included had an error.

>   CHKDT   Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
>   DTC     Documentation/devicetree/bindings/arm/altera.example.dt.yaml
>   DTC     Documentation/devicetree/bindings/arm/nxp/lpc32xx.example.dt.yaml
>   DTC     Documentation/devicetree/bindings/arm/pmu.example.dt.yaml
>   DTC     Documentation/devicetree/bindings/arm/rockchip.example.dt.yaml
>   DTC     Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.example.dt.yaml
>   DTC     Documentation/devicetree/bindings/arm/primecell.example.dt.yaml
>   DTC     Documentation/devicetree/bindings/arm/renesas.example.dt.yaml
>   CHECK   Documentation/devicetree/bindings/arm/nxp/lpc32xx.example.dt.yaml
>   CHECK   Documentation/devicetree/bindings/arm/pmu.example.dt.yaml
>   CHECK   Documentation/devicetree/bindings/arm/altera.example.dt.yaml
>   CHECK   Documentation/devicetree/bindings/arm/rockchip.example.dt.yaml
>   CHECK   Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.example.dt.yaml
>   CHECK   Documentation/devicetree/bindings/arm/primecell.example.dt.yaml
>   CHECK   Documentation/devicetree/bindings/arm/renesas.example.dt.yaml
> /home/masahiro/ref/linux/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml:
> allOf:0: 'if2' is not one of ['$ref', 'if', 'then', 'else']
> make[1]: *** [Documentation/devicetree/bindings/Makefile;12:
> Documentation/devicetree/bindings/gpu/arm,mali-midgard.example.dts]
> Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile;1266: dt_binding_check] Error 2
>
>
>
>
>
>
> > BTW, update dtschema and you'll get better (or more at least) messages
> > when 'is not valid under any of the given schemas' errors occur.
> >
> > > Tested-by: Jeffrey Hugo <jhugo@codeaurora.org>
> >
> > Thanks.
> >
> > Rob
>
>
>
> --
> Best Regards
> Masahiro Yamada
