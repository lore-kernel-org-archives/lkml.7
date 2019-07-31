Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8018C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF98B2089E
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N3fAGqeG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbfGaJCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 05:02:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52290 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfGaJCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 05:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RPv5D0YsFA+dr9kxKGN1j9O4pN/sAqyeCoYleozCdjA=; b=N3fAGqeG3DKpCPiqRdLjHveah
        idaMU5tAQ43QxN0v4ujTgxbZJgDc27yVT3KQS4lEEpy9tdqIuboqf5dZVTQ+iTywUo4sND3QuZITw
        1+FQNyF5m+kpY9uTFnBpmFAsmfeQOTxmUrqJ5FxunLpr4nKELmxTKclpYmhKAcI20RS/ygNNPvEh1
        5OQR8PPwQujix6gUV9EJ9LgkNpj6KWYpkV6f3fsL7UCTUm0fgHC+qkqVorV+HWvhJqBC+7uMVS5iz
        ZHem4lclfr5FC5y0yAVSuoA/TWmtDo0rfgKEY8g6jRHtxTB1UuJV3z8/BCJSSjOkljXlNG/qzd6gZ
        riJ4+x60w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hskUv-0007GV-IV; Wed, 31 Jul 2019 09:02:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0413B2029FD58; Wed, 31 Jul 2019 11:02:11 +0200 (CEST)
Date:   Wed, 31 Jul 2019 11:02:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joe Perches <joe@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Kees Cook <keescook@chromium.org>,
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
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] compiler_attributes.h: Add 'fallthrough' pseudo
 keyword for switch/case use
Message-ID: <20190731090211.GP31381@hirez.programming.kicks-ass.net>
References: <e0dd3af448e38e342c1ac6e7c0c802696eb77fd6.1564549413.git.joe@perches.com>
 <1d2830aadbe9d8151728a7df5b88528fc72a0095.1564549413.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d2830aadbe9d8151728a7df5b88528fc72a0095.1564549413.git.joe@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 10:35:18PM -0700, Joe Perches wrote:
> Reserve the pseudo keyword 'fallthrough' for the ability to convert the
> various case block /* fallthrough */ style comments to appear to be an
> actual reserved word with the same gcc case block missing fallthrough
> warning capability.
> 
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

_MUCH_ better than that silly comment, thanks for doing this!

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
