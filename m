Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4286ACA9EC2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17012208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="deh2nyp9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hQQ03xOr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731476AbfJ1Pev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 11:34:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44280 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfJ1Peu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 11:34:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 97C9060D39; Mon, 28 Oct 2019 15:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572276889;
        bh=bCbdiTSckyICpvwuvpK6d6BcawKxrhdEuu25eW7caFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=deh2nyp9QKwEe2IUBDz71a85Z8BLFSTPeuOPtic8Dwm/mGlWRrIePWVXV4pyWJukU
         w9U01YmEHLIVHppiPIysSFkaB42VTLbuHeF4JtA3L2DWc7ne17OG3zIHBPp3KRixD6
         l4UHWp5EfAkwsAU+gJ8QV0XFb9bfmSTTWFot0COA=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E38EF60850;
        Mon, 28 Oct 2019 15:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572276888;
        bh=bCbdiTSckyICpvwuvpK6d6BcawKxrhdEuu25eW7caFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hQQ03xOrt536qEv7tq/7vDv8eKBYgdppf6EnJZ0Gu2clNU7Y46/cT8vJo6vfb4aKv
         rLmFgQEbpbccRx2ByIFJKdNSha+n0ewaTA+MPu5J1tZHWn6L9n0CU4NDdPmkCWOgdo
         E7hMd5pe9cMzWqXYkAVbGV4/qTtp0JOMlkrwo41M=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E38EF60850
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Mon, 28 Oct 2019 09:34:46 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
        isaacm@codeaurora.org, linux-kernel@vger.kernel.org,
        lmark@codeaurora.org, iommu@lists.linux-foundation.org,
        pratikp@codeaurora.org, smasetty@codeaurora.org
Subject: Re: [PATCH] iommu/dma: Add support for DMA_ATTR_SYS_CACHE
Message-ID: <20191028153445.GD7966@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
        isaacm@codeaurora.org, linux-kernel@vger.kernel.org,
        lmark@codeaurora.org, iommu@lists.linux-foundation.org,
        pratikp@codeaurora.org, smasetty@codeaurora.org
References: <1572050616-6143-1-git-send-email-isaacm@codeaurora.org>
 <20191026053026.GA14545@lst.de>
 <e5fe861d7d506eb41c23f3fc047efdfa@codeaurora.org>
 <20191028074156.GB20443@lst.de>
 <20191028112457.GB4122@willie-the-truck>
 <c1b37c8d-7bdc-eb81-19c2-29f50568150a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1b37c8d-7bdc-eb81-19c2-29f50568150a@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 11:59:04AM +0000, Robin Murphy wrote:
> On 28/10/2019 11:24, Will Deacon wrote:
> >Hi Christoph,
> >
> >On Mon, Oct 28, 2019 at 08:41:56AM +0100, Christoph Hellwig wrote:
> >>On Sat, Oct 26, 2019 at 03:12:57AM -0700, isaacm@codeaurora.org wrote:
> >>>On 2019-10-25 22:30, Christoph Hellwig wrote:
> >>>>The definition makes very little sense.
> >>>Can you please clarify what part doesn’t make sense, and why?
> >>
> >>It looks like complete garbage to me.  That might just be because it
> >>uses tons of terms I've never heard of of and which aren't used anywhere
> >>in the DMA API.  It also might be because it doesn't explain how the
> >>flag might actually be practically useful.
> >
> >Agreed. The way I /think/ it works is that on many SoCs there is a
> >system/last-level cache (LLC) which effectively sits in front of memory for
> >all masters. Even if a device isn't coherent with the CPU caches, we still
> >want to be able to allocate into the LLC. Why this doesn't happen
> >automatically is beyond me, but it appears that on these Qualcomm designs
> >you actually have to set the memory attributes up in the page-table to
> >ensure that the resulting memory transactions are non-cacheable for the CPU
> >but cacheable for the LLC. Without any changes, the transactions are
> >non-cacheable in both of them which assumedly has a performance cost.
> >
> >But you can see that I'm piecing things together myself here. Isaac?
> 
> FWIW, that's pretty much how Pratik and Jordan explained it to me - the LLC
> sits directly in front of memory and is more or less transparent, although
> it might treat CPU and device accesses slightly differently (I don't
> remember exactly how the inner cacheablility attribute interacts). Certain
> devices don't get much benefit from the LLC, hence the desire for
> finer-grained control of their outer allocation policy to avoid more
> thrashing than necessary. Furthermore, for stuff in the video/GPU/display
> area certain jobs benefit more than others, hence the desire to go even
> finer-grained than a per-device control in order to maximise LLC
> effectiveness.

Robin's description is correct. And we did have a patch for an in-kernel user
but it got lost in the wash. I'm hoping Sharat can get a respin in time for 5.5.

https://lore.kernel.org/linux-arm-msm/1538744915-25490-8-git-send-email-smasetty@codeaurora.org/

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
