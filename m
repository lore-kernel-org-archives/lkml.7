Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F4FC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 14:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B1B1218F0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 14:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563893433;
	bh=NWY3jIvmqwRnEzth0vMKEw2NgpGjrUlBjW0KeFbTm5o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=V6lcAQTd1Hv6cUpevMybF8pZRHQYY7U+MLAApbRFycuCYswYpg69IB1BMlaRAKNzD
	 Aja5ZB/PRbdxT+YTpdIjtaxSN1bnxL2cL3+WnTX3E3tCdi8W2A7qfUjC/Q27qv76oG
	 mkgk3RdbV5eP973MG18Rq2CLduJXtJhuLzExlRqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390749AbfGWOuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 10:50:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732532AbfGWOuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 10:50:32 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 152C4229E9;
        Tue, 23 Jul 2019 14:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563893431;
        bh=NWY3jIvmqwRnEzth0vMKEw2NgpGjrUlBjW0KeFbTm5o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IDFS8+WNAeGLOnDIvNmXlG7K9oKwlVq7Z+RmdL9ze2zCJFUZz5fvjP3elsU3XWct6
         tVyeZxrFlS7zl0MIWuIyAUvMa0HUuQ4I5w6wcCdPzbRvoQe13OtzfjBPi+FTsf6Yem
         y09h8D/vh1Vta4RvFOm8i+sZwmHxidcnx17LNy6o=
Received: by mail-qt1-f178.google.com with SMTP id a15so42176272qtn.7;
        Tue, 23 Jul 2019 07:50:31 -0700 (PDT)
X-Gm-Message-State: APjAAAXsk/6k55/dKPMWpftR0wrVGGm0GrWNPUhEpx0M9SLt12HKspiR
        795RBP0Sgw7iaOhFkr+KdPAJVLkWevMU/eUX/g==
X-Google-Smtp-Source: APXvYqwBju742Uv1oJ/wgPhfyE4ujnFUKj5HTZyO6Z9MYKgunw2Xd7cpXwgfdumZPHvlQwtgggvcrJUV0jigeCY0Eso=
X-Received: by 2002:a0c:b786:: with SMTP id l6mr55369242qve.148.1563893430142;
 Tue, 23 Jul 2019 07:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190723002052.2878847-1-vijaykhemka@fb.com>
In-Reply-To: <20190723002052.2878847-1-vijaykhemka@fb.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 23 Jul 2019 08:50:18 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+uAjK6+xzkyOhcH96tZuqv7i6Nz5_nhUQkZ2adt2gutA@mail.gmail.com>
Message-ID: <CAL_Jsq+uAjK6+xzkyOhcH96tZuqv7i6Nz5_nhUQkZ2adt2gutA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Add pxe1610 as a trivial device
To:     Vijay Khemka <vijaykhemka@fb.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Jiri Kosina <trivial@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Patrick Venture <venture@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Anson Huang <anson.huang@nxp.com>,
        Jeremy Gebben <jgebben@sweptlaser.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>,
        Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org,
        sdasari@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 6:46 PM Vijay Khemka <vijaykhemka@fb.com> wrote:
>
> The pxe1610 is a voltage regulator from Infineon. It also supports
> other VRs pxe1110 and pxm1310 from Infineon.
>
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 2e742d399e87..1be648828a31 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -99,6 +99,8 @@ properties:
>              # Infineon IR38064 Voltage Regulator
>            - infineon,ir38064
>              # Infineon SLB9635 (Soft-) I2C TPM (old protocol, max 100khz)
> +          - infineon,pxe1610
> +            # Infineon PXE1610, PXE1110 and PXM1310 Voltage Regulators

The comment goes above the entry.

>            - infineon,slb9635tt
>              # Infineon SLB9645 I2C TPM (new protocol, max 400khz)
>            - infineon,slb9645tt
> --
> 2.17.1
>
