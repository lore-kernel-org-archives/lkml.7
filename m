Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D13C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 21:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC6020721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 21:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="mimi3IN9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgAIVCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 16:02:34 -0500
Received: from mail.skyhub.de ([5.9.137.197]:34362 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgAIVCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 16:02:33 -0500
Received: from zn.tnic (p200300EC2F0C57004DD84C0E473AA3AE.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:5700:4dd8:4c0e:473a:a3ae])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 659911EC0CAD;
        Thu,  9 Jan 2020 22:02:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578603752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=L9ctHWAEoAxB6qWkfJNvezN/3ut+326++8UFDKa+VH0=;
        b=mimi3IN90JDCdnLLXjFsXBwc2bpx9kyR9bbApbdRZ9MjN4zWTKOP7tRm0fjmvU9NCPLj6P
        dwjkaG0KeVdmrygkWwgzFjFSuv+2Bmv/r7ISR35sTWfKCYVl4N8Ts0ZxxoZ5x1FLVvK16I
        +8Wh4GBKmmfe8XFixCRqVJo42MUWihQ=
Date:   Thu, 9 Jan 2020 22:02:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, hpa@zytor.com, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/nmi: remove the irqwork from long duration nmi
 handler
Message-ID: <20200109210225.GK5603@zn.tnic>
References: <20200101072017.82990-1-changbin.du@gmail.com>
 <877e20bb8o.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877e20bb8o.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 09:55:51PM +0100, Thomas Gleixner wrote:
> Changbin Du <changbin.du@gmail.com> writes:
> 
> > First, printk is NMI context safe now since the safe printk has been
> > implemented. The safe printk already has an irqwork to make NMI context
> > safe.
> >
> > Second, the NMI irqwork actually does not work if a NMI handler causes
> > panic by watchdog timeout. This NMI irqwork have no chance to run in such
> > case, while the safe printk will flush its per-cpu buffer before panic.
> >
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> 
> Looks about right.
> 
> Acked-by: Thomas Gleixner <tglx@linutronix.de>

I'm wondering why is this thing being moved:

-             if (delta < nmi_longest_ns || delta < a->max_duration)
-                     continue;

into nmi_check_duration() and not remaining where it is?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
