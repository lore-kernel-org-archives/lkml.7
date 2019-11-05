Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC76AC49EAA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30BF20869
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="endRY/Rl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbfKEJEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 04:04:32 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35344 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730525AbfKEJEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 04:04:32 -0500
Received: by mail-pl1-f193.google.com with SMTP id x6so9052198pln.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 01:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X1aa+RRLCGC9my2m6kd83snLA2qyRmty2v6y1d5R9P0=;
        b=endRY/Rltnfhp07fO3ptST2djGJsP4DdqdYX5XkzofqOnX0ENzldtbpHu3ndfGNcRC
         WhzHSKVymDgWvFSuGgBDAcZNiaAQrJYFYWb6zhrouxvKjKspy7ST+c28KInjRb7c6HH6
         1bk0NKQLwE9OCUPkuIqVkw8JncayJ8YYWwxkLfPPSOosU91aQqmZHGGHX1+L6vCwWz7b
         q/IoI67ej+buHog5IwRC22tzfHy8P5grReGhijAXvOPweJ5VAJZzBtUISBRBgsi+uXW0
         9okhfeWC3Qnr7wPFDHtC5VtqVGxGQjbYgoBHoiBMzuWTGO6Q6fQk2w2BTOgX5FP9uWmV
         vMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X1aa+RRLCGC9my2m6kd83snLA2qyRmty2v6y1d5R9P0=;
        b=LWAmRx/Y+Du9qLaEZlxgYOHNuQ6Dc4iK7fBbPVC3xGSi76Gfcdx7srH9DKUTS/nydT
         ALtuFirvQbTnbNTGVif+yJ5zle58X7buO5oTzEnkC2OcvoJ6bA5boy+Gnzz6138TfTIf
         QwCzvg36QIx4ufOi1tkwz4uQ2NkhM8CUW4HP2OHZoC7yDa4ZtGCDobYg3RWWpf01Wkel
         miE0//58Z8BvvH9N2ht9w9YaoA9VOwo48Xz3XdrsFfvVArv+8ogYkuh3Ge7krAGG8yEg
         Mkgs8v+741Byhu8lFz07MrZ/r4eh1jqR0TnluYx1S10Z5kLWCTpXrd+Bhp8d6ONclcL3
         vHQQ==
X-Gm-Message-State: APjAAAVHgjKfnNHu+vMLcq/WBCc+MKbOTrNxy9R4yi4mpDFJeBGbYsa+
        yyJuRwDy54GxD26PocCxIYQjoQ==
X-Google-Smtp-Source: APXvYqxpCk6VYogCmBRUaj33ltVVU8V3qzwuVeHtSMuP604mRn5mA22dm6U3ZPTDJtZl24ulfM7MIg==
X-Received: by 2002:a17:902:9a0a:: with SMTP id v10mr459102plp.190.1572944669845;
        Tue, 05 Nov 2019 01:04:29 -0800 (PST)
Received: from localhost ([122.171.110.253])
        by smtp.gmail.com with ESMTPSA id a29sm26327469pfr.49.2019.11.05.01.04.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 01:04:28 -0800 (PST)
Date:   Tue, 5 Nov 2019 14:34:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@lists.codethink.co.uk,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: fix integer/pointer warnings in
 acpi_platform_list
Message-ID: <20191105090422.vehycbs7eubwq7xq@vireshk-i7>
References: <20191105075225.9083-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105075225.9083-1-ben.dooks@codethink.co.uk>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-11-19, 07:52, Ben Dooks (Codethink) wrote:
> The fourth field in this table is a pointer, not an integer so replace
> the 0 with a NULL to avoid the following sparse warnings:
> 
> drivers/cpufreq/intel_pstate.c:2667:64: sparse: sparse: Using plain integer as NULL pointer
> drivers/cpufreq/intel_pstate.c:2668:64: sparse: sparse: Using plain integer as NULL pointer
> drivers/cpufreq/intel_pstate.c:2669:64: sparse: sparse: Using plain integer as NULL pointer
> drivers/cpufreq/intel_pstate.c:2670:64: sparse: sparse: Using plain integer as NULL pointer
> drivers/cpufreq/intel_pstate.c:2671:64: sparse: sparse: Using plain integer as NULL pointer
> drivers/cpufreq/intel_pstate.c:2672:64: sparse: sparse: Using plain integer as NULL pointer
> drivers/cpufreq/intel_pstate.c:2673:64: sparse: sparse: Using plain integer as NULL pointer
> drivers/cpufreq/intel_pstate.c:2674:64: sparse: sparse: Using plain integer as NULL pointer
> drivers/cpufreq/intel_pstate.c:2675:64: sparse: sparse: Using plain integer as NULL pointer
> drivers/cpufreq/intel_pstate.c:2676:64: sparse: sparse: Using plain integer as NULL pointer
> drivers/cpufreq/intel_pstate.c:2677:64: sparse: sparse: Using plain integer as NULL pointer
> drivers/cpufreq/intel_pstate.c:2678:64: sparse: sparse: Using plain integer as NULL pointer
> drivers/cpufreq/intel_pstate.c:2679:64: sparse: sparse: Using plain integer as NULL pointer
> drivers/cpufreq/intel_pstate.c:2680:64: sparse: sparse: Using plain integer as NULL pointer
> drivers/cpufreq/intel_pstate.c:2681:64: sparse: sparse: Using plain integer as NULL pointer
> 
> Signed-off-by: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>
> ---
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Someone else posted this before you :)

https://lore.kernel.org/lkml/20191105055427.11943-1-jamal.k.shareef@gmail.com/

Will be good if you can review that. Thanks.

-- 
viresh
