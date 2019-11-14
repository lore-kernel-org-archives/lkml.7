Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74395C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 20:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A6420724
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 20:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfKNU3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 15:29:02 -0500
Received: from foss.arm.com ([217.140.110.172]:49096 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbfKNU3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 15:29:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FDD431B;
        Thu, 14 Nov 2019 12:29:01 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF2E03F534;
        Thu, 14 Nov 2019 12:28:59 -0800 (PST)
Date:   Thu, 14 Nov 2019 20:28:57 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org,
        Dietmar.Eggemann@arm.com, tj@kernel.org,
        patrick.bellasi@matbug.net, surenb@google.com, qperret@google.com
Subject: Re: [PATCH] sched/uclamp: Fix overzealous type replacement
Message-ID: <20191114202855.64e4jnb4dcbru4w3@e107158-lin.cambridge.arm.com>
References: <20191113165334.14291-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191113165334.14291-1-valentin.schneider@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/19 16:53, Valentin Schneider wrote:
> Some uclamp helpers had their return type changed from 'unsigned int' to
> 'enum uclamp_id' by commit
> 
>   0413d7f33e60 ("sched/uclamp: Always use 'enum uclamp_id' for clamp_id values")
> 
> but it happens that some *actually* do return an unsigned int value. Those
> are the helpers that return a utilization value: uclamp_rq_max_value() and
> uclamp_eff_value(). Fix those up.
> 
> Note that this doesn't lead to any obj diff using a relatively recent
> aarch64 compiler (8.3-2019.03). The current code of e.g. uclamp_eff_value()
> already figures out that the return value is 11 bits (bits_per(1024)) and
> doesn't seem to do anything funny. I'm still marking this as fixing the
> above commit to be on the safe side.
> 
> Fixes: 0413d7f33e60 ("sched/uclamp: Always use 'enum uclamp_id' for clamp_id values")
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---

The changelog could be a bit simpler and more explicitly say 0413d7f33e60
wrongly changed the return type of some functions. For a second I thought
something weird is going inside these functions.

But that could be just me :-)

Reviewed-by: Qais Yousef <qais.yousef@arm.com>

Thanks!

--
Qais Yousef
