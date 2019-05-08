Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED49C004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 00:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 565DA20C01
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 00:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfEHApP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 20:45:15 -0400
Received: from ozlabs.org ([203.11.71.1]:32875 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfEHApO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 20:45:14 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44zHnN3NLtz9s00;
        Wed,  8 May 2019 10:45:12 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/ftrace: Enable C Version of recordmcount
In-Reply-To: <4464516c0b6835b42acc65e088b6d7f88fe886f2.1557235811.git.christophe.leroy@c-s.fr>
References: <4464516c0b6835b42acc65e088b6d7f88fe886f2.1557235811.git.christophe.leroy@c-s.fr>
Date:   Wed, 08 May 2019 10:45:12 +1000
Message-ID: <87ef59wz8n.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> Selects HAVE_C_RECORDMCOUNT to use the C version of the recordmcount
> intead of the old Perl Version of recordmcount.
>
> This should improve build time. It also seems like the old Perl Version
> misses some calls to _mcount that the C version finds.

That would make this a bug fix possibly for stable even.

Any more details on what the difference is, is it just some random
subset of functions or some pattern?

cheers

> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 2711aac24621..d87de4f9da61 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -180,6 +180,7 @@ config PPC
>  	select HAVE_ARCH_NVRAM_OPS
>  	select HAVE_ARCH_SECCOMP_FILTER
>  	select HAVE_ARCH_TRACEHOOK
> +	select HAVE_C_RECORDMCOUNT
>  	select HAVE_CBPF_JIT			if !PPC64
>  	select HAVE_STACKPROTECTOR		if PPC64 && $(cc-option,-mstack-protector-guard=tls -mstack-protector-guard-reg=r13)
>  	select HAVE_STACKPROTECTOR		if PPC32 && $(cc-option,-mstack-protector-guard=tls -mstack-protector-guard-reg=r2)
> -- 
> 2.13.3
