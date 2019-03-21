Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C09C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C53218D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fjDK9Dkq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbfCULlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 07:41:44 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35248 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbfCULln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 07:41:43 -0400
Received: by mail-wm1-f67.google.com with SMTP id y197so2352175wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 04:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Kk3qRaZkUHMzTMWgNZmLC/J01FA9A8MR5I4diocBK9M=;
        b=fjDK9DkqpVdBZjlYHxp3S1SPgc6Hif+B1BlBJRgtsDv+gDGxppFcxsoY8YigxjOh01
         XTD6Yh1Qhz31qu3RX7KcGxi9KrSqO/QRo+EjfAkuce1WhDul1PTjzlfhJJf0t05vh8od
         9holYbu+tTJShn9I8zL2McQI9WUdqPOYB+MVo0aZOPw5nvkjo0Yjn5leYKnw+6CrRrqz
         xtExo7cugaNNklSbh2tkrPlMmIcNnPIh8ZSKjMVmxA0cy1lBVeIk1EQyCoJ1vmjisJL2
         A8tQY/GsGB+qdU/yMkkqzG9HPTjW15EUX2+9qEej3NyppQZs50QACz9Ofw7BEu8fhnhr
         COHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Kk3qRaZkUHMzTMWgNZmLC/J01FA9A8MR5I4diocBK9M=;
        b=CFWA0xs6K4TUOHNYkQ3iHrtwDfEYF6Fcj2+5mCoVut3rx41I6aWri/kncMs7KMOPTi
         GHMcdONb+q7VJCUlhfVaMGl3tr2W/bpwKNklHDQA5jyWTI0EazBMDpsb4nhNG7ttczT+
         caIj9b89oTzenNJgiF+RouJguvobDWdUctb6mHuCzCBKlRtFvGRldU8OqZeapi5HMvy8
         tE31hPXLBzUih0SGFyjpwZuglA+crtrOwaoxOnmdx1IjFDXEZF+PRlbYfzTMmK1QS/Mj
         1NmWwIP+da5gx4L4XjqN1ED6wzs3RfA5YAmEVtTARR0tmUye7ekxkbxoywFRc1WYe8ek
         w0Qw==
X-Gm-Message-State: APjAAAWPeFFZ8h3TxKZ3HLtq8e02DgZb6EZc9spGEpeHlOME8DjV8lK8
        5n9oblqYTrqLjT+Rx7x4LAJavtTeFdg=
X-Google-Smtp-Source: APXvYqzKtB7vbLwvN58ImgWmzRuaOuHerZSf+nkstB8SruUEOw1cVj2uWyZuYSsJ2Eu53mQCB7fC0A==
X-Received: by 2002:a1c:d0c7:: with SMTP id h190mr2300573wmg.17.1553168501633;
        Thu, 21 Mar 2019 04:41:41 -0700 (PDT)
Received: from [192.168.0.41] (27.78.95.92.rev.sfr.net. [92.95.78.27])
        by smtp.googlemail.com with ESMTPSA id v20sm11365169wmj.2.2019.03.21.04.41.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 04:41:40 -0700 (PDT)
Subject: Re: [PATCH v12 4/4] PM / Domains: Add genpd governor for CPUs
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190227195836.24739-1-ulf.hansson@linaro.org>
 <20190227195836.24739-5-ulf.hansson@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <89b2583d-672c-4264-a627-d0b606c3d076@linaro.org>
Date:   Thu, 21 Mar 2019 12:41:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190227195836.24739-5-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2019 20:58, Ulf Hansson wrote:
> As it's now perfectly possible that a PM domain managed by genpd contains
> devices belonging to CPUs, we should start to take into account the
> residency values for the idle states during the state selection process.
> The residency value specifies the minimum duration of time, the CPU or a
> group of CPUs, needs to spend in an idle state to not waste energy entering
> it.
> 
> To deal with this, let's add a new genpd governor, pm_domain_cpu_gov, that
> may be used for a PM domain that have CPU devices attached or if the CPUs
> are attached through subdomains.
> 
> The new governor computes the minimum expected idle duration time for the
> online CPUs being attached to the PM domain and its subdomains. Then in the
> state selection process, trying the deepest state first, it verifies that
> the idle duration time satisfies the state's residency value.
> 
> It should be noted that, when computing the minimum expected idle duration
> time, we use the information about the next timer/tick that is stored in
> the per CPU variable, cpuidle_devices, for the related CPUs. Future wise,
> this deserves to be improved, as there are obviously more reasons to why a
> CPU may be woken up from idle.
> 
> Cc: Lina Iyer <ilina@codeaurora.org>
> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

