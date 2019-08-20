Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C8FC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 16:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 035FC2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 16:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566316866;
	bh=nV5YN+hmMYKRrONNn5xNuCElpNdG1gIN8RzDCyYXJ+c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SQ7jVFma4etRmmZDmC8NtDux+80k+XM58a8y8/hCtS198xi3Zpa/KsuB8IPjlzO3h
	 dulQj0xgUGaSP2eI8IMFfrl4NxnhWHr4buG6d0hHIn+7gA4ZCfATDge+SLsr3XqogT
	 vCz7fJChjX9MzZSZTLoCK1LtWmdliePfCNj67Nyc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbfHTQBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 12:01:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbfHTQBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 12:01:04 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAC572070B;
        Tue, 20 Aug 2019 16:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566316863;
        bh=nV5YN+hmMYKRrONNn5xNuCElpNdG1gIN8RzDCyYXJ+c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p4ggRT+LXmFWLmCmW75AlCneVYEg4PSEY3RLFQ2CBVr5Olub9Fo3MtE+90qPcaNUT
         S0aIj+QEAnVigb1RCG2PtNyCIjol2FilotWn7w9RIjAAdDlcfSwY8rPBOFHrntQHDQ
         hw7CqMEz2DUQXgrGESH8AQSle1APxJFjuU7LNR+4=
Received: by mail-qt1-f170.google.com with SMTP id t12so6601176qtp.9;
        Tue, 20 Aug 2019 09:01:02 -0700 (PDT)
X-Gm-Message-State: APjAAAVav/4tGMkn3Dct1O/9fxz8/jaPVKIjULYVLZ7qb7r5VLjK59n0
        hpa1X8cReNki7gFRJzr/LyNRbIzv6o5G1VCH0g==
X-Google-Smtp-Source: APXvYqz2zveglNg8JwmfSLq5hdaazZoQ5IFKBOJiEArUfGI9j75aOKNBEA55KOZ26U75HZiyOnkCY/yfaMokX0z7Qqg=
X-Received: by 2002:ad4:4301:: with SMTP id c1mr12131156qvs.138.1566316862075;
 Tue, 20 Aug 2019 09:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1566288689.git.rahul.tanwar@linux.intel.com> <fa6b20015dc6bfe247e1b2a07bdc5c727595a04b.1566288689.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <fa6b20015dc6bfe247e1b2a07bdc5c727595a04b.1566288689.git.rahul.tanwar@linux.intel.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 20 Aug 2019 11:00:50 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJK=TFsAt4kegGs2ymnWpY4tuDXNJF0RFpvZJmuPHJMYA@mail.gmail.com>
Message-ID: <CAL_JsqJK=TFsAt4kegGs2ymnWpY4tuDXNJF0RFpvZJmuPHJMYA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: lantiq: Update for new SoC
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        qi-ming.wu@intel.com, cheol.yong.kim@intel.com,
        rahul.tanwar@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 3:29 AM Rahul Tanwar
<rahul.tanwar@linux.intel.com> wrote:
>
> Intel Lightning Mountain(LGM) SoC reuses Lantiq ASC serial controller IP.
> Update the dt bindings to support LGM as well.
>
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---
>  .../devicetree/bindings/serial/lantiq_asc.yaml          | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/serial/lantiq_asc.yaml b/Documentation/devicetree/bindings/serial/lantiq_asc.yaml
> index 54b90490f4fb..92807b59b024 100644
> --- a/Documentation/devicetree/bindings/serial/lantiq_asc.yaml
> +++ b/Documentation/devicetree/bindings/serial/lantiq_asc.yaml
> @@ -17,6 +17,7 @@ properties:
>      oneOf:
>        items:
>          - const: lantiq,asc
> +        - const: intel,lgm-asc

Better expressed as:

compatible:
  enum:
    - intel,lgm-asc
    - lantiq,asc

>
>    reg:
>      maxItems: 1
> @@ -28,6 +29,12 @@ properties:
>        - description: tx or combined interrupt
>        - description: rx interrupt
>        - description: err interrupt
> +    description:
> +      For lantiq,asc compatible, it supports 3 separate
> +      interrupts for tx rx & err. Whereas, for intel,lgm-asc
> +      compatible, it supports combined single interrupt for
> +      all of tx, rx & err interrupts.

This can be expressed with an if/then schema. There's some examples in
the tree how to do that.

> +
>
>    clocks:
>      description:
> @@ -67,4 +74,14 @@ examples:
>              interrupts = <112 113 114>;
>      };
>
> +  - |
> +    asc0: serial@e0a00000 {
> +            compatible = "intel,lgm-asc";
> +            reg = <0xe0a00000 0x1000>;
> +            interrupt-parent = <&ioapic1>;
> +            interrupts = <128 1>;
> +            clocks = <&cgu0 LGM_CLK_NOC4>, <&cgu0 LGM_GCLK_ASC0>;
> +            clock-names = "freq", "asc";
> +    };
> +
>  ...
> --
> 2.11.0
>
