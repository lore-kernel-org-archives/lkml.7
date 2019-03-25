Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9112CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 04:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E2B2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 04:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553489677;
	bh=ueBgVV70DJvt8SSwprL82/xnIWLBpMIINVj7pPcdztE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YFo0uD1QtpC33+OXZC6S/3uVvXlL+8nQKNCeU/Xr5sNyGuroR9RoCg7iFzOK9eljk
	 8ZUp/2utddudmUN6P/2tbNIKvnZ3G53RGAcHWrsY72PwFS4OkxQ/nf9spV3vEXh4rV
	 +6bK3TtIU+2NuJjd/BtY1Wmt1G+4YnU/4v7/exHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfCYEyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 00:54:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbfCYEyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 00:54:35 -0400
Received: from localhost (unknown [171.61.95.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 323802087E;
        Mon, 25 Mar 2019 04:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553489674;
        bh=ueBgVV70DJvt8SSwprL82/xnIWLBpMIINVj7pPcdztE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wVXwSam/KFMHk1gTkzLjmBngMLUlCuiYpOSdKDgSfmicoaC5HBF+fqPRUNlCvASi0
         3CD381YtKVFhPzYQ2xbL2sbmuif/kYOANQTLfVgjSz3b4seFLcPjRUOHZSjmKfFGpp
         OdnHMuB9E+GzNco/sjnc+u0qgQJQHrBPoDuw/BMw=
Date:   Mon, 25 Mar 2019 10:24:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     dan.j.williams@intel.com, treding@nvidia.com, jonathanh@nvidia.com,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dmaengine: tegra210-adma: use devm_clk_*() helpers
Message-ID: <20190325045429.GF5348@vkoul-mobl>
References: <1552476757-22360-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552476757-22360-1-git-send-email-spujar@nvidia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-03-19, 17:02, Sameer Pujar wrote:
> adma driver is using pm_clk_*() interface for managing clock resources.
> With this it is observed that clocks remain ON always. This happens on
> Tegra devices which use BPMP co-processor to manage clock resources,
> where clocks are enabled during prepare phase. This is necessary because
> clocks to BPMP are always blocking. When pm_clk_*() interface is used on
> such Tegra devices, clock prepare count is not balanced till remove call
> happens for the driver and hence clocks are seen ON always. Thus this
> patch replaces pm_clk_*() with devm_clk_*() framework.

Both applied, thanks

-- 
~Vinod
