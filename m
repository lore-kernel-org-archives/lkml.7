Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCF1C32750
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 23:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2892070C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 23:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="DqhZUmKB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfHLXNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 19:13:04 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:52994 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbfHLXNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 19:13:04 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 466s6V0vSBz6q;
        Tue, 13 Aug 2019 01:11:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1565651491; bh=UJV35mr5bEdziwEqgqSYt8j0RPmmg7Xw/RLjApRfovk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DqhZUmKBvLnAQCY7e/nagfK7xMzuptxoAw0XcqLBycihMGzPIKCCYeaY3JTw9OS7H
         g0FwBoCtfpw1jGMyEAsRa8sqekn8ajpIlWvD+CrtvW3g1VVVUETUqBOfCe+YdRWdU/
         nRRuYTIITgTrVLWOieIjk6K5BUcWyKm3zx7igAjiEK+sG2IvScK5TS0y9byRTeRP+J
         CSssGLNk/cKz5UpuwozLmr+OGspuLiWZ0jCxUTFPsHEVQDe0y+oh/U6RhNe0Dea3AN
         7BG27fs7+Zy7obNQCLRU8/gqZsMKm0xQwMrNCKcHcKCWStvhvS+ROIjp5SOJxsyuQf
         Dkfka+AHqLr1g==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.3 at mail
Date:   Tue, 13 Aug 2019 01:12:58 +0200
From:   =?iso-8859-2?B?TWljaGGzoE1pcm9zs2F3?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh-dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 01/15] clk: tegra20/30: Add custom EMC clock
 implementation
Message-ID: <20190812231258.GA31836@qmqm.qmqm.pl>
References: <20190811210043.20122-1-digetx@gmail.com>
 <20190811210043.20122-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190811210043.20122-2-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 12:00:29AM +0300, Dmitry Osipenko wrote:
> A proper External Memory Controller clock rounding and parent selection
> functionality is required by the EMC drivers, it is not available using
> the generic clock implementation because only the Memory Controller driver
> is aware of what clock rates are actually available for a particular
> device. EMC drivers will have to register a Tegra-specific CLK-API
> callback which will perform rounding of a requested rate. EMC clock users
> won't be able to request EMC clock by getting -EPROBE_DEFER until EMC
> driver is probed and the callback is set up.
[...]
> diff --git a/drivers/clk/tegra/Makefile b/drivers/clk/tegra/Makefile
> index 4812e45c2214..df966ca06788 100644
> --- a/drivers/clk/tegra/Makefile
> +++ b/drivers/clk/tegra/Makefile
> @@ -17,7 +17,9 @@ obj-y					+= clk-tegra-fixed.o
>  obj-y					+= clk-tegra-super-gen4.o
>  obj-$(CONFIG_TEGRA_CLK_EMC)		+= clk-emc.o
>  obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += clk-tegra20.o
> +obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= clk-tegra20-emc.o
>  obj-$(CONFIG_ARCH_TEGRA_3x_SOC)         += clk-tegra30.o
> +obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= clk-tegra20-emc.o
>  obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= clk-tegra114.o
>  obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= clk-tegra124.o
>  obj-$(CONFIG_TEGRA_CLK_DFLL)		+= clk-tegra124-dfll-fcpu.o

Doesn't it complain when both CONFIG_ARCH_TEGRA_2x_SOC and
CONFIG_ARCH_TEGRA_3x_SOC are enabled at the same time?

Best Regards,
Micha³ Miros³aw
