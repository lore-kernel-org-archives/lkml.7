Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B30BC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF38A2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Dwuqx/VV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfDLR3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 13:29:40 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36446 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbfDLR3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 13:29:40 -0400
Received: from zn.tnic (p200300EC2F088400182D43E6467BCCF1.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:8400:182d:43e6:467b:ccf1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2799D1EC04B9;
        Fri, 12 Apr 2019 19:29:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555090178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZqF6laFPCLc2dscp6YczEFCerSEH+x8fhTe8pZPFxCA=;
        b=Dwuqx/VVaIUgJX5HPLThflV7lLbCIY2OG/g5X2fG0dZAcYX52ECza/cfnhh4usfE1C1g0k
        7/I9Z7lBT8y0+fuqqHOFfDVX4JhttXvVr3lu8WO0rqq9gpAVH/uvGA+fk8/ZQYgSNw4tpL
        +muisXnp868GzPRSLl/mJQiZYaW6Mck=
Date:   Fri, 12 Apr 2019 19:29:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 23/27] x86/fpu: Defer FPU state load until return to
 userspace
Message-ID: <20190412172931.GI19808@zn.tnic>
References: <20190403164156.19645-1-bigeasy@linutronix.de>
 <20190403164156.19645-24-bigeasy@linutronix.de>
 <20190412143615.GE19808@zn.tnic>
 <20190412152437.d2bswajqtx7hrpkb@linutronix.de>
 <20190412162213.GF19808@zn.tnic>
 <20190412163741.wq2iq44bnvcbne3a@linutronix.de>
 <20190412164827.GG19808@zn.tnic>
 <20190412171955.npe2pbomc6np326v@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190412171955.npe2pbomc6np326v@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 07:19:55PM +0200, Sebastian Andrzej Siewior wrote:
> remove x86_fpu_activate_state.

Ok, zapping it as part of this patch.

> We could also rip all trcepoints out, rethink the situation and add new
> ones based on current code.

Well, since this changes FPU regs handling considerably, I think the
only correct step would be to adjust the tracepoints. BUT(!) we should
not forget we're not supposed to break luserspace.

> - on schedule out, we may need to save registers (depending on
>   TIF_NEED_FPU_LOAD) which is new. Before the series we always did.

That makes sense.

> - on schedule in do nothing but set that TIF bit. This is probably
>   boring.

Yah.

> - on return to userland we should load the registers but can avoid it if
>   we assume that they are valid for the current task
>   (fpregs_state_valid())

That is interesting info.

> - in kernel_fpu_begin() we may trash the task's FPU state (by saving its
>   registers or by resetting fpu_fpregs_owner_ctx).

Do we care?

You mean, in case you have workloads which might involve a lot of
in-kernel FPU use which would punish task context switches?

> Those might be interesting.
> 
> Currently we have:
>   "x86/fpu: %p load: %d xfeatures: %llx xcomp_bv: %llx"
> 
> and we have to find out what happens based on where that TP was
> recorded. Also I'm not sure if the recorded xfeatures change over time.
> I think they do not…

Good question.

> you mean trace_x86_fpu_activate_state and trace_x86_fpu_regs_activated?
> They were added in d1898b733619b ("x86/fpu: Add tracepoints to dump FPU
> state at key points") and we wouldn't have any otherwise.

I guess it made sense then...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
