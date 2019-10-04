Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D28C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1507222C0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cige8aeI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389412AbfJDOp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 10:45:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43540 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389136AbfJDOpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 10:45:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id j18so6752648wrq.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 07:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HNaskgA9CGTRjPX5e5ZK2QfhqMEnQGHXob8M639FZMU=;
        b=cige8aeI93GPpuuoEgeWsSpy4l0fVuwBai3aDolKgCEZoMgoDPcAwoNVLYoJYCEa5Y
         T6msSfDjto/LLQ8zYZpFpczbMJht8u586Mi/ddTTN29VtoCVE2OafbjiBDYtIHgbqO9L
         HpMfh84b2Ecaou4bqbFvXc8PDpp7fc1oOmohsoAHd7dZTck6mBlhPSVPZc0oVtspwf2a
         boDTgI3N67eFN1mih+5qCEjjHjaQAMAf1F2mMtMNv1rATkJiNIUWREvPkpp9Mw80jlTf
         8oUqJ3/HuQSNA3EzgHiMeKNj67g9AVY757SSDybSX3R+fvVoO1FeHuGyqcREgO9sMFtJ
         w3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HNaskgA9CGTRjPX5e5ZK2QfhqMEnQGHXob8M639FZMU=;
        b=B66oR3KVt60Ag5vKARHy0Rz4G2Tyi3kXfT04iO2n5AjvANHnkpvVVj3ywn3Xw8C+/i
         1ek2ubiOzt7PaTSQDK8KfniqekomQKYzXiDjy9dFX8otlOc0KPft7o+U0YpyKCuNmPOK
         oodI5mVT3eiaw9IntUF/QS71tipuvmtxKkv3Ax4nBDAjZUo0RbC2aGIwNDD49giex2Ql
         U6CXj+HAZPwkum7Oa/m82qzYL1SsNAuNhjGvOmG3fO7vZIuwHjr1jjN0CVCeQJJR+jUX
         mXb1MBymLQXRXJ9AHCVg0uEFwI3wlEoGd7XphJJgEv/5k+ku2UPbUMenKGCVKeoV9e1f
         3LBA==
X-Gm-Message-State: APjAAAV7bLbg591dzcfWBQKCPte2xT75Uaf6sP0WshR4pgCAgSbupSXN
        opHREh9cdKMxIpuBqI/3r1jwYCdnWo0=
X-Google-Smtp-Source: APXvYqzeTXoEKPqTHngsFt5A7Yz0CZBxZ6TGexzTbaMsTPn1BMdEvT9oeQJeJ2hU/X9uJQuQ1NdmDw==
X-Received: by 2002:adf:fa0e:: with SMTP id m14mr7281348wrr.11.1570200353922;
        Fri, 04 Oct 2019 07:45:53 -0700 (PDT)
Received: from dell ([2.27.167.122])
        by smtp.gmail.com with ESMTPSA id v8sm9165069wra.79.2019.10.04.07.45.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 07:45:53 -0700 (PDT)
Date:   Fri, 4 Oct 2019 15:45:52 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 2/5] dt-bindings: mfd: Document the Xylon LogiCVC
 multi-function device
Message-ID: <20191004144551.GR18429@dell>
References: <20190927100407.1863293-1-paul.kocialkowski@bootlin.com>
 <20190927100407.1863293-3-paul.kocialkowski@bootlin.com>
 <20190927221550.GA28831@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190927221550.GA28831@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Sep 2019, Rob Herring wrote:

> On Fri, Sep 27, 2019 at 12:04:04PM +0200, Paul Kocialkowski wrote:
> > The LogiCVC is a display engine which also exposes GPIO functionality.
> > For this reason, it is described as a multi-function device that is expected
> > to provide register access to its children nodes for gpio and display.
> > 
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  .../bindings/mfd/xylon,logicvc.yaml           | 50 +++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/xylon,logicvc.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/xylon,logicvc.yaml b/Documentation/devicetree/bindings/mfd/xylon,logicvc.yaml
> > new file mode 100644
> > index 000000000000..abc9937506e0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/xylon,logicvc.yaml
> > @@ -0,0 +1,50 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright 2019 Bootlin
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/mfd/xylon,logicvc.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: Xylon LogiCVC multi-function device
> > +
> > +maintainers:
> > +  - Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > +
> > +description: |
> > +  The LogiCVC is a display controller that also contains a GPIO controller.
> > +  As a result, a multi-function device is exposed as parent of the display
> > +  and GPIO blocks.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - xylon,logicvc-3.02.a
> > +      - const: syscon
> > +      - const: simple-mfd
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +select:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        enum:
> > +          - xylon,logicvc-3.02.a
> 
> I've seen a couple of these with 'syscon' today, so I fixed the schema 
> tool to just exclude 'syscon' and 'simple-mfd' from the generated 
> 'select'. So you can drop select now.

Does this need to happen before this patch can be applied?

> Reviewed-by: Rob Herring <robh@kernel.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
