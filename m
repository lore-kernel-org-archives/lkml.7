Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2763EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03E722CF7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567500329;
	bh=TfLcqVZI8L0vFKtsZxUpSt1VNzMBPAPesOSpXiHIeLw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SNYml3aNCwgKw/kSW9giowcxwCrX3wcOB5f8jTu3UwKJpPOJV9Pox+o6p0IsmQnx/
	 vyv2sPdzitqaVmT9L2WpqVjmnAjhYTJA3+/C/L8DosSyrM55Fs7a3aULRyV4CEnj6t
	 Qv9GgkCP9hu6jAwjyEY+Y58YAfm9pkv+ib4U7xu4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfICIp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 04:45:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:34756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727667AbfICIp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 04:45:27 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF497230F2;
        Tue,  3 Sep 2019 08:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567500326;
        bh=TfLcqVZI8L0vFKtsZxUpSt1VNzMBPAPesOSpXiHIeLw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YGDSdqYiACbjr7nYurhrPCyfi+SGa8k5xiy/AroGa84SfqqLM5CKNXbiOqDSUmWsH
         LwlzP+7IlDam5RrAgkvU4DRbv5YIIHsRuZEiQOMp9VOIrkNh49bOJEftCcYmwodQEb
         629XJZxqNUOEuztnd5zXo80cqCohKFQqCgRT6LyQ=
Received: by mail-qt1-f177.google.com with SMTP id o12so7192604qtf.3;
        Tue, 03 Sep 2019 01:45:25 -0700 (PDT)
X-Gm-Message-State: APjAAAUImicItQGNgkPkyTXaXrWTeF6Tqz6tB4r2DrpX7bYVEoEAA6x/
        0ESWnhmn+5kfGICIujqrLiTBkykEWHzgOViJeg==
X-Google-Smtp-Source: APXvYqyk/lAUl1vjxNsNPD2AOpSFtOu+yA00RV1lmAkNqJ0wvqQzPOIKEBMNaM4Hpk/TT1QQ9rfBnaB4mWp+uNUkc6o=
X-Received: by 2002:a05:6214:10e1:: with SMTP id q1mr21183926qvt.148.1567500325065;
 Tue, 03 Sep 2019 01:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190903080336.32288-1-philippe.schenker@toradex.com> <20190903080336.32288-4-philippe.schenker@toradex.com>
In-Reply-To: <20190903080336.32288-4-philippe.schenker@toradex.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 3 Sep 2019 09:45:13 +0100
X-Gmail-Original-Message-ID: <CAL_JsqLnqZ80soGVMvZjAMZvu+K=ebDUz2bM_ZodPp7YRvUnDw@mail.gmail.com>
Message-ID: <CAL_JsqLnqZ80soGVMvZjAMZvu+K=ebDUz2bM_ZodPp7YRvUnDw@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: regulator: add regulator-fixed-clock binding
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Luka Pivk <luka.pivk@toradex.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 3, 2019 at 9:03 AM Philippe Schenker
<philippe.schenker@toradex.com> wrote:
>
> This adds the documentation to the compatible regulator-fixed-clock

Please explain what that is in this patch.

>
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
>
> ---
>
>  .../bindings/regulator/fixed-regulator.yaml    | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
> index a650b457085d..5fd081e80b43 100644
> --- a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
> +++ b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
> @@ -19,9 +19,19 @@ description:
>  allOf:
>    - $ref: "regulator.yaml#"
>
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        const: regulator-fixed-clock
> +  required:
> +    - clocks

You don't need this.

If you add a new compatible, then this should probably be a new schema
doc. Is the 'gpio' property valid in this case as if a clock is the
enable, can you also have a gpio enable? That said, it seems like the
new compatible is only for validating the DT in the driver. You could
just use a clock if present and default to current behavior if not.
It's not the kernel's job to validate DTs.

>
>  properties:
>    compatible:
> -    const: regulator-fixed
> +    items:
> +      - const: regulator-fixed
> +      - const: regulator-fixed-clock

This says you must have 'compatible = "regulator-fixed",
"regulator-fixed-clock";'.

What you want is:

enum:
  - regulator-fixed
  - regulator-fixed-clock

>    regulator-name: true
>
> @@ -29,6 +39,12 @@ properties:
>      description: gpio to use for enable control
>      maxItems: 1
>
> +  clocks:
> +    description:
> +      clock to use for enable control. This binding is only available if
> +      the compatible is chosen to regulator-fixed-clock. The clock binding
> +      is mandatory if compatible is chosen to regulator-fixed-clock.

Need to define how many clocks (maxItems: 1).

> +
>    startup-delay-us:
>      description: startup time in microseconds
>      $ref: /schemas/types.yaml#/definitions/uint32
> --
> 2.23.0
>
