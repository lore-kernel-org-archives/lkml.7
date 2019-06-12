Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D1FC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D37C02063F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ev+kVdsE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408456AbfFLHrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 03:47:31 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46502 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731513AbfFLHra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 03:47:30 -0400
Received: by mail-pl1-f196.google.com with SMTP id e5so6272654pls.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 00:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RTEvowjVOZ1tt6yW3tt8znN/f0k1q7mGY13SshYdHu0=;
        b=ev+kVdsEuZay+u/9fs+NWPIBWNJyQcyQ6Ur5EFF5tKrCyVYcgNizj2gLPu5bxid0Hz
         tPLF7jTePnup5KqcxVjCHful3j9gTdvqX+Qriam8LVoek6qX29ezGElZwt6zYBEcb2SN
         Q37YLJtAP03GlRDoXXFwr55GafpU0rlhDZGhQcl3SWX6gJA9KQpqiKwUOmlIGxRiYosn
         dr9HK/RZVUvizdrr5OpBpHn4ChblEUXYJHENQsSph+PYnec44Z2CFtv0zFRptfx7TiLd
         S7/PaXMj+7j/nP3bEQCPT+x48srxZ2LXHIsDlMch7Ni6dFdgIfKRdUiOcsa/OwOyp9cP
         OrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RTEvowjVOZ1tt6yW3tt8znN/f0k1q7mGY13SshYdHu0=;
        b=GC9KQf/+BNnCC7GI7GFJ0mwTTZeyLs9EBLAuOg1Fb5WsVmFDyGZEcwioZKer/TKdW9
         20qB31tviGPIF01NW+8VikZVbyhYYVncBlmoioCFcFr7pIYm2qu6IFry4lqyCvcg8/8T
         oSt5jTVzl8pN943CCPwswb2SIw7L8qM4/zlLbbWIZksTM9FVsYC05OCScyl53dWZ/xyv
         1CPjSbPoI2jIrMwtA1NHPtzmBtrt3oBPdgOJ4C4g3KLBwQ34J1RI8A5HxD+le4zK/T3i
         j6XMaJBElMBJ04H0dLYoF2h3tGEPh0W0PICM1WHkZv7qYASiDuQE+z+RfvQBYlrI+SAs
         TNqw==
X-Gm-Message-State: APjAAAUDlTQB7Xcw5iyJwYn2x2d4NmSfQpZuqWGe0FRLKC2oAts95ETI
        pRK3Vw5lx/jJnzoLe62m0JXr
X-Google-Smtp-Source: APXvYqxdFNwHHUupAjw3XvuIJ/ZVdpM65R2uvHP1jCdfRej7cyXAdncrWoLq1ppn8UtyJYh5XGiOKw==
X-Received: by 2002:a17:902:968b:: with SMTP id n11mr43028455plp.120.1560325649660;
        Wed, 12 Jun 2019 00:47:29 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:894:d456:15b5:9ca9:e3ec:c06a])
        by smtp.gmail.com with ESMTPSA id v5sm16896474pfm.22.2019.06.12.00.47.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 00:47:28 -0700 (PDT)
Date:   Wed, 12 Jun 2019 13:17:20 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        loic pallardy <loic.pallardy@st.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: arm: stm32: Convert STM32 SoC
 bindings to DT schema
Message-ID: <20190612074720.GA5513@Mani-XPS-13-9360>
References: <20190531063849.26142-1-manivannan.sadhasivam@linaro.org>
 <20190531063849.26142-3-manivannan.sadhasivam@linaro.org>
 <CAL_Jsq+N7NA7m+dp+zpwFeZLM6B+OwRrqZdzKkJp2TRWi_e3Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+N7NA7m+dp+zpwFeZLM6B+OwRrqZdzKkJp2TRWi_e3Mw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, Jun 10, 2019 at 03:57:43PM -0600, Rob Herring wrote:
> On Fri, May 31, 2019 at 12:39 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > This commit converts STM32 SoC bindings to DT schema using jsonschema.
> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  .../devicetree/bindings/arm/stm32/stm32.yaml  | 29 +++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/stm32/stm32.yaml
> 
> Converting implies removal of something. The schema looks fine though.
> 

Ah, sorry. I forgot to delete the .txt file. Will do it in next revision.

Thanks,
Mani

> >
> > diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
> > new file mode 100644
> > index 000000000000..f53dc0f2d7b3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
> > @@ -0,0 +1,29 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/stm32/stm32.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: STMicroelectronics STM32 Platforms Device Tree Bindings
> > +
> > +maintainers:
> > +  - Alexandre Torgue <alexandre.torgue@st.com>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - const: st,stm32f429
> > +
> > +      - items:
> > +          - const: st,stm32f469
> > +
> > +      - items:
> > +          - const: st,stm32f746
> > +
> > +      - items:
> > +          - const: st,stm32h743
> > +
> > +      - items:
> > +          - const: st,stm32mp157
> > +...
> > --
> > 2.17.1
> >
