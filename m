Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A82C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 331312063F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a+wJjnuA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436969AbfFLIZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:25:11 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43732 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731122AbfFLIZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:25:10 -0400
Received: by mail-pl1-f194.google.com with SMTP id cl9so6309958plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 01:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nBMA4cy81IvwlogUNVTSbkNxTIWioniCIzkx/8GVX+Q=;
        b=a+wJjnuAGmyci01wUJwpOo66LfzQLqVmU/rrqkPsB3+Osld40BrLicEQEtRHLj3/qC
         EZlN08bV7dBSutV/DWuhnaeLl99pieDgvwVhqLl7e4muSznARw3f8OB7w75ZVNc+D74f
         6EdbLqHlmtygqDMpa1asruqhvOUlnPCdo4tBsXhAT+65UQDs0y3TNl9YSoPIRd/GVsFx
         XmjVGdH64Mz7adJ1rRtE/3IIhYb0nEDeEKH8Oa+5FELjylx8AK8m9Pr1RY6z8UpX5/kR
         OKJPRv9d4GhdHU/JZe5egfRf0LkDTKONpMhLBLNPl5rLGDpO4dfMwcsW4KM3IutaQ1ip
         QDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nBMA4cy81IvwlogUNVTSbkNxTIWioniCIzkx/8GVX+Q=;
        b=o/0qV03Ougg+yPhCq8ACAR6GGG5YjVgas5qgqfYv58WyzsIUd/m0MqY77nQD3wj9hk
         qV5LqmtIDbvLgXspIXDdRQhte6OcyofS5eDJVnEHBTI3I5CztfSCl6R90i5uZM6Zcyi+
         47SHrWyOTuDMD1fdx3IQSRjuX+Lie50N1Nu9c553CkF10U8DHiPR92d9E7QzEzgYaaxG
         g8DGVuVbb4MkDCZn+XEuJbd3EKIdQaMqtcutj3NCbF2emsmAPmK+/TnzKJweaDO/kC6Y
         /UZZBmSKDcR9frdlDdjn/wfijlXWBie0RbjGGN0OKvg26oPdaRDyhA6ST7Lkno/q7VXy
         MCgA==
X-Gm-Message-State: APjAAAVPlOOvSH3fKl/GfZQoCNZ8W1QyTmE2n/TbKKswNn1ehGaAkZcv
        +f4V7qe3ymAHiPM6rK3E+Slj8g==
X-Google-Smtp-Source: APXvYqybHOJE7k4tfvCUarMEbtrPs2q8NhhT6+odOFeOUT79YnY1t55lTWzVNvdYsbZaV/wXb2zhrA==
X-Received: by 2002:a17:902:b705:: with SMTP id d5mr44986119pls.274.1560327909598;
        Wed, 12 Jun 2019 01:25:09 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id s7sm1822824pgm.8.2019.06.12.01.25.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 01:25:08 -0700 (PDT)
Date:   Wed, 12 Jun 2019 13:55:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     swboyd@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-scsi@vger.kernel.org,
        ulf.hansson@linaro.org, dianders@chromium.org, rafael@kernel.org
Subject: Re: [RFC v2 01/11] OPP: Don't overwrite rounded clk rate
Message-ID: <20190612082506.m735bsk7bjijf2yg@vireshk-i7>
References: <20190320094918.20234-1-rnayak@codeaurora.org>
 <20190320094918.20234-2-rnayak@codeaurora.org>
 <20190611105432.x3nzqiib35t6mvyg@vireshk-i7>
 <c173a57d-a4de-99f7-e8d8-28a7612f4ca3@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c173a57d-a4de-99f7-e8d8-28a7612f4ca3@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-06-19, 13:12, Rajendra Nayak wrote:
> so the 'fmax' tables basically say what the max frequency the device can
> operate at for a given performance state/voltage level.
> 
> so in your example it would be for instance
> 
> 500M, Perf state = 2
> 1G, Perf state = 3
> 1.2G, Perf state = 4
> 
> Now when the device wants to operate at say 800Mhz, you need to set the
> Perf state to 3, so this patch basically avoids you having to put those additional
> OPPs in the table which would otherwise look something like this
> 
> 500M, Perf state = 2
> 800M, Perf state = 3 <-- redundant OPP
> 1G, Perf state = 3
> 1.2G, Perf state = 4
> 
> Your example had just 1 missing entry in the 'fmax' tables in reality its a lot more,
> atleast on all qualcomm platforms.

Okay, I have applied this patch (alone) to the OPP tree with minor
modifications in commit log and diff.

-- 
viresh

-------------------------8<-------------------------

From: Stephen Boyd <swboyd@chromium.org>
Date: Wed, 20 Mar 2019 15:19:08 +0530
Subject: [PATCH] opp: Don't overwrite rounded clk rate

Doing this allows us to call this API with any rate requested and have
it no need to match in the OPP table. Instead, we'll round the rate up
to the nearest OPP, so that we can get the voltage or performance level
required for that OPP. This supports users of the OPP core that want to
specify the possible 'fmax' values corresponding to the voltage or
performance levels of each OPP. And for devices that required the exact
frequency, we can rely on the clk framework to round the rate to the
nearest supported frequency instead of the OPP framework to do so.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
[ Viresh: Massaged changelog and use temp_opp variable instead ]
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 764e05a2fa66..0fbc77f05048 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -757,7 +757,7 @@ static int _set_required_opps(struct device *dev,
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 {
 	struct opp_table *opp_table;
-	unsigned long freq, old_freq;
+	unsigned long freq, old_freq, temp_freq;
 	struct dev_pm_opp *old_opp, *opp;
 	struct clk *clk;
 	int ret;
@@ -796,13 +796,15 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		goto put_opp_table;
 	}
 
-	old_opp = _find_freq_ceil(opp_table, &old_freq);
+	temp_freq = old_freq;
+	old_opp = _find_freq_ceil(opp_table, &temp_freq);
 	if (IS_ERR(old_opp)) {
 		dev_err(dev, "%s: failed to find current OPP for freq %lu (%ld)\n",
 			__func__, old_freq, PTR_ERR(old_opp));
 	}
 
-	opp = _find_freq_ceil(opp_table, &freq);
+	temp_freq = freq;
+	opp = _find_freq_ceil(opp_table, &temp_freq);
 	if (IS_ERR(opp)) {
 		ret = PTR_ERR(opp);
 		dev_err(dev, "%s: failed to find OPP for freq %lu (%d)\n",
