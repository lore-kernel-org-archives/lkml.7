Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE17BC4646C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 01:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFCD720663
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 01:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561425106;
	bh=sgq+msnAL8kQZ3mY807VJdBo2IAPDJhsech1nzjdf3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H+ZgV3zYgwkAcxfWNAZ2LLa81YIhS8KBTbPF6+sHcFaoXIqlfnXM8WqxkFcUYb/6L
	 GiQeDaLV7f8ghz/ukEjr+j4kVuZxjSxOfN8Pnbj86HC7P0zJBs16vusuAuK9xA7FfD
	 rgQnz3pj74/tE97MPb2pznXq8PB3dUwZF2fcafNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbfFYBLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 21:11:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbfFYBLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 21:11:21 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B10920663;
        Tue, 25 Jun 2019 01:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561425080;
        bh=sgq+msnAL8kQZ3mY807VJdBo2IAPDJhsech1nzjdf3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jOfpsfUQLiuYRDxN0UFK20JUJKFWFDynl9v4wwhOPj8Dwc8iGiag2xqLwGXByiTmg
         OKJEJ2L7ZP8u+qI5W4iELQ3uV+vI4HDLJ/1AOhVMqbXjjyEpuhbFbmoP1i59w6GWW3
         +Tj2t72OV5mVELADSq+YAK4/hqskTKQP2dBo7vu4=
Date:   Tue, 25 Jun 2019 03:11:18 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>
Subject: Re: [PATCH v2] kernel/isolation: Assert that a housekeeping CPU
 comes up at boot time
Message-ID: <20190625011117.GC17497@lerouge>
References: <20190625001720.19439-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625001720.19439-1-npiggin@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 10:17:20AM +1000, Nicholas Piggin wrote:
> +static int __init housekeeping_verify_smp(void)
> +{
> +	int cpu;
> +
> +	if (!housekeeping_flags)
> +		return 0;
> +
> +	/*
> +	 * Early housekeeping setup is done before CPUs come up, and there are
> +	 * a range of options scattered around that can restrict which CPUs
> +	 * come up. It is possible to pass in a combination of housekeeping
> +	 * and SMP arguments that result in housekeeping assigned to an
> +	 * offline CPU.
> +	 *
> +	 * Check that condition here after SMP comes up, and give a useful
> +	 * error message rather than an obscure non deterministic crash or
> +	 * hang later.
> +	 */
> +	for_each_online_cpu(cpu) {
> +		if (cpumask_test_cpu(cpu, housekeeping_mask))
> +			return 0;
> +	}
> +	panic("Housekeeping: nohz_full= or isolcpus= resulted in no online CPUs for housekeeping.\n");

Ok let's keep the panic. But let's simplify and spare long iterations off boot load:

    if (!cpumask_intersects(cpu_online_mask, housekeeping_mask))
        panic(...);

Thanks.
