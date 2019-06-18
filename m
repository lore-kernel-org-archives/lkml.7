Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B99C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 20:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0582214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 20:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="h8ccuIFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbfFRUeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 16:34:25 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49168 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730176AbfFRUeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 16:34:25 -0400
Received: from zn.tnic (p200300EC2F07D6009033472370AB0B0E.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:d600:9033:4723:70ab:b0e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 01E671EC08BF;
        Tue, 18 Jun 2019 22:34:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560890064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3Me18gZ4G0D32oI7Ykod1+DIQFZ1PZOVqgmun10TTO4=;
        b=h8ccuIFHDMdBvsVgdC3shdMPiM/G+BF2nYA51jFJrWXa3KRnbVTm+wmNvSNraqFXzXoyXJ
        DDpsOrrFvWWHmb1rCIx7/T98nKWT40nqBPI6Zlv1xDmJPkyPfAbpP8TGXRd03yCFWrjeez
        2bdRNSJ4uraw8Zs5HBVKxBUc9M4nooQ=
Date:   Tue, 18 Jun 2019 22:34:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org
Subject: Re: [PATCH] x86/microcode: Fix the microcode load on CPU hotplug for
 real
Message-ID: <20190618203348.GA16699@zn.tnic>
References: <alpine.DEB.2.21.1906182228350.1766@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906182228350.1766@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 10:31:40PM +0200, Thomas Gleixner wrote:
> A recent change moved the microcode loader hotplug callback into the early
> startup phase, which is running with interrupts disabled. It missed that
> the callbacks invoke sysfs functions which might sleep causing nice 'might
> sleep' splats with proper debugging enabled.
> 
> Split the callbacks and only load the microcode in the early startup phase
> and move the sysfs handling back into the later threaded and preemptible
> bringup phase where it was before.
> 
> Fixes: 78f4e932f776 ("x86/microcode, cpuhotplug: Add a microcode loader CPU hotplug callback")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org
> ---
>  arch/x86/kernel/cpu/microcode/core.c |   15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

Acked-by: Borislav Petkov <bp@suse.de>

Thanks for fixing that!

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
