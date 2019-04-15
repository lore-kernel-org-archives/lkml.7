Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B0AC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDB4B206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Eg6z81qd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfDOKw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 06:52:27 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60244 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfDOKw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 06:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DlIj17HSmXj9nZCEjavudDP71Uz3owu6mPfUFnKUouM=; b=Eg6z81qdyNmU6IRF0IvZZ8Xpo
        HjZnVzizSUjFBPoHIxJyxTHHxBubWFWpXclRmoRlm0DSXBRTmtzCr5ATLpBbeGcZtb1BdFSj7LdkV
        tl++h7GkBmGuSDtNR6D/iy7/k4unVoBKWO+suyLosd7Grl18SR2F/oc7YA/zhxjQ4JPzg/Zi4Iu10
        QXn7sIujv71lP2iJdtW0hme+uctNpnuUU2lMWi383W58zWGRRX4MGsEUNv9hXOJvIwKTvhmj1zzwQ
        Agnx6nZMLSiw5oZiNyqk2BFrYDttrwjMPzsQg6uSW2mtiR1P82Dbimme3kRB99BpmfxAxmlyjE6Vd
        F5mOzf7Zg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hFzDV-00006V-KO; Mon, 15 Apr 2019 10:52:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1A48A2038C257; Mon, 15 Apr 2019 12:51:59 +0200 (CEST)
Date:   Mon, 15 Apr 2019 12:51:59 +0200
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
Subject: Re: [PATCH V5 1/7] jump_label: Add for_each_label_entry helper
Message-ID: <20190415105159.GI11158@hirez.programming.kicks-ass.net>
References: <cover.1554106794.git.bristot@redhat.com>
 <708f1d88826965ef5735c372cc9a17bb80613856.1554106794.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <708f1d88826965ef5735c372cc9a17bb80613856.1554106794.git.bristot@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 10:58:13AM +0200, Daniel Bristot de Oliveira wrote:
> Add a helper macro to make jump entry iteration code more readable.
> 
> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>

> diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
> index 3e113a1fa0f1..7e91af98bbb1 100644
> --- a/include/linux/jump_label.h
> +++ b/include/linux/jump_label.h
> @@ -227,6 +227,9 @@ extern void static_key_disable(struct static_key *key);
>  extern void static_key_enable_cpuslocked(struct static_key *key);
>  extern void static_key_disable_cpuslocked(struct static_key *key);
>  
> +#define for_each_label_entry(key, entry, stop)				  \
> +	for (; (entry < stop) && (jump_entry_key(entry) == key); entry++)
> +

I don't really like this naming; most (all?) for_each_*() loops start
iteration and have the iteration variable as first argument.

This should maybe be called:

	for_each_jump_entry_by_key_cont(entry, stop, key)

and I realize that is a horrible name too.
