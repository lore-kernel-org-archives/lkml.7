Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C450DC31E53
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 03:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929BC21873
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 03:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e68ppl05"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfFQDvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 23:51:04 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:34053 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbfFQDvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 23:51:03 -0400
Received: by mail-pf1-f182.google.com with SMTP id c85so4894972pfc.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 20:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=57FOpX8q6OFc6W9+7flDD5a/Z9hlA87d2qLRqS0QYaA=;
        b=e68ppl05KRRtZIc1up7uMbJ/HjhMgh58+UwxNJKYKlaAGtXco05wfaqv7IgnA1jbKc
         lHnO0U8yljUgdWHpuTfTN/cXV04X3CiRTk1Isbrt43ve37Fb3maMQSD5/n/280jzVolS
         usDQMVtEvfq+0+Fg6mFwdaKgLifFV2xhY3NEjpN+I8Lx+4MwBYpUas/Ve1oA5XQrxilD
         dVXlSp/l/jjHqYcf2x5HbmkVD7fXKOL++1687ZoxfGGLT9kozygpxW38FXdTKU2cdCm/
         Qz15Gc9On/OD28FLeKrmF7JJm8nvC4SwGeURaguzhcHNqaaAMZM5TylX2hnB2ggrwMmu
         v10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=57FOpX8q6OFc6W9+7flDD5a/Z9hlA87d2qLRqS0QYaA=;
        b=cwLI4uFHVcFokqpdmNNQhjI0bLrFdHaNseJ1J912dduQwZjDbk0QXoV6w0J7q99xhs
         LaJHPCWxMqD3ch88Zh6LDJuYAGcrRnTq4fEI+VysP3kiyhnF547hlUNv3rJ87+CPgROt
         IJlviS26zGW2e12OpCpwPWou2va40MXrXwm3PqH8mbZSgXf59uGDuiF38qTJ0OHWhtVM
         0XgUnfihh/vxG4uJtqBkgjqCD1Zy3V7rpzrxXGUxdMq1MytqGSQbNWmgVjoJcF92zaaY
         9CxFi3BMozGFxPKq+pWuO2RGQ1nFqOxoCPAVG9o6nNtEmf8Bm6bRrp9tKrUPyUfxRHpz
         iL5w==
X-Gm-Message-State: APjAAAUq4kzjE13eMJo1MWQ5V6IW2HQ+hKT4IFCFU5jk7QV0AEHGO8SS
        0cqMleXkewhqFrkpQGgQL50oWg==
X-Google-Smtp-Source: APXvYqw7hr8o8WapiyfCJVNaq9F8LVepSPGUar/mLLidClzHNbV4xV6Ezzi7xspIP+K/WxmqHTt6oA==
X-Received: by 2002:aa7:956d:: with SMTP id x13mr72685522pfq.132.1560743462982;
        Sun, 16 Jun 2019 20:51:02 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id l44sm11566082pje.29.2019.06.16.20.51.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jun 2019 20:51:01 -0700 (PDT)
Date:   Mon, 17 Jun 2019 09:20:58 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     swboyd@chromium.org, Rajendra Nayak <rnayak@codeaurora.org>,
        vincent.guittot@linaro.org, mturquette@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-scsi@vger.kernel.org, ulf.hansson@linaro.org,
        dianders@chromium.org, rafael@kernel.org
Subject: Re: [RFC v2 01/11] OPP: Don't overwrite rounded clk rate
Message-ID: <20190617035058.veo7uwqjrpa6kykt@vireshk-i7>
References: <20190320094918.20234-1-rnayak@codeaurora.org>
 <20190320094918.20234-2-rnayak@codeaurora.org>
 <20190611105432.x3nzqiib35t6mvyg@vireshk-i7>
 <c173a57d-a4de-99f7-e8d8-28a7612f4ca3@codeaurora.org>
 <20190612082506.m735bsk7bjijf2yg@vireshk-i7>
 <20190613095419.lfjeko7nmxtix2n4@vireshk-i7>
 <20190614052732.4w6vvwwich2h4cgu@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614052732.4w6vvwwich2h4cgu@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-06-19, 10:57, Viresh Kumar wrote:
> Hmm, so this patch won't break anything and I am inclined to apply it again :)
> 
> Does anyone see any other issues with it, which I might be missing ?

I have updated the commit log a bit more to clarify on things, please let me
know if it looks okay.

    opp: Don't overwrite rounded clk rate
    
    The OPP table normally contains 'fmax' values corresponding to the
    voltage or performance levels of each OPP, but we don't necessarily want
    all the devices to run at fmax all the time. Running at fmax makes sense
    for devices like CPU/GPU, which have a finite amount of work to do and
    since a specific amount of energy is consumed at an OPP, its better to
    run at the highest possible frequency for that voltage value.
    
    On the other hand, we have IO devices which need to run at specific
    frequencies only for their proper functioning, instead of maximum
    possible frequency.
    
    The OPP core currently roundup to the next possible OPP for a frequency
    and select the fmax value. To support the IO devices by the OPP core,
    lets do the roundup to fetch the voltage or performance state values,
    but not use the OPP frequency value. Rather use the value returned by
    clk_round_rate().
    
    The current user, cpufreq, of dev_pm_opp_set_rate() already does the
    rounding to the next OPP before calling this routine and it won't
    have any side affects because of this change.
    
    Signed-off-by: Stephen Boyd <swboyd@chromium.org>
    Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
    [ Viresh: Massaged changelog and use temp_opp variable instead ]
    Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>


-- 
viresh
