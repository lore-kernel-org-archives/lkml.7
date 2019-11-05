Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7AAC49EAB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6BD21928
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o27oGeaQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730866AbfKEJhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 04:37:23 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40825 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730846AbfKEJhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 04:37:22 -0500
Received: by mail-pg1-f193.google.com with SMTP id 15so13682785pgt.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 01:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jDulaD8yGPSw9RKsvK4+mof/PDtVuO9RYsvVXQwxzXM=;
        b=o27oGeaQFxD86u8gIGPhrzIR6SfI9fMQiBcCgp5sHCQPiaD27PrDoNQBJWtB0QX+dP
         qzXuOric5LOnQdEqqsdBrNIrsOh6QfgTwdZqm8w+5Bbo7Aqbc1nQr+Z2iKKg2xNmpSdW
         XBp/BuUmEQddIvttxGZhA/tCgUFUvbqjcFk/iOpIDzFyrlKHe+nOzDET9BacRvs9g3AQ
         /Z7xa0vBzFtlr1TRIsIb3T8BpEzi5Alw/tFY56gRnfYNBVsRaHVVTnHprjy2VeynAt1u
         HVe3f6kmQpXlYTtVHFnMAEw897EAarckuA+gTg39J3OAKNz5oqgDex9R818HEacqL0TP
         74jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jDulaD8yGPSw9RKsvK4+mof/PDtVuO9RYsvVXQwxzXM=;
        b=E1BdWn8Trp8/DZriBp1yWkOO+xPXkxkCa/lqam4YVePS1LFY8kMWWZPKnUPq4uY/M9
         YZ0mOqWxzVv+XfzVu8eOWarbvQa7eZeXoVSnbuTioSH6PdtgxmYFg5s+uMK9Ko0xE9Hp
         plYqSnAa6UExtWEJa7dMVrmcPuIBSyx5jIlS0k6d6eeF70aG97exBvadB5oZ5bGiZF4Z
         yXKhixzhyvjdCLenf0KzMBq/BVyQaLPLxNnwvY4Uj9lsUlr6KSl3C3xNOW1FJERMkHoV
         1bM/3bOk67rS3s0Ro3TKRS/7yUiUuDrK8mSx+ecOuydtJwJAAnDq9uMvILLvqALvm7yd
         0tSQ==
X-Gm-Message-State: APjAAAV+1cMxZwq3CKPSaAVxZjJeIvGD+IJoLL5ZPfJKD387QBE5bjdQ
        DhilmWMD7I3U0u3Pj19p1iBZ5w==
X-Google-Smtp-Source: APXvYqyzuRVgyvTXTyQjC8xtu0nRUNtH/fWQGOgOhCgO04UFjuK/wTl+n0U3uw5++iupsawbMVoZEA==
X-Received: by 2002:a17:90a:ab83:: with SMTP id n3mr5259220pjq.21.1572946641205;
        Tue, 05 Nov 2019 01:37:21 -0800 (PST)
Received: from localhost ([122.171.110.253])
        by smtp.gmail.com with ESMTPSA id 135sm17540908pgh.89.2019.11.05.01.37.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 01:37:20 -0800 (PST)
Date:   Tue, 5 Nov 2019 15:07:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Ondrej Jirman <megous@megous.com>, linux-sunxi@googlegroups.com,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:ALLWINNER CPUFREQ DRIVER" <linux-pm@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cpufreq: sun50i: Fix CPU speed bin detection
Message-ID: <20191105093717.q5ixjjsnb3aqzxql@vireshk-i7>
References: <20191101164152.445067-1-megous@megous.com>
 <20191103155901.GC7001@gilmour>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191103155901.GC7001@gilmour>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-11-19, 16:59, Maxime Ripard wrote:
> On Fri, Nov 01, 2019 at 05:41:51PM +0100, Ondrej Jirman wrote:
> > I have observed failures to boot on Orange Pi 3, because this driver
> > determined that my SoC is from the normal bin, but my SoC only works
> > reliably with the OPP values for the slowest bin.
> >
> > By querying H6 owners, it was found that e-fuse values found in the wild
> > are in the range of 1-3, value of 7 was not reported, yet. From this and
> > from unused defines in BSP code, it can be assumed that meaning of efuse
> > values on H6 actually is:
> >
> > - 1 = slowest bin
> > - 2 = normal bin
> > - 3 = fastest bin
> >
> > Vendor code actually treats 0 and 2 as invalid efuse values, but later
> > treats all invalid values as a normal bin. This looks like a mistake in
> > bin detection code, that was plastered over by a hack in cpufreq code,
> > so let's not repeat it here. It probably only works because there are no
> > SoCs in the wild with efuse value of 0, and fast bin SoCs are made to
> > use normal bin OPP tables, which is also safe.
> >
> > Let's play it safe and interpret 0 as the slowest bin, but fix detection
> > of other bins to match this research. More research will be done before
> > actual OPP tables are merged.
> >
> > Fixes: f328584f7bff ("cpufreq: Add sun50i nvmem based CPU scaling driver")
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
> 
> Acked-by: Maxime Ripard <mripard@kernel.org>

Applied. Thanks.

-- 
viresh
