Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEE0C2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C268C2465E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="wtvPaOr2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfLSUKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 15:10:46 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:44066 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726906AbfLSUKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 15:10:46 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576786245; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: To: From: Date: Sender;
 bh=/5veci3IX8iV9Lr7OinmX1GSclV5/3Uya8rEs4CH8nA=; b=wtvPaOr2BZbEoJhvPSB+Ku5EK2t5bx2U1rTs7jINojbbbWMaaYJ6btR1cjS+SynOmH+9hHT0
 +R4I9rPys9+ygWDCvhlPKKsjWzyOBmPZ56wgQSQRUXdEkRI90YWaomKHAoH/L0mDXqtmxIno
 ns0dh+3Xez+M8U18/eQ8giHk8OQ=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfbd944.7f6b5df85c38-smtp-out-n03;
 Thu, 19 Dec 2019 20:10:44 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BE1E6C447A5; Thu, 19 Dec 2019 20:10:44 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5878AC447A0;
        Thu, 19 Dec 2019 20:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5878AC447A0
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Thu, 19 Dec 2019 13:10:41 -0700
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Sharat Masetty <smasetty@codeaurora.org>,
        freedreno@lists.freedesktop.org, dri-devel@freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH 5/5] drm/msm/a6xx: Add support for using system cache(LLC)
Message-ID: <20191219201041.GB23673@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Sharat Masetty <smasetty@codeaurora.org>,
        freedreno@lists.freedesktop.org, dri-devel@freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, saiprakash.ranjan@codeaurora.org
References: <1576761286-20451-1-git-send-email-smasetty@codeaurora.org>
 <1576761286-20451-6-git-send-email-smasetty@codeaurora.org>
 <20191219195814.GA23673@jcrouse1-lnx.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219195814.GA23673@jcrouse1-lnx.qualcomm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 12:58:15PM -0700, Jordan Crouse wrote:
> On Thu, Dec 19, 2019 at 06:44:46PM +0530, Sharat Masetty wrote:


<snip>

> > +
> > +	/*
> > +	 * CNTL1 is used to specify SCID for (CP, TP, VFD, CCU and UBWC
> > +	 * FLAG cache) GPU blocks. This value will be passed along with
> > +	 * the address for any memory transaction from GPU to identify
> > +	 * the sub-cache for that transaction.
> > +	 */
> > +	if (!IS_ERR(llc->gpu_llc_slice)) {
> > +		u32 gpu_scid = llcc_get_slice_id(llc->gpu_llc_slice);
> > +		int i;
> > +
> > +		for (i = 0; i < A6XX_LLC_NUM_GPU_SCIDS; i++)
> > +			llc->cntl1_regval |=
> > +				gpu_scid << (A6XX_GPU_LLC_SCID_NUM_BITS * i);
> 
> As above, i'm not sure a loop is better than just:
> 
> gpu_scid &= 0x1f;
> 
> llc->cntl1_regval = (gpu_scid << 0) || (gpu_scid << 5) | (gpu_scid << 10)
>  | (gpu_scid << 15) | (gpu_scid << 20);
> 
> And I'm not even sure we need do this math here in the first place.

One more question - can you get a valid slice id before activation?

<snip>

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
