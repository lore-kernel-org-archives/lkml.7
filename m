Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742BFCA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4956B2082C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vUspotA4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404124AbfJRFiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:38:51 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45965 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391330AbfJRFiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:38:50 -0400
Received: by mail-pf1-f194.google.com with SMTP id y72so3121154pfb.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=favjdzRU1rfhU7ChOjnx/HV3JdEGUj6dDH+WdrDvfms=;
        b=vUspotA4ZuOGuUodX8gkdySdRLnqUW6TrEa8jP7fdzEC6CUR0IFEdhDYtqqG5iYSeZ
         FHZThIg5bXROG9MY/BtWzzZ23fBXFgSDOiwVwXeDCxPlNABXxDDx02KCK5xGy9+9xd4U
         grU+4C0WZRYGSoxz23MkOrzJ/dJVY56ENmyUJyZ3fH7/LqwyuI1X0qWx2qjLzKdPoFnN
         yxG/5Vzbzl+ptro/zEiK7mP+JcmUZL7Qg33nkqwodfeNOLVV7kUyxZIScfjYz3yvZqQ9
         xWOxkGqK+bJ+fOnw6UlBRJaBx1k8JLSXefW6psXIhSWWNLvmZaG6P73lmFHbbPMsYI75
         jaKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=favjdzRU1rfhU7ChOjnx/HV3JdEGUj6dDH+WdrDvfms=;
        b=LY4xjjNdazxe5X79FggIfsZ/SI42zHRdW4PNUgw5ny07IgaPe5Zv+IK8Yo4vZb327r
         Hqivnc7DqYNuaduVPZ4u33nLYi82ROL5e7PFc9Qy8zaQ2VRD1m0uglmTIPLVXdrvszjq
         aItycbS2zntZo9NuytT6FPcjsxix+Yv/4+qb9SSjYH5kH+EO/xfclQv3brMq7XmUGq1i
         Mq9mM1Bfg4tp2scid4WybBS142SXBCmLGDxnks+YtsVRm1Zxt5NZmmyZAHpzhykWJCNl
         cPxIRwZDCALV6SzmZ9hZN0OT0BGLo4XVEpWgH4gr16B908DFFlHPOSELKQEdudz5Y9TK
         ehWA==
X-Gm-Message-State: APjAAAXhuHgx7/dUhS6/PZXDR/l4LqYNYMbIBecnIVBJePJebrCX2Lx7
        oYdGZNWyTXa9ewljQJvRzC2xZw==
X-Google-Smtp-Source: APXvYqwAf78oDe4HV2k0xDu05GH8JYfHA0WpKkJGlDFTWKOn1FS3MDAG/e3XGdMC15CBnZUy2Ghrcg==
X-Received: by 2002:a17:90a:ad95:: with SMTP id s21mr8860945pjq.11.1571377129786;
        Thu, 17 Oct 2019 22:38:49 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id i16sm4824533pfa.184.2019.10.17.22.38.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 22:38:47 -0700 (PDT)
Date:   Fri, 18 Oct 2019 11:08:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: flush any pending policy update work scheduled
 before freeing
Message-ID: <20191018053844.s2fbk2le6uz3chk6@vireshk-i7>
References: <20191017163503.30791-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017163503.30791-1-sudeep.holla@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-10-19, 17:35, Sudeep Holla wrote:
> dev_pm_qos_remove_request ends calling {max,min}_freq_req QoS notifiers
> which schedule policy update work.

I don't think that's correct. We remove the notifiers first and then
only remove the requests. Though it is possible due to the other bug
we are discussing where the notifier doesn't really get removed from
the right CPU, but even that patch didn't fix your issue.

Looks like we are still missing something ?

> It may end up racing with the freeing
> the policy and unregistering the driver.
> 
> One possible race is as below where the cpufreq_driver is unregistered
> but the scheduled work gets executed at later stage when cpufreq_driver
> is NULL(i.e. after freeing the policy and driver)
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000001c
> pgd = (ptrval)
> [0000001c] *pgd=80000080204003, *pmd=00000000
> Internal error: Oops: 206 [#1] SMP THUMB2
> Modules linked in:
> CPU: 0 PID: 34 Comm: kworker/0:1 Not tainted 5.4.0-rc3-00006-g67f5a8081a4b #86
> Hardware name: ARM-Versatile Express
> Workqueue: events handle_update
> PC is at cpufreq_set_policy+0x58/0x228
> LR is at dev_pm_qos_read_value+0x77/0xac
> Control: 70c5387d  Table: 80203000  DAC: fffffffd
> Process kworker/0:1 (pid: 34, stack limit = 0x(ptrval))
> 	(cpufreq_set_policy) from (refresh_frequency_limits.part.24+0x37/0x48)
> 	(refresh_frequency_limits.part.24) from (handle_update+0x2f/0x38)
> 	(handle_update) from (process_one_work+0x16d/0x3cc)
> 	(process_one_work) from (worker_thread+0xff/0x414)
> 	(worker_thread) from (kthread+0xff/0x100)
> 	(kthread) from (ret_from_fork+0x11/0x28)
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/cpufreq/cpufreq.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> Hi Rafael, Viresh,
> 
> This fixed the boot issue I reported[1] on TC2 with bL switcher enabled.
> I have based this patch on -rc3 and not on top of your patches. This
> only fixes the boot issue but I hit the other crashes while continuously
> switching on and off the bL switcher that register/unregister the driver
> Your patch series fixes them. I can based this on top of those if you
> prefer.
> 
> Regards,
> Sudeep
> 
> [1] https://lore.kernel.org/linux-pm/20191015155735.GA29105@bogus/
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index c52d6fa32aac..b703c29a84be 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1278,6 +1278,9 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>  	}
>  
>  	dev_pm_qos_remove_request(policy->min_freq_req);
> +	/* flush the pending policy->update work before freeing the policy */
> +	if (work_pending(&policy->update))
> +		flush_work(&policy->update);

This diff surely makes sense even without the QoS stuff, this race can
still happen, very unlikely though.

And yes, you must use the other variant that Rafael suggested, we are
already doing similar thing in a bunch of cpufreq governors :)

And I will probably add this after calling
dev_pm_qos_remove_notifier() for the MAX policy as this doesn't and
shouldn't depend on removing the qos request.

>  	kfree(policy->min_freq_req);
>  
>  	cpufreq_policy_put_kobj(policy);
> -- 
> 2.17.1

-- 
viresh
