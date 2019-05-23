Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013D6C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 14:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85AC206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 14:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rP6Xyj/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbfEWOop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 10:44:45 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38373 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730709AbfEWOon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 10:44:43 -0400
Received: by mail-pl1-f196.google.com with SMTP id f97so2860085plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 07:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2Ky1NhTh6Sjvjan+qNl8ZXCfOCQ4Wh0D7lNZmX1Rk4s=;
        b=rP6Xyj/q6gZKJRtGHb4s/nLwR57MhxbnQuw2lmcL3adCpoU5QQdXse548sY7W/zuGp
         g3z9l8KWVy7T+jhAfzH4EGz7LVMEhKk/jgOsuOOZH6LVaBZp6ItlLieciyelHwkQi9vq
         cyPa0I+iCP/5H0+wSOBK/+c68CkvPwr3dBsB3qkom9Zz39aMQ4lSgMFjNYrwKAk72L59
         Er36+iRGksE9wtmaMGeW2U70CWZsgcLznWLbkqm42rTFioB6CT7z7+7rjDHBKi3I3NyA
         rWeniayWC+nTUj/whE5g/LNk+Pqo2fUqzuNWP72MxRJjvYw2MjwFBpjGVQAA+vlkllFN
         8k2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2Ky1NhTh6Sjvjan+qNl8ZXCfOCQ4Wh0D7lNZmX1Rk4s=;
        b=qz2Lin7BsyoYR1pVFcQge8GF5b5LZt5xNAxd3JjftOgMBf3fJ9wk0hr+hjG+SbhgVq
         VqmMM2CpJyzE4Ii8Ew9Lfhye13QF4UEEdJV7q7sh0eSxLODl8SqiRIZtc5lPoPbAew4e
         FlXK89WaSTUvscr3kkDNjVvIeCSB+DdCWupnblPRrRKrWTbV2C3/rqWyEw3gcBa5s/fA
         L337PaSK+Jhj6euNE0iMEEPldatIrSyt+t6wIVvS2RPCcY8g80tAuLYVRtWahh5v8I9i
         ElkZIcoo3nb/FFZOCIxGUq7+sdmmS1lG3EFXsssVbH9Eo2WnnFQ3gYQGA0q343FMpo/s
         kZHA==
X-Gm-Message-State: APjAAAUqBPSCk12j39aTltli/+oAzVxo0gTG9d9PD94T4JICZ240jPt5
        mXlmpSsn5/X8jAkybofok8r89w==
X-Google-Smtp-Source: APXvYqzchItDvd9Ubge8eLDuQHoQswRIRqB8pGOfnTf4Aha7Nu59oyxPz1vEnqnJxz47wckbg4GLYQ==
X-Received: by 2002:a17:902:2aab:: with SMTP id j40mr75540236plb.238.1558622682710;
        Thu, 23 May 2019 07:44:42 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c129sm39219824pfg.178.2019.05.23.07.44.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 07:44:41 -0700 (PDT)
Date:   Thu, 23 May 2019 07:45:08 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: apr: Don't use reg for domain id
Message-ID: <20190523144508.GH2085@tuxbook-pro>
References: <20190522015342.29501-1-bjorn.andersson@linaro.org>
 <e7046725-578d-8854-872b-a7837d0fc20a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7046725-578d-8854-872b-a7837d0fc20a@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 23 May 07:38 PDT 2019, Srinivas Kandagatla wrote:

> 
> 
> On 22/05/2019 02:53, Bjorn Andersson wrote:
> > The reg property represents the address and size on the bus that a
> > device lives, but for APR the parent is a rpmsg bus, which does not have
> > numerical addresses. Simply defining #address/#size-cells to 1 and 0,
> > respectively, to silence the compiler is not an appropriate solution.
> > 
> I agree.
> 
> > Replace the use of "reg" with an APR specific property.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> Can you also change the example too.
> 

Of course, sorry for missing that.

> other than that am okay with the change.
> 
> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 

Thanks,
Bjorn

> --srini
> > 
> > The APR device was recently added to msm8996.dtsi, but this is still
> > depending on working SMMU to provide functional audio support.
> > 
> >   Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt | 2 +-
> >   drivers/soc/qcom/apr.c                                  | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
> > index bcc612cc7423..38d3c06abc41 100644
> > --- a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
> > +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
> > @@ -9,7 +9,7 @@ used for audio/voice services on the QDSP.
> >   	Value type: <stringlist>
> >   	Definition: must be "qcom,apr-v<VERSION-NUMBER>", example "qcom,apr-v2"
> > -- reg
> > +- qcom,apr-domain
> >   	Usage: required
> >   	Value type: <u32>
> >   	Definition: Destination processor ID.
> > diff --git a/drivers/soc/qcom/apr.c b/drivers/soc/qcom/apr.c
> > index 74f8b9607daa..b83d71b2e0a4 100644
> > --- a/drivers/soc/qcom/apr.c
> > +++ b/drivers/soc/qcom/apr.c
> > @@ -276,7 +276,7 @@ static int apr_probe(struct rpmsg_device *rpdev)
> >   	if (!apr)
> >   		return -ENOMEM;
> > -	ret = of_property_read_u32(dev->of_node, "reg", &apr->dest_domain_id);
> > +	ret = of_property_read_u32(dev->of_node, "qcom,apr-domain", &apr->dest_domain_id);
> >   	if (ret) {
> >   		dev_err(dev, "APR Domain ID not specified in DT\n");
> >   		return ret;
> > 
