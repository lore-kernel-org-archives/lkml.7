Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DB3C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 05:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C8162072D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 05:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="uUT8/z3P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfKOF7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 00:59:44 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:47062 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfKOF7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 00:59:44 -0500
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id xAF5xML6026641;
        Fri, 15 Nov 2019 14:59:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com xAF5xML6026641
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1573797563;
        bh=VA8X3h+y+KvJiojZ5g26ovV795yixeERhKPix/QmG/c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uUT8/z3Po6ePdKq0xpsKyb9l9TXSWwsRM/l8lXibFE3IeVnwt+SVxALoOieK7aB2F
         FevGAbMqZ6jWoGmrjfTcVHoYK8iNirlko/v6DPrLjSrC1K2wx8q2uUQIZ13HeyUgzV
         0W3uLor+/yItWFr0Ggdt4wNL8yQ8133ip71NOQG/9QIYOvggKmrNkoagfsZMcGufnV
         HK2GU9MNY/HvGHlytbN4NCKFrl7PoPZwu/JtVHipzbL7sCIHkl/1fd1PMf9p3FJzSZ
         NxblPdTzUDwp94F5+KNQRZXt2IbBPFRNlgz5OOV35blyPJTs4cK8J8lkeMIcb1ejcJ
         w3+PdyHGORqwQ==
X-Nifty-SrcIP: [209.85.221.181]
Received: by mail-vk1-f181.google.com with SMTP id k19so2089035vke.10;
        Thu, 14 Nov 2019 21:59:22 -0800 (PST)
X-Gm-Message-State: APjAAAXA/NsSEGm8rj1gibLdulB0z7QGiBHtEbvYCOTmMzAcORusPh0r
        akqlnFmB2xVQ72h5fVMmxguRg/d7GaFwhG4qRks=
X-Google-Smtp-Source: APXvYqyZJAPFWi3reLTRhjgvpArjLWd5wfehmmvNraZbh7if4u73Xae3mpQOmM94kk9sT124enz7GBfmsdDdrRzxqUY=
X-Received: by 2002:a1f:7387:: with SMTP id o129mr7550948vkc.73.1573797561403;
 Thu, 14 Nov 2019 21:59:21 -0800 (PST)
MIME-Version: 1.0
References: <20191113210544.1894-1-robh@kernel.org> <30b73f89-1ba1-6052-53bd-414ebdfa142c@codeaurora.org>
 <CAL_Jsq+WFvwBy4rpZkT=_KMYzzvrsLcaTMFSydY_euuFLAsZEQ@mail.gmail.com>
In-Reply-To: <CAL_Jsq+WFvwBy4rpZkT=_KMYzzvrsLcaTMFSydY_euuFLAsZEQ@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 15 Nov 2019 14:58:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNASNugzCjzgObh8+fMvDhUNspapZy9rCA57eX3cLs6NW_g@mail.gmail.com>
Message-ID: <CAK7LNASNugzCjzgObh8+fMvDhUNspapZy9rCA57eX3cLs6NW_g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Improve validation build error handling
To:     Rob Herring <robh@kernel.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 1:34 AM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Nov 14, 2019 at 9:21 AM Jeffrey Hugo <jhugo@codeaurora.org> wrote:
> >
> > On 11/13/2019 2:05 PM, Rob Herring wrote:
> > > Schema errors can cause make to exit before useful information is
> > > printed. This leaves developers wondering what's wrong. It can be
> > > overcome passing '-k' to make, but that's not an obvious solution.
> > > There's 2 scenarios where this happens.
> > >
> > > When using DT_SCHEMA_FILES to validate with a single schema, any error
> > > in the schema results in processed-schema.yaml being empty causing a
> > > make error. The result is the specific errors in the schema are never
> > > shown because processed-schema.yaml is the first target built. Simply
> > > making processed-schema.yaml last in extra-y ensures the full schema
> > > validation with detailed error messages happen first.
> > >
> > > The 2nd problem is while schema errors are ignored for
> > > processed-schema.yaml, full validation of the schema still runs in
> > > parallel and any schema validation errors will still stop the build when
> > > running validation of dts files. The fix is to not add the schema
> > > examples to extra-y in this case. This means 'dtbs_check' is no longer a
> > > superset of 'dt_binding_check'. Update the documentation to make this
> > > clear.
> > >
> > > Cc: Jeffrey Hugo <jhugo@codeaurora.org>
> > > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> >
> > I injected a syntax error into a random binding file, and compared the
> > output with and without this patch.  This patch makes a massive
> > improvement in giving the user the necessary information to identify and
> > fix issues.  Thanks!


Could you show me an example of the injected syntax error,
and how this commit will improve the diagnostic?


For example, I changed as follows:

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
index 47bc1ac36426..358cb1fa4bb6 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
@@ -89,7 +89,7 @@ required:
   - clocks

 allOf:
-  - if:
+  - if2:
       properties:
         compatible:
           contains:



The tool clearly explains the cause of the error.
I am struggling to understand what the current problem is.



masahiro@pug:~/ref/linux$ make -j8  ARCH=arm  dt_binding_check
  CHKDT   Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
  DTC     Documentation/devicetree/bindings/arm/altera.example.dt.yaml
  DTC     Documentation/devicetree/bindings/arm/nxp/lpc32xx.example.dt.yaml
  DTC     Documentation/devicetree/bindings/arm/pmu.example.dt.yaml
  DTC     Documentation/devicetree/bindings/arm/rockchip.example.dt.yaml
  DTC     Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.example.dt.yaml
  DTC     Documentation/devicetree/bindings/arm/primecell.example.dt.yaml
  DTC     Documentation/devicetree/bindings/arm/renesas.example.dt.yaml
  CHECK   Documentation/devicetree/bindings/arm/nxp/lpc32xx.example.dt.yaml
  CHECK   Documentation/devicetree/bindings/arm/pmu.example.dt.yaml
  CHECK   Documentation/devicetree/bindings/arm/altera.example.dt.yaml
  CHECK   Documentation/devicetree/bindings/arm/rockchip.example.dt.yaml
  CHECK   Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.example.dt.yaml
  CHECK   Documentation/devicetree/bindings/arm/primecell.example.dt.yaml
  CHECK   Documentation/devicetree/bindings/arm/renesas.example.dt.yaml
/home/masahiro/ref/linux/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml:
allOf:0: 'if2' is not one of ['$ref', 'if', 'then', 'else']
make[1]: *** [Documentation/devicetree/bindings/Makefile;12:
Documentation/devicetree/bindings/gpu/arm,mali-midgard.example.dts]
Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile;1266: dt_binding_check] Error 2






> BTW, update dtschema and you'll get better (or more at least) messages
> when 'is not valid under any of the given schemas' errors occur.
>
> > Tested-by: Jeffrey Hugo <jhugo@codeaurora.org>
>
> Thanks.
>
> Rob



-- 
Best Regards
Masahiro Yamada
