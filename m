Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0EEC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 20:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C09620862
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 20:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568751234;
	bh=QD2jrpkdpFVtu6RbulHBwnzGJdhalt5ZYR1fRIHqmBo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=w6ZWR5rTfXzC5nRWudyFkN8Y9p9rHCKK+ZYPe55qn0zV4Sm5ukP/GVGyAUjHd16R6
	 /AU4vq7h0ztd8zbBkFginaTGLEQopjwC2UUyNdq1q7kn+LRf/n+DYykdioqheIwPsx
	 Afe6i+wwslltZsNo6QNHy/jzn6Q3AgySNeFCO0TQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbfIQUNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 16:13:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:38924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfIQUNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 16:13:53 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22D15218AC;
        Tue, 17 Sep 2019 20:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568751232;
        bh=QD2jrpkdpFVtu6RbulHBwnzGJdhalt5ZYR1fRIHqmBo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GQtzUvF/iUq9O0VBCtpM49FGGmvbDpy3HT3fUXArHiSEwfMIGYiak60u1i5YtvBIN
         Wnr4Rmhq5/6Pb4Osl6WBs+vKBrBUgcWf52PNPYHL+q4wYSCxju85jOZ9iZUACGClz5
         HyNR+/GdRUD+tri5AkVDcpTfa8cScwFEh7gpVTMY=
Received: by mail-qt1-f177.google.com with SMTP id c21so5994535qtj.12;
        Tue, 17 Sep 2019 13:13:52 -0700 (PDT)
X-Gm-Message-State: APjAAAWxHPMpbqVcNZd+vcCrHZdhs2M+/BHTQlZSuYpoIho6GwlYsEny
        tTjKegTRCclqvL+X38VxBRncgGmYbWmI9A48iA==
X-Google-Smtp-Source: APXvYqwCu+ccCReyAWvySFIlMkLhOSLkP4JIuAvJCOo/l7X0GB8Y4G5qVJE3jnEww9nOwYBA9RPLuGQNrR2JTMtRiiU=
X-Received: by 2002:ac8:100d:: with SMTP id z13mr700774qti.224.1568751231298;
 Tue, 17 Sep 2019 13:13:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190910062103.39641-1-philippe.schenker@toradex.com> <20190910062103.39641-4-philippe.schenker@toradex.com>
In-Reply-To: <20190910062103.39641-4-philippe.schenker@toradex.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 17 Sep 2019 15:13:39 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLyawEariYuaHJ+Lyt1DhJe9fdAE88ANrhHAokWJhUOdw@mail.gmail.com>
Message-ID: <CAL_JsqLyawEariYuaHJ+Lyt1DhJe9fdAE88ANrhHAokWJhUOdw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: regulator: add regulator-fixed-clock binding
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

On Tue, Sep 10, 2019 at 1:21 AM Philippe Schenker
<philippe.schenker@toradex.com> wrote:
>
> This adds the documentation to the compatible regulator-fixed-clock.
> This binding is a special binding of regulator-fixed and adds the
> ability to add a clock to regulator-fixed, so the regulator can be
> enabled and disabled with that clock. If the special compatible
> regulator-fixed-clock is used it is mandatory to supply a clock.
>
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
>
> ---
>
> Changes in v2:
> - Change select: to if:
> - Change items: to enum:
> - Defined how many clocks should be given
>
>  .../bindings/regulator/fixed-regulator.yaml   | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
> index a650b457085d..a78150c47aa2 100644
> --- a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
> +++ b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
> @@ -19,9 +19,19 @@ description:
>  allOf:
>    - $ref: "regulator.yaml#"
>
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: regulator-fixed-clock
> +  required:
> +    - clocks
> +
>  properties:
>    compatible:
> -    const: regulator-fixed
> +    enum:
> +      - const: regulator-fixed
> +      - const: regulator-fixed-clock

'make dt_binding_check' is failing. You need to drop 'const: '. Please
send a patch to fix this.

Rob
