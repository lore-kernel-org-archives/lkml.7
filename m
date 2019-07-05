Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AFBC46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F08216E3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B7jvm3zL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbfGEKyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 06:54:47 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38218 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728688AbfGEKyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 06:54:46 -0400
Received: by mail-pf1-f194.google.com with SMTP id y15so4174202pfn.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 03:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X+i0ihKUKh9zH/dzyx37jqaQZeuNpViMy5ihMF+r5JI=;
        b=B7jvm3zLDT17WViGsWe6HVTA/RMK9tpN6VU9GKr0lSd18hWimncbyo62MN7pWNSCCb
         JTwdPlcp/eMJYJzbeq9SK7p5T2EBq0FCqS/KM9xTxa5svPDlezsL0Nq94LD4cnO8QCYj
         KkCYcfx339JfDERMEMuk6JudGXunY+F30VXQlsg476viB//NDqdtBz8qHkDpjGcR9CQT
         C0yLJDgCmhMANycaTYl7pFHaWJacdZxWKVaLMdl8QDU4+lrvpbwuCTku6Irz/htz8ZVe
         xMhc+qCDkIUiznXGMrcGig5WzdDNXx0moq4/0U41oQ6NbAbXxmOYO/jMb+D05EyzjGuT
         18hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X+i0ihKUKh9zH/dzyx37jqaQZeuNpViMy5ihMF+r5JI=;
        b=Xp0WReLM0yhH3TKS5D1IkHiVvArB/6EhWdqgYHfO2YieRu2mOOCPw2S4ApgKEvpWYX
         /UIEqsEZel8SuhBDRio8iUPEjWlRUsXjOvJ7t3IxHc96s5eApJDCIiqNIbZ+X/7H4VH0
         R+FJEmFdjk+76DX7DIiY6VymHgYbMTmMc8SvZ2B383XBbyv2EnsQnac5BgMR0lIWvIvs
         uEYo3JQFKpZK+iBMSVDl77GAOwDWqgAfie8J1RJ9CTQml/K7OCkCbYHt553rgTXudvqc
         vQz3RItrcsQqEptij0CLcW6Nq79V2pfTQIKjkOd2xeEYfjSZTJV6+sDEJp5P9hHxPxye
         DxiA==
X-Gm-Message-State: APjAAAXrurXhnhTneLXqDCPK2mWW2DgtqWWRNEOazZImWd+bGnD31jpv
        1zN3rGUF6R+E2uVVZzO+/dUhBQ==
X-Google-Smtp-Source: APXvYqyZrWjQz0cOysQ4pI8fQy5lNaRKRxlNunIMBDivqa/jpRKCAZsjwHlHLjbtd2tPozOp2amXug==
X-Received: by 2002:a63:2323:: with SMTP id j35mr4753028pgj.166.1562324085546;
        Fri, 05 Jul 2019 03:54:45 -0700 (PDT)
Received: from localhost ([223.226.51.128])
        by smtp.gmail.com with ESMTPSA id d12sm8264161pfd.96.2019.07.05.03.54.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 03:54:44 -0700 (PDT)
Date:   Fri, 5 Jul 2019 16:24:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+de771ae9390dffed7266@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Len Brown <len.brown@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: linux-next boot error: WARNING in corrupted
Message-ID: <20190705105442.kpvvyxakpa6mrxlu@vireshk-i7>
References: <0000000000005bf6c3058cde49a7@google.com>
 <8755905.1UUJr7qOyo@kreacher>
 <CACT4Y+awzZOSAseosiUDvs_zk7hFRuQrrr0LjRmVwesVbF_+aQ@mail.gmail.com>
 <20190705104152.wniaje2u5d77iaoa@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705104152.wniaje2u5d77iaoa@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-07-19, 16:11, Viresh Kumar wrote:
> This fixes it for me (after faking the failure). @Rafael this needs to
> be merged to the top commit:
> 
> 0d4c2a013b32 cpufreq: Add QoS requests for userspace constraints

@Rafael: I have sent V7 of this patch now after merging below diff
(and improving it further). Thanks.

> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 13c2f119cc0c..5eecd54195a9 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1228,12 +1228,6 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
>                 goto err_min_qos_notifier;
>         }
>  
> -       policy->min_freq_req = kzalloc(2 * sizeof(*policy->min_freq_req),
> -                                      GFP_KERNEL);
> -       if (!policy->min_freq_req)
> -               goto err_max_qos_notifier;
> -
> -       policy->max_freq_req = policy->min_freq_req + 1;
>         INIT_LIST_HEAD(&policy->policy_list);
>         init_rwsem(&policy->rwsem);
>         spin_lock_init(&policy->transition_lock);
> @@ -1244,9 +1238,6 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
>         policy->cpu = cpu;
>         return policy;
>  
> -err_max_qos_notifier:
> -       dev_pm_qos_remove_notifier(dev, &policy->nb_max,
> -                                  DEV_PM_QOS_MAX_FREQUENCY);
>  err_min_qos_notifier:
>         dev_pm_qos_remove_notifier(dev, &policy->nb_min,
>                                    DEV_PM_QOS_MIN_FREQUENCY);
> @@ -1370,6 +1361,13 @@ static int cpufreq_online(unsigned int cpu)
>                         add_cpu_dev_symlink(policy, j);
>                 }
>  
> +               policy->min_freq_req = kzalloc(2 * sizeof(*policy->min_freq_req),
> +                                              GFP_KERNEL);
> +               if (!policy->min_freq_req)
> +                       goto out_destroy_policy;
> +
> +               policy->max_freq_req = policy->min_freq_req + 1;
> +
>                 ret = dev_pm_qos_add_request(dev, policy->min_freq_req,
>                                              DEV_PM_QOS_MIN_FREQUENCY,
>                                              policy->min);

-- 
viresh
