Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A775EC33C9A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 05:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EECD21734
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 05:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YUsvcYgU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgAFFpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 00:45:02 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40847 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgAFFpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 00:45:01 -0500
Received: by mail-pl1-f195.google.com with SMTP id s21so18688828plr.7
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jan 2020 21:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gE/Gid9i9PsBYsQlg4fmp57Ncbkyju9XGadeZRX0gF4=;
        b=YUsvcYgUUc5z5cDmx8TusJQdedghyS4mO/+HKbOr+CblccrQl+0cwBT/vWzbe0MHx2
         QygMwZvxE2N9VK/mg1gpYFlKhzqVWWQDfFDD06SaYUeNbJk1uKxokGj70ZQUsNpKbctH
         FcK9o5kCJ58G6vlgT2qslLidoX4nKlSzRwsXMA/lpRPCnTg5vcLZCnt1RYfngBon8GVt
         BizW140hesxr64i4pb/Nqt++6R7w/yZ1EQ6XAwj0PuWyZ19c4HyMp2Il8xuOT/UQuLW/
         ixThiTGoEbMLhxGOmd03HKC19gcrvrpV53g3LS4laULn8mfedP0+ba3r5p6XqVAc3KE/
         r9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gE/Gid9i9PsBYsQlg4fmp57Ncbkyju9XGadeZRX0gF4=;
        b=pjYbuQqOFP3lRYQ4LNZxkgKswIF4EodACWv4cAFVx6iN8Xp2HRkrA3VBA2HNaqK/0A
         Tb3gVSdxv9o9R5QowLKuf22HKoGrJYTYLu4jwv//0Y/7Y5N9v20LcO53QtUiwlGsMH6G
         ywFmceHP1DM7OT6/Z6VdeWuCJL7hmUbZ6IrDBg+z1zzSUWPB0btR6DmxZlnMfigDTYHi
         Awv8oDGAurfUi57EfXsCYJOUlwYEl4bld+XqHO0Yd36USXzr3YVQ1Mo+ht5aZ1BCCdQh
         sEyg58ejW7HQ6upctVPsTL/vvNFv4HgoWjxgJ8xHhgxbKxFjbKZ1N/uKwfU3qOWYJ47L
         3pcw==
X-Gm-Message-State: APjAAAXVc/DXaDXCw0/NwpfWIY9/nx1Vg2hfhic3+LFIVWsIk5f7UIr5
        SztUeR1qGcoI7nkakXdc/UIzIw==
X-Google-Smtp-Source: APXvYqzWXlQqvmRVI1MoLPER/6vOzIRLLhjY3gbCu4p9smluhkTOdAjJDcJ2o3CSCudp542u0BhlaQ==
X-Received: by 2002:a17:902:8a8e:: with SMTP id p14mr104008787plo.28.1578289500553;
        Sun, 05 Jan 2020 21:45:00 -0800 (PST)
Received: from localhost ([122.172.26.121])
        by smtp.gmail.com with ESMTPSA id n26sm74694101pgd.46.2020.01.05.21.44.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Jan 2020 21:44:59 -0800 (PST)
Date:   Mon, 6 Jan 2020 11:14:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     qiwuchen55@gmail.com
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH] cpufreq: powernow-k8: avoid use after free issue in
 cpufreq_notify_transition()
Message-ID: <20200106054457.sgz4uevykvkqdqzt@vireshk-i7>
References: <1577501824-12152-1-git-send-email-qiwuchen55@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577501824-12152-1-git-send-email-qiwuchen55@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-12-19, 10:57, qiwuchen55@gmail.com wrote:
> From: chenqiwu <chenqiwu@xiaomi.com>
> 
> There is a potential UAF issue in cpufreq_notify_transition() that the
> cpufreq of current cpu has been released before using it. So we should
> make a judgement and avoid it.
> 
> Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
> ---
>  drivers/cpufreq/powernow-k8.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
> index 2db2f17..7391eb0 100644
> --- a/drivers/cpufreq/powernow-k8.c
> +++ b/drivers/cpufreq/powernow-k8.c
> @@ -913,6 +913,11 @@ static int transition_frequency_fidvid(struct powernow_k8_data *data,
>  	freqs.new = find_khz_freq_from_fid(fid);
>  
>  	policy = cpufreq_cpu_get(smp_processor_id());
> +	if (!policy) {
> +		pr_debug("cpu %d: CPUFreq policy not found\n",
> +			 smp_processor_id());
> +		return 1;
> +	}

You $subject and this change doesn't look related to me. The cpufreq
policy shall never be NULL here as we are in the middle of changing
frequency, initiated by cpufreq core itself.

>  	cpufreq_cpu_put(policy);
>  
>  	cpufreq_freq_transition_begin(policy, &freqs);
> -- 
> 1.9.1

-- 
viresh
