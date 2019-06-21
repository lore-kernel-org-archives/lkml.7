Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCF8C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 19:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7182208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 19:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561146612;
	bh=04JoEBxD3BFQvCruh9qRPwf97IIUDRYFCn4G/UANqMg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rKI3ccuHfRZrSQStCmPwQr1+7QS7RWFbqFZIEW1Go+dj8BOUryWCl/1OhUN4UI36X
	 YIJkiFiD02E6y/ft0HKBRC+cetsc9LSvt/hYDK9o4sSyFrh/lNSruoaliI4b8Ey0Ls
	 sEtAwnL8bppId2KmGgLhORkpczwMUqcO0Ybzmyi4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfFUTuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 15:50:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfFUTuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 15:50:10 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A0DD21530;
        Fri, 21 Jun 2019 19:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561146610;
        bh=04JoEBxD3BFQvCruh9qRPwf97IIUDRYFCn4G/UANqMg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c/DvUGTRbo284HFgnXzdQ1URo3qv+8FtczRuvG/PEF2kvColGkafTHWVSlKwemimP
         QimdsMdIrkhxHixKgp+8wxLp9u6+NU66LuWrYMI1SyaNdJBD3W3eByS7n67tu2oZw1
         nhYNqW3ADmPBB/XGFH9x2gwJpEpW9kmECmb5AIw0=
Received: by mail-qk1-f178.google.com with SMTP id r6so5354686qkc.0;
        Fri, 21 Jun 2019 12:50:10 -0700 (PDT)
X-Gm-Message-State: APjAAAX95WkH3x9K8iXrZAW5+FAqr2cfdYXB1RpAg9XD3e9XJV2BBmfe
        Ob+VLO8gEBBs3kTuiH6l+W2z5MEnLmzsgVFOFw==
X-Google-Smtp-Source: APXvYqz5cBp3x+DmSEQitU24gvMNTmfNuB58xPNZsCfkqZeUWaT8NtfpQbGa48QKpKo3Wv6jZktZ44i2bkYwwhqXESo=
X-Received: by 2002:a05:620a:1447:: with SMTP id i7mr17358138qkl.254.1561146609224;
 Fri, 21 Jun 2019 12:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190602080126.31075-1-paul.walmsley@sifive.com>
 <20190602080126.31075-4-paul.walmsley@sifive.com> <CAL_JsqJd6s6ta==AoxmNXdpzWL1RytSwR2P4MOfAFSEJavbt+w@mail.gmail.com>
In-Reply-To: <CAL_JsqJd6s6ta==AoxmNXdpzWL1RytSwR2P4MOfAFSEJavbt+w@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 21 Jun 2019 13:49:58 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL1a-irBa4MaVzak5DrTjxiySuqTJSQOqwzymVa=Uz=gg@mail.gmail.com>
Message-ID: <CAL_JsqL1a-irBa4MaVzak5DrTjxiySuqTJSQOqwzymVa=Uz=gg@mail.gmail.com>
Subject: Re: [PATCH 3/5] dt-bindings: riscv: convert cpu binding to json-schema
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org, Paul Walmsley <paul@pwsan.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 3:46 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Sun, Jun 2, 2019 at 2:01 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
> >
> > At Rob's request, we're starting to migrate our DT binding
> > documentation to json-schema YAML format.  Start by converting our cpu
> > binding documentation.  While doing so, document more properties and
> > nodes.  This includes adding binding documentation support for the E51
> > and U54 CPU cores ("harts") that are present on this SoC.  These cores
> > are described in:
> >
> >     https://static.dev.sifive.com/FU540-C000-v1.0.pdf
> >
> > This cpus.yaml file is intended to be a starting point and to
> > evolve over time.  It passes dt-doc-validate as of the yaml-bindings
> > commit 4c79d42e9216.
> >
> > This patch was originally based on the ARM json-schema binding
> > documentation as added by commit 672951cbd1b7 ("dt-bindings: arm: Convert
> > cpu binding to json-schema").
> >
> > Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-riscv@lists.infradead.org
> > ---
> >  .../devicetree/bindings/riscv/cpus.yaml       | 168 ++++++++++++++++++
> >  1 file changed, 168 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/riscv/cpus.yaml
>
> Reviewed-by: Rob Herring <robh@kernel.org>

You all have applied this now leaving the binding checks broken. I
have a fix for one issue validating the schema, but there's a
dependency on schemas/cpus.yaml which I gave feedback on.

Rob
