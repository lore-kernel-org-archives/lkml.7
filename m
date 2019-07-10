Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27C3C73C65
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 00:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4ED20645
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 00:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZeyRE2E8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfGJAbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 20:31:10 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44211 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfGJAbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 20:31:10 -0400
Received: by mail-pl1-f196.google.com with SMTP id t14so231638plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 17:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wGVuhfntLCcg6LbQye6xKiCv590GgebAIJc5hMYMFD4=;
        b=ZeyRE2E8dkygONuPOjCCPgp1vuJ+IsSJvjYUI3pjlzxYCsBUC8VSTPlc4h4Rw2QtRr
         +tD1ts+A7RUgm23rPeAD9yshzojSRr44P99RhL3UDXHxv6qRCunGqfNCsfIxUJ50CLHr
         /SOIqZkz2nVgKEvtXAPp1IfdizTWAOwiIh9ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wGVuhfntLCcg6LbQye6xKiCv590GgebAIJc5hMYMFD4=;
        b=qDconKFa99IPxREhs8qvt5IyQ21O+fLnJS3ot6LWPvmuaZpAzkDLvY6Sxl0bBrnX4z
         YkNJdG1Eo4K8m13+kZvur09oQOAbY8vEi+n8rk+TJyImfxt1koP8fcMqm852CD45b29v
         3IVoz2lyOzNz3KOgncUCoOxw5m0+BnOkoOlL53m6HeroOvvkmMdViIR5bqzNFbT0T77j
         ydhFHKa/cXy+HJqj3wLi7oaXkvLap6xLXggHKA/FnJPvzkxpRdVvwenxWjz/08goD7PB
         b1reJ79UHRH8zzYwGhkQUhLfWcyO0b8hRDqsCcc/RycqzV4QIihU2WLT9bhYlJYEpkgr
         Jbww==
X-Gm-Message-State: APjAAAWigKN/F3HE+Fxc9WsOHZCqVBD3Z62az6clOvKzMKYW7mvcsEt5
        gadECzSr7uWI0BRb59gblKkrdg==
X-Google-Smtp-Source: APXvYqx4jeEI/W0g4ZaW5KHgEMLKauCehn+AVqcFpr82KU5jwXUocznLtSGM2LJQgtTmSnydL3c0/Q==
X-Received: by 2002:a17:902:788f:: with SMTP id q15mr36007545pll.236.1562718669555;
        Tue, 09 Jul 2019 17:31:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d12sm231271pfd.96.2019.07.09.17.31.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Jul 2019 17:31:08 -0700 (PDT)
Date:   Tue, 9 Jul 2019 17:31:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>, Jiri Kosina <jkosina@suse.cz>,
        Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>
Subject: Re: [GIT PULL] x86/topology changes for v5.3
Message-ID: <201907091727.91CC6C72D8@keescook>
References: <20190708162756.GA69120@gmail.com>
 <CAHk-=wigbHd6wXcrpH+6jnDe=e+OHFy6-KdVSUP2yU5aip-UAg@mail.gmail.com>
 <CAHk-=wgkWTtW-JWVAO0Y6s=dRgZGAaTWAsOuYaTFNJzkF+Z_Jg@mail.gmail.com>
 <CAHk-=whJtbQFHNtNG7t7y6+oEKLpjj3eSQOrr3OPCVGbMaRz-A@mail.gmail.com>
 <CAHk-=wh7NChJP+WkaDd3qCz847Fq4NdQ6z6m-VFpbr3py_EknQ@mail.gmail.com>
 <alpine.DEB.2.21.1907100023020.1758@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907100039540.1758@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907100115220.1758@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907100115220.1758@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 01:17:11AM +0200, Thomas Gleixner wrote:
> On Wed, 10 Jul 2019, Thomas Gleixner wrote:
> > 
> > That still does not explain the cr4/0 issue you have. Can you send me your
> > .config please?
> 
> Does your machine have UMIP support? None of my test boxes has. So that'd
> be the difference of bits enforced in CR4. Should not matter because it's
> User mode instruction prevention, but who knows.

Ew. Yeah, I don't have i9 nor i7 for testing this. I did try everything
else I had (and hibernation). Is only Linus able to reproduce this so far?

To rule out (in?) UMIP, this would remove UMIP from the pinning:

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 309b6b9b49d4..f3beedb6da8a 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -380,7 +380,7 @@ static void __init setup_cr_pinning(void)
 {
 	unsigned long mask;
 
-	mask = (X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP);
+	mask = (X86_CR4_SMEP | X86_CR4_SMAP);
 	cr4_pinned_bits = this_cpu_read(cpu_tlbstate.cr4) & mask;
 	static_key_enable(&cr_pinning.key);
 }


-- 
Kees Cook
