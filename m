Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54639C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 10:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20750218FC
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 10:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555236267;
	bh=VRNpGG6DGz3HCICg0uPRtFetXsQys30QPGkgPwmHekU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gwi6xzFtojK56IuTrRzpjM4McCu1fO/4UP7dyvfZAgy0mug312U7UvANqeOC3jXQg
	 MTxPjHVbebE6nJnLmXvv/4wXg9j5Ara2x31beUXYJPBdo265jfpqyWqbNMwI6/UxLR
	 tHHDkPc2/f90CpERI67CotRkeCy5zQBTBiX1hoAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfDNKEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 06:04:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbfDNKEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 06:04:25 -0400
Received: from localhost (unknown [106.199.53.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 221BB2148E;
        Sun, 14 Apr 2019 10:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555236264;
        bh=VRNpGG6DGz3HCICg0uPRtFetXsQys30QPGkgPwmHekU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lr9rhGhS9QJQvpG+daoPte7tM62C+KrL6/SfM3c2AnxEEHU0YNR6ab7BodKTggStQ
         rX2QYRo45dwXn7xHafXwfSLSMVyxQkmv583Jl0M7zXY/45XmXjZFdHdX4rjso8wC0u
         yIOWvKyeh5lC02LvR1wyfrAWNwj0AeUTW66lR4gs=
Date:   Sun, 14 Apr 2019 15:34:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org
Subject: Re: [PATCH v3 0/5] soundwire: code cleanup
Message-ID: <20190414100417.GH28103@vkoul-mobl>
References: <20190411031701.5926-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411031701.5926-1-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-04-19, 22:16, Pierre-Louis Bossart wrote:
> SoundWire support will be provided in Linux with the Sound Open
> Firmware (SOF) on Intel platforms. Before we start adding the missing
> pieces, there are a number of warnings and style issues reported by
> checkpatch, cppcheck and Coccinelle that need to be cleaned-up.

Applied, 1, 3 and 4 (5 looked good but didnt apply)

Thanks

> 
> Changes since v2:
> fixed inversion of devm_kcalloc parameters, detected while rebasing
> additional patches.
> 
> Changes since v1:
> added missing newlines in new patch (suggested by Joe Perches)
> 
> Pierre-Louis Bossart (5):
>   soundwire: intel: fix inversion in devm_kcalloc parameters
>   soundwire: fix style issues
>   soundwire: bus: remove useless initializations
>   soundwire: stream: remove useless initialization of local variable
>   soundwire: add missing newlines in dynamic debug logs
> 
>  drivers/soundwire/Kconfig          |   2 +-
>  drivers/soundwire/bus.c            | 137 ++++++++-------
>  drivers/soundwire/bus.h            |  16 +-
>  drivers/soundwire/bus_type.c       |   4 +-
>  drivers/soundwire/cadence_master.c |  99 +++++------
>  drivers/soundwire/cadence_master.h |  22 +--
>  drivers/soundwire/intel.c          | 103 ++++++-----
>  drivers/soundwire/intel.h          |   4 +-
>  drivers/soundwire/intel_init.c     |  12 +-
>  drivers/soundwire/mipi_disco.c     | 116 +++++++------
>  drivers/soundwire/slave.c          |  10 +-
>  drivers/soundwire/stream.c         | 267 +++++++++++++++--------------
>  12 files changed, 404 insertions(+), 388 deletions(-)
> 
> -- 
> 2.17.1

-- 
~Vinod
