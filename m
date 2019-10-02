Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3040C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 18:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A64BF222CB
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 18:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jfMvq2pQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbfJBSVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 14:21:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53144 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfJBSVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 14:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tV4F6QlszFFgcHGHREIAUvHx1CffhZaSy+HMTK3Mt0Q=; b=jfMvq2pQAYsNkDUWwigv0rk0M
        +T/AACmOD6kQ+a4JYh9r8tdPQUNqua52dLBPSKRYWpTGflnYMLoeZrl9PyKjnCxXCcwhrVXrqxXtz
        dRliVEKB37xKpkKtHqTusP1F5mmgLxRrrtVUZdxfQK5zaQ+jWp77u06x0zvYfWpZatYGcnSCYcxJ6
        uef6lEvDI/tBrFx0r3QalXfvVhrNQC2J92FfS68NtIq+6FX8TH8jhO8H7Ig4XaA1nPzRZVfQuj0Ca
        dves+0EtHxJjAazVBomWOoYuFFhMeOPBTE05YQcokfW4KPnX8MPrX07fUhh2cA/4QTwDEadUeiZQp
        1GJe+oWpw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iFjFO-0000tg-FG; Wed, 02 Oct 2019 18:21:10 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6F65B9801D6; Wed,  2 Oct 2019 20:21:06 +0200 (CEST)
Date:   Wed, 2 Oct 2019 20:21:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3/3] x86/ftrace: Use text_poke()
Message-ID: <20191002182106.GC4643@worktop.programming.kicks-ass.net>
References: <20190827180622.159326993@infradead.org>
 <20190827181147.166658077@infradead.org>
 <aaffb32f-6ca9-f9e3-9b1a-627125c563ed@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaffb32f-6ca9-f9e3-9b1a-627125c563ed@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 06:35:26PM +0200, Daniel Bristot de Oliveira wrote:

> ftrace was already batching the updates, for instance, causing 3 IPIs to enable
> all functions. The text_poke() batching also works. But because of the limited
> buffer [ see the reply to the patch 2/3 ], it is flushing the buffer during the
> operation, causing more IPIs than the previous code. Using the 5.4-rc1 in a VM,
> when enabling the function tracer, I see 250+ intermediate text_poke_finish()
> because of a full buffer...
> 
> Would this be the case of trying to use a dynamically allocated buffer?
> 
> Thoughts?

Is it a problem? I tried growing the buffer (IIRC I made it 10 times
bigger) and didn't see any performance improvements because of it.
