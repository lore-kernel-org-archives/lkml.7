Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBF8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DADD62083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553550878;
	bh=x7swZbaedvnBUNIl2XBb7czEubkDx8HjKsBq4Pc2yWE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=cReJNLiZ1DboWmAUezAUXXECwC0Mka/AMd+0mghf+f3ASiIZqmhJKJjCUYCWNU8vO
	 7Ks3teioOuxkAqmuRAQ6hZLiiISyHU5/J18/OILSjgR2KwZtVlPHLjErrUJmcewGbx
	 XtKP/I0Yo2GSBAm5uCzBvhRzUy66K9SGcQbnu0Q0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730452AbfCYVyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:54:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37234 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728563AbfCYVyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:54:37 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 78091FB3;
        Mon, 25 Mar 2019 21:54:29 +0000 (UTC)
Date:   Mon, 25 Mar 2019 14:54:28 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Yury Norov <ynorov@marvell.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] bitmap_parselist: move non-parser logic to helpers
Message-Id: <20190325145428.b826c281daa7f5cd1f110efe@linux-foundation.org>
In-Reply-To: <20190325210748.6571-3-ynorov@marvell.com>
References: <20190325210748.6571-1-ynorov@marvell.com>
        <20190325210748.6571-3-ynorov@marvell.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019 00:07:44 +0300 Yury Norov <yury.norov@gmail.com> wrote:

> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -477,6 +477,42 @@ int bitmap_print_to_pagebuf(bool list, char *buf, const unsigned long *maskp,
>  }
>  EXPORT_SYMBOL(bitmap_print_to_pagebuf);
>  
> +/*
> + * Region 9-38:4/10 describes the following bitmap structure:
> + * 0	   9  12    18			38
> + * .........****......****......****......
> + *	    ^  ^     ^			 ^
> + *      start  off   grlen	       end
> + */
> +struct region {
> +	unsigned int start;
> +	unsigned int off;
> +	unsigned int grlen;
> +	unsigned int end;
> +};

grlen means...  group_len, I think?

Perhaps it should be called group_len ;)

