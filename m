Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B682C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB63F20896
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DinTrsuf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733215AbfFMPMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:12:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50584 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732286AbfFMNtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=K3KSbmQVJmhgaolOXqN5jC7ueDvgBWUaym2beuTKQRM=; b=DinTrsufwYtZHErmCGkaFeASA
        aVkny4bZYVbium2ZfOuKEEE8OUINrp31PJgKc09WyfN5syWyQ4Qzkqoc+9Di1xO0MTtqT7I2bdpHb
        ZKg1Xg5iQ4S9MAWHCVzYTlQSMheCPUDg3SXhw3EjhdpMJdzvON1dcduU4J+tvwFlFzsqBPs1TGcYR
        bHxcRRlD7nZR3eSlt2t7jUyYXhnLsY3Q1Fpjm+CayodVN3GTNDdWoMha9z/WwcjcdUgx2DXscNCKP
        yMkr41g4hi9aHKTWebr9a0O6qr2afDMgiqKJYGFmOkSJ3gg6Rx5N1fKcs5ocDBIt5Hz4zTUPlZFzX
        9Wg4OiTCw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbQ68-0007xY-J5; Thu, 13 Jun 2019 13:49:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D892420316592; Thu, 13 Jun 2019 15:48:58 +0200 (CEST)
Date:   Thu, 13 Jun 2019 15:48:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCHv2 0/3] improve wait logic of stop_machine
Message-ID: <20190613134858.GL3436@hirez.programming.kicks-ass.net>
References: <20190613103510.60529-1-heiko.carstens@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613103510.60529-1-heiko.carstens@de.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 12:35:07PM +0200, Heiko Carstens wrote:
> Heiko Carstens (2):
>   processor: remove spin_cpu_yield
>   processor: get rid of cpu_relax_yield
> 
> Martin Schwidefsky (1):
>   s390: improve wait logic of stop_machine
> 
>  arch/powerpc/include/asm/processor.h |  2 --
>  arch/s390/include/asm/processor.h    |  7 +------
>  arch/s390/kernel/processor.c         | 19 +++++++++++++------
>  arch/s390/kernel/smp.c               |  2 +-
>  include/linux/processor.h            |  9 ---------
>  include/linux/sched.h                |  4 ----
>  include/linux/stop_machine.h         |  1 +
>  kernel/stop_machine.c                | 19 ++++++++++++++-----
>  8 files changed, 30 insertions(+), 33 deletions(-)

Seems sensible to me.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
