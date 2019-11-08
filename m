Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725AAFC6195
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 496EC214DA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573234375;
	bh=Ofx8YKmDV57qHEAkebxJT8e1dJRj7IJxPAc/SX4NHqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yebSMsA0KTc7A/6kOnjSeesix0J20t0wt3Ih+4oE0JIfWzqtHMJV3OYzn85wZ7xnA
	 tUheLEaogg5CEqO2Z5xx8klgMS28xb/iyE85igLts1fxzF/u6gqOKhTwzW3i/BXE5C
	 s/9acdFels+ETxL5wA8CTGLsLvMe6ffahZOACnU0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbfKHRcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 12:32:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:54544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbfKHRcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 12:32:53 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A10052084D;
        Fri,  8 Nov 2019 17:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573234373;
        bh=Ofx8YKmDV57qHEAkebxJT8e1dJRj7IJxPAc/SX4NHqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yHvB28FnuDMkdkXpBFbiPqmmjVjHBkk/mH3QgZbyhcBUq8OGIK/5vOdid6UGunG86
         wzf3WuaIySpscgorqrGjICHsKndEi4DHC1CWzmxJwiN/kal8TNome5GAuXSy9abhIl
         Cjm6d7g4WxIIlP92SSH/7+5zrvjuAj9La75WILvs=
Date:   Fri, 8 Nov 2019 17:32:48 +0000
From:   Will Deacon <will@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 6/9] Revert "iommu/arm-smmu: Make arm-smmu-v3
 explicitly non-modular"
Message-ID: <20191108173248.GA22448@willie-the-truck>
References: <20191108151608.20932-1-will@kernel.org>
 <20191108151608.20932-7-will@kernel.org>
 <06dfd385-1af0-3106-4cc5-6a5b8e864759@huawei.com>
 <7e906ed1-ab85-7e25-9b29-5497e98da8d8@huawei.com>
 <20191108164728.GB20866@willie-the-truck>
 <c4cb13d3-3786-2e45-ba57-9965cead9a49@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4cb13d3-3786-2e45-ba57-9965cead9a49@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 05:25:09PM +0000, John Garry wrote:
> On 08/11/2019 16:47, Will Deacon wrote:
> > On Fri, Nov 08, 2019 at 04:44:25PM +0000, John Garry wrote:
> > > BTW, it now looks like it was your v1 series I was testing there, on your
> > > branch iommu/module. It would be helpful to update for ease of testing.
> > 
> > Yes, sorry about that. I'll update it now (although I'm not sure it will
> > help with this -- I was going to see what happens with other devices such
> > as the intel-iommu or storage controllers)
> 
> So I tried your v2 series for this - it has the same issue, as I
> anticipated.

Right, I'm just not sure how resilient drivers are expected to be to force
unbinding like this. You can break lots of stuff with root...

> It seems that some iommu drivers do call iommu_device_register(), so maybe a
> decent reference. Or simply stop the driver being unbound.

I'm not sure what you mean about iommu_device_register() (we call that
already), but I guess we can keep the '.suppress_bind_attrs = true' if
necessary. I'll have a play on my laptop and see how well that works if
you start unbinding stuff.

Will
