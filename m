Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48875C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7C02133D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbfDAPhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:37:31 -0400
Received: from foss.arm.com ([217.140.101.70]:36756 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfDAPha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 11:37:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47324A78;
        Mon,  1 Apr 2019 08:37:28 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36F043F690;
        Mon,  1 Apr 2019 08:37:27 -0700 (PDT)
Date:   Mon, 1 Apr 2019 16:37:22 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 14/15] arm64: cpu_ops: fix a leaked reference by
 adding missing of_node_put
Message-ID: <20190401153722.GA6884@fuggles.cambridge.arm.com>
References: <1551785646-46173-1-git-send-email-wen.yang99@zte.com.cn>
 <1551785646-46173-14-git-send-email-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551785646-46173-14-git-send-email-wen.yang99@zte.com.cn>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 07:34:05PM +0800, Wen Yang wrote:
> The call to of_get_next_child returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
> 
> Detected by coccinelle with the following warnings:
> ./arch/arm64/kernel/cpu_ops.c:102:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 69, but without a corresponding object release within this function.
> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
> v2->v1: add a missing space between "adding" and "missing"
> 
>  arch/arm64/kernel/cpu_ops.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/kernel/cpu_ops.c b/arch/arm64/kernel/cpu_ops.c
> index ea00124..00f8b86 100644
> --- a/arch/arm64/kernel/cpu_ops.c
> +++ b/arch/arm64/kernel/cpu_ops.c
> @@ -85,6 +85,7 @@ static const char *__init cpu_read_enable_method(int cpu)
>  				pr_err("%pOF: missing enable-method property\n",
>  					dn);
>  		}
> +		of_node_put(dn);
>  	} else {
>  		enable_method = acpi_get_enable_method(cpu);
>  		if (!enable_method) {

Looks about right to me:

Acked-by: Will Deacon <will.deacon@arm.com>

How do you plan to get this upstream? Can we just pick this one up via
arm64?

Will
