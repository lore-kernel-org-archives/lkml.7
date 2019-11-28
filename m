Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50E1C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 09:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E9B21770
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 09:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfK1JI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 04:08:57 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:44764 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726565AbfK1JI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 04:08:57 -0500
Received: from [109.168.11.45] (port=58706 helo=[192.168.101.73])
        by hostingweb31.netsons.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <luca@lucaceresoli.net>)
        id 1iaFnD-001hSv-4c; Thu, 28 Nov 2019 10:08:55 +0100
Subject: Re: [PATCH] genirq: show irq name in non-oneshot error message
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>
References: <20191105140854.27893-1-luca@lucaceresoli.net>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <e698b81f-54c3-6d47-8a4b-80c15b58aaad@lucaceresoli.net>
Date:   Thu, 28 Nov 2019 10:08:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191105140854.27893-1-luca@lucaceresoli.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05/11/19 15:08, Luca Ceresoli wrote:
> Requesting a threaded IRQ with handler=NULL and !ONESHOT fails, but the
> error message does not include the IRQ line name, which makes it harder to
> find the offending driver.
> 
> Print the IRQ line name to clarify where the error comes from. Use the same
> format as other pr_err() above in the same function.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  kernel/irq/manage.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 1753486b440c..b6c53ab053d2 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -1500,8 +1500,8 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
>  		 * has. The type flags are unreliable as the
>  		 * underlying chip implementation can override them.
>  		 */
> -		pr_err("Threaded irq requested with handler=NULL and !ONESHOT for irq %d\n",
> -		       irq);
> +		pr_err("Threaded irq requested with handler=NULL and !ONESHOT for %s (irq %d)\n",
> +		       new->name, irq);

Gently pinging about this trivial patch.

Should I send it elsewhere than where get_maintainer.pl suggests?

Thanks,
-- 
Luca
