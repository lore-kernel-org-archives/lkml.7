Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAC4C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 03:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B23B20879
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 03:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SNRqwJ7E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbfEQDyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 23:54:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39623 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbfEQDyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 23:54:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id w22so2605837pgi.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 20:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aSWv/3E5xONuctyVCVpI+09Uko/UnXB8canipxV/tCA=;
        b=SNRqwJ7EZ+/CWo5k9NfHmkbROXRuPjzLmaJu4Rvhsi2l9ucWEJJyifU4TP5Ztq5eFf
         6yKDtee7U8Gt3U1ALOf2SaDQI2wHmrlXYvApMqK8XlX7Dap63oqg3JaVwGKD3YMSmDq6
         +0WcehHzxLN5r0deh1CF8RwD0p1D+2oHPRmQM0CJRfogIubkEe5u+1cLLMtL6erU83Oy
         ZBbLTl6s8SiHgA09T5XdzCdIm2uarVZjmqXuWvZZqFHp5VHApjuV5t8QPaKMJPgfz83E
         GHMtBBOyWce4MkW8aJ2mY29Kmb6Lm7Cs46J206H6T+oVs14QAKRL43wtfkxVlMoqS/n4
         L+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aSWv/3E5xONuctyVCVpI+09Uko/UnXB8canipxV/tCA=;
        b=GqewePwu4K7TY+W5Rz8sX3t24C4NyaipcrKrsoBfPK3m+LV5RoDuGl3xkE0c/KtNUd
         sPOcmvKpT4Lb66O7uWX4GqAhjq3mtv+4CwHh//+sfmUjKncRSb357+r8mBt2hKQdW4AZ
         fu3axkDexzK8zXe1SOv0VJ1W5VsoUcSsHqfBwM9w3ziXBpdx4sZHN9ZGd9iOq44V2gY5
         6KaawSpg/mQrixlKtrZiCUet/i22r8muJu/buh5ELbyjfurrCHd+df+SE9uSWPXTaI66
         1+wzd11Dz5QBhRxAmwv1nNG65vKxPfn/PnBabsM2o84IEU25bEfwJMeokdvV/fN8cdeR
         eKAg==
X-Gm-Message-State: APjAAAUaGejKq2vi5Nm7+VCWXTJDVTypbyiCcN5rnh3vZeULulpEvZXJ
        JuNZqKV/3IBi8jFDDDYgNyFH6y+kSA==
X-Google-Smtp-Source: APXvYqzoHXX1P5yhzflXLHPYow3wkn9VYYg/Butit6e08vzoVnsngfCu3i4rgBTsIxwoAWOQnOO4yg==
X-Received: by 2002:a62:5f42:: with SMTP id t63mr15660001pfb.83.1558065288251;
        Thu, 16 May 2019 20:54:48 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6390:5018:b478:7b0e:49e:16a3])
        by smtp.gmail.com with ESMTPSA id s12sm12152355pfd.152.2019.05.16.20.54.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 20:54:47 -0700 (PDT)
Date:   Fri, 17 May 2019 09:24:40 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, loic.pallardy@st.com
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: stm32: Document Avenger96
 devicetree binding
Message-ID: <20190517035440.GA12863@Mani-XPS-13-9360>
References: <20190506100534.24145-1-manivannan.sadhasivam@linaro.org>
 <20190506100534.24145-2-manivannan.sadhasivam@linaro.org>
 <20190513180246.GA8487@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513180246.GA8487@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, May 13, 2019 at 01:02:46PM -0500, Rob Herring wrote:
> On Mon, May 06, 2019 at 03:35:32PM +0530, Manivannan Sadhasivam wrote:
> > Document devicetree binding for Avenger96 board.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/arm/stm32/stm32.txt | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.txt b/Documentation/devicetree/bindings/arm/stm32/stm32.txt
> > index 6808ed9ddfd5..eba363a4b514 100644
> > --- a/Documentation/devicetree/bindings/arm/stm32/stm32.txt
> > +++ b/Documentation/devicetree/bindings/arm/stm32/stm32.txt
> > @@ -8,3 +8,9 @@ using one of the following compatible strings:
> >    st,stm32f746
> >    st,stm32h743
> >    st,stm32mp157
> > +
> > +Boards:
> > +
> > +Root node property compatible must contain one of below depending on board:
> > +
> > + - Avenger96: "arrow,stm32mp157a-avenger96"
> 
> With which SoC compatible?
> 

I referred some other platform bindings (non YAML) and they don't
mention the SoC compatible with boards. Shall I just put it like below?

Avenger96: "arrow,stm32mp157a-avenger96", "st,stm32mp157"

Thanks,
Mani

Thanks,
Mani

> > -- 
> > 2.17.1
> > 
