Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B590C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2234D207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="cyF0l7Y7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgAGMi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 07:38:59 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11015 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728109AbgAGMi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 07:38:57 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e147bcf0000>; Tue, 07 Jan 2020 04:38:39 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 07 Jan 2020 04:38:56 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 07 Jan 2020 04:38:56 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 Jan
 2020 12:38:55 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 Jan
 2020 12:38:55 +0000
Received: from [192.168.22.23] (10.124.1.5) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 7 Jan 2020 12:38:53 +0000
From:   Thierry Reding <treding@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "Mikko Perttunen" <cyndis@kapsi.fi>,
        Wolfram Sang <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/9] i2c: tegra: Fix suspending in active runtime PM state
In-Reply-To: <20200106010423.5890-2-digetx@gmail.com>
References: <20200106010423.5890-2-digetx@gmail.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Message-ID: <e2342be158e84496ba99ec26ad506292@HQMAIL105.nvidia.com>
Date:   Tue, 7 Jan 2020 12:38:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578400719; bh=yUlzoUmEWEuVYLFL8uw99xkZj0/vPM8e/0q6WO3gKUg=;
        h=X-PGP-Universal:From:To:CC:Subject:In-Reply-To:References:
         X-NVConfidentiality:MIME-Version:Message-ID:Date:Content-Type:
         Content-Transfer-Encoding;
        b=cyF0l7Y7WvqE7gvJa5F8TwWyj4PVWBYayuhS9kPFxWXoJHP5gVYsKTKqzxqwutDni
         IK0w8D3O5OapHRSsR9ZGxGhZAAWhVqR833ZxWTokf7VcGN8u9hXb41NEn3qNBkM9Py
         xc5nfIOftOSWInnbqY8vpMjvtglUYhOYddJF1Y7qolnpTan5TcZwOVI6YG0itLN+YG
         /6zBBThTOgLcTEw7bld3d4II043z7FVG3dmokLGRknHrc7W1XZJQhFAs/p1dxojWer
         4CemF4alnZPBDP7bSXVcCA+V7/iRmnrqTnjlIZBCAOvg1tZqZSb6cFLXthQsyqDzfS
         4AHlm9GkuwLEg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Jan 2020 04:04:15 +0300, Dmitry Osipenko wrote:
> I noticed that sometime I2C clock is kept enabled during suspend-resume.
> This happens because runtime PM defers dynamic suspension and thus it may
> happen that runtime PM is in active state when system enters into suspend.
> In particular I2C controller that is used for CPU's DVFS is often kept ON
> during suspend because CPU's voltage scaling happens quite often.
> 
> Fixes: 8ebf15e9c869 ("i2c: tegra: Move suspend handling to NOIRQ phase")
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/i2c/busses/i2c-tegra.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Tested-by: Thierry Reding <treding@nvidia.com>
