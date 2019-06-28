Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C8FC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED5D208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ApTvu7OB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfF1Ngl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 09:36:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54550 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfF1Ngd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 09:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Hs9auHkF03NdeqtewD6fUm4GeHSf7zbsBEMAsta2Bvg=; b=ApTvu7OBW2b+RUTKP51nSjH3g
        bE8YUno0WpQa7s1eLfEBGNCGM7NAyUxTuQeqz2P2/wXgyX7+n3fSHvvDIjSzMw4oXaJT/xXeEd444
        E1cS8j7b1l4aaRuT2UMkiIRs87MmGiyo262V9jOrqcZVZ/d2E4ca15p7TycRGVLpTwP54N4WFPBbd
        3ddN9HbHXlJW6oOdD1HQ54w2bJpW28e4YUERvOfLHnOSnEItYpyXjZeDt2kOnrcLge+Zqz6eeKbBo
        W0PAs6mZbUwCryYLFeJ0ItkiXtwrZy1nj54vHrFpyBMgn7kgqeOGebZIUrHrsfGGQIGMbE+55VVmO
        xHUkkXd4Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgr2r-0006t0-1A; Fri, 28 Jun 2019 13:36:05 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7579820AB898D; Fri, 28 Jun 2019 15:36:03 +0200 (CEST)
Message-Id: <20190628102113.360432762@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 28 Jun 2019 12:21:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [RFC][PATCH 0/8] jump_label, x86: Support variable sized JMP instructions
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After discussing jump_labels with Eugeny and Vineet the other day, I started
playing with adding support for our 2 byte JMP/8 instruction. Much thanks to
Josh for (re)discovering the .skip trick.

These patches boot an x86_64 defconfig in kvm, so it must be perfect.

Using the 2 byte jumps saves about ~6k text for an x86_64-defconfig build.

