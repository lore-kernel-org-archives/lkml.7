Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F24C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 03:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB152173E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 03:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576122572;
	bh=sO6XmEoJxykkgpmbd4+eUXUxrxDhjg81vEZPden8/MU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h0nkVkpBCM8VbPcOhby2QjzLsrPLAF9M86IMzxxSYVU4qAsZXAJdJTNg7ydKmzICl
	 x9k15FWFuujU2TkIKXvPKwBuI3kX2pfuE9+kQz8BC3RhDjm0msS5jqOz3U9XbSyb+l
	 y+uFSMTe3DEg9cNUtaYdIZ0ZWgSdX+Nzb2Oy+jOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfLLDtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 22:49:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:55178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727589AbfLLDtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 22:49:31 -0500
Received: from localhost (unknown [106.200.251.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDF90214D8;
        Thu, 12 Dec 2019 03:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576122570;
        bh=sO6XmEoJxykkgpmbd4+eUXUxrxDhjg81vEZPden8/MU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PO8NlrgakWBWf/vuxs49fIfKtb/DQFt/iw6sGB4y05mZhvI+Lsd5Q4SONdcdOq0Ts
         XGipELIWwdl4gI087D9aEA/6SJ8upNHwy7wagVw9pdpldzYydgpND76jw6ZV7ynsET
         0QdUKKjhT/aTSxSAHqs18kmWir7KPa5BCKcWNKUU=
Date:   Thu, 12 Dec 2019 09:19:26 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [PATCH v5 00/11] soundwire: update ASoC interfaces
Message-ID: <20191212034926.GK2536@vkoul-mobl>
References: <20191212014507.28050-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191212014507.28050-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-12-19, 19:44, Pierre-Louis Bossart wrote:
> We need new fields in existing structures to
> a) deal with race conditions on codec probe/enumeration
> b) allow for multi-step ACPI scan/probe/startup on Intel plaforms
> c) deal with MSI issues using a single handler/threads for all audio
> interrupts
> d) deal with access to registers shared across multiple links on Intel
> platforms
> 
> These structures for a) will be used by the SOF driver as well as
> codec drivers. The b) c) and d) cases are only for the Intel-specific
> implementation.
> 
> To avoid conflicts between ASoC and Soundwire trees, these 11 patches
> are provided out-of-order, before the functionality enabled in these
> header files is added in follow-up patch series which can be applied
> separately in the ASoC and Soundwire trees. As discussed earlier,
> Vinod would need to provide an immutable tag for Mark Brown, and the
> integration on the ASoC side of SOF changes and new codecs drivers can
> proceed in parallel with SoundWire core changes.
> 
> I had multiple offline discussions with Vinod/Mark/Takashi on how to
> proceed withe volume of SoundWire changes. Now that v5.5-rc1 is out we
> should go ahead with these interface changes.
> 
> The next patchset "[PATCH v3 00/15] soundwire: intel: implement new
> ASoC interfaces​" can still be reviewed but will not apply as is due to
> a one-line conflict. An update will be provided when Vinod applies
> this series to avoid noise on mailing lists.
> 
> An update for the series "[PATCH v3 00/22] soundwire: code hardening
> and suspend-resume support" is ready but will be provided when both
> the interfaces changes and the implementation changes are merged.

Applied, thanks

I will send the tag tomorrow after it is in next

Thanks

-- 
~Vinod
