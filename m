Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A03CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90DAD2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbfJUQww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 12:52:52 -0400
Received: from [217.140.110.172] ([217.140.110.172]:58394 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbfJUQww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:52:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DA551715;
        Mon, 21 Oct 2019 09:52:31 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98E853F71F;
        Mon, 21 Oct 2019 09:52:30 -0700 (PDT)
Date:   Mon, 21 Oct 2019 17:52:24 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@lists.codethink.co.uk, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] RFC: cpu-topology: declare parse_acpi_topology in
 <linux/arch_topology.h>
Message-ID: <20191021165224.GA8066@bogus>
References: <20191021162530.13611-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021162530.13611-1-ben.dooks@codethink.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 05:25:30PM +0100, Ben Dooks (Codethink) wrote:
> The parse_acpi_topology() is not declared anywhere which
> causes the following sparse warning:
> 
> drivers/base/arch_topology.c:522:19: warning: symbol 'parse_acpi_topology' was not declared. Should it be static?
> 
> RFC: is this the best place to put it?
> 
> Signed-off-by: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>
> ---
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: linux-kernel@vger.kernel.org
> ---
>  include/linux/arch_topology.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> index 42f2b5126094..7ae32900d9a2 100644
> --- a/include/linux/arch_topology.h
> +++ b/include/linux/arch_topology.h
> @@ -59,4 +59,6 @@ void remove_cpu_topology(unsigned int cpuid);
>  void reset_cpu_topology(void);
>  #endif
>  
> +extern int parse_acpi_topology(void);
> +

Can we drop extern like other declarations here ?
Also move this inside CONFIG_GENERIC_ARCH_TOPOLOGY ?

Please cc Greg with these changes, I will ack and ask Greg to pick up. Thanks.

--
Regards,
Sudeep
