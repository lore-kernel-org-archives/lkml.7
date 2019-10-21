Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C72CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D282084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LMChVAZf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfJUK4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 06:56:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42478 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbfJUK4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:56:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id q12so8194042pff.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 03:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wF1+8YZQPASjCzMnoxagVtf09QEbjdj0mZoAlrVP5Cs=;
        b=LMChVAZfWEwWAiP/W1Lpr/Cx13RyxCKmAavy8ARHSE4X1bKwsHSOjkhCrrk7dHU5uK
         MCnnOrefKvNyBpX1eeKrTQF+yTBqFuHYojitYoMR56/2y8GZhU8/zWMgweVVc873sN9N
         1vEQMgvMCqicCakx/fhau0P2MFX2vzXWq3jkcu4taXakMKDfvp5OlA9Wzmt2f+D9Xkx4
         f1TjJZfyHyWrvvN3X0wx2BOOzi/o3DydEymPA2Y/LynPyBatfsmGoTCP1PV5iplm0rrx
         aiu2+O1aHTKTv9MbqnKXQr3LbUw2fvIZ996Q+YyrTm7X4kW9D61ycInxcVzyk1Hvg/Np
         km3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wF1+8YZQPASjCzMnoxagVtf09QEbjdj0mZoAlrVP5Cs=;
        b=HAFO9OU0M0xIX1Rd9EaqApV0Wj72kXsuvwNM6h1ZwVCdf11ECiIazPuf3zxv1kgjaS
         t9kLBSpdrXjEhIfRBQ9mz6of7lUZerlmjqrff8gc6pHUP0SXWUCtu7/oc+P5yqnM68AF
         UsKGGHiNEfLFl+H5gXtqcVb74KXRauAHOZQIMbOZL2jqMBrwvUW8Aw5159KUGb17TZog
         DRpRjHDi4gudRxqEJFGNnaiB1GRc3w5BS8g9KXLJUUzLaCvdJ5IHI2xT60iHRGdvpwJI
         MgeysyK5Uo0Ut0fjNFaT/cffcgbTGq29pI7tEkkm5EKgXzc0474zzJqzq4fmSvlpb8bQ
         xQ2w==
X-Gm-Message-State: APjAAAW0RE2lf/1FUVoswqt3XR5bhcDnDTVOFYt6oOODW/R188irwAWN
        9FaE/ucZ6fLgeGNchUZAC2WYgw==
X-Google-Smtp-Source: APXvYqxtkhlEHrd59Xgs4FPY7IgW8ANyk/EGhMAMJhBaYKDI8tISB5wQrYi5RgTUkoGiQD3QnsJCmQ==
X-Received: by 2002:a17:90a:35a5:: with SMTP id r34mr26976603pjb.40.1571655362925;
        Mon, 21 Oct 2019 03:56:02 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id y17sm22150159pfo.171.2019.10.21.03.56.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 03:56:02 -0700 (PDT)
Date:   Mon, 21 Oct 2019 16:25:59 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: flush any pending policy update work scheduled
 before freeing
Message-ID: <20191021105559.fqmf3pcvxxeh2ote@vireshk-i7>
References: <20191017163503.30791-1-sudeep.holla@arm.com>
 <20191018060247.g5asfuh3kncoj7kl@vireshk-i7>
 <20191018101924.GA25540@bogus>
 <4881906.zjS51fuFuv@kreacher>
 <20191018110632.GB25540@bogus>
 <20191021021551.bjhf74zeyuqcl4w3@vireshk-i7>
 <20191021102730.GA21581@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021102730.GA21581@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-10-19, 11:27, Sudeep Holla wrote:
> I just tested now with today's linux-pm/bleeding-edge branch.
> And even if I move cancel_work_sync just after freq_qos_remove_notifier,
> it works fine now. It was not the case on Friday.
> 
> Is that what you wanted to check or something else ?
> 
> Regards,
> Sudeep
> 
> -->8
> 
> diff --git i/drivers/cpufreq/cpufreq.c w/drivers/cpufreq/cpufreq.c
> index 829a3764df1b..48a224a6b178 100644
> --- i/drivers/cpufreq/cpufreq.c
> +++ w/drivers/cpufreq/cpufreq.c
> @@ -1268,6 +1268,9 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>         freq_qos_remove_notifier(&policy->constraints, FREQ_QOS_MIN,
>                                  &policy->nb_min);
> 
> +       /* Cancel any pending policy->update work before freeing the policy. */
> +       cancel_work_sync(&policy->update);
> +
>         if (policy->max_freq_req) {
>                 /*
>                  * CPUFREQ_CREATE_POLICY notification is sent only after
> @@ -1279,8 +1282,6 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>         }
> 
>         freq_qos_remove_request(policy->min_freq_req);
> -       /* Cancel any pending policy->update work before freeing the policy. */
> -       cancel_work_sync(&policy->update);
>         kfree(policy->min_freq_req);
> 
>         cpufreq_policy_put_kobj(policy);

Yes, send a incremental patch for that. Thanks.

-- 
viresh
