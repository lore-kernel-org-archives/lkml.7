Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E3DC4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 16:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910DB20856
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 16:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568307051;
	bh=jN+xiP8H2WM9L8uStklM+fMxvpDMXyRhPsKydGAxCMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OPoA3nuCBJJNmG/rdKyFQpI8srH81XwY3tNIKR/T6UNVLEEyHn9iM7KCqWTA9mrCp
	 6gJJYq/xcxSnF8+4tdNbgMcAc+kmfAMIHYvMI+lJ/D2ic6GjHCqOMbnh/7kJnbxf/P
	 ft40xv8V+3G7WdUKPIU+u3BmkQMI4uXKqIi7hBVA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730898AbfILQuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 12:50:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:34508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730254AbfILQuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 12:50:50 -0400
Received: from localhost (unknown [117.99.85.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38FD92084D;
        Thu, 12 Sep 2019 16:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568307049;
        bh=jN+xiP8H2WM9L8uStklM+fMxvpDMXyRhPsKydGAxCMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sk8F2Qio8VIFJT3KQFvRlMQwb4ItoYCgL5URMVPgm94hLioRTiOnX2vkKdl+gT7/q
         wQh78UQf5GfrW7uzt/27+rCiz0iSyRgJxhmI4M/8/TVrEzYHq5Nc4Ijx68JNxm+lMm
         xAf8DfPgoBV1Si51heBCspc0/huokMznwdURG+wk=
Date:   Thu, 12 Sep 2019 22:19:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     robh+dt@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        devicetree@vger.kernel.org
Subject: Re: [RFC 3/3] dmaengine: Support for requesting channels preferring
 DMA domain controller
Message-ID: <20190912164941.GC4392@vkoul-mobl>
References: <20190906141816.24095-1-peter.ujfalusi@ti.com>
 <20190906141816.24095-4-peter.ujfalusi@ti.com>
 <20190908121507.GN2672@vkoul-mobl>
 <0bd4d678-31be-bead-7591-0452b6fed5f2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bd4d678-31be-bead-7591-0452b6fed5f2@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-09-19, 08:56, Peter Ujfalusi wrote:

> >> -struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask)
> >> +struct dma_chan *dma_domain_request_chan_by_mask(struct device *dev,
> >> +						 const dma_cap_mask_t *mask)
> > 
> > should we really use dma_request_chan_by_mask() why not create a new api
> > dma_request_chan_by_domain() and use that, it falls back to
> > dma_request_chan_by_mask() if it doesnt find a valid domain!
> 
> So:
> struct dma_chan *dma_request_chan_by_domain(struct device *dev,
> 					    const dma_cap_mask_t *mask);

Yeah that looks better to me :)

-- 
~Vinod
