Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4463FC06510
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 07:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CCDC20B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 07:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I/Asd9kK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbfGAHsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 03:48:52 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45309 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbfGAHsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 03:48:52 -0400
Received: by mail-pl1-f194.google.com with SMTP id bi6so6889057plb.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 00:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LiIfIxZ8yVOrxL7wxFdJNOALpAf3pMqVBXu7vXPB+W4=;
        b=I/Asd9kKKjpZqqnCRZPokZpCnvl8PfSuK2Z9Ww7sGxP/pghuZ1EZGOBrkXti3sjmzm
         H47lqhzA6t8BGlW7+wa0XL0vN755Sn7NAq8SrZ5Scp7uckJfPU5mjz4ry4Q1+2JvxVc9
         hTN4Kck9dUVm4Rg4Y5mFMKuB86LDvX9htXlEHdwEgR5hUcr7UABoqNXsDDE0Wqauvy3q
         lTw5khOJyWBcv1b2xlCWVXqoc0VyVdfZRMrAVioEOnfXCowRA6gOk0UMsPCMNRamSp0T
         xHj/T9q1vb7kPo+n++TkTJAtjVFW3P7qHjpLUeAZ+u07x3T3kc7TyXjyR8Dt5xR3Slha
         EHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LiIfIxZ8yVOrxL7wxFdJNOALpAf3pMqVBXu7vXPB+W4=;
        b=NniRZsJe5KvYH1wdzqo47HxgHnEXGNKLTNKG6zNaVdgTMdtwbapIwks7d+WUiBryaO
         E6N9TTpz0PEXPFuQw2CUCtJg7BIzEFouMYuWA0oYPwoLq/VcKwyHxPzmnS59FPWXCJ4o
         NsymWxCf/+CuVN8XHNwnFOIK6BM1dy0xBwb3cAnSsO8806oUGWdPQqL5rFklfOL21oC2
         hCE4ipXDRIK9hpTQl9lcfxiBVH4DJd9/sYTetfVzMDnM+vh77S4z6wCxsNryKrUd6W74
         99nbGQdKcOmLt4xDmD/tyJIXR5u2HC3jznfTplRd1eeGekeaGAnIHl2I838c92mMS+Xc
         gExQ==
X-Gm-Message-State: APjAAAUO5TF92eT1YqRw4vkD/Bi7apfysn5A8/Ge3TNT+6wDOOPkAUSX
        2Y5CdAkchx35lgTLOltpMqVSAA==
X-Google-Smtp-Source: APXvYqzG91nLECKhoHkU3yYpo0JgtHBaTrcYi3ueg3PLqyptMbhCqdseXyHsktizl97jxn3YzcP04A==
X-Received: by 2002:a17:902:8d95:: with SMTP id v21mr26964419plo.225.1561967331572;
        Mon, 01 Jul 2019 00:48:51 -0700 (PDT)
Received: from localhost ([122.172.21.205])
        by smtp.gmail.com with ESMTPSA id p19sm20598313pfn.99.2019.07.01.00.48.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 00:48:49 -0700 (PDT)
Date:   Mon, 1 Jul 2019 13:18:47 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the pm tree
Message-ID: <20190701074847.onx6irxbhkc5hbp3@vireshk-i7>
References: <20190701133715.702d4b57@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701133715.702d4b57@canb.auug.org.au>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-07-19, 13:37, Stephen Rothwell wrote:
> In file included from drivers/cpufreq/intel_pstate.c:11:
> drivers/cpufreq/intel_pstate.c: In function 'intel_pstate_update_max_freq':
> drivers/cpufreq/intel_pstate.c:912:31: error: 'struct cpufreq_policy' has no member named 'user_policy'; did you mean 'last_policy'?
>   new_policy.max = min(policy->user_policy.max, policy->cpuinfo.max_freq);
                                ^~~~~~~~~~~

Yeah, that was a recent update and I missed this path completely.

> Caused by commit
> 
>   218208538ffe ("cpufreq: Add QoS requests for userspace constraints")

@Rafael: I hope merging below to this commit would be the right thing to do ?

-- 
viresh

-------------------------8<-------------------------
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 9da4dc33b716..99bcdb6d4d83 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1105,7 +1105,7 @@ static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy, unsigned int cp
        return ret;
 }
 
-static void refresh_frequency_limits(struct cpufreq_policy *policy)
+void refresh_frequency_limits(struct cpufreq_policy *policy)
 {
        struct cpufreq_policy new_policy;
 
@@ -1120,6 +1120,7 @@ static void refresh_frequency_limits(struct cpufreq_policy *policy)
 
        up_write(&policy->rwsem);
 }
+EXPORT_SYMBOL(refresh_frequency_limits);
 
 static void handle_update(struct work_struct *work)
 {
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index f2ff5de988c1..cc27d4c59dca 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -898,7 +898,6 @@ static void intel_pstate_update_policies(void)
 static void intel_pstate_update_max_freq(unsigned int cpu)
 {
        struct cpufreq_policy *policy = cpufreq_cpu_acquire(cpu);
-       struct cpufreq_policy new_policy;
        struct cpudata *cpudata;
 
        if (!policy)
@@ -908,11 +907,7 @@ static void intel_pstate_update_max_freq(unsigned int cpu)
        policy->cpuinfo.max_freq = global.turbo_disabled_mf ?
                        cpudata->pstate.max_freq : cpudata->pstate.turbo_freq;
 
-       memcpy(&new_policy, policy, sizeof(*policy));
-       new_policy.max = min(policy->user_policy.max, policy->cpuinfo.max_freq);
-       new_policy.min = min(policy->user_policy.min, new_policy.max);
-
-       cpufreq_set_policy(policy, &new_policy);
+       refresh_frequency_limits(policy);
 
        cpufreq_cpu_release(policy);
 }
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index dca2ae358542..d757a56a74dc 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -200,6 +200,7 @@ void cpufreq_cpu_release(struct cpufreq_policy *policy);
 int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu);
 int cpufreq_set_policy(struct cpufreq_policy *policy,
                       struct cpufreq_policy *new_policy);
+void refresh_frequency_limits(struct cpufreq_policy *policy);
 void cpufreq_update_policy(unsigned int cpu);
 void cpufreq_update_limits(unsigned int cpu);
 bool have_governor_per_policy(void);

