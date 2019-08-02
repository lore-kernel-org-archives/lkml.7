Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFA3C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 06:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB64205F4
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 06:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="cTOZX6Px"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388617AbfHBGbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 02:31:35 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40623 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729432AbfHBGbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 02:31:35 -0400
Received: by mail-qk1-f196.google.com with SMTP id s145so53986492qke.7;
        Thu, 01 Aug 2019 23:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cU53kLwgvXwi7YmNfuNjyU7Fjnwocbh+C31lAE2HzLg=;
        b=cTOZX6PxGxXFImrywl7zCwC/CJrBlmNZKDI4Dd7SOu2wZvajdyC1nqkKNmdH1Fetdg
         a4Vu4mfrdmF4K7QkrHUYRJ4eTrR51A2uPiNtwIo04a7PJ+o9If/oNwd0JNBA+5Cr99rC
         JTmZnW2X6Xtt1WrTb7RY3VbfHgAKMXbbbRAjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cU53kLwgvXwi7YmNfuNjyU7Fjnwocbh+C31lAE2HzLg=;
        b=afTUSpMpbXmsh4IcSM6dEIMdrYm27R8fGeVpiXcMRWl5emMyb/zHaHuzg24wk2LDab
         Ege/015gs98u8DjFrc5retpK77hLun7rgxaE1iB5WlpkyVJCJBanXOPdWlybev1tudVU
         0VwJYEy5mgrp/CqI7pfc9gb0Bg1u2Qz4rG+/tgoKVCYQZIhp7eVsTDyy39gGU+qEDF2l
         WhDaHCmwto0232o1SRZI6AJ1rYQAS2Tm3D/vSrlaQEyePPHd02MHZfFNFzPsj2KaAbnu
         yYO6vLUHlbFyNDoxOHEWVG+9QoPzD6w3PjZPbqqsAzbPwLbIQNpnIrLt4XPpOBJeDEsU
         BQUg==
X-Gm-Message-State: APjAAAWIszyL7nT1qsNbGFLccvwZ9vlSBKWmMrdjjCj6beagS5SVoCDH
        Eh0WHxcZqKRsBKcIZiw8Iljh61CyqzjiYPW2VoA=
X-Google-Smtp-Source: APXvYqycpdU0Ot7OSszfb9qsAobDtrU0SbtRJPSehpAqubHj0m1A4ozadPuePm+cp+fofQLhkzNkPzk0PDDfC3RngLc=
X-Received: by 2002:a37:a1d6:: with SMTP id k205mr88446327qke.171.1564727493972;
 Thu, 01 Aug 2019 23:31:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190723002052.2878847-1-vijaykhemka@fb.com> <CAL_Jsq+uAjK6+xzkyOhcH96tZuqv7i6Nz5_nhUQkZ2adt2gutA@mail.gmail.com>
 <CAL_Jsq+Kw0TFW_v54Y2QHcChqpNDYhFyCSO5Cj-be9yLSCq-Pw@mail.gmail.com> <F7BAC53E-925E-4FA4-815D-ACB82DF8D240@fb.com>
In-Reply-To: <F7BAC53E-925E-4FA4-815D-ACB82DF8D240@fb.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 2 Aug 2019 06:31:22 +0000
Message-ID: <CACPK8XehEoakQxvQhC1cU5tvZaVbLOARtZ4xc6dD8sx9WDiPuA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Add pxe1610 as a trivial device
To:     Vijay Khemka <vijaykhemka@fb.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Kosina <trivial@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Patrick Venture <venture@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Anson Huang <anson.huang@nxp.com>,
        Jeremy Gebben <jgebben@sweptlaser.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        Sai Dasari <sdasari@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pxe1610 as a trivial device



On Tue, 23 Jul 2019 at 17:14, Vijay Khemka <vijaykhemka@fb.com> wrote:
>
> =EF=BB=BFOn 7/23/19, 7:53 AM, "Rob Herring" <robh+dt@kernel.org> wrote:
>
>     On Tue, Jul 23, 2019 at 8:50 AM Rob Herring <robh+dt@kernel.org> wrot=
e:
>     >
>     > On Mon, Jul 22, 2019 at 6:46 PM Vijay Khemka <vijaykhemka@fb.com> w=
rote:
>     > >
>     > > The pxe1610 is a voltage regulator from Infineon. It also support=
s
>     > > other VRs pxe1110 and pxm1310 from Infineon.
>
>     What happened to the other compatibles? S/w doesn't need to know the
>     differences?
> As far as driver is concerned, it doesn't need to know differences.

You have these three IDs in the driver:

 pxm1310
 pxm1310
 pxe1610

So all three could be listed in the documentation?

Rob, is this what you wanted Vijay to do?
