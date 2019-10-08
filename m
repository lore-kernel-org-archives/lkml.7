Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9956C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A295A206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="YduNK1Ez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfJHPYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 11:24:17 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58064 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbfJHPYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:24:16 -0400
Received: from zn.tnic (p200300EC2F0B5100B1AE7F6CCC5C3495.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:5100:b1ae:7f6c:cc5c:3495])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5E1D31EC067D;
        Tue,  8 Oct 2019 17:24:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1570548255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RhgPny4KDnuAzl5T84M1zxOntf4rs7YtH2tmNBz55AA=;
        b=YduNK1EzyGpMftul0OtE8qXXV5AcPO1WiyFlOEI0ckmWWE0lfgQ0lx4VxH6WTV9UytSmHY
        HHgUWTko6bhgUIojllMKnaJI2HsSOBZPHyU3DQCwzXLE1WrJ3GIwuiYE/xwGh4fEK4xzIJ
        WFh6rrhSKnRDG+9N769XurvPmymu0Mw=
Date:   Tue, 8 Oct 2019 17:24:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
Subject: Re: [PATCH v3 1/6] x86/alternatives: Teach text_poke_bp() to emulate
 instructions
Message-ID: <20191008152408.GI14765@zn.tnic>
References: <20191007081716.07616230.8@infradead.org>
 <20191007081944.88332264.2@infradead.org>
 <20191008142924.GE14765@zn.tnic>
 <20191008144834.GD2328@hirez.programming.kicks-ass.net>
 <20191008145423.GG14765@zn.tnic>
 <20191008110412.29afac9f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191008110412.29afac9f@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 11:04:12AM -0400, Steven Rostedt wrote:
> The difference between do_sync and i is that i gets incremented at
> every iteration, where do_sync gets incremented only when the first
> conditional is false. But I still see do_sync as a loop variable.

I'd prefer it this way:

	do_sync = 0;

	for (i = 0; i < nr_entries; i++) {
	        if (tp[i].text[0] == INT3_INSN_OPCODE)
	                continue;

	        text_poke(tp[i].addr, tp[i].text, sizeof(int3));
	        do_sync++;
	}

	if (do_sync)
	        on_each_cpu(do_sync_core, NULL, 1);

Clear and simple. We clear it, the loop runs and we check it after the
loop ends. Clear and simple pattern which you see everywhere in code.
All well known and uneventful.

Now if the do_sync clearing is in the for () brackets, you have to stop
and look for it and wonder, why is that thing there, is there anything
special about it?

And with the amount of code going through us every day, I'd prefer well
known and uneventful in any day of the week.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
