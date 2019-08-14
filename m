Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0501C0650F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 05:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0F82084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 05:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565761638;
	bh=sGSEpLFwxSA+wPTlqNmCouxrUR10WybyiEQw8oFiCeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wLdv51bCBQ7veytSoDs5rlXsyAOvKyja/4QafnDkU6VxwbyIxnDkljWxwTqB83hQW
	 nba653CxIdtOKBjUlqaxuEzwxNc0mZP1LgwetZ575OuvPJKYSLXqXEESjDxuUTJG7K
	 t2Rm2hGPt09RoanLGzmuaJ2GlbVv99fyWG2hiXSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfHNFrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 01:47:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725263AbfHNFrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 01:47:17 -0400
Received: from localhost (unknown [106.51.111.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0319820843;
        Wed, 14 Aug 2019 05:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565761637;
        bh=sGSEpLFwxSA+wPTlqNmCouxrUR10WybyiEQw8oFiCeQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nmUZ55RmgNLBGCLo2iWsovHMXWinQFV+E8dH5Rban/fSxGQogjKDHrS6VslJfQLBc
         4zacY6la89zK0RNkjNlyqAmsDUWxobYWOzGCDWaL6JtGS0Ml8P3pml1sVgxHswtuVC
         xys1QuksyRR7jd/EBug5SMhf5VFFcCo6jx5RDzAM=
Date:   Wed, 14 Aug 2019 11:16:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        clang-built-linux@googlegroups.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH] soundwire: Don't build sound.o without
 CONFIG_ACPI
Message-ID: <20190814054604.GW12733@vkoul-mobl.Dlink>
References: <20190813061014.45015-1-natechancellor@gmail.com>
 <445d16e1-6b00-6797-82df-42a49a5e79e3@linux.intel.com>
 <20190814035947.GS12733@vkoul-mobl.Dlink>
 <20190814042428.GA125416@archlinux-threadripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814042428.GA125416@archlinux-threadripper>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-08-19, 21:24, Nathan Chancellor wrote:
> On Wed, Aug 14, 2019 at 09:29:47AM +0530, Vinod Koul wrote:
> > On 13-08-19, 09:22, Pierre-Louis Bossart wrote:
> > > On 8/13/19 1:10 AM, Nathan Chancellor wrote:
 
> > > I am fine with the change, but we might as well rename the file acpi_slave.c
> > > then?
> > 
> > Srini's change add support for DT for the same file, so It does not make
> > sense to rename. Yes this patch tries to fix a warn which is there due
> > to DT being not supported but with Srini's patches this warn should go
> > away as sdw_slave_add() will be invoked by the DT counterpart
> > 
> > Sorry Nathan, we would have to live with the warn for few more days till
> > I apply Srini's changes. So I am not taking this (or v2) patch
> > 
> 
> That is fine as I can apply this locally. Could you point me to these
> patches so that I can take a look at them?

Here you go:

https://lore.kernel.org/lkml/20190808144504.24823-3-srinivas.kandagatla@linaro.org/

-- 
~Vinod
