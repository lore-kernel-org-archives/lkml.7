Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4532CCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D42F21897
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="opuzBLM/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504784AbfJRHvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 03:51:36 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34292 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504755AbfJRHvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 03:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=udiFsuLSecJae2KLXB64oscu+ISQzu6uTxUGRr5+ReQ=; b=opuzBLM/M/L/juv0irN0Z1SZD
        F7xfF+Csenygl6CZaMS9BtSSDz+sjkMSpFUVTU2BHc4kkUPUyyQ79jcn1r32g0IBZ/LbV4Jd6kF8q
        YC0ZPF5dZbwYD2xD6k92KknYTomExi4Zf16uZvkJgJEQc09UrKwJzxVSDVCSp4HTxM2juK6EsMZGl
        dVYcdBN3Am7J3vfpoImLOMqWs9D5144/V0sr+YaUSPdcJE1gaIwiaPLqOUuBnW0B79oPgXviefS5x
        OBO1b3ZI1w4WOhwkDO0BSwt1oxzKIvtd0r5OLL3UaGYJkGTkLl1whAe7y1+axP9oD8nMM+y7ScEG0
        9OITnCKtA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLN2b-0007mg-2T; Fri, 18 Oct 2019 07:51:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8A081301245;
        Fri, 18 Oct 2019 09:50:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 327962B17810C; Fri, 18 Oct 2019 09:51:15 +0200 (CEST)
Message-Id: <20191018073525.768931536@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 18 Oct 2019 09:35:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, jeyu@kernel.org
Subject: [PATCH v4 00/16] Rewrite x86/ftrace to use text_poke (and more)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ftrace was one of the last W^X violators (and KLP it seems). These here patches
move it over to the generic text_poke() interface and thereby get rid of this
oddity.

The first 6 or so patches are more or less the same as in v3, except it has the
bugs fixed that Steve found:

 - boot time function tracing works
 - module loading with function tracing works

Then there's 10 new patches, that go all over the place, mostly inspired by
staring at code touched by the first 6. That is, there's further ftrace and
kprobes cleanups, as well fixes for various issues.

In the end, it will have removed the horrible set_all_modules_text_*()
interface and reduced the ftrace module loading to a single callback (again).

The ARM patch is compiled only, I would be much obliged if someone could test
that.

