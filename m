Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54ED0C606A7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E46820651
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vlQWlkor"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbfGHJ2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 05:28:44 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38546 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbfGHJ2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 05:28:43 -0400
Received: by mail-pl1-f193.google.com with SMTP id az7so484035plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 02:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bzSu12w3x9YIv6MmsFtGgdZlBzpVE7U3Zp3DHJ6/2sc=;
        b=vlQWlkor0s5EALpYGbCMIGhlVz+XUHfcsqKySuV/d5cMd/YzrykeeXc3K40VMILpBg
         5ZjT8h9M+wXijUpsLdtsEuZuALUVJkQP9Xj4R7M52CCcnX/k99UyR2aLnnTDoOv0Kb6N
         iZzobi0WIZHpckcnlWf2efezjFr+fkVmAT2lafG/aAeH7e5yc/t1RGJHcG0RY+ZbHA8T
         EzHuBmwIRI3DCizBhlKbsBMAFuNUJXIZaqp7riDfNkE0FgAozxchlnH/92UiXgny2FO2
         9NdsQ/MumFwkOv5yP7CJV3FVO2mwG2LurQqHEGC6B7jaWhGVWMhcdqkWyyTdxZfuiLi/
         I+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bzSu12w3x9YIv6MmsFtGgdZlBzpVE7U3Zp3DHJ6/2sc=;
        b=M07IWBe5Hma8p+O+QFFaMtpzyMGixNoAW7dpWFoBVZLGOYxeJNbnpcqAwFReQ2vg/q
         t7AGpR2OYysxGcFtpszz44LHtImHketqS+i3l6p2JQxAGxYMp56MCeBHpbE0gYWIFiT+
         ToVxil2tJl5P4q+yfIZJTWIwZCsUsutxoDJqIK9fM3NWkHsqBi7hWK8n1ORXC6h1M50d
         Lm2b2ZTdk+XzF8DmNFlJyP0LvxSd3VXhzX4ekUEOqkdAZlwXteVJrIPBLD3T81KxSi+/
         tab7qn9rVZpM9SL57AtD9Z/kO0Sjy2mHdF4GJ8Cgq/TzK77Wrylfgr5uMCnuOc4WjZl1
         SZ7Q==
X-Gm-Message-State: APjAAAV2FZwHVnRTrr8PsAp5tfKYO5RgVVQ6eT7F9j+PTCZ08DNtTyfD
        b1bc4nRSidFeMGUNA+cTF+sgB9gd3kA=
X-Google-Smtp-Source: APXvYqzk9RnjBLcv3ZNNeU6sbdZ3j4RgpTbBkf+aRX7f/bcCSnLxyQJqPpoqviyWq0CH9m0q53V/ng==
X-Received: by 2002:a17:902:7d8b:: with SMTP id a11mr16514875plm.306.1562578122838;
        Mon, 08 Jul 2019 02:28:42 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id e124sm24872961pfh.181.2019.07.08.02.28.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 02:28:42 -0700 (PDT)
Date:   Mon, 8 Jul 2019 14:58:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: cpufreq notifiers break suspend -- Re: suspend broken in
 next-20190704 on Thinkpad X60
Message-ID: <20190708092840.ynibtrntval6krc4@vireshk-i7>
References: <20190704192020.GA3771@amd>
 <CAJZ5v0gn7FWpqW+WmCzj1=K-pjY=SjRNuEsMR3bRTSO8FzFG=Q@mail.gmail.com>
 <20190705185001.GA4068@amd>
 <CAJZ5v0irbn-Xd47KExw=h7On7KShCm6rThCo0q4-zn=o_x6_HQ@mail.gmail.com>
 <20190706203032.GA26828@amd>
 <20190708030505.kvrg6sh6bd4xzzwa@vireshk-i7>
 <CAJZ5v0hTXtjkatT4wVftPac-LgL1GSAbwLZ0mMDSpFn=8k9Ssg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hTXtjkatT4wVftPac-LgL1GSAbwLZ0mMDSpFn=8k9Ssg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-07-19, 10:28, Rafael J. Wysocki wrote:
> Pavel has tested the latest version of the patch series AFAICS.
> 
> The locking added by the commit in question to
> refresh_frequency_limits() requires an update of
> cpufreq_update_policy(), or it will deadlock in there because of the
> lock acquired by cpufreq_cpu_get() if I haven't missed anything.

Ah, looks quite straight forward.

@Pavel: Can you please try this diff ?

-------------------------8<-------------------------

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 9f68d0f306b8..4d6043ee7834 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1109,16 +1109,12 @@ void refresh_frequency_limits(struct cpufreq_policy *policy)
 {
        struct cpufreq_policy new_policy;
 
-       down_write(&policy->rwsem);
-
        if (!policy_is_inactive(policy)) {
                new_policy = *policy;
                pr_debug("updating policy for CPU %u\n", policy->cpu);
 
                cpufreq_set_policy(policy, &new_policy);
        }
-
-       up_write(&policy->rwsem);
 }
 EXPORT_SYMBOL(refresh_frequency_limits);
 
@@ -1128,7 +1124,9 @@ static void handle_update(struct work_struct *work)
                container_of(work, struct cpufreq_policy, update);
 
        pr_debug("handle_update for cpu %u called\n", policy->cpu);
+       down_write(&policy->rwsem);
        refresh_frequency_limits(policy);
+       up_write(&policy->rwsem);
 }
 
-------------------------8<-------------------------

Though it makes me wonder why I didn't hit this thing. I was using the
cpu_cooling device the other day, which calls cpufreq_update_policy()
very frequently on heat-up. And I had a hair dryer blowing over my
board to heat it up. Lemme check that again :)

@Rafael: You want me to send a new diff patch with Fixes tag this time
if this works out fine ?

-- 
viresh
