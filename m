Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB148C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C9B8206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sZx/GclE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfDOKz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 06:55:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42248 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfDOKz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 06:55:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Gxzy/AaNeEIvJVgpcQ2SD4ixinqpb33r3egFNFahl0Y=; b=sZx/GclEx2J7ERWF/WG5Aw9Va
        IkO2Q8iGHGIwnSMWq1ir1DZcQlabOA16th0I2Sf6iZrIGBGcIDGfP3M0M84oQdzCA0h0Rk1C7EfXK
        zjRbgvmTxS+tAoCIJ3lPjk/Ypg/XpGf4PvDEPU9OV1JBi/Rs3T5B9ZvrCRlLX43Lwp4Wg99hQj8Il
        DFtHYUpHAYA6qmRiW2U4ekWyIC3q5jI4QaBsR1ElUhE/00Wo2e1nAuJapbiRiDiMMEc3mdFHTasnQ
        /Hbx4AZR/671L75GI+1CM1Y5bvbfms4J9b9QsW7BqgeX7/Y8g2fJdhBkqS2gsRq+ETcFde9FiOXH+
        n18BNKssQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hFzGt-0006DR-Lx; Mon, 15 Apr 2019 10:55:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 04F622038C257; Mon, 15 Apr 2019 12:55:30 +0200 (CEST)
Date:   Mon, 15 Apr 2019 12:55:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: Re: [PATCH V5 4/7] jump_label: Sort entries of the same key by the
 code
Message-ID: <20190415105529.GJ11158@hirez.programming.kicks-ass.net>
References: <cover.1554106794.git.bristot@redhat.com>
 <d89001dfd5429567a4c54ff6667986ecaed9900b.1554106794.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d89001dfd5429567a4c54ff6667986ecaed9900b.1554106794.git.bristot@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 10:58:16AM +0200, Daniel Bristot de Oliveira wrote:
> In the batching mode, entries with the same key should also be sorted by the
> code, enabling a bsearch() of a code/addr when updating a key.

Might be good to explain *why*.

We can see what the code does, explaining why we do things is what we
have Changelogs for.

> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> Cc: Jiri Kosina <jkosina@suse.cz>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Chris von Recklinghausen <crecklin@redhat.com>
> Cc: Jason Baron <jbaron@akamai.com>
> Cc: Scott Wood <swood@redhat.com>
> Cc: Marcelo Tosatti <mtosatti@redhat.com>
> Cc: Clark Williams <williams@redhat.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  kernel/jump_label.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/kernel/jump_label.c b/kernel/jump_label.c
> index e666a4d6642a..8b7bfbba4cef 100644
> --- a/kernel/jump_label.c
> +++ b/kernel/jump_label.c
> @@ -36,12 +36,28 @@ static int jump_label_cmp(const void *a, const void *b)
>  	const struct jump_entry *jea = a;
>  	const struct jump_entry *jeb = b;
>  
> +	/*
> +	 * Entrires are sorted by key.
> +	 */
>  	if (jump_entry_key(jea) < jump_entry_key(jeb))
>  		return -1;
>  
>  	if (jump_entry_key(jea) > jump_entry_key(jeb))
>  		return 1;
>  
> +#ifdef HAVE_JUMP_LABEL_BATCH
> +	/*
> +	 * In the batching mode, entries should also be sorted by the code
> +	 * inside the already sorted list of entries, enabling a bsearch in
> +	 * the vector.
> +	 */
> +	if (jump_entry_code(jea) < jump_entry_code(jeb))
> +		return -1;
> +
> +	if (jump_entry_code(jea) > jump_entry_code(jeb))
> +		return 1;
> +#endif
> +
>  	return 0;
>  }

The secondary sort order doesn't hurt, so we could leave the #ifdef out,
not sure.
