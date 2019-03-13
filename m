Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FDDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48EA62146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfCMSkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:40:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbfCMSkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 14:40:17 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30B902146E;
        Wed, 13 Mar 2019 18:40:15 +0000 (UTC)
Date:   Wed, 13 Mar 2019 14:40:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     akpm@linux-foundation.org, clang-built-linux@googlegroups.com,
        linux-kbuild@vger.kernel.org, stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        James Y Knight <jyknight@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] lib/string.c: implement a basic bcmp
Message-ID: <20190313144013.37cab5c7@gandalf.local.home>
In-Reply-To: <20190313181719.87859-1-ndesaulniers@google.com>
References: <CAKwvOdmdEH1U9vOmVKo2Fn+hMPF9AB1enZ2rkpJcU9XHgR8Wng@mail.gmail.com>
        <20190313181719.87859-1-ndesaulniers@google.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2019 11:17:15 -0700
Nick Desaulniers <ndesaulniers@google.com> wrote:

> +#ifndef __HAVE_ARCH_BCMP
> +/**
> + * bcmp - Like memcmp but a non-zero return code simply indicates a non-match.
> + * @cs: One area of memory.
> + * @ct: Another area of memory.
> + * @count: The size of the areas.
> + */
> +#undef bcmp
> +int bcmp(const void *cs, const void *ct, size_t count)
> +{
> +	return memcmp(cs, ct, count);

This is confusing where the comment says "like memcmp but .." and then
just returns memcmp() unmodified. If anything, I would expect to see

	return !!memcmp(cs, ct, conut);

or have a better comment explaining why its the same.

-- Steve

> +}
> +EXPORT_SYMBOL(bcmp);
> +#endif
> +
