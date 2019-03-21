Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45803C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF33218D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbfCUQTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:19:43 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38689 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfCUQTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 12:19:43 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h70Ps-0000Uj-0a; Thu, 21 Mar 2019 17:19:40 +0100
Date:   Thu, 21 Mar 2019 17:19:39 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Prasad Sodagudi <psodagud@codeaurora.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH] genirq: call cancel_work_sync from
 irq_set_affinity_notifier
In-Reply-To: <1553119211-29761-1-git-send-email-psodagud@codeaurora.org>
Message-ID: <alpine.DEB.2.21.1903211651030.1784@nanos.tec.linutronix.de>
References: <1553119211-29761-1-git-send-email-psodagud@codeaurora.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prasad,

On Wed, 20 Mar 2019, Prasad Sodagudi wrote:

> Subject: [PATCH] genirq: call cancel_work_sync from irq_set_affinity_notifier

Please do not decribe WHAT the code change is. Give a consice explanation
WHY this change is done. The above is like '[PATCH] foo: Increment bar by 5'.

  [PATCH] genirq: Prevent UAF and work list corruption

> When ever notification of IRQ affinity changes, call
> cancel_work_sync from irq_set_affinity_notifier to cancel
> all pending works to avoid work list corruption.

Again, you describe first WHAT you are doing instead of telling WHY.

  When irq_set_affinity_notifier() replaces the notifier, then the
  reference count on the old notifier is dropped which causes it to be
  freed. But nothing ensures that the old notifier is not longer queued in
  the work list. If it is queued this results in a use after free and
  possibly in work list corruption.

  Ensure that the work is canceled before the reference is dropped.

See?

This gives precise context first and then describes the cure.

Also it is completely irrelevant whether this is achieved by calling
cancel_work_sync() or by something else. What matters is that it's
canceled. Changelogs describe context and concepts not implementation
details. The implementation details are in the patch itself.

> Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
> ---
>  kernel/irq/manage.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 9ec34a2..da8b2ee 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -356,6 +356,9 @@ static void irq_affinity_notify(struct work_struct *work)
>  	desc->affinity_notify = notify;
>  	raw_spin_unlock_irqrestore(&desc->lock, flags);
>  
> +	if (!notify && old_notify)
> +		cancel_work_sync(&old_notify->work);

That '!notify' doesn't make any sense.

Thanks,

	tglx
