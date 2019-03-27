Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E21BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E2E2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553697592;
	bh=9BWuXRUv0O/12yU4gtsVYMGF5YqtaJcx/ToeRFHvNc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RgULtHMZBwTVChK55f+/dosZcSMMaOrCzeBNnYRn/couSErtr++yT1zLB9eQCPmjV
	 s1T21dgU+Lnel+quEfsD5iE+PUA4JR9psdruofUD1h21NIqEaWnEKcYicHZE7RqTcb
	 RzkwyNtnW8G+6mYjJwEYJNXBZoXXd8JLcxpJXn9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbfC0Oju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:39:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41325 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727683AbfC0Oju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:39:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id r4so11195197wrq.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 07:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S3Q88qChHE1w02tGUWzYQiNwrI9I5BWKAhSSHFy9H4g=;
        b=Q1DErkZSrazjLtGpgtPl2LWm65B59PTeEpjOYA3cjvE8uV0wbsd0AVQebeXGQ/0nxq
         XMZ7CfDo0EIRxhaUyPQt/veKdvh88juUkj1QfiwRa91gcxcyxU3uf/rsVvrSpUsTL/oe
         J5EZic4c4weK3in4TCCPBtIkgs5sb02ItS9jWCnceUugxSPbliiZL8EihwckP/tb6tIt
         DCEwKhGXhiJbCjDD8m2EQFPYTdyZz0wE/SwQMNAxySJI0jqUsiHpldbHHhOoGP7bgi6/
         XRU4N0b5+nOyMJ2+TBEGk1nPmkY/LGK5mK2f9n1VqKLqUna6JO63L9MfHt0eqQ8V4Ur8
         D4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=S3Q88qChHE1w02tGUWzYQiNwrI9I5BWKAhSSHFy9H4g=;
        b=M8gY3egv3JF+wjhJU3AIW74J1tPX1lyJIpbyCWA5sctNlfDPTLAuBz9xgA4Wa3yvXA
         xV8d/q7jL3GWVr5gYTg0700fGcI9p/y6TvORLUifeqYNOWI8O5x6P7ln3obYtGk6a6TB
         Z3m0Sr2oC0Xn4MZbtHXNqJaQRNI279fkCNhFudXm3ccLJhDMXLKpTXMYx8AF6/0IyUzb
         DkENxtX8XORmjA+VNO8tE5FC9ZNYcH+ctG+xNzFCLCJFiEsto/YFuFg1pZhvdc3dpQzd
         GWuv+rG9UGqLR2Qjjlt7rwmv7QXOEPHH5n7TAdCceXLPBToihv/4tHyH9bpmVn26XKi6
         2XeA==
X-Gm-Message-State: APjAAAUgl1NTjKY0++OJMdIqJn4OyYoWcIunJxQqbuzJuRAzuvqp+uRK
        EMrtXp8JcKExt/UZrV6iQFA=
X-Google-Smtp-Source: APXvYqyroECcRHoT7Ms/ObqBivICEYvpjz79TZ5nDesbAjKtPrqP+1DLTJSX7i8qE+gpF+8slYKr7w==
X-Received: by 2002:a5d:43c9:: with SMTP id v9mr23273140wrr.269.1553697588558;
        Wed, 27 Mar 2019 07:39:48 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id q19sm107170wmq.23.2019.03.27.07.39.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 07:39:47 -0700 (PDT)
Date:   Wed, 27 Mar 2019 15:39:45 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andi Kleen <andi@firstfloor.org>, Andi Kleen <ak@linux.intel.com>,
        x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 02/17] x86, lto: Mark all top level asm statements as
 .text
Message-ID: <20190327143945.GA55393@gmail.com>
References: <20190321220009.29334-1-andi@firstfloor.org>
 <20190321220009.29334-3-andi@firstfloor.org>
 <alpine.DEB.2.21.1903261751490.1789@nanos.tec.linutronix.de>
 <20190326213803.GN18020@tassilo.jf.intel.com>
 <alpine.DEB.2.21.1903262321390.1789@nanos.tec.linutronix.de>
 <20190327005523.bbxxittqf4d5bdz5@two.firstfloor.org>
 <alpine.DEB.2.21.1903270820530.1789@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903270820530.1789@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> Proper fix below.
> 
> Thanks,
> 
> 	tglx
> 
> 8<-------------------
> 
> --- a/arch/x86/include/asm/paravirt_types.h
> +++ b/arch/x86/include/asm/paravirt_types.h
> @@ -367,11 +367,15 @@ extern struct paravirt_patch_template pv
>  	_paravirt_alt(insn_string, "%c[paravirt_typenum]", "%c[paravirt_clobber]")
>  
>  /* Simple instruction patching code. */
> -#define NATIVE_LABEL(a,x,b) "\n\t.globl " a #x "_" #b "\n" a #x "_" #b ":\n\t"
> +#define NATIVE_LABEL(a,x,b) "\n" a #x "_" #b ":\n\t"
>  
>  #define DEF_NATIVE(ops, name, code)					\
> -	__visible extern const char start_##ops##_##name[], end_##ops##_##name[];	\
> -	asm(NATIVE_LABEL("start_", ops, name) code NATIVE_LABEL("end_", ops, name))
> +	static const char start_##ops##_##name[], end_##ops##_##name[]; \
> +	asm(".pushsection .rodata, \"a\"\n"				\
> +	    NATIVE_LABEL("start_", ops, name)				\
> +	    code							\
> +	    NATIVE_LABEL("end_", ops, name)				\
> +	    ".popsection\n")

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
