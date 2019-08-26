Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BB4C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 14:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA8B7217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 14:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CkN4Km85"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732542AbfHZOhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 10:37:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42598 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfHZOhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 10:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9L6x3bv3OAx/rNyKIGAjoq8IovFuRmRoE4HKzlVac30=; b=CkN4Km85hK6pSp0jpT8G5RAj/
        h+hJGzLQumvjJ3l14xFuBFt96F3L0owPEaUT3Sq34R239hUaS7ZJZK0TJqCZqdQisWzqWbVm06DKD
        5UgFdt3xeT6I/t77fic667mkohIiHLObFG2ZgnoH+BntEfs5w6SIX7kBrGJizT2t4JUAN49aW1PmO
        xazoi0avOSqvVXWs+mQYInrFYHEkdEoChNorbJXNT+ODj9tkm4lqPEH51xPl8BbXRGutHYpW1euur
        ZPsMWWRLNOhrh/rtmm48SN2Hi2ug+02qlaIpKBNi/6BiOKl1ErsqKJ1dRnY2XCIw0B7ol64FUl/nL
        V/cj+Rv5g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2G70-0001ZE-1m; Mon, 26 Aug 2019 14:36:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 23D7C3070F4;
        Mon, 26 Aug 2019 16:36:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9B84C20A6A641; Mon, 26 Aug 2019 16:36:47 +0200 (CEST)
Date:   Mon, 26 Aug 2019 16:36:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/3] x86/alternatives: Move tp_vec
Message-ID: <20190826143647.GV2369@hirez.programming.kicks-ass.net>
References: <20190826125138.710718863@infradead.org>
 <20190826125519.798115791@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826125519.798115791@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 02:51:40PM +0200, Peter Zijlstra wrote:

> +#define TP_VEC_MAX (PAGE_SIZE / sizeof(struct text_poke_loc))
> +extern struct text_poke_loc tp_vec[TP_VEC_MAX];
> +extern int tp_vec_nr;

FWIW, that currently results in a batch size of 128, but I've not
noticed any delay in flipping ftrace on and off on the commandline.

Growing that buffer really shouldn't be a problem, but I'm thinking we'd
want solid performance numbers to justify it.
