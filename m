Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B39C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6561E218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553177942;
	bh=cMkdX0KGpz7di4SCPDDKR2SJsCSmXBjSaNSqEy1Dj78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iT6mR9yhw3mAylZgmYHCdhyVj6ZhLjMyKp6hXFyO8gPi/YgsTMlIJOsRygUBLCX/c
	 vyvT6mLsnM2rEMHgqHb+EHpDWRItLa//KmPcPk2aGNXf/nkZfdIa4/oITepCcdm+oe
	 /XiTzog7SmcJc/bdMX3BfIdsvbQvh1y5OF4zMdeE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbfCUOTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:19:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:51074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbfCUOTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:19:00 -0400
Received: from localhost (unknown [106.201.33.144])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D74E2075E;
        Thu, 21 Mar 2019 14:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553177940;
        bh=cMkdX0KGpz7di4SCPDDKR2SJsCSmXBjSaNSqEy1Dj78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uGeYqwd19QZIfDE/bu9f9CfOXR5scZKz1fPLprGefOJcUjONvKgZio2dOu0OknO7c
         87MRaUN2rCPkC672U3+aY1X22GkKfUMlIFv8a+2Rn0wAUK10F2l6RYC6HYfD57kFeV
         qG1rr/XyeLJroxlqKFxOOtcZWkHAJGkZOGb3azrA=
Date:   Thu, 21 Mar 2019 19:48:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dmaengine: idma64: Use actual device for DMA transfers
Message-ID: <20190321141854.GA5348@vkoul-mobl>
References: <20190318153930.25641-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318153930.25641-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-03-19, 18:39, Andy Shevchenko wrote:
> Intel IOMMU, when enabled, tries to find the domain of the device,
> assuming it's a PCI one, during DMA operations, such as mapping or
> unmapping. Since we are splitting the actual PCI device to couple of
> children via MFD framework (see drivers/mfd/intel-lpss.c for details),
> the DMA device appears to be a platform one, and thus not an actual one
> that performs DMA. In a such situation IOMMU can't find or allocate
> a proper domain for its operations. As a result, all DMA operations are
> failed.
> 
> In order to fix this, supply parent of the platform device
> to the DMA engine framework and fix filter functions accordingly.
> 
> We may rely on the fact that parent is a real PCI device, because no
> other configuration is present in the wild.

Applied, thanks

-- 
~Vinod
