Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E81C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5842173E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xVWaQP1+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732942AbfHZPNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 11:13:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55352 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730379AbfHZPNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 11:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Vu7Vxv75qBoSgs/X+s8lo6kYB6U6TM+eQAF9W4hOV64=; b=xVWaQP1+E5yZmxnnvf734leaj
        zEIzM4iVyRw6XLQTPPZeZPOdd47kGc+Yk4lfjO9tLDkhkUgpAH0oXXpBu8W7cnUI2M8PTFzkL7WSq
        iAdmlJ/gQ1HosZsAgbutu4dUX9TCaFTUjxRbCN89/XFvgAMHyBans52MJ10zF6M8hqZfRZBdMsYAo
        ezRwO82mUAqGxiqHfRZWYiKWiux45UCgG8HcyN2OjyQaaS/f7VSDcfTdgonfhwUDuvoqbd9hQAWlA
        /xfkhuY+X6xGq93wtTPsQsWbmek6/lHFCjlJZ05a4Nzp+20fo/eorQqo7UfrGcv8YMuoMtZSwLi11
        7quGgNgHQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2Gge-0001rZ-7Y; Mon, 26 Aug 2019 15:13:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 79A983075FE;
        Mon, 26 Aug 2019 17:13:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EF45E20A71EF1; Mon, 26 Aug 2019 17:13:37 +0200 (CEST)
Date:   Mon, 26 Aug 2019 17:13:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 3/3] x86/ftrace: Use text_poke()
Message-ID: <20190826151337.GW2369@hirez.programming.kicks-ass.net>
References: <20190826125138.710718863@infradead.org>
 <20190826125519.879543828@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826125519.879543828@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 02:51:41PM +0200, Peter Zijlstra wrote:
> Move ftrace over to using the generic x86 text_poke functions; this
> avoids having a second/different copy of that code around.
> 
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

*sigh*.. one of those days again. I seem to have tested without this
patch applied.

Let me go fix this.
