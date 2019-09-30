Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861B2C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4678B2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569849736;
	bh=5YgzqjSTmNEx7qj7fQeG6vrEjnUn7W/lfum0s/DKHGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eKzk/qjUuTLxTAizGOLTMz04L7qHtJDeso3ahaUU5euzeWa4GHMuwaMk1hXbdPT+l
	 JtQ7u5XvoZ757uddDr692aWe3LVYvetjaPvVAgQ4ZXgTwOTJbRkBQn/xAjTOphJEfY
	 D/jFN2rfL/KM5q5zSm6HeTMFcSoGoLC1l5uf655Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731364AbfI3NWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 09:22:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:55594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730266AbfI3NWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 09:22:15 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2384120842;
        Mon, 30 Sep 2019 13:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569849734;
        bh=5YgzqjSTmNEx7qj7fQeG6vrEjnUn7W/lfum0s/DKHGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1d0oL1arMIQkT3rZLOZ6EqO21ByQGs1tnW7R8kZ5o2NUeo28JRXzi9RVhryn48xaa
         dGD0ACOAKudBKKq9x8/KquD18TBawUJJYQnVvLLd6iZu/DCDnPVUOVwEY/HvV2IMcl
         BjtBvC8uqVeTuJT5Z+lIt/fWQRlvOiaOrEnFF/Mc=
Date:   Mon, 30 Sep 2019 14:22:10 +0100
From:   Will Deacon <will@kernel.org>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        tglx@linutronix.de, info@metux.net, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: armv8_deprecated: Checking return value for
 memory allocation
Message-ID: <20190930132209.jyyemkck7orji64i@willie-the-truck>
References: <ea235720-5bbd-27b7-a9b1-34aa8a344e3a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea235720-5bbd-27b7-a9b1-34aa8a344e3a@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2019 at 12:44:17PM +0800, Yunfeng Ye wrote:
> There are no return value checking when using kzalloc() and kcalloc() for
> memory allocation. so add it.
> 
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> ---
>  arch/arm64/kernel/armv8_deprecated.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
> index 2ec09de..ca158be 100644
> --- a/arch/arm64/kernel/armv8_deprecated.c
> +++ b/arch/arm64/kernel/armv8_deprecated.c
> @@ -174,6 +174,9 @@ static void __init register_insn_emulation(struct insn_emulation_ops *ops)
>  	struct insn_emulation *insn;
> 
>  	insn = kzalloc(sizeof(*insn), GFP_KERNEL);
> +	if (!insn)
> +		return;
> +
>  	insn->ops = ops;
>  	insn->min = INSN_UNDEF;
> 
> @@ -233,6 +236,8 @@ static void __init register_insn_emulation_sysctl(void)
> 
>  	insns_sysctl = kcalloc(nr_insn_emulated + 1, sizeof(*sysctl),
>  			       GFP_KERNEL);
> +	if (!insns_sysctl)
> +		return;

Since both of these failure paths are fatal to the instruction emulation,
can you please return an error code when the allocation fails and use that
to fail the calling initcall() appropriately?

Will
