Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43828C433FF
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 18:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9BB206C1
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 18:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfHDSB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 14:01:28 -0400
Received: from smtprelay0052.hostedemail.com ([216.40.44.52]:48847 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726387AbfHDSB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 14:01:28 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 622B68368EFA;
        Sun,  4 Aug 2019 18:01:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pain56_633b533f5da3a
X-Filterd-Recvd-Size: 4034
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sun,  4 Aug 2019 18:01:21 +0000 (UTC)
Message-ID: <c0669a7130645a20e99915385b7e712360c31ed9.camel@perches.com>
Subject: Re: [RFC PATCH] compiler_attributes.h: Add 'fallthrough' pseudo
 keyword for switch/case use
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Shawn Landden <shawn@git.icu>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>,
        David Miller <davem@davemloft.net>
Date:   Sun, 04 Aug 2019 11:01:10 -0700
In-Reply-To: <1d2830aadbe9d8151728a7df5b88528fc72a0095.1564549413.git.joe@perches.com>
References: <e0dd3af448e38e342c1ac6e7c0c802696eb77fd6.1564549413.git.joe@perches.com>
         <1d2830aadbe9d8151728a7df5b88528fc72a0095.1564549413.git.joe@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-30 at 22:35 -0700, Joe Perches wrote:
> Reserve the pseudo keyword 'fallthrough' for the ability to convert the
> various case block /* fallthrough */ style comments to appear to be an
> actual reserved word with the same gcc case block missing fallthrough
> warning capability.

Linus?  Do you have an opinion about this RFC/patch?

> All switch/case blocks now must end in one of:
> 
> 	break;
> 	fallthrough;
> 	goto <label>;
> 	return [expression];
> 
> fallthough is gcc's __attribute__((__fallthrough__)) which was introduced
> in gcc version 7..
> 
> fallthrough devolves to an empty "do {} while (0)" if the compiler version
> (any version less than gcc 7) does not support the attribute.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
> 
> For allow compilation of a kernel that includes net/sctp, this patch
> also requires a rename of the use of fallthrough as a label in
> net/sctp/sm_make_chunk.c that was submitted as:
> 
> https://lore.kernel.org/lkml/e0dd3af448e38e342c1ac6e7c0c802696eb77fd6.1564549413.git.joe@perches.com/
> 
>  include/linux/compiler_attributes.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
> index 6b318efd8a74..cdf016596659 100644
> --- a/include/linux/compiler_attributes.h
> +++ b/include/linux/compiler_attributes.h
> @@ -40,6 +40,7 @@
>  # define __GCC4_has_attribute___noclone__             1
>  # define __GCC4_has_attribute___nonstring__           0
>  # define __GCC4_has_attribute___no_sanitize_address__ (__GNUC_MINOR__ >= 8)
> +# define __GCC4_has_attribute___fallthrough__         0
>  #endif
>  
>  /*
> @@ -185,6 +186,22 @@
>  # define __noclone
>  #endif
>  
> +/*
> + * Add the pseudo keyword 'fallthrough' so case statement blocks
> + * must end with any of these keywords:
> + *   break;
> + *   fallthrough;
> + *   goto <label>;
> + *   return [expression];
> + *
> + *  gcc: https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html#Statement-Attributes
> + */
> +#if __has_attribute(__fallthrough__)
> +# define fallthrough                    __attribute__((__fallthrough__))
> +#else
> +# define fallthrough                    do {} while (0)  /* fallthrough */
> +#endif
> +
>  /*
>   * Note the missing underscores.
>   *

