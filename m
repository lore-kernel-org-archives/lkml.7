Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C97BC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F321A22DD3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="AgNS2jBG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbfHUTiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 15:38:08 -0400
Received: from onstation.org ([52.200.56.107]:44742 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbfHUTiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 15:38:08 -0400
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 9F3763E8A5;
        Wed, 21 Aug 2019 19:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1566416287;
        bh=LSVMcf7/+Pknk2oK/dA6jgWSlxEz5JclLfuEyMQqBPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AgNS2jBGyjrDVg8BiTYs7QD8K9ZV/zJULU6ZU0wLGrkKstvXZev3WHs+2hCnP7kRS
         UzzmJ0Teje4fLdu0g+FqrkuJw1h/I3Tu3/BNEgcheQY2Sb3FCIn/kg02xgYXuUBUmr
         zV+oUFSs9oXkZS8HdOR/rLSnJnylV6FghyCS0uKI=
Date:   Wed, 21 Aug 2019 15:38:06 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Rob Herring <robh@kernel.org>
Cc:     agross@kernel.org, robdclark@gmail.com, sean@poorly.run,
        bjorn.andersson@linaro.org, airlied@linux.ie, daniel@ffwll.ch,
        mark.rutland@arm.com, jonathan@marek.ca,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, jcrouse@codeaurora.org
Subject: Re: [PATCH v5 2/7] dt-bindings: display: msm: gmu: add optional
 ocmem property
Message-ID: <20190821193806.GA17476@onstation.org>
References: <20190806002229.8304-1-masneyb@onstation.org>
 <20190806002229.8304-3-masneyb@onstation.org>
 <20190821192602.GA16243@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192602.GA16243@bogus>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 02:26:02PM -0500, Rob Herring wrote:
> On Mon, Aug 05, 2019 at 08:22:24PM -0400, Brian Masney wrote:
> > Some A3xx and A4xx Adreno GPUs do not have GMEM inside the GPU core and
> > must use the On Chip MEMory (OCMEM) in order to be functional. Add the
> > optional ocmem property to the Adreno Graphics Management Unit bindings.
> > 
> > Signed-off-by: Brian Masney <masneyb@onstation.org>
> > ---
> > Changes since v4:
> > - None
> > 
> > Changes since v3:
> > - correct link to qcom,ocmem.yaml
> > 
> > Changes since v2:
> > - Add a3xx example with OCMEM
> > 
> > Changes since v1:
> > - None
> > 
> >  .../devicetree/bindings/display/msm/gmu.txt   | 50 +++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/msm/gmu.txt b/Documentation/devicetree/bindings/display/msm/gmu.txt
> > index 90af5b0a56a9..672d557caba4 100644
> > --- a/Documentation/devicetree/bindings/display/msm/gmu.txt
> > +++ b/Documentation/devicetree/bindings/display/msm/gmu.txt
> > @@ -31,6 +31,10 @@ Required properties:
> >  - iommus: phandle to the adreno iommu
> >  - operating-points-v2: phandle to the OPP operating points
> >  
> > +Optional properties:
> > +- ocmem: phandle to the On Chip Memory (OCMEM) that's present on some Snapdragon
> > +         SoCs. See Documentation/devicetree/bindings/sram/qcom,ocmem.yaml.
> 
> Sigh, to repeat my comment on v1 and v3:
> 
> We already have a couple of similar properties. Lets standardize on
> 'sram' as that is what TI already uses.

I also had the path wrong then in those older versions. It was
previously in the soc namespace instead of the sram namespace. I didn't
realize that you also wanted to change the name of the property as well.
Sorry about the confusion on my part.

Brian
