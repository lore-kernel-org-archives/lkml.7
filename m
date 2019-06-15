Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96635C31E47
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 07:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA322184C
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 07:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BQljxYEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfFOHGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 03:06:44 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39301 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfFOHGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 03:06:44 -0400
Received: by mail-pl1-f194.google.com with SMTP id b7so1917662pls.6
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2019 00:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nxfStrkoZ2f5uEaotGyNxBrt2oeXGj2yoJPwauA88HM=;
        b=BQljxYEsUcWx6IMUJWs3lt9f4P2pNVaKin9m6xUqR9H9LNqOdMLDtclGLYX11b74io
         /xFEGeBJUthHOtnhoFu6naZs+pQbH2gprvEvYfgRxH1hJLMfXIrliNCKf2aBfrL4enuO
         7Jv7couBfgBKbghqyfQquAUp2sor9PX1xt9xuNXyiM07hJTt6cWmghGQgeWoq8ZpGQf8
         FpuXUGUnhT9PI2i6c89dZ6NAn/sNJU2eMwtAcXD7mNiXaJfr/8yTjQfGJExcfmCscggp
         pdz6hm4bizPtTC3WfYTyvqGNMdfT2/aNGpADPBNdFn6bwXUK/xdRBDhURgEaIVYh2244
         5UFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nxfStrkoZ2f5uEaotGyNxBrt2oeXGj2yoJPwauA88HM=;
        b=mCj84jtoHr/nrB6NuGrJ3SU0Ex1EEHJBhKBr/f9zidKKaBvia5MuGH6fIWRRV84/Ze
         4d3+Hk0NDsa9lptiYjpWA0C7DHiSFQeN5CyqIqKxbJFCXrbC+AEmCeJCyiUp35i8qYWD
         FewY7NL71diSLRubKCCe2TyJQPr5iAuLHqSTSWz6+5/SKkb57kuvWe+l6h8Walq8M+yD
         +TjeVswencaD0W91h4RM1mh92G5Gwou+e2xIkoBxRc/Hx13PeUbmsJQxCLGFkG6DSyM6
         ecOD2elXzZaD6W/CbvJE3lI0+rR36T6wNPrmq6w/3M4fqUMaU8mwPvICugqivJiMYof8
         lUDg==
X-Gm-Message-State: APjAAAWV4+pOzrjQyzOQYYHx2Df1MkMPqndZyep8scf4Sb0F5anR/lt2
        Km+knXiaiu5MIAb9lNEK7/IBmA==
X-Google-Smtp-Source: APXvYqwRyuDbMyXOtqz9wjhQN4oYSmEs4Kbc4rLpIiSEpz/Xzcy8mvo3twNZXhAZt/2ICZStoevA0w==
X-Received: by 2002:a17:902:29a7:: with SMTP id h36mr45551825plb.158.1560582403432;
        Sat, 15 Jun 2019 00:06:43 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p2sm7963869pfb.118.2019.06.15.00.06.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 15 Jun 2019 00:06:42 -0700 (PDT)
Date:   Sat, 15 Jun 2019 00:07:29 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] soc: qcom: apr: Don't use reg for domain id
Message-ID: <20190615070729.GB31088@tuxbook-pro>
References: <20190523150153.13136-1-bjorn.andersson@linaro.org>
 <20190614165724.GA3083@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614165724.GA3083@bogus>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 14 Jun 09:57 PDT 2019, Rob Herring wrote:

> On Thu, 23 May 2019 08:01:53 -0700, Bjorn Andersson wrote:
> > The reg property represents the address and size on the bus that a
> > device lives, but for APR the parent is a rpmsg bus, which does not have
> > numerical addresses. Simply defining #address/#size-cells to 1 and 0,
> > respectively, to silence the compiler is not an appropriate solution.
> > 
> > Replace the use of "reg" with an APR specific property.
> > 
> > Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> > 
> > Changes since v1:
> > - Fixed example to match change
> > 
> >  Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt | 6 +++---
> >  drivers/soc/qcom/apr.c                                  | 2 +-
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> > 
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks Rob, patch applied.

Regards,
Bjorn
