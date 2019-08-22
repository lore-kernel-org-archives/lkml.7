Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92987C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 12:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B15B21726
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 12:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566477692;
	bh=ufaJdla4WjitlIUVwrCCXVQWoJ8wWemRzKfjx3IdVk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EGDSIhqmgool/E9SWaZN64FW4LOf5y4eB/v6/f78niSjn2Im2+rlo2b/jEJef1zEh
	 G/FPiVs1xspzJ7ufqKTM7iaz0afmiPGLu6d1ESQ7Btvko0+o6dVXsHJHsEFa+u8mIR
	 y5l7v+F2AO+IBpwthpGQhGcL2U7DHp46n453gB3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387779AbfHVMlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 08:41:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:34470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732129AbfHVMlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 08:41:31 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08B0C206DD;
        Thu, 22 Aug 2019 12:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566477690;
        bh=ufaJdla4WjitlIUVwrCCXVQWoJ8wWemRzKfjx3IdVk4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t/Vggz3iThCTxMA5zz0iMDRkmfct+wgjPCnjG+0o7UbcOizI8hzrfTfgHjnH6GUwR
         kausWwjnEG1kg+pATFnnlpJCee6RbY+pjjxwBd6NGauatEnO46wz96jStM8I3L0xyM
         gAYzNyMlmWFQaX8wsvbV//DWIU2MeDoB1TYT2vKo=
Date:   Thu, 22 Aug 2019 14:41:28 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 07/38] posix-cpu-timers: Rename
 thread_group_cputimer() and make it static
Message-ID: <20190822124127.GK22020@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192919.869350319@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192919.869350319@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:08:54PM +0200, Thomas Gleixner wrote:
> thread_group_cputimer() is a complete misnomer. The function does two things:
> 
>  - For arming process wide timers it makes sure that the atomic time
>    storage is up to date. If no cpu timer is armed yet, then the atomic
>    time storage is not updated by the scheduler for performance reasons.
> 
>    In that case a full summing up of all threads needs to be done and the
>    update needs to be enabled.
> 
> - Samples the current time into the caller supplied storage.
> 
> Rename it to thread_group_start_cputime(), make it static and fixup the
> callsite.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
