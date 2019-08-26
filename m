Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD7DC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2750721852
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="z9QCoPLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732111AbfHZM5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 08:57:42 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54298 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730767AbfHZM5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 08:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BwNvFz5ICiIfDFwTlrOTMntBeu9sHaNPD8/acHilW3M=; b=z9QCoPLqHF8dvcUOyZQ6UdZ7m
        Of8V50yvlrsDD9pHe6vgyDTBLfB/lGIqVC0pNcwpc1ixttjSRlZP6f8uLCANRdhZO82hg16H4moFx
        xADqbhoQg63C/3yKKIHVZJXuXHHQGCmElEgiCwIXsop3f/DbRhHcNYjaA1ns19OvNkly1qzbEo1Ba
        Fwl6RUgQpSRkVfU95cVbACH3zpb5QGaCwg+EILmvfd4mqPtrPZz/fgFzFvqaUMPrihoYuwAY/dXQk
        VbnGaK9HcvjSjl3L/yYhms1t1GGQybWdl81DaL8Jh8OurqpYXp+F9PQSfx13I2T00psvUumcRrWnL
        uqUbOI2aQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2EYb-0006vv-Fa; Mon, 26 Aug 2019 12:57:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 078073070F4;
        Mon, 26 Aug 2019 14:56:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7AAE9202245D4; Mon, 26 Aug 2019 14:57:10 +0200 (CEST)
Message-Id: <20190826125138.710718863@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 26 Aug 2019 14:51:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/3] Rewrite x86/ftrace to use text_poke()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ftrace was one of the last W^X violators; these patches move it over to the
generic text_poke() interface and thereby get rid of this oddity.

Very lightly tested...

