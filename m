Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDD5C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 16:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C994820872
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 16:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731352AbfCaQyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 12:54:54 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57418 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731240AbfCaQyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 12:54:54 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hAdjL-0004Jb-HS; Sun, 31 Mar 2019 18:54:47 +0200
Date:   Sun, 31 Mar 2019 18:54:46 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 17/24] x86/fpu: Always store the registers in
 copy_fpstate_to_sigframe()
In-Reply-To: <20190321202632.16810-18-bigeasy@linutronix.de>
Message-ID: <alpine.DEB.2.21.1903311849520.2476@nanos.tec.linutronix.de>
References: <20190321202632.16810-1-bigeasy@linutronix.de> <20190321202632.16810-18-bigeasy@linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019, Sebastian Andrzej Siewior wrote:
> @@ -169,9 +155,15 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
>  			sizeof(struct user_i387_ia32_struct), NULL,
>  			(struct _fpstate_32 __user *) buf) ? -1 : 1;
>  
> -	/* Save the live register state to the user directly. */
> -	if (copy_fpregs_to_sigframe(buf_fx))
> -		return -1;
> +	copy_fpregs_to_fpstate(fpu);
> +
> +	if (using_compacted_format()) {
> +		copy_xstate_to_user(buf_fx, xsave, 0, size);

This needs to check the return value. 

> +	} else {
> +		fpstate_sanitize_xstate(fpu);
> +		if (__copy_to_user(buf_fx, xsave, fpu_user_xstate_size))
> +			return -1;
> +	}

Thanks,

	tglx
