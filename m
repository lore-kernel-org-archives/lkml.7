Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F030BC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB85020811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfDWLXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 07:23:25 -0400
Received: from foss.arm.com ([217.140.101.70]:54800 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726989AbfDWLXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 07:23:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 491F3374;
        Tue, 23 Apr 2019 04:23:24 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57C283F557;
        Tue, 23 Apr 2019 04:23:22 -0700 (PDT)
Date:   Tue, 23 Apr 2019 12:23:19 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Julien Grall <julien.grall@arm.com>
Cc:     ard.biesheuvel@linaro.org, marc.zyngier@arm.com,
        catalin.marinas@arm.com, julien.thierry@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        christoffer.dall@arm.com, james.morse@arm.com,
        linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Subject: Re: [PATCH v2 3/3] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
Message-ID: <20190423112317.GK3567@e103592.cambridge.arm.com>
References: <20190412171420.29065-1-julien.grall@arm.com>
 <20190412171420.29065-4-julien.grall@arm.com>
 <20190416123033.GM3567@e103592.cambridge.arm.com>
 <901b1c73-4f96-b493-cdc7-bc2f6bd2d7ca@arm.com>
 <20190417140058.GZ3567@e103592.cambridge.arm.com>
 <80c6b8cd-5ea9-7fa3-7a3b-8b3af686f737@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80c6b8cd-5ea9-7fa3-7a3b-8b3af686f737@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 11:59:44AM +0100, Julien Grall wrote:
> Hi Dave,
> 
> On 4/17/19 3:01 PM, Dave Martin wrote:
> >On Wed, Apr 17, 2019 at 12:37:57PM +0100, Julien Grall wrote:
> >>Hi Dave,
> >>
> >>On 16/04/2019 13:30, Dave Martin wrote:
> >>>On Fri, Apr 12, 2019 at 06:14:20PM +0100, Julien Grall wrote:

[...]

> >>>>@@ -1125,19 +1194,18 @@ static void fpsimd_flush_cpu_state(void)
> >>>>  /*
> >>>>   * Save the FPSIMD state to memory and invalidate cpu view.
> >>>>- * This function must be called with softirqs (and preemption) disabled.
> >>>>+ * This function must be called with preemption disabled.
> >>>>   */
> >>>>  void fpsimd_save_and_flush_cpu_state(void)
> >>>>  {
> >>>>+	__get_cpu_fpsimd_context();
> >>>>  	fpsimd_save();
> >>>>  	fpsimd_flush_cpu_state();
> >>>>+	__put_cpu_fpsimd_context();
> >>>
> >>>It may be cleaner to avoid the assumption about preemption already being
> >>>disabled here.  fpsimd_thread_switch() is rather a special case, but for
> >>>this one is this really used on a hot path that justifies the assumption?
> >>
> >>It is currently only called with preemption disabled. So I thought it would
> >>be better to avoid disabling preemption again. But I am happy to use the
> >>non-__ version if you think it is better.
> >
> >Hmmm, this works either way.  Since this is not fast-path and has an
> >external caller, it might be worth adding a WARN_ON(preemptible()) here
> >if you want to stick with the __ functions.
> 
> As it is not a fastpath, I will use the non-underscore version.

OK, either is good for me.

Cheers
---Dave
