Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31344C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA4D520850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="FhqI6RCO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfDLQWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:22:22 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55092 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbfDLQWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 12:22:22 -0400
Received: from zn.tnic (p200300EC2F08840045FC5AE246A091A8.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:8400:45fc:5ae2:46a0:91a8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 84CB01EC027B;
        Fri, 12 Apr 2019 18:22:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555086140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pJZ/RsPDisoeApAvLnzUtHG54NZ2c/yzsursCQX20VM=;
        b=FhqI6RCOSNc7T9M5KOvY5sQ2eNkKKawpnOKAnAXjqrtadxeGkkiEwUHRefeR+ey+V+SsC0
        9rv9XNabphJ++7rr1v1MhOOKS2iMqLQLiWo5DK64EDuIkqog2ewdEwdgAC8/uVcLWqzNqp
        1XN7yRWc4K9hU7HXd/aaOM0U4qlsuZ4=
Date:   Fri, 12 Apr 2019 18:22:13 +0200
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
Message-ID: <20190412162213.GF19808@zn.tnic>
References: <20190403164156.19645-1-bigeasy@linutronix.de>
 <20190403164156.19645-24-bigeasy@linutronix.de>
 <20190412143615.GE19808@zn.tnic>
 <20190412152437.d2bswajqtx7hrpkb@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190412152437.d2bswajqtx7hrpkb@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 05:24:37PM +0200, Sebastian Andrzej Siewior wrote:
> Isn't it called from fpu__clear()?

$ git grep trace_x86_fpu_activate_state
$

all 23 patches applied. Grepping the later patches doesn't give
trace_x86_fpu_activate_state() either.

> > Shouldn't it be called below, before fpregs_activate() because
> > fpregs_activate() does trace_x86_fpu_regs_activated()?
> 
> Why? fpu__initialize() wipes the FPU state and starts from zero.
> fpregs_mark_activate() on the other hand marks this FPU context is
> currently active.

Well, then the naming still needs adjusting.

"trace_x86_fpu_activate_state" reads to me like the state is being
activated here, at the call site. And fpregs_mark_activate() marks which
*fpu is the active one.

Hmm.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
