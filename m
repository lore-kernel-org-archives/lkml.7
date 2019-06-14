Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF84DC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 19:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C36217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 19:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560541406;
	bh=7gKmgo1dRjA4yONDe3HR3+7X4u/83d+VuGOw5pQZNh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SnDpRsaHCYiZ2CFlc300W/V8kTlCCeprmqIi1pCT2G1+HrnghCpQWC2y/IHSy9osy
	 Gad2fzLdLVCEnpLeMVy85a/4ypTNldWwW2xNdOklbccH2IetxzlGjdrJoD86MEiB4f
	 rT2jcvlJ30DpT0OJuywaYhTELTtc4H+YD1NFu36Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfFNTnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 15:43:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:60546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbfFNTnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 15:43:24 -0400
Received: from localhost (107-207-74-175.lightspeed.austtx.sbcglobal.net [107.207.74.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C48B1217D6;
        Fri, 14 Jun 2019 19:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560541404;
        bh=7gKmgo1dRjA4yONDe3HR3+7X4u/83d+VuGOw5pQZNh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nx3YHCMvLrQ8EeCL7b6r55mXR4P7IXZevBKUROMh95rXS6UY1DZ8FLy1Vd88fYM3m
         1jMsa1Si3koPI+t9iYqmsXLChMVRR0RV7IE0TaLzO0h0cZGiBV5Opyj0XjszVQqv62
         Ovs6aoJfrjC36wQUiR4GhiihU0wad+USGgz1Xhvg=
Date:   Fri, 14 Jun 2019 14:43:22 -0500
From:   Andy Gross <agross@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        sricharan@codeaurora.org
Subject: Re: [PATCH] dmaengine: qcom-bam: fix circular buffer handling
Message-ID: <20190614194322.GA4791@hector.attlocal.net>
References: <20190614142012.31384-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614142012.31384-1-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 03:20:12PM +0100, Srinivas Kandagatla wrote:
> For some reason arguments to most of the circular buffers
> macros are used in reverse, tail is used for head and vice versa.
> 
> This leads to bam thinking that there is an extra descriptor at the
> end and leading to retransmitting descriptor which was not scheduled
> by any driver. This happens after MAX_DESCRIPTORS (4096) are scheduled
> and done, so most of the drivers would not notice this, unless they are
> heavily using bam dma. Originally found this issue while testing
> SoundWire over SlimBus on DB845c which uses DMA very heavily for
> read/writes.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Reviewed-by: Andy Gross <agross@kernel.org>
