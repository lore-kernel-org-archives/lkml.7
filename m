Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E082C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA1920838
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575984306;
	bh=7zz0gT/SrMqg+Iv3/a+MU7zCh+V2pcljyvzuxR+IT34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C1eXmSJuv4OvNXsV2x6TVavLPWwD8Ii29OZmOAaRSY4Xmm6RuT++RNe3EwTDQVPUx
	 EStlR29Qfx6RpHjTL6/L0yeFSIs9PGC1xkr+YhfO6KfrIVRURCWNiCTx6eRygm9oYn
	 Mj5VxRJsEzUhzEQgIjYPTp0yORX2c6vNmcBwsGm4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbfLJNZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 08:25:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:44108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727211AbfLJNZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 08:25:04 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56D15207FF;
        Tue, 10 Dec 2019 13:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575984303;
        bh=7zz0gT/SrMqg+Iv3/a+MU7zCh+V2pcljyvzuxR+IT34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1GM1k2ugB1SumXt2BeMZkt/nfg8Hpg1wJl35Dv8zm/pnjLZLxly+QpNTSclZQ9xH5
         kaJzxjY0okQ64nFPtls6LyKALqZSsZwnY1/5Q641+vdO2WJ03UXl33/WwOVfs73jZ0
         WtYNagDwyN8nEHS/rXf4aHm5SEfhS6VVha7ey/7s=
Date:   Tue, 10 Dec 2019 13:24:58 +0000
From:   Will Deacon <will@kernel.org>
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/smmuv3: Remove the leftover put_cpu() in error path
Message-ID: <20191210132458.GA19183@willie-the-truck>
References: <1575974784-55046-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575974784-55046-1-git-send-email-guohanjun@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 06:46:24PM +0800, Hanjun Guo wrote:
> In smmu_pmu_probe(), there is put_cpu() in the error path,
> which is wrong because we use raw_smp_processor_id() to
> get the cpu ID, not get_cpu(), remove it.
> 
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> ---
>  drivers/perf/arm_smmuv3_pmu.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
> index 773128f..fd1d46a 100644
> --- a/drivers/perf/arm_smmuv3_pmu.c
> +++ b/drivers/perf/arm_smmuv3_pmu.c
> @@ -834,7 +834,6 @@ static int smmu_pmu_probe(struct platform_device *pdev)
>  out_unregister:
>  	cpuhp_state_remove_instance_nocalls(cpuhp_state_num, &smmu_pmu->node);
>  out_cpuhp_err:
> -	put_cpu();
>  	return err;

Can we kill 'out_cpuhp_err' altogether then and just return err if we fail
to add the hotplug instance?

Will
