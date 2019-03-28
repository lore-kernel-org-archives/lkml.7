Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D633C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45DF2206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfC1KWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:22:13 -0400
Received: from foss.arm.com ([217.140.101.70]:42024 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfC1KWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 06:22:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4513D15AB;
        Thu, 28 Mar 2019 03:22:12 -0700 (PDT)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE3443F59C;
        Thu, 28 Mar 2019 03:22:09 -0700 (PDT)
Date:   Thu, 28 Mar 2019 10:22:08 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        will.deacon@arm.com, catalin.marinas@arm.com
Cc:     daniel.lezcano@linaro.org, dietmar.eggemann@arm.com,
        ionela.voinescu@arm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] arm64: defconfig: Enable CONFIG_ENERGY_MODEL
Message-ID: <20190328102206.doqj5fykqlld7jkd@queper01-lin>
References: <20190328101352.25657-1-quentin.perret@arm.com>
 <20190328101352.25657-2-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328101352.25657-2-quentin.perret@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 Mar 2019 at 10:13:50 (+0000), Quentin Perret wrote:
> The recently introduced Energy Model (EM) framework manages power cost
> tables for the CPUs of the system. Its only user right now is the
> scheduler, in the context of Energy Aware Scheduling (EAS).
> 
> However, the EM framework also offers a generic infrastructure that
> could replace subsystem-specific implementations of the same concepts,
> as this is the case in the thermal framework.
> 
> So, in order to prepare the migration of the thermal subsystem to use
> the EM framework, enable it in the default arm64 defconfig, which is the
> most commonly used architecture for IPA. This will also compile-in all
> of the EAS code, although it won't be enabled by default -- EAS requires
> to use the 'schedutil' CPUFreq governor while arm64 defaults to
> 'performance'.
> 
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 2d9c39033c1a..3c09bdaaefd3 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -97,6 +97,7 @@ CONFIG_XEN=y
>  CONFIG_COMPAT=y
>  CONFIG_HIBERNATION=y
>  CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
> +CONFIG_ENERGY_MODEL=n

Hmm, sorry I turned this to '=n' for testing and forgot to update the
patch. This obviously should be '=y' ...

>  CONFIG_ARM_CPUIDLE=y
>  CONFIG_CPU_FREQ=y
>  CONFIG_CPU_FREQ_STAT=y
> -- 
> 2.21.0
> 
