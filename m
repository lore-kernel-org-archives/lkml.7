Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CD4C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51BFB21A4A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570022431;
	bh=g3t5nhV3guqKXwJxMUuc0EepL7CxVYfQMy0uPF6xuNg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=C41UNGOnxn3sIdnRxeCPC02nC1AOkZiblk4B6Vvx4duwwnl4IfkY+dYmE4Ed3GE46
	 aJYVTHdxOnGM9pgBciEhSJ7GlCeiHLJr9sBFnPrzQ+srZ1ocFJJIHwlMrRMh7IkAdd
	 SVTxFPF9JQODHLncUZJnEDs8vxY1usn8T6VeM6vw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfJBNUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 09:20:30 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:38292 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725999AbfJBNUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 09:20:30 -0400
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:AES256-GCM-SHA384:256)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iFeYL-00083Y-Qs; Wed, 02 Oct 2019 15:20:25 +0200
Date:   Wed, 2 Oct 2019 14:20:24 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: errata: Update stale comment
Message-ID: <20191002142024.60c6bab8@why>
In-Reply-To: <20190923091229.14675-1-thierry.reding@gmail.com>
References: <20190923091229.14675-1-thierry.reding@gmail.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: thierry.reding@gmail.com, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Sep 2019 11:12:29 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> From: Thierry Reding <treding@nvidia.com>
> 
> Commit 73f381660959 ("arm64: Advertise mitigation of Spectre-v2, or lack
> thereof") renamed the caller of the install_bp_hardening_cb() function
> but forgot to update a comment, which can be confusing when trying to
> follow the code flow.
> 
> Fixes: 73f381660959 ("arm64: Advertise mitigation of Spectre-v2, or lack thereof")
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  arch/arm64/kernel/cpu_errata.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 1e43ba5c79b7..f593f4cffc0d 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -128,8 +128,8 @@ static void install_bp_hardening_cb(bp_hardening_cb_t fn,
>  	int cpu, slot = -1;
>  
>  	/*
> -	 * enable_smccc_arch_workaround_1() passes NULL for the hyp_vecs
> -	 * start/end if we're a guest. Skip the hyp-vectors work.
> +	 * detect_harden_bp_fw() passes NULL for the hyp_vecs start/end if
> +	 * we're a guest. Skip the hyp-vectors work.
>  	 */
>  	if (!hyp_vecs_start) {
>  		__this_cpu_write(bp_hardening_data.fn, fn);

Acked-by: Marc Zyngier <maz@kernel.org>

-- 
Without deviation from the norm, progress is not possible.
