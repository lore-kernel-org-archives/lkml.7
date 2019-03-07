Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9CDC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB82720643
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfCGP2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:28:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56178 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbfCGP2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:28:12 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 15E3CC049DC1;
        Thu,  7 Mar 2019 15:28:11 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.34])
        by smtp.corp.redhat.com (Postfix) with SMTP id DE8911001E69;
        Thu,  7 Mar 2019 15:28:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  7 Mar 2019 16:28:09 +0100 (CET)
Date:   Thu, 7 Mar 2019 16:28:05 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-arch@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH] signal: fix building with clang
Message-ID: <20190307152805.GA25101@redhat.com>
References: <20190307091218.2343836-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307091218.2343836-1-arnd@arndb.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 07 Mar 2019 15:28:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07, Arnd Bergmann wrote:
>
> clang warns about the sigset_t manipulating functions (sigaddset, sigdelset,
> sigisemptyset, ...) because it performs semantic analysis before discarding
> dead code, unlike gcc that does this in the reverse order.
>
> The result is a long list of warnings like:
>
> In file included from arch/arm64/include/asm/ftrace.h:21:
> include/linux/compat.h:489:10: error: array index 3 is past the end of the array (which contains 2 elements) [-Werror,-Warray-bounds]
>         case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];

stupid question... I have no idea if this can work or not, but may be we can just do

	--- x/Makefile
	+++ x/Makefile
	@@ -701,6 +701,7 @@ KBUILD_CPPFLAGS += $(call cc-option,-Qun
	 KBUILD_CFLAGS += $(call cc-disable-warning, format-invalid-specifier)
	 KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
	 KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
	+KBUILD_CFLAGS += $(call cc-disable-warning, array-bounds)
	 # Quiet clang warning: comparison of unsigned expression < 0 is always false
	 KBUILD_CFLAGS += $(call cc-disable-warning, tautological-compare)
	 # CLANG uses a _MergedGlobals as optimization, but this breaks modpost, as the

?

> As a (rather ugly) workaround,

Yes :/

But I am not going to argue, just a couple of questions.

> I turn the nice switch()/case statements
> into preprocessor conditionals, and where that is not possible, use the
> '%' operator

I can't say what looks worse... to me it would be either use ifdef's or %'s
everywhere in signal.h, with this patch the code doesn't look consistent.
But I won't insist.


>  static inline int sigisemptyset(sigset_t *set)
>  {
> -	switch (_NSIG_WORDS) {
> -	case 4:
> -		return (set->sig[3] | set->sig[2] |
> -			set->sig[1] | set->sig[0]) == 0;
> -	case 2:
> -		return (set->sig[1] | set->sig[0]) == 0;
> -	case 1:
> -		return set->sig[0] == 0;
> -	default:
> -		BUILD_BUG();
> -		return 0;
> -	}
> +#if _NSIG_WORDS == 4
> +	return (set->sig[3] | set->sig[2] |
> +		set->sig[1] | set->sig[0]) == 0;
> +#elif _NSIG_WORDS == 2
> +	return (set->sig[1] | set->sig[0]) == 0;
> +#elif _NSIG_WORDS == 1
> +	return set->sig[0] == 0;
> +#else
> +	BUILD_BUG();
> +#endif
>  }

Or perhaps we can simply rewrite this and other helpers?

I don't think that, say,

	static inline int sigisemptyset(sigset_t *set)
	{
		for (i = 0; i < ARRAY_SIZE(set->sig); ++i)
			set->sig[i] = 0;
	}

will make asm worse...

Oleg.

