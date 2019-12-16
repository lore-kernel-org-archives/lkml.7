Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0EBC2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F6220726
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576498865;
	bh=9JnIsU2VsxcqQhyyLWzP8sEVnItBtMoCqaQxLQmUEUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zyFeuC+8Rbr3URzRJ2/r4xigUXPmyvOL4P11L5M9NjS9TokWRIDqwRiN6rxGMRAao
	 endE1ZW26On1Fjawl4zZPTLipp+Ewrh8LpfXMtCBiMKEQtnsnjNXSbOQUa1YfdqcOk
	 JspSh098PL8C4cvHRUbzzdIJblJxl+6onYcso/9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfLPMVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 07:21:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:41696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727580AbfLPMVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 07:21:02 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF54C206D3;
        Mon, 16 Dec 2019 12:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576498862;
        bh=9JnIsU2VsxcqQhyyLWzP8sEVnItBtMoCqaQxLQmUEUE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qtVRTREs4vDiqd/PBCTW23+XJ5iZxjFvXhj/yi4JSxN6J4EO678vYp8NbEvoHh8kj
         Yqoj4gpDqm9rEO6VdsQQwy+LK18RJ9/ZFf/8JvtTFKSx6E8UKrNZQ6hDagGyFaIUfY
         6BOEXgFSZbciT+vC6ksuuoJJJeLhLbGWokKtgLAk=
Date:   Mon, 16 Dec 2019 12:20:57 +0000
From:   Will Deacon <will@kernel.org>
To:     Hanjun Guo <guohanjun@huawei.com>, catalin.marinas@arm.com
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf/smmuv3: Remove the leftover put_cpu() in error
 path
Message-ID: <20191216122057.GB12947@willie-the-truck>
References: <1576046586-59145-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576046586-59145-1-git-send-email-guohanjun@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Catalin]

On Wed, Dec 11, 2019 at 02:43:06PM +0800, Hanjun Guo wrote:
> In smmu_pmu_probe(), there is put_cpu() in the error path,
> which is wrong because we use raw_smp_processor_id() to
> get the cpu ID, not get_cpu(), remove it.
> 
> While we are at it, kill 'out_cpuhp_err' altogether and
> just return err if we fail to add the hotplug instance.
> 
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> ---
>  drivers/perf/arm_smmuv3_pmu.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
> index 773128f..d704ecc 100644
> --- a/drivers/perf/arm_smmuv3_pmu.c
> +++ b/drivers/perf/arm_smmuv3_pmu.c
> @@ -814,7 +814,7 @@ static int smmu_pmu_probe(struct platform_device *pdev)
>  	if (err) {
>  		dev_err(dev, "Error %d registering hotplug, PMU @%pa\n",
>  			err, &res_0->start);
> -		goto out_cpuhp_err;
> +		return err;
>  	}
>  
>  	err = perf_pmu_register(&smmu_pmu->pmu, name, -1);
> @@ -833,8 +833,6 @@ static int smmu_pmu_probe(struct platform_device *pdev)
>  
>  out_unregister:
>  	cpuhp_state_remove_instance_nocalls(cpuhp_state_num, &smmu_pmu->node);
> -out_cpuhp_err:
> -	put_cpu();
>  	return err;
>  }

Acked-by: Will Deacon <will@kernel.org>

Catalin -- please can you take this as a fix via the arm64 tree? I don't
have any other perf patches pending at the moment.

Cheers,

Will
