Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DADC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 13:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8996C217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 13:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Aou8o3kx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbfHZNEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 09:04:20 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54372 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfHZNEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 09:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4LqlgRwuiJk/8JJ10qWC9ccyEahAihBfJhv+eLrMoAo=; b=Aou8o3kx9eLNin8V/NlOX2Wr6
        +jnWjJThFBbBU9JqyLJ6QYknAQVKI5rQNF7fXI2hx5W6yX1wsNx7EabPWjXp+5MEQWKYcEMaMqJSQ
        MlKB+LC19Xez+iXADBVL2FWN+zS9WTdnSszfp/0dh0gDIJm+2nlB7/LVrR58scO7eV7gPGL8jT9L8
        8E0VbalujhArSS8bH2TVQlhcZ39QA87EIjhGA/N86stQa+vQYN9wjo6Zh30M/xZXdX5lLVl6GZfQH
        oRyWNTzAH7HmK05cD0yXKlKs7GrFbG1ncDr9TsSki1P36/UfRFOsgeb4SNgBV3tuSH8GKRr79k26a
        8jUfn3l/w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2EfL-00070s-Nj; Mon, 26 Aug 2019 13:04:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AE7B63070F4;
        Mon, 26 Aug 2019 15:03:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2C35D20A71EF4; Mon, 26 Aug 2019 15:04:10 +0200 (CEST)
Date:   Mon, 26 Aug 2019 15:04:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 0/3] Rewrite x86/ftrace to use text_poke()
Message-ID: <20190826130410.GU2369@hirez.programming.kicks-ass.net>
References: <20190826125138.710718863@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826125138.710718863@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 02:51:38PM +0200, Peter Zijlstra wrote:
> Ftrace was one of the last W^X violators; these patches move it over to the
> generic text_poke() interface and thereby get rid of this oddity.
> 
> Very lightly tested...

I'm thinking there's more cleanup to be had; set_kernel_text_*() can go
away now, and I'm thinking the whole batching thing can be further
simplified/shared between this and jump_label.

