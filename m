Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18B5C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0EE1217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jrLd3Y5w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfDWUDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 16:03:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54228 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfDWUDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 16:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hb01MqLnuP98D2RoWKX+a93Pok53youKonh3HoYDsEs=; b=jrLd3Y5wt7POd90HFccujSy1P
        g2LW4Kx6vLBasdOIk39IhEtAR+vKMpWNvC/qUjJtLAD2KK1XTEd/hWgJtWFVF0qvJPyk9BcHHD8Ud
        6X21Ka944HdvU5Z1alWK1f3xohAYIt3vD6xuw1acxolv8NntxZxRC1j6/9GAMG8Pk/Y5vxUJ1XCd5
        EMK1FvffGi4DO9apPX8xgcvbXQTNwEyh6IKCVQ9EkfndrxDQLXrJNSKLrh6Nhk6/kL+TCyehz3CNu
        +K9ygjXRT0utcnfqYMbup8BYm7iGcuA8vekmpvozmJZwhPvftpRCeYZgnYoB8J8DKP0fdMIo80XlK
        bd8qAjcuQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJ1dQ-000135-2v; Tue, 23 Apr 2019 20:03:20 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D1A1329C30E18; Tue, 23 Apr 2019 22:03:18 +0200 (CEST)
Date:   Tue, 23 Apr 2019 22:03:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] trace: Fix preempt_enable_no_resched() abuse
Message-ID: <20190423200318.GY14281@hirez.programming.kicks-ass.net>
References: <20190419130304.GV14281@hirez.programming.kicks-ass.net>
 <20190419131522.GW14281@hirez.programming.kicks-ass.net>
 <57620139-92a3-4a21-56bd-5d6fff23214f@redhat.com>
 <7b1bfc26-6e90-bd65-ab46-08413acd80e9@redhat.com>
 <20190423141714.GO11158@hirez.programming.kicks-ass.net>
 <CAHk-=whnQJ9YDrkcKteNSACMJxzw1bL0RPfGQsey_9Nm7b8mnw@mail.gmail.com>
 <4f62d7f2-e5f6-500e-3e70-b1d1978f7140@redhat.com>
 <20190423193435.GX4038@hirez.programming.kicks-ass.net>
 <88ba7be0-9ec5-941e-1b3f-80fbe05fe3a0@redhat.com>
 <20190423195559.GY4038@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423195559.GY4038@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 09:55:59PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 23, 2019 at 03:41:32PM -0400, Waiman Long wrote:

> > I saw a number of instances of
> > preempt_enable_no_resched() without right next a schedule().
> 
> Look more closely.. and let me know, if true, those are bugs that need
> fixing.
> 
> Argghhh.. BPF...

/me shakes head, Steve...

---
Subject: trace: Fix preempt_enable_no_resched() abuse

Unless the very next line is schedule(), or implies it, one must not use
preempt_enable_no_resched(). It can cause a preemption to go missing and
thereby cause arbitrary delays, breaking the PREEMPT=y invariant.

Cc: Steven Rostedt <rostedt@goodmis.org>
Fixes: 37886f6a9f62 ("ring-buffer: add api to allow a tracer to change clock source")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/trace/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 41b6f96e5366..4ee8d8aa3d0f 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -762,7 +762,7 @@ u64 ring_buffer_time_stamp(struct ring_buffer *buffer, int cpu)
 
 	preempt_disable_notrace();
 	time = rb_time_stamp(buffer);
-	preempt_enable_no_resched_notrace();
+	preempt_enable_notrace();
 
 	return time;
 }
