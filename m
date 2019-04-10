Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1E3C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8183D20674
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SkfAwoJU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbfDJKOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:14:30 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45526 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729876AbfDJKO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 06:14:29 -0400
Received: by mail-pg1-f196.google.com with SMTP id y3so1259215pgk.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 03:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B8ioIUEeiqtVl+ZCSp3JvwV+qbfIptquCFsO7jxIal4=;
        b=SkfAwoJUywdpyqAX3z1tNy5OT98AYB5hAC0i6kdlVvDXPR0cv670KQ0klWoC0F06Fa
         SAlVZ4eLTO1qFiPRdQwPExN0TDn7qIbcM5gPEBVwmDhspPE5/H1br6PqvltaqjBMgoVe
         ibnR6jouewQMDp6B56qib3/sWbaZoHEAP/Dc4qkqoahvfrItIfWAmg0NGIMPQtJAG86u
         IhkAS3AFxC8h8mNqj9JTLncLMr6p1zVffL7LMFc6LXcjDko/BEgxbon/VSQaszB10oa7
         EyxhtGbGIwlK/2Barsr/qX/ASfOFLYlWUC+Cxo/gZWb+YFRY8JzmplvdO4Rs0YV1fjOM
         +R5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B8ioIUEeiqtVl+ZCSp3JvwV+qbfIptquCFsO7jxIal4=;
        b=tYI/6ha3JGKJxy7b3faBfno56+HIbDc8zrqUzMRShZz7dGJB6LtQanW8sPnHBGKH9U
         39TGYkCZbQJHVEXEPp964X93Qdp+F+htsqZhdV9eeO+AprDvchxEqBvO5M0/sNG2Khln
         1QCZbSkjNBsZoFNnDRK/FtFxwCtPBSOlTIpqJkonvnMHEpNylP6AHnpKW+E5p3F1FG7o
         RS4WfxuWxjwBcbddh5np2fzIk02wDaxulQCVtpl9fF7+Twq8qqQGE8eqXuypOl7uaccq
         /bM6Jrxj8nWW6TxvHxzalNZ7jCErBHjAnJ/w3QaXCsnb9TxC77CmZnwdlr/sJXOXC0S9
         uIPg==
X-Gm-Message-State: APjAAAVxFYXOzNYKsGn5TdLnpgkxtz18Iuz2/OBPLBL0XlCrn0X/Z612
        EMEzWdBECAR2vZPMoZNuZdJhkXt7v3o=
X-Google-Smtp-Source: APXvYqwo7+KKU8jVhTU8CQxQvy82MbjdeDtbg3qjgVR3vvqyC2411pwMRRr6uk0FOV7ft026V5NXTw==
X-Received: by 2002:a65:4489:: with SMTP id l9mr39223674pgq.1.1554891267760;
        Wed, 10 Apr 2019 03:14:27 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id v19sm47575587pfn.62.2019.04.10.03.14.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 03:14:26 -0700 (PDT)
Date:   Wed, 10 Apr 2019 15:44:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        amit.kachhap@gmail.com, rjw@rjwysocki.net, will.deacon@arm.com,
        catalin.marinas@arm.com, daniel.lezcano@linaro.org,
        dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] thermal: cpu_cooling: Migrate to using the EM
 framework
Message-ID: <20190410101423.3pl6yfhv2wnxuwgw@vireshk-i7>
References: <20190328101352.25657-1-quentin.perret@arm.com>
 <20190328101352.25657-4-quentin.perret@arm.com>
 <20190410054449.zwmemg7vza557gue@vireshk-i7>
 <20190410085702.nll6spd565oio3ds@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410085702.nll6spd565oio3ds@queper01-lin>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-04-19, 09:57, Quentin Perret wrote:
> Hmm, indeed... I thought cpufreq_table_validate_and_sort() was actively
> sorting the table but it seems I was wrong.
> 
> But I _think_ in practice the freq table actually happens to be sorted
> for the upstream cpufreq drivers with the CPUFREQ_IS_COOLING_DEV flag
> set. Most of them use dev_pm_opp_init_cpufreq_table() which guarantees
> the table is sorted and qoriq-cpufreq explicitly sorts the table. But
> I'm not sure about qcom-cpufreq-hw ...
> 
> So, if the above is true, perhaps I could simply add a check to mandate
> that policy->freq_table_sorted != CPUFREQ_TABLE_SORTED_UNSORTED for
> cpu_cooling ? That shouldn't harm the existing users.

Right, I think most of the platforms will have it sorted anyway right now, but
you never know if one or two of them don't. Maybe just add the above conditional
and put out an error or WARN or something, so people know that something broke.


-- 
viresh
