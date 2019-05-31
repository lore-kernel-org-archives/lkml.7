Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FBDC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 08:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0920265BE
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 08:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dglyHjYn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfEaI0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 04:26:38 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:7322 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfEaI0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 04:26:37 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf0e5320001>; Fri, 31 May 2019 01:26:26 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 31 May 2019 01:26:37 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 31 May 2019 01:26:37 -0700
Received: from tbergstrom-lnx.Nvidia.com (172.20.13.39) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Fri, 31 May 2019 08:26:36 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1000)
        id 67E4740BFF; Fri, 31 May 2019 11:26:34 +0300 (EEST)
Date:   Fri, 31 May 2019 11:26:34 +0300
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nicolas Chauvet <kwizart@gmail.com>
Subject: Re: [PATCH v3 0/8] NVIDIA Tegra clocksource driver improvements
Message-ID: <20190531082634.GA6070@pdeschrijver-desktop.Nvidia.com>
References: <20190524153253.28564-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190524153253.28564-1-digetx@gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559291187; bh=VcZEf7tgMNIXUUg2aicGt0agDtisPyMFpAo7p5giBdA=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
         X-NVConfidentiality:User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=dglyHjYnmWAOWHzKaqceaJx0Ys6DQXlaf3TFxqQb8JHYiYzozq4oJdsSPGPD235Ar
         X/bjWk9y8g0q6EGDe6DUucL96LJFyzgIzQvNxZpl7Sy7rgqksECiBBRq/4cRQtqGUT
         S4Jbd2MfLwoOzAGCVr7GozHU8QPlZ31oAWoh65XEYpnDhCkgSuBDRzqbPg6MkoaYV2
         0t1Lifc1N+UATaavXZ+VzSS4eh3ogSzAud448T0d9Jq8XYtEe0ez4lHyAgDgPZohNh
         +e7gyJZZA0INC8ZO9BIdyWgMn7bGjnI9C3DP2dOT0aIdyaq70LXUiC4sq3/VTUIBnf
         Lie7wCUBnA9ww==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 06:32:45PM +0300, Dmitry Osipenko wrote:
> Hello,
> 
> This series primarily unifies the driver code across all Tegra SoC
> generations. In a result the clocksources are allocated per-CPU on
> older Tegra's and have a higher rating than the arch-timer, the newer
> Tegra210 is getting support for microsecond clocksource and the driver's
> code is getting much cleaner. Note that arch-timer usage is discouraged on
> all Tegra's due to the time jitter caused by the CPU frequency scaling.

I think the limitations are more as follows:

Chip	timer		suffers cpu dvfs jitter		can wakeup from cc7
T20	us-timer	No				Yes
T20	twd timer	Yes				No?
T30	us-timer	No				Yes
T30	twd timer	Yes				No?
T114	us-timer	No				Yes
T114	arch timer	No				Yes
T124	us-timer	No				Yes
T124	arch timer	No				Yes
T210	us-timer	No				Yes
T210	arch timer	No				No
T210	clk_m timer	No				Yes

right?

Peter.
