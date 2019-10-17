Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63733FA3728
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 02:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39729218DE
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 02:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AaHywvkM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406920AbfJQC3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 22:29:00 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45104 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404182AbfJQC27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 22:28:59 -0400
Received: by mail-pl1-f196.google.com with SMTP id u12so339350pls.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 19:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mJUTEhX3TFcHtz27+83IOXuwWGxntrc9pvOqZY1hpgM=;
        b=AaHywvkMSuy9OnV8rJbxorKjDSfBfAc1ciKJafM0KBuyZdEKajDgUAPvSRruvLwpUd
         s+rQUukzTiEgkCgX9ldvv6cMt0gbvjKrDpPBLWtGtzHtvrxbH6RduRz8o7Oz8xGeausy
         afnLLUqD6xKhLvHoiWflgql6wLjsl8xZjnq+1wfnTXNgfug7Z3XMLWGm51c5WHMjk8X8
         rcUDp/d+Q9Gki6VzIj0FBWno9kMjvauIXpvrMUSWpe9GKmQ4rGGYIJ7VhHK+9ozUOm14
         rg76exgPb9QRPsqoIquFELofX0VLBSiNdb5Efoqxmpwjvl2+q2cHgVZx0N6AEYiP7+5i
         mUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mJUTEhX3TFcHtz27+83IOXuwWGxntrc9pvOqZY1hpgM=;
        b=LUALfpi28GKK4KSpSqGyjAZW+dkqStfJAlg3cAeXSTUEJCtXbluiqvwFTF2Uyn4Z+F
         A9Rh1E2MfpdkzHwy7ywYKl5/sQ96Iz6aohot5eWcDTKxbSnj0oMkBRVZ5wlI0hQFe16M
         IJt9CjWzfuiTDL1QHTJIc7hZE4v2kBPnH1UjlUqlnKFzgU43OIDgALQmsbvgw9tx/8iQ
         m2yM3X8AYG6a2xbUcA3K+msvfLfucJ2eYjHMP5zB3iUGrRFB+zfygRQbX+lujesiAVYG
         6KgyYep09Eq72ytThwzVGZWuRWtlULXk3NLReU3It2zd/1wkNm9rGHyI7njUXsn+iaD8
         mL1Q==
X-Gm-Message-State: APjAAAWbN61ud+UhGSq3gA2NEYUh5v1mDKgMpf9d4S9wMqZj/jaiCKM4
        AaAJXd7hLhP7HxZrWFHZagNFAQ==
X-Google-Smtp-Source: APXvYqwNFLKLkCxw5ab420MkNxcVkjXE2Jlq4h5pXqtFv2s2iZhgQ3vv70QHp3Lxt9QjQiam6DFvtw==
X-Received: by 2002:a17:902:d90e:: with SMTP id c14mr1427032plz.91.1571279337923;
        Wed, 16 Oct 2019 19:28:57 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id x10sm448224pfr.44.2019.10.16.19.28.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 19:28:56 -0700 (PDT)
Date:   Thu, 17 Oct 2019 07:58:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 11/17] ARM: dts: tegra20: Add CPU Operating
 Performance Points
Message-ID: <20191017022854.c23zgp3th7v4afa4@vireshk-i7>
References: <20191015211618.20758-1-digetx@gmail.com>
 <20191015211618.20758-12-digetx@gmail.com>
 <20191016052323.w6hav4qqn3ybt55q@vireshk-i7>
 <ba9d6de0-38dc-a851-cf0a-fb9d06461671@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba9d6de0-38dc-a851-cf0a-fb9d06461671@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-10-19, 16:21, Dmitry Osipenko wrote:
> 16.10.2019 08:23, Viresh Kumar пишет:
> > On 16-10-19, 00:16, Dmitry Osipenko wrote:
> >> Operating Point are specified per HW version. The OPP voltages are kept
> >> in a separate DTSI file because some boards may not define CPU regulator
> >> in their device-tree if voltage scaling isn't necessary, like for example
> >> in a case of tegra20-trimslice which is outlet-powered device.
> >>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>  .../boot/dts/tegra20-cpu-opp-microvolt.dtsi   | 201 ++++++++++++
> >>  arch/arm/boot/dts/tegra20-cpu-opp.dtsi        | 302 ++++++++++++++++++
> >>  2 files changed, 503 insertions(+)
> >>  create mode 100644 arch/arm/boot/dts/tegra20-cpu-opp-microvolt.dtsi
> >>  create mode 100644 arch/arm/boot/dts/tegra20-cpu-opp.dtsi
> >>
> >> diff --git a/arch/arm/boot/dts/tegra20-cpu-opp-microvolt.dtsi b/arch/arm/boot/dts/tegra20-cpu-opp-microvolt.dtsi
> >> new file mode 100644
> >> index 000000000000..e85ffdbef876
> >> --- /dev/null
> >> +++ b/arch/arm/boot/dts/tegra20-cpu-opp-microvolt.dtsi
> >> @@ -0,0 +1,201 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +
> >> +/ {
> >> +	cpu0_opp_table: cpu_opp_table0 {
> >> +		opp@216000000_750 {
> > 
> > Maybe just drop the _750 (i.e. voltage) from the names as we don't generally
> > follow it :)
> 
> The reason for the _750 postfix is that there are multiple OPPs for
> 216MHz and they have different voltages for different versions of
> hardware, thus those are separate OPPs and they can't be squashed into a
> single OPP node.

Ah, okay. I missed that you are using supported-hw bindings.

-- 
viresh
