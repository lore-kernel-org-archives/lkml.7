Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1495BC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 02:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D1F217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 02:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388479AbfEXCMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 22:12:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:54502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbfEXCMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 22:12:13 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D962217D7;
        Fri, 24 May 2019 02:12:12 +0000 (UTC)
Date:   Thu, 23 May 2019 22:12:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: silence GCC 9 array bounds warning
Message-ID: <20190523221210.4a2bb326@oasis.local.home>
In-Reply-To: <20190523124535.GA12931@gmail.com>
References: <20190523124535.GA12931@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 May 2019 14:45:35 +0200
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> +/*
> + * Reset the state of the trace_iterator so that it can read consumed data.
> + * Normally, the trace_iterator is used for reading the data when it is not
> + * consumed, and must retain state.
> + */
> +static __always_inline void trace_iterator_reset(struct trace_iterator *iter)
> +{
> +	const size_t offset = offsetof(struct trace_iterator, seq);
> +
> +	/*
> +	 * Keep gcc from complaining about overwriting more than just one
> +	 * member in the structure.
> +	 */
> +	memset((char *)(iter) + offset, 0, sizeof(struct trace_iterator) - offset);

I still prefer the typecast of void *, as that's used a bit more in the
kernel, but since char * is also used (not as much), I'll leave it. But
the parenthesis around iter are unnecessary. I'll remove them.

-- Steve


> +
> +	iter->pos = -1;
> +}
> +
