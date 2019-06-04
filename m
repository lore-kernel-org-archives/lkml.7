Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9369C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F5D324A00
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="k+0FH7uj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfFDNd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 09:33:59 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:1833 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbfFDNd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:33:59 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf673440001>; Tue, 04 Jun 2019 06:33:56 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 04 Jun 2019 06:33:58 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 04 Jun 2019 06:33:58 -0700
Received: from tbergstrom-lnx.Nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 4 Jun
 2019 13:33:57 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1000)
        id 7F1E540DE3; Tue,  4 Jun 2019 16:33:55 +0300 (EEST)
Date:   Tue, 4 Jun 2019 16:33:55 +0300
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Jonathan Hunter" <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 00/10] NVIDIA Tegra clocksource driver improvements
Message-ID: <20190604133355.GE29894@pdeschrijver-desktop.Nvidia.com>
References: <20190603185948.30438-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190603185948.30438-1-digetx@gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559655236; bh=2sojii35KxqDwKfii9xBSRKtdkHnDinO/EJKDqXI9KI=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
         X-NVConfidentiality:User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=k+0FH7uj/+J5LyNT46gLV4oI/dgnh2cTKQ5C4mRdT73cX0uHgtKXpMfY5gFO+E01r
         GwBsrw9gHcZSe2GBOoEj5hVOtqfADGMnSIKl7+GKIOreM3HbEigdYOPbPCYamNBJCz
         8cfIgde29EzFB5vRVgIoeHkPpzEoYmvR1rQjaSjUiYL/SiBZizIkqRStkd4g6QAWWS
         hI7WiSIBEj0PHmXtgP0DZjNEkdIEqx/lAC0JGl64i21d0vBmzEhbkDHtSg1RGFZ0FZ
         W4hPHk/S3+CQwMVVs1rrroKe/HFYtI9Fkj/ntakRLsVXgJdoF+v18t4Zq9VdstgUke
         pYE1tqtX7gdxw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 09:59:38PM +0300, Dmitry Osipenko wrote:
> Hello,
> 
> This series primarily unifies the driver code across all Tegra SoC
> generations. In a result the clocksources are allocated per-CPU on
> older Tegra's and have a higher rating than the arch-timer where
> appropriate, the newer Tegra210 is getting support for microsecond
> clocksource and the driver's code is getting much cleaner.
> 
> The series was extensively tested on Tegra20 and Tegra30.
> 
> Changelog:
> 
> v4: In the comment to v3 Peter De Schrijver pointed out that arch-timer
>     isn't affected by DVFS changes and thus it is preferred over tegra-timer
>     on [T114, T210). Added new patch to address that: "Lower clocksource
>     rating for some Tegra's".
> 
>     Daniel Lezcano suggested that it will be worthwhile to rename driver's
>     source file as driver now covers more SoC generations than it initially
>     did. Hence the new "Rename timer-tegra20.c to timer-tegra.c" patch.
> 
> v3: Fixed compilation on ARM64. Turned out that it doesn't have the
>     delay-timer, thanks to Nicolas Chauvet for the report.
> 
>     Added new "Support COMPILE_TEST universally" patch for better
>     compile-test coverage.
> 
> v2: Rebased on recent linux-next. Now all of #ifdef's are removed from the
>     code due to the recent patch that generalized persistent clocksource.
> 
>     Couple other minor cosmetic changes.

Series Acked-By: Peter De Schrijver <pdeschrijver@nvidia.com>
