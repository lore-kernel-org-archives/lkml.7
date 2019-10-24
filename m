Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7721BCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D64221872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571917990;
	bh=99qNRQHdAv3dolhrrrxjrJsk3saJLLP8RXdz9XOhJoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dwQorRgYlWwi2ZRKodbBGB4LegMjohjJ08irVIoqeOsc1PLclGW1dvlhOvi5SWiMe
	 7AKtIm5+HjgFp9RC0mD5RQn1fC2QHGnAdogWQMafflnuhZUNAgvWuTcPYh6lcP+7GO
	 BHwH3sFx88hy6fjXqKc5PIoBH1e8lSDNhhetCLwE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439497AbfJXLxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 07:53:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbfJXLxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 07:53:07 -0400
Received: from localhost (unknown [122.181.210.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96A0F21655;
        Thu, 24 Oct 2019 11:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571917987;
        bh=99qNRQHdAv3dolhrrrxjrJsk3saJLLP8RXdz9XOhJoY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wWLSjaOE1ZSOod4ym/XUfzf9mF/N2gw6RJSxC8XU8zbYjqypBMxdzGIJeydDb9sSb
         pvQUXYCCTsFCdgHKo9bHmsJnfB4sRekhq977OtQZNUckcyeiRuNurYJm+hvdQAQ5iG
         Wy61/3f9A3NS77jQYIvoyGjLnagrs4Nwa5XOOAuo=
Date:   Thu, 24 Oct 2019 17:22:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [PATCH v3 0/5] soundwire: intel/cadence: better initialization
Message-ID: <20191024115259.GE2620@vkoul-mobl>
References: <20191022235448.17586-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022235448.17586-1-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-10-19, 18:54, Pierre-Louis Bossart wrote:
> Changes since v2: addressed feedback from Vinod Koul on patch 2&4
> Add kernel taint when using debugfs hw_reset (similar to regmap)
> Remove useless goto label
> 
> Changes since v1: addressed feedback from Vinod Koul
> clarified init changes impact Intel and Cadence sides
> remove unnecessary intermediate variable
> disable interrupts when exit_reset fails, updated error handling
> returned -EINVAL on debugfs invalid parameter

Applied, thanks

> 
> Pierre-Louis Bossart (5):
>   soundwire: intel/cadence: fix startup sequence
>   soundwire: cadence_master: add hw_reset capability in debugfs
>   soundwire: intel: add helper for initialization
>   soundwire: intel/cadence: add flag for interrupt enable
>   soundwire: cadence_master: make clock stop exit configurable on init
> 
>  drivers/soundwire/cadence_master.c | 134 +++++++++++++++++++++--------
>  drivers/soundwire/cadence_master.h |   5 +-
>  drivers/soundwire/intel.c          |  39 ++++++---
>  3 files changed, 129 insertions(+), 49 deletions(-)
> 
> -- 
> 2.20.1

-- 
~Vinod
