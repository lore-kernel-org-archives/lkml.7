Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88458C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 05:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5996C2072B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 05:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="l5xqIVub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgAHF0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 00:26:33 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:12578 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgAHF0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 00:26:33 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1567d70000>; Tue, 07 Jan 2020 21:25:43 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 07 Jan 2020 21:26:32 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 07 Jan 2020 21:26:32 -0800
Received: from [10.24.44.157] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 Jan
 2020 05:26:25 +0000
Subject: Re: [PATCH v7 13/21] ASoC: tegra: Use device managed resource APIs to
 get the clock
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <gregkh@linuxfoundation.org>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <josephl@nvidia.com>, <daniel.lezcano@linaro.org>,
        <mmaddireddy@nvidia.com>, <markz@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1578457515-3477-1-git-send-email-skomatineni@nvidia.com>
 <1578457515-3477-14-git-send-email-skomatineni@nvidia.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <692ae1f9-ec01-f0e9-9b9a-a0eba3f32e44@nvidia.com>
Date:   Wed, 8 Jan 2020 10:56:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <1578457515-3477-14-git-send-email-skomatineni@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578461144; bh=w+gsWa0qiEkQSfXhM8XZ4JIoQhx/eP1errE4+Rsqd/E=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=l5xqIVubpaNoOoNwLqOYOWizAjo7K2v7/n/TYg/81Uto2BR6zBJUqI9DlxaMjJ9wA
         qNCQ8QWGVjX/5ggpMQqPrx84daWX9h8Yfg9Nw+F69H/q182bWw6sjptir0uDVGUl1F
         WPm0NQrdqf8ynfLk/4vZmMzJuseNxW5GLzuB+GxlE+52la9KKO46N36K8+dhdXrlye
         o+pWY5V8K3jPo4izmxLsFjDOGBTcc3JEiY8kx94qLoupPz82nUG3wMepXT0w363yp5
         NozOnsnXYvk+uQMVc7bMKe3Cro//GQ8qW4JlmU6qT1fb9fD1hjeJKkY4264KotxBjY
         zTNOTVdBHQjZw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/8/2020 9:55 AM, Sowjanya Komatineni wrote:
> tegra_asoc_utils uses clk_get() and clk_put() to get the clock
> and to free them explicitly.
>
> This patch updates it to use device managed resource API
> devm_clk_get() so the clock will be automatically released and freed
> when the device is unbound and removes tegra_asoc_utils_fini() as
> its no longer needed.
>
> Tested-by: Dmitry Osipenko <digetx@gmail.com>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Reviewed-by: Sameer Pujar <spujar@nvidia.com>

> ---
>   sound/soc/tegra/tegra_alc5632.c    |  7 +------
>   sound/soc/tegra/tegra_asoc_utils.c | 34 +++++++---------------------------
>   sound/soc/tegra/tegra_asoc_utils.h |  1 -
>   sound/soc/tegra/tegra_max98090.c   | 22 ++++++----------------
>   sound/soc/tegra/tegra_rt5640.c     | 22 ++++++----------------
>   sound/soc/tegra/tegra_rt5677.c     |  7 +------
>   sound/soc/tegra/tegra_sgtl5000.c   |  7 +------
>   sound/soc/tegra/tegra_wm8753.c     | 22 ++++++----------------
>   sound/soc/tegra/tegra_wm8903.c     | 22 ++++++----------------
>   sound/soc/tegra/tegra_wm9712.c     |  8 ++------
>   sound/soc/tegra/trimslice.c        | 18 ++++--------------
>   11 files changed, 40 insertions(+), 130 deletions(-)
. . .
