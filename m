Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DBFC432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336D821E6F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574098213;
	bh=AIFMjOG1SMLyN7ph0ofkjADh0HpYilqm2YWZs1PDFLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g6qWgqUejRWVV+elQ/1KQXGbjFvb+hC+Jr1FKec/5ubg/i1r7N0u8bqckKXo0xZIU
	 ZqAgzBjMXN/Zz894Fvum4iXQsSSULBrJr4qsQ6cBJSrqNNhHPbcOJG1kMfxN21EvPA
	 sqgxFIswPtYHY534kGlVnGRSEPFKLW0EgbOs2qvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfKRRaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 12:30:12 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42137 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfKRRaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 12:30:12 -0500
Received: by mail-ot1-f67.google.com with SMTP id b16so15219626otk.9;
        Mon, 18 Nov 2019 09:30:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Sc1XalYtAcW8vcap9ciRIDbP58GTDwM0RBx4a9ILBAk=;
        b=Q24LOerBTVIZ3izhUfNtReKcJahX9OtaXw3DyE6NAO02kUcvip+MbGcsKMraboUVQA
         9o+nP5GxLHTPasvzKN01VL7YpZIP+FrPDLDuXICHz8hNmJohfMmr2SXEJNEwHb8fXe9d
         rHm5cjnum4qyNQV9uEIzGa1O+kW7+1XoB1Z676fgAZlnZ2TXYxTU9m1PZz0MYIpZRNSF
         t/s6jIa8nnfO5AaCV1ISpiI8QZZyexPWg9oTLpy4/68KVOAINKbaQILwHu8LDJe5KSrs
         Ievcgo3C3WE5LYeXAh450tChTaII0SYtG/xo99sG1KAwqYyJFRmkKMCCxCPxjD4faKzv
         nIvQ==
X-Gm-Message-State: APjAAAUKAnOj8blnftvPDzu3DpJbSdCUYN60KYZOF1NDVYr5QbaxyPHC
        VISKniwuEyVp+QJX1eRUnQ==
X-Google-Smtp-Source: APXvYqw1OlPnWi/HP4m9zDdcj7/ZWCmt8YCrZHzLncVfpzpiqABUT2k1SS9sfJz3gBNd0ZixL3aXsw==
X-Received: by 2002:a05:6830:1649:: with SMTP id h9mr288452otr.281.1574098210777;
        Mon, 18 Nov 2019 09:30:10 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y23sm6139512oih.17.2019.11.18.09.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 09:30:10 -0800 (PST)
Date:   Mon, 18 Nov 2019 11:30:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Rajan Vaja <rajan.vaja@xilinx.com>, dan.carpenter@oracle.com,
        gustavo@embeddedor.com, jolly.shah@xilinx.com,
        m.tretter@pengutronix.de, mark.rutland@arm.com,
        michal.simek@xilinx.com, mturquette@baylibre.com,
        nava.manne@xilinx.com, ravi.patel@xilinx.com,
        tejas.patel@xilinx.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/7] dt-bindings: clock: Add bindings for versal clock
 driver
Message-ID: <20191118173009.GA1865@bogus>
References: <1573564580-9006-1-git-send-email-rajan.vaja@xilinx.com>
 <1573564580-9006-2-git-send-email-rajan.vaja@xilinx.com>
 <20191112225147.7E59D21783@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112225147.7E59D21783@mail.kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 02:51:46PM -0800, Stephen Boyd wrote:
> Quoting Rajan Vaja (2019-11-12 05:16:14)
> > diff --git a/Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml b/Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml
> > new file mode 100644
> > index 0000000..da82f6a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml
> > @@ -0,0 +1,67 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/bindings/clock/xlnx,versal-clk.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Xilinx Versal clock controller
> > +
> > +maintainers:
> > +  - Michal Simek <michal.simek@xilinx.com>
> > +  - Jolly Shah <jolly.shah@xilinx.com>
> > +  - Rajan Vaja <rajan.vaja@xilinx.com>
> > +
> > +description: |
> > +  The clock controller is a h/w block of Xilinx versal clock tree. It reads
> 
> hardware instead of h/w
> 
> > +  required input clock frequencies from the devicetree and acts as clock
> > +  provider for all clock consumers of PS clocks. See clock_bindings.txt
> > +  for more information on the generic clock bindings.
> 
> Please drop this last sentence about clock_bindings.txt
> 
> > +
> > +properties:
> > +  compatible:
> > +    const: xlnx,versal-clk
> > +
> > +  "#clock-cells":
> > +    const: 1
> > +
> > +  clocks:
> > +    description: List of clock specifiers which are external input
> > +      clocks to the given clock controller.
> > +    minItems: 3
> > +    maxItems: 3

Can drop these. Implied by by 'items' list.

> > +    items:
> > +      - description: ref clk
> > +      - description: alternate ref clk
> > +      - description: pl alternate ref clk
> 
> What is "pl"? Can you clarify?
> 
> > +
> > +  clock-names:
> > +    minItems: 3
> > +    maxItems: 3

Same here.

> > +    items:
> > +      - const: ref_clk
> > +      - const: alt_ref_clk
> > +      - const: pl_alt_ref_clk

'_clk' is redundant.

> > +
> > +required:
> > +  - compatible
> > +  - "#clock-cells"
> > +  - clocks
> > +  - clock-names
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    firmware {
> > +      zynqmp_firmware: zynqmp-firmware {
> > +        compatible = "xlnx,zynqmp-firmware";
> > +        method = "smc";
> 
> Is there a way to say in the binding that this must be a child of a
> xlnx,zynqmp-firmware node? That would be ideal so we can constrain this
> to that location somehow.

Yes. Add the node name as a property to the f/w schema and reference 
($ref) this file and add 'select: false' to this one. The problem is the 
firmware binding is probably not yet a schema. Once it is a schema, this 
example will start failing because it's incomplete. For that reason, I 
prefer the examples in these cases (inc MFDs) in the base schema and not 
in the child node schemas.

> > +        versal_clk: clock-controller {
> > +          #clock-cells = <1>;
> > +          compatible = "xlnx,versal-clk";
> > +          clocks = <&ref_clk>, <&alt_ref_clk>, <&pl_alt_ref_clk>;
> > +          clock-names = "ref_clk", "alt_ref_clk", "pl_alt_ref_clk";
> > +        };
> > +      };
> > +    };
> > +...
> 
