Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27E5C2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A4872467E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576784781;
	bh=xUSTFd7GGdvk10sf3+om8mg9EYMJvjpiQnqD0QauP2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D+yapatSzRGA2fmynniD6jAys66NOq8NNdgCCf274EF5ePoYCbJAQy2KoL+L6DYl5
	 HaRPr3XlpxwVq+RhDI83I7LXWFXLYL4PqwflOxNYMQYjRl/XgNXxbcTfWVbY539DI9
	 te+fKLzVCR7u6GfX3ZO+SsOoBIFFr3RyZMSJBmeE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfLSTqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 14:46:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:57226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbfLSTqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 14:46:20 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3297227BF;
        Thu, 19 Dec 2019 19:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576784779;
        bh=xUSTFd7GGdvk10sf3+om8mg9EYMJvjpiQnqD0QauP2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TlZXCHKVySipIwV8OQTf4eP3VeA0QPzE+s9nJVK5IUitaVn0l2mcL7AWC2Xvaxbju
         l4K26akuLHBCiPdJZXw9IjzSH3PlfKq+EHYNazCz9xmkuM90nZO4pSvrwtESuW0ggT
         4/G6f+qMiFE1v3SEzi1TZcwsUyDIJy4Cpr3wiQ5Q=
Date:   Thu, 19 Dec 2019 14:46:18 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 5.4 197/350] ASoC: SOF: imx: fix reverse
 CONFIG_SND_SOC_SOF_OF dependency
Message-ID: <20191219194618.GQ17708@sasha-vm>
References: <20191210210735.9077-1-sashal@kernel.org>
 <20191210210735.9077-158-sashal@kernel.org>
 <20191211110005.GC3870@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191211110005.GC3870@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 11:00:05AM +0000, Mark Brown wrote:
>On Tue, Dec 10, 2019 at 04:05:02PM -0500, Sasha Levin wrote:
>> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>
>> [ Upstream commit f9ad75468453b019b92c5296e6a04bf7c37f49e4 ]
>>
>> updated solution to the problem reported with randconfig:
>>
>> CONFIG_SND_SOC_SOF_IMX depends on CONFIG_SND_SOC_SOF, but is in
>> turn referenced by the sof-of-dev driver. This creates a reverse
>> dependency that manifests in a link error when CONFIG_SND_SOC_SOF_OF
>> is built-in but CONFIG_SND_SOC_SOF_IMX=m:
>
>Are you sure this doesn't depend on any other Kconfig changes?

Nope, but it didn't fail my build tests.

-- 
Thanks,
Sasha
