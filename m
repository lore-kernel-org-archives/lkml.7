Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4775C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C434824592
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbfFCQZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 12:25:39 -0400
Received: from foss.arm.com ([217.140.101.70]:55106 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbfFCQZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 12:25:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54CBA80D;
        Mon,  3 Jun 2019 09:25:39 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D64E3F5AF;
        Mon,  3 Jun 2019 09:25:37 -0700 (PDT)
Date:   Mon, 3 Jun 2019 17:25:34 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Julien Grall <julien.grall@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, will.deacon@arm.com,
        christoffer.dall@arm.com, marc.zyngier@arm.com,
        james.morse@arm.com, julien.thierry@arm.com,
        suzuki.poulose@arm.com, Dave.Martin@arm.com,
        ard.biesheuvel@linaro.org
Subject: Re: [PATCH v5 3/3] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
Message-ID: <20190603162534.GF63283@arrakis.emea.arm.com>
References: <20190521172139.21277-1-julien.grall@arm.com>
 <20190521172139.21277-4-julien.grall@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521172139.21277-4-julien.grall@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 06:21:39PM +0100, Julien Grall wrote:
> Since a softirq is supposed to check may_use_simd() anyway before
> attempting to use FPSIMD/SVE, there is limited reason to keep softirq
> disabled when touching the FPSIMD/SVE context. Instead, we can simply
> disable preemption and mark the FPSIMD/SVE context as in use by setting
> CPU's fpsimd_context_busy flag.
[...]
> +static void get_cpu_fpsimd_context(void)
> +{
> +	preempt_disable();
> +	__get_cpu_fpsimd_context();
> +}

Is there anything that prevents a softirq being invoked between
preempt_disable() and __get_cpu_fpsimd_context()?

-- 
Catalin
