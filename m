Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E05C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D48213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfCMRWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:22:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58614 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbfCMRWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 13:22:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E0FF93007C36;
        Wed, 13 Mar 2019 17:22:06 +0000 (UTC)
Received: from ovpn-120-157.rdu2.redhat.com (ovpn-120-157.rdu2.redhat.com [10.10.120.157])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2EE2D5DD84;
        Wed, 13 Mar 2019 17:22:04 +0000 (UTC)
Message-ID: <ab0f6cff1dd07ec42f13894d0833fbd506bdc10a.camel@redhat.com>
Subject: Re: [PATCH 02/14] c6x: entry: Remove unneeded need_resched() loop
From:   Mark Salter <msalter@redhat.com>
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org
Date:   Wed, 13 Mar 2019 13:21:58 -0400
In-Reply-To: <20190311224752.8337-3-valentin.schneider@arm.com>
References: <20190311224752.8337-1-valentin.schneider@arm.com>
         <20190311224752.8337-3-valentin.schneider@arm.com>
Organization: Red Hat, Inc
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 13 Mar 2019 17:22:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-11 at 22:47 +0000, Valentin Schneider wrote:
> Since the enabling and disabling of IRQs within preempt_schedule_irq()
> is contained in a need_resched() loop, we don't need the outer arch
> code loop.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Mark Salter <msalter@redhat.com>
> Cc: Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
> Cc: linux-c6x-dev@linux-c6x.org
> ---
>  arch/c6x/kernel/entry.S | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/c6x/kernel/entry.S b/arch/c6x/kernel/entry.S
> index 2721c90b0121..17926e942edb 100644
> --- a/arch/c6x/kernel/entry.S
> +++ b/arch/c6x/kernel/entry.S
> @@ -567,7 +567,6 @@ resume_kernel:
>  	NOP	4
>   [A1]	BNOP	.S2	restore_all,5
>  
> -preempt_schedule:
>  	GET_THREAD_INFO A2
>  	LDW	.D1T1	*+A2(THREAD_INFO_FLAGS),A1
>  #ifdef CONFIG_C6X_BIG_KERNEL
> @@ -584,7 +583,7 @@ preempt_schedule:
>  #else
>  	B	.S2	preempt_schedule_irq
>  #endif
> -	ADDKPC	.S2	preempt_schedule,B3,4
> +	ADDKPC	.S2	restore_all,B3,4
>  #endif /* CONFIG_PREEMPT */
>  
>  ENTRY(enable_exception)

Acked-by: Mark Salter <msalter@redhat.com>


