Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0C4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 05:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F902085A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 05:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lvQlKcPh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfCNFU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 01:20:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39782 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfCNFU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 01:20:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id h8so3190435pgp.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 22:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2s/Hr9SneOeJLDFpj9F9UksSE/CrscH+uSgEjAMDDRE=;
        b=lvQlKcPhjqaIk3ODNB6+Q+iIB4lAtqzbdtYW1H4A+Xf6okRxrtq1tNzGQ/WJYPeGhH
         0pxWKzEedpPWsogZi/XU9kEpEMHIPzcasJ/hcm3odwxiTTTxDfaB/2Ejx68mCaaBVwTL
         dtOODBKUNRQ+sX3RAaJYUkua2T+O+pclSSWYLxse27ZSTnyiDqikzbpCOBmQQeaufE5i
         FFSOW77rODUhWxR2eRUtIycuDoOQqI5XToVU4QfVdzYgQ1vW2s5oD0NWP0EVmQ1f/t/g
         xUH8W6MefoffldS2Es+VLgHTWdESs5N+y9PmWYkBruK0DwpvzO9ne1eE0bmCM2s4pfW9
         Xpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2s/Hr9SneOeJLDFpj9F9UksSE/CrscH+uSgEjAMDDRE=;
        b=aLl9SZGpmso1zdggKAvkoSyd6G7URsiB67Dmh/N7+wivu4Jbp1LgIfSh6+Ru3eEDHl
         IVFTqIoC6eVLJL5tcrz6QO9N6BMqrq+xB1x3294Sch2xc5eGObeor0iWhR9KB4CAh2Wa
         M7BqJJbvoBR7UvJM9+kOF/W9bDFN5t8H+7Lov6s6kWVfFq2qSRXoOFTc9jUvULxd702C
         ZAMI1uOu+Ooz+zbdlpfJFyzyKyBBV96Dqk+gMgb3HVSiIJAbeAsqtD/aniVcUUKDvZiA
         2v4xu2jdTc6c3H01xCB9qmkCjL84EZlYKTRJtPA4S2/cHCC86+3i/c48VGlPBCUDekKN
         xSWg==
X-Gm-Message-State: APjAAAXgqjZFoHBnBr3nckxKWy5ZwaMkheEVKf10Mb5P/3aoMQg87V0J
        mLuBTfADFTU6qhSPv6P5d++N3g==
X-Google-Smtp-Source: APXvYqzdCSHjC6h36txHL0w5syguVRidRUl2x1Wf2mu4hm5PekgYCLT1XfzK/cEcODPMwEK5ue3CmA==
X-Received: by 2002:a63:1a03:: with SMTP id a3mr43855280pga.192.1552540824952;
        Wed, 13 Mar 2019 22:20:24 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x23sm46616880pfe.0.2019.03.13.22.20.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 22:20:23 -0700 (PDT)
Date:   Wed, 13 Mar 2019 22:20:20 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Jordan Crouse <jcrouse@codeaurora.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <andy.gross@linaro.org>
Subject: Re: [Freedreno] [PATCH v1 4/4] arm64: dts: sdm845: Add zap shader
 region for GPU
Message-ID: <20190314052020.GC6435@tuxbook-pro>
References: <1552414422-9568-1-git-send-email-jcrouse@codeaurora.org>
 <1552414422-9568-5-git-send-email-jcrouse@codeaurora.org>
 <CAF6AEGt74Hs+VMgMOMAyFw9FGk5mrY2NU07JUh=OKSOhj-h6CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF6AEGt74Hs+VMgMOMAyFw9FGk5mrY2NU07JUh=OKSOhj-h6CA@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13 Mar 08:42 PDT 2019, Rob Clark wrote:

> On Tue, Mar 12, 2019 at 2:14 PM Jordan Crouse <jcrouse@codeaurora.org> wrote:
> >
> > Some Adreno GPU targets require a special zap shader to bring the GPU
> > out of secure mode. Define a region to allocate and store the zap
> > shader.
> >
> > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > ---
> >
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > index fed7a29..526456d 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > @@ -100,6 +100,11 @@
> >                         no-map;
> >                 };
> >
> > +               zap_shader_region: memory@8c415000 {
> > +                       reg = <0 0x8c415000 0 0x2000>;
> > +                       no-map;
> > +               };
> > +
> >                 mpss_region: memory@8e000000 {
> >                         reg = <0 0x8e000000 0 0x7800000>;
> >                         no-map;
> > @@ -109,6 +114,8 @@
> >                         reg = <0 0x96500000 0 0x200000>;
> >                         no-map;
> >                 };
> > +
> > +
> 
> I guess we don't really need this hunk..
> 

I'll trim that as I pick up the patch.

> other than that, the series lgtm
> 

Will you pick up patch 1-3 and I'll pick patch 4 through Andy's tree?

Regards,
Bjorn

> BR,
> -R
> 
> >         };
> >
> >         cpus {
> > @@ -1514,6 +1521,10 @@
> >
> >                         qcom,gmu = <&gmu>;
> >
> > +                       zap-shader {
> > +                               memory-region = <&zap_shader_region>;
> > +                       };
> > +
> >                         gpu_opp_table: opp-table {
> >                                 compatible = "operating-points-v2";
> >
> > --
> > 2.7.4
> >
> > _______________________________________________
> > Freedreno mailing list
> > Freedreno@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/freedreno
