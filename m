Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF6DC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E74822296
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbfGVIys convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 04:54:48 -0400
Received: from unicorn.mansr.com ([81.2.72.234]:60232 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfGVIys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 04:54:48 -0400
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 80C9215611; Mon, 22 Jul 2019 09:54:46 +0100 (BST)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] irqchip/tango: Add NULL check after memory operation
References: <20190721181536.GA13450@hari-Inspiron-1545>
Date:   Mon, 22 Jul 2019 09:54:46 +0100
In-Reply-To: <20190721181536.GA13450@hari-Inspiron-1545> (Hariprasad Kelam's
        message of "Sun, 21 Jul 2019 23:45:36 +0530")
Message-ID: <yw1xh87efnzd.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hariprasad Kelam <hariprasad.kelam@gmail.com> writes:

> Add NULL check after kzalloc operation.
>
> Fix below issue reported by coccicheck
> ./drivers/irqchip/irq-tango.c:189:1-5: alloc with no test, possible
> model on line 193
>
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/irqchip/irq-tango.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/irqchip/irq-tango.c b/drivers/irqchip/irq-tango.c
> index 34290f0..761b9fa 100644
> --- a/drivers/irqchip/irq-tango.c
> +++ b/drivers/irqchip/irq-tango.c
> @@ -187,6 +187,8 @@ static int __init tangox_irq_init(void __iomem *base, struct resource *baseres,
>  		panic("%pOFn: failed to get address", node);
>
>  	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
>  	chip->ctl = res.start - baseres->start;
>  	chip->base = base;
>
> -- 

Nothing checks the return value of that function, so bad things will
still happen, only more confusing to debug.  If you really want to
"fix" this, you should either:

- Simply panic() like the other error cases.  If anything here fails,
  the system will not work anyway.

- Replace the panic() calls with error returns and check the return
  value in tangox_of_irq_init().  The system will still end up unusable.

-- 
Måns Rullgård
