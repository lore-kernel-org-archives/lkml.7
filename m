Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F4AC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0640C21850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ei8Tz4yR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbfDEN5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 09:57:21 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42692 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbfDEN5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 09:57:21 -0400
Received: from zn.tnic (p200300EC2F148A00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6E5271EC05A6;
        Fri,  5 Apr 2019 15:57:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554472638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=O4UcyGkVKqjCMDV4RKEHL/ZfLzZq+tk55TxsL4ffLco=;
        b=Ei8Tz4yR7zuJn7CJE0n6hAz17WJzl2w7nRekqRrJkkwm9Sz/RvpX4BO771fbchCcS0Et2t
        LPkAwY8rKoOxG2rez//jKqS+1a0Yshr6pQN01btrJJLe9aI8+l1VGgaMdUHr7qYzPwRFQn
        kO/gruRXjd/9x1fQyut47HXgp08BeYs=
Date:   Fri, 5 Apr 2019 15:57:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jon Masters <jcm@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tyler Hicks <tyhicks@canonical.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RFC 2/5] x86/speculation: Add support for
 'cpu_spec_mitigations=' cmdline options
Message-ID: <20190405135712.GF23348@zn.tnic>
References: <cover.1554396090.git.jpoimboe@redhat.com>
 <78c63cb08f36f55407f534d49cc2543079e44dbb.1554396090.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <78c63cb08f36f55407f534d49cc2543079e44dbb.1554396090.git.jpoimboe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 11:44:12AM -0500, Josh Poimboeuf wrote:
> Configure x86 runtime CPU speculation bug mitigations in accordance with
> the 'cpu_spec_mitigations=' cmdline options.  This affects Meltdown,
> Spectre v2, Speculative Store Bypass, and L1TF.
> 
> The default behavior is unchanged.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  .../admin-guide/kernel-parameters.txt         | 15 +++++++++
>  arch/x86/include/asm/processor.h              |  1 +
>  arch/x86/kernel/cpu/bugs.c                    | 32 ++++++++++++++++---
>  arch/x86/kvm/vmx/vmx.c                        |  2 ++
>  arch/x86/mm/pti.c                             |  4 ++-
>  5 files changed, 49 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index ac42e510bd6e..29dc03971630 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2552,6 +2552,11 @@
>  
>  			off
>  				Disable all speculative CPU mitigations.
> +				Equivalent to: nopti [x86]
> +					       nospectre_v2 [x86]
> +					       spectre_v2_user=off [x86]
> +					       spec_store_bypass_disable=off [x86]
> +					       l1tf=off [x86]
>  
>  			auto (default)
>  				Mitigate all speculative CPU vulnerabilities,
> @@ -2560,12 +2565,22 @@
>  				surprised by SMT getting disabled across kernel
>  				upgrades, or who have other ways of avoiding
>  				SMT-based attacks.
> +				Equivalent to: pti=auto [x86]
> +					       spectre_v2=auto [x86]
> +					       spectre_v2_user=auto [x86]
> +					       spec_store_bypass_disable=auto [x86]
> +					       l1tf=flush [x86]
>  
>  			auto,nosmt
>  				Mitigate all speculative CPU vulnerabilities,
>  				disabling SMT if needed.  This is for users who
>  				always want to be fully mitigated, even if it
>  				means losing SMT.
> +				Equivalent to: pti=auto [x86]
> +					       spectre_v2=auto [x86]
> +					       spectre_v2_user=auto [x86]
> +					       spec_store_bypass_disable=auto [x86]
> +					       l1tf=flush,nosmt [x86]
>  
>  	mminit_loglevel=
>  			[KNL] When CONFIG_DEBUG_MEMORY_INIT is set, this

Yap, those sets look ok.

> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 2bb3a648fc12..7e95b310f869 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -982,6 +982,7 @@ void microcode_check(void);
>  
>  enum l1tf_mitigations {
>  	L1TF_MITIGATION_OFF,
> +	L1TF_MITIGATION_DEFAULT,
>  	L1TF_MITIGATION_FLUSH_NOWARN,
>  	L1TF_MITIGATION_FLUSH,
>  	L1TF_MITIGATION_FLUSH_NOSMT,
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 2da82eff0eb4..65b95fb95ba5 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -308,8 +308,11 @@ spectre_v2_parse_user_cmdline(enum spectre_v2_mitigation_cmd v2_cmd)
>  
>  	ret = cmdline_find_option(boot_command_line, "spectre_v2_user",
>  				  arg, sizeof(arg));
> -	if (ret < 0)
> +	if (ret < 0) {
> +		if (cpu_spec_mitigations == CPU_SPEC_MITIGATIONS_OFF)
> +			return SPECTRE_V2_USER_CMD_NONE;

Instead of sprinkling that test in those three functions, just do it
once above in check_bugs(), before those *_select_mitigation() functions
get to run and depending on the value, you either run them or use the
default settings, for the OFF case, for example.

>  		return SPECTRE_V2_USER_CMD_AUTO;
> +	}
>  
>  	for (i = 0; i < ARRAY_SIZE(v2_user_options); i++) {
>  		if (match_option(arg, ret, v2_user_options[i].option)) {
> @@ -444,8 +447,11 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
>  		return SPECTRE_V2_CMD_NONE;
>  
>  	ret = cmdline_find_option(boot_command_line, "spectre_v2", arg, sizeof(arg));
> -	if (ret < 0)
> +	if (ret < 0) {
> +		if (cpu_spec_mitigations == CPU_SPEC_MITIGATIONS_OFF)
> +			return SPECTRE_V2_CMD_NONE;
>  		return SPECTRE_V2_CMD_AUTO;
> +	}
>  
>  	for (i = 0; i < ARRAY_SIZE(mitigation_options); i++) {
>  		if (!match_option(arg, ret, mitigation_options[i].option))
> @@ -677,8 +683,11 @@ static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
>  	} else {
>  		ret = cmdline_find_option(boot_command_line, "spec_store_bypass_disable",
>  					  arg, sizeof(arg));
> -		if (ret < 0)
> +		if (ret < 0) {
> +			if (cpu_spec_mitigations == CPU_SPEC_MITIGATIONS_OFF)
> +				return SPEC_STORE_BYPASS_CMD_NONE;
>  			return SPEC_STORE_BYPASS_CMD_AUTO;
> +		}
>  
>  		for (i = 0; i < ARRAY_SIZE(ssb_mitigation_options); i++) {
>  			if (!match_option(arg, ret, ssb_mitigation_options[i].option))
> @@ -955,7 +964,7 @@ void x86_spec_ctrl_setup_ap(void)
>  #define pr_fmt(fmt)	"L1TF: " fmt
>  
>  /* Default mitigation for L1TF-affected CPUs */
> -enum l1tf_mitigations l1tf_mitigation __ro_after_init = L1TF_MITIGATION_FLUSH;
> +enum l1tf_mitigations l1tf_mitigation __ro_after_init = L1TF_MITIGATION_DEFAULT;
>  #if IS_ENABLED(CONFIG_KVM_INTEL)
>  EXPORT_SYMBOL_GPL(l1tf_mitigation);
>  #endif
> @@ -1010,8 +1019,23 @@ static void __init l1tf_select_mitigation(void)
>  
>  	override_cache_bits(&boot_cpu_data);
>  
> +	if (l1tf_mitigation == L1TF_MITIGATION_DEFAULT) {
> +		switch (cpu_spec_mitigations) {
> +		case CPU_SPEC_MITIGATIONS_OFF:
> +			l1tf_mitigation = L1TF_MITIGATION_OFF;
> +			break;
> +		case CPU_SPEC_MITIGATIONS_AUTO:
> +			l1tf_mitigation = L1TF_MITIGATION_FLUSH;
> +			break;
> +		case CPU_SPEC_MITIGATIONS_AUTO_NOSMT:
> +			l1tf_mitigation = L1TF_MITIGATION_FLUSH_NOSMT;
> +			break;
> +		}
> +	}
> +
>  	switch (l1tf_mitigation) {
>  	case L1TF_MITIGATION_OFF:
> +	case L1TF_MITIGATION_DEFAULT:
>  	case L1TF_MITIGATION_FLUSH_NOWARN:
>  	case L1TF_MITIGATION_FLUSH:
>  		break;
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index ab432a930ae8..83b5bdc3c777 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -233,6 +233,7 @@ static int vmx_setup_l1d_flush(enum vmx_l1d_flush_state l1tf)
>  		case L1TF_MITIGATION_FLUSH_NOWARN:
>  		case L1TF_MITIGATION_FLUSH:
>  		case L1TF_MITIGATION_FLUSH_NOSMT:
> +		case L1TF_MITIGATION_DEFAULT:
>  			l1tf = VMENTER_L1D_FLUSH_COND;
>  			break;
>  		case L1TF_MITIGATION_FULL:
> @@ -6686,6 +6687,7 @@ static int vmx_vm_init(struct kvm *kvm)
>  		case L1TF_MITIGATION_FLUSH:
>  		case L1TF_MITIGATION_FLUSH_NOSMT:
>  		case L1TF_MITIGATION_FULL:
> +		case L1TF_MITIGATION_DEFAULT:
>  			/*
>  			 * Warn upon starting the first VM in a potentially
>  			 * insecure environment.

The L1TF bits need to be a separate patch.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
