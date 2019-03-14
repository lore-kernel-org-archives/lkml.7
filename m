Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FC9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 17:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A30F2087C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 17:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfCNR1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 13:27:22 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:47804 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfCNR1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 13:27:22 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 50D9C14D77FB4;
        Thu, 14 Mar 2019 10:27:21 -0700 (PDT)
Date:   Thu, 14 Mar 2019 10:27:17 -0700 (PDT)
Message-Id: <20190314.102717.1146763900493083907.davem@davemloft.net>
To:     viresh.kumar@linaro.org
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        vincent.guittot@linaro.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] sparc64: Update cpufreq transition notifier to
 handle multiple CPUs
From:   David Miller <davem@davemloft.net>
In-Reply-To: <f4eb2ed1e473ca9bb4c0a9ace27d816f4840f531.1552545525.git.viresh.kumar@linaro.org>
References: <cover.1552545525.git.viresh.kumar@linaro.org>
        <f4eb2ed1e473ca9bb4c0a9ace27d816f4840f531.1552545525.git.viresh.kumar@linaro.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 14 Mar 2019 10:27:21 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 14 Mar 2019 12:12:50 +0530

> The cpufreq core currently calls the cpufreq transition notifier
> callback once for each affected CPU. This is going to change soon and
> the cpufreq core will call the callback only once for each cpufreq
> policy. The callback must look at the newly added field in struct
> cpufreq_freqs, "cpus", which contains policy->related_cpus (both
> online/offline CPUs) and perform per-cpu actions for them if any.
> 
> This patch updates sparc64_cpufreq_notifier() to use the new "cpus" field
> and update per-cpu data for all the related CPUs.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: David S. Miller <davem@davemloft.net>
