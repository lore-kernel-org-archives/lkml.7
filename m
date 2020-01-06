Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77D6C32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 07:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98BD821734
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 07:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="q6euyIR7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgAFHII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 02:08:08 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57460 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbgAFHII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 02:08:08 -0500
Received: from zn.tnic (p200300EC2F270F0024DF20D65B514141.dip0.t-ipconnect.de [IPv6:2003:ec:2f27:f00:24df:20d6:5b51:4141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0258B1EC0B67;
        Mon,  6 Jan 2020 08:08:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578294487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=cZSFcr/6/NDXfNRf5/C3Serqj4wqjHvHUQIPMvTEhB4=;
        b=q6euyIR7Ji8hgeAK5l4wMIBf3WAxqPQYMSYQTfik54CnvRxfGAzOFdIryGrA7TGwhLVgKk
        uC6G37D39f7VfY7LS0GMbc49z03m/Q/xDO5ISJVX3NTmqsAb0fvd0pXjnjB/IJQAsZeZ7W
        zUvSbphmAFOqpM0HEH149N3cWDY6lfg=
Date:   Mon, 6 Jan 2020 08:07:59 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chuansheng Liu <chuansheng.liu@intel.com>
Cc:     linux-kernel@vger.kernel.org, tony.luck@intel.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Subject: Re: [PATCH] x86/mce/therm_throt: Fix the access of uninitialized
 therm_work
Message-ID: <20200106070759.GB12238@zn.tnic>
References: <20200106064155.64-1-chuansheng.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200106064155.64-1-chuansheng.liu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 06:41:55AM +0000, Chuansheng Liu wrote:
> In ICL platform, it is easy to hit bootup failure with panic
> in thermal interrupt handler during early bootup stage.
> 
> Such issue makes my platform almost can not boot up with
> latest kernel code.
> 
> The call stack is like:
> kernel BUG at kernel/timer/timer.c:1152!
> 
> Call Trace:
> __queue_delayed_work
> queue_delayed_work_on
> therm_throt_process
> intel_thermal_interrupt
> ...
> 
> When one CPU is up, the irq is enabled prior to CPU UP
> notification which will then initialize therm_worker.

You mean the unmasking of the thermal vector at the end of
intel_init_thermal()?

If so, why don't you move that to the end of the notifier and unmask it
only after all the necessary work like setting up the workqueues etc, is
done, and save yourself adding yet another silly bool?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
