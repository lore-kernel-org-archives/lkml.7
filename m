Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDF6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0C4218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wmQ3jTzI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbfCUKEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 06:04:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43757 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbfCUKEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 06:04:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id d17so5848443wre.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 03:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AMpkmUXacpqX4+2hG71MIDiFucmFy1SzxtnoKlWQwY0=;
        b=wmQ3jTzIgfjyfgbEGvrYPmQ0UmIuds2DGRpuHeGR8yRat4IZ8ELyCesEOaJLdatcFt
         T5FElpN69K3uptWEGxDVFww4IqVWLMJVttsI3O3Ki5/GafIkAGz3gF3/wzt5KKmuOT+O
         5F7tn1dmlqSp5214Td4heDMBdXRIw2vtqUkR0OWAFIwXBu9NPb81ICiFDX+v0iItlKpH
         ypG7GxX5/pMTWePAHKzkLrKNfokNhMwiz5hS4n5hv/1jILcCQ/E/0WBSwRzpaN83G2AG
         QUWCqXfDOkDUsj9mm2oF4457s2HGoJ8SgmFe1PEW0YeHBNasgpYtYlmNhPlTt/R4P09/
         XZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AMpkmUXacpqX4+2hG71MIDiFucmFy1SzxtnoKlWQwY0=;
        b=thvIU9/bhDyVInp+E0SPAp5pAm95+sF364DF8q/BN3E46Y9seNdIi+hfLQZ2aSuVqw
         gnwZ9Z4/6wxhmoqqy/drIlQKPIbGeY80qu/s65QjLUOuaNcCMtV7EPzc4jLMczVXR571
         Ma54iolF3fsdARh+7XW0q5pOdwJs5XH60nvaZeqPKcpFI7uq1AeiRne/9LtrByyP5w4X
         Y0YbTqm1asaYSwoUiwXuVJEY9Vf0O0EkkLRF1k/nNvIhfoUD0owbGhcoUtBMKWBPbOqd
         j9ropDlVyExyns0CMJvPHQ6UUIdl8Q/SSdzDnwksclxcW3ZUhp8MiGDcywyPTMH5wh8e
         orXg==
X-Gm-Message-State: APjAAAUqpRpdhdRInk1HsXil3Rs80TqfMGcV1rbhT+FjgIy9KqwYpL9N
        zh3CMvur3k+FG/8JkKUwHXEyQuokHrY=
X-Google-Smtp-Source: APXvYqzMAD+tKcDeEtf1jjqHo+O8P2YJNPPf+q/PtBwutFsGxjs+5ow3PNbCxCLvHcI4XFjSO4GD1A==
X-Received: by 2002:adf:f7cc:: with SMTP id a12mr1525675wrq.87.1553162651227;
        Thu, 21 Mar 2019 03:04:11 -0700 (PDT)
Received: from [192.168.0.41] (27.78.95.92.rev.sfr.net. [92.95.78.27])
        by smtp.googlemail.com with ESMTPSA id l4sm14807409wrf.35.2019.03.21.03.04.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 03:04:10 -0700 (PDT)
Subject: Re: [PATCH v12 3/4] cpuidle: Export the next timer/tick expiration
 for a CPU
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
 <20190227195836.24739-4-ulf.hansson@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <209bb2d7-a7cd-cc27-7d96-35b596b7bab2@linaro.org>
Date:   Thu, 21 Mar 2019 11:04:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190227195836.24739-4-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2019 20:58, Ulf Hansson wrote:
> To be able to predict the sleep duration for a CPU that is entering idle,
> knowing when the next timer/tick is going to expire, is extremely useful.
> Both the teo and the menu cpuidle governors already makes use of this
> information, while selecting an idle state.
> 
> Moving forward, the similar prediction needs to be done, but for a group of
> idle CPUs rather than for a single idle CPU. Following changes implements a
> new genpd governor, which needs this.
> 
> Support this, by sharing a new function called
> tick_nohz_get_next_hrtimer(), which returns the next hrtimer or the next
> tick, whatever that expires first.
> 
> Additionally, when cpuidle is about to invoke the ->enter() callback, then
> call tick_nohz_get_next_hrtimer() and store its return value in the per CPU
> struct cpuidle_device, as to make it available outside cpuidle.
> 
> Do note, at the point when cpuidle calls tick_nohz_get_next_hrtimer(), the
> governor's ->select() callback has already made a decision whether to stop
> the tick or not. In this way, tick_nohz_get_next_hrtimer() actually returns
> the next timer expiration, whatever origin.
> 
> Cc: Lina Iyer <ilina@codeaurora.org>
> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> Co-developed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

