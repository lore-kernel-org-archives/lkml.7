Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F4DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 350C420880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OJRF2LoR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="c97nB5f6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbfDAQN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:13:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54274 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfDAQN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:13:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2FFDA602FC; Mon,  1 Apr 2019 16:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554135208;
        bh=WYwpLiVmlq7w2P2VM/mBTYfyO9E5Bs+lJEpNL2DzA64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OJRF2LoR80VPf5rRWQY4027Or3RFAKZhEtG102utCwdUTZYKHf+d7B0Wb25JwuBwb
         eSks4ES+WW9GVwUu6805dXgl54Qt+zMh4mbpjQiCgnPLSMN5UtO1zljPIP4jlQTI0y
         PHCAHscyjRsxaDr6g9UXck6xY0u9mY95LG79IHQY=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 28E20602FC;
        Mon,  1 Apr 2019 16:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554135207;
        bh=WYwpLiVmlq7w2P2VM/mBTYfyO9E5Bs+lJEpNL2DzA64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c97nB5f6Oq8QBFweVoYCbWNopBHstHv5jyRm89Rb3Udlx1lQatVQSKSVIc7usXiY4
         FUopFPKuqKGup3EPc3dd/M3z/xiryTktLT81XWFiTDTd/KDyT/M3Wi/2DhKeNDt4pF
         XjNetqsF99XvmGOilkgKDErj9WkFO0uU0DH3DtPM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 28E20602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Mon, 1 Apr 2019 10:13:24 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Rob Herring <robh@kernel.org>
Cc:     freedreno@lists.freedesktop.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sean Paul <sean@poorly.run>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v1 3/4] dt-bindings: drm/msm/gpu: Document a5xx / a6xx
 zap shader region
Message-ID: <20190401161324.GC10168@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Rob Herring <robh@kernel.org>,
        freedreno@lists.freedesktop.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sean Paul <sean@poorly.run>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>
References: <1552414422-9568-1-git-send-email-jcrouse@codeaurora.org>
 <1552414422-9568-4-git-send-email-jcrouse@codeaurora.org>
 <20190328133215.GA14020@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328133215.GA14020@bogus>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 08:32:15AM -0500, Rob Herring wrote:
> On Tue, Mar 12, 2019 at 12:13:41PM -0600, Jordan Crouse wrote:
> > Describe the zap-shader node that defines a reserved memory region
> > to store the zap shader.
> > 
> > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > ---
> > 
> >  Documentation/devicetree/bindings/display/msm/gpu.txt | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/msm/gpu.txt b/Documentation/devicetree/bindings/display/msm/gpu.txt
> > index aad1aef..1e6d870 100644
> > --- a/Documentation/devicetree/bindings/display/msm/gpu.txt
> > +++ b/Documentation/devicetree/bindings/display/msm/gpu.txt
> > @@ -25,6 +25,9 @@ Required properties:
> >  - qcom,gmu: For GMU attached devices a phandle to the GMU device that will
> >    control the power for the GPU. Applicable targets:
> >      - qcom,adreno-630.2
> > +- zap-shader: For a5xx and a6xx devices this node contains a memory-region that
> > +  points to reserved memory to store the zap shader that can be used to help
> > +  bring the GPU out of secure mode.
> 
> This is the properties section and zap-shader is not a property.

Thanks, I can fix that.

> But why do you need a child node in the first place? Just add 
> 'memory-region' to the parent.

Two reasons.  First, this memory is locked in the secure world once the MDT
loader is run and it isn't really intended for CPU access. If the parent device
tries to set up DMA operations thinking it has access to the memory it might not
work out very well.  Putting it in a child makes it clear that this is a special
chunk of memory for a special case.

The second reason is that not all target platforms require the zap shader, so it
would be nice to have it as a child node so that it could be removed on target
platforms that don't need it.

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
