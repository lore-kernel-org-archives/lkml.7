Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792C5C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A8220578
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557922923;
	bh=vcfxo2TFke0cuyMwibf/eIW/V6zVHCpZXvsgz4Sm4gY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0dw+5W/yUvAxOZWvQqDNFjjdThGVUMEt+EZeB2aSDU5cekff0J83VZpQten1TsT+C
	 du+w2axkVtISGnfL81Emvp/qtDacF+ghbniorYOs+CRgqL4KM1XshDtOMO2t5vsRPf
	 xin6DBYEhMhbSm6CCUn0kO5OutqF/Oe3gOzmeZrA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfEOMWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:22:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:54390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbfEOK6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 06:58:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AA1820843;
        Wed, 15 May 2019 10:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557917892;
        bh=vcfxo2TFke0cuyMwibf/eIW/V6zVHCpZXvsgz4Sm4gY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QOv8CO5uJK6CCeX+9tWSF1GAF86d3+uFWdr86lgQfMUxzqGdRYg3GJQWLZOaMOmsz
         ejoSSfVclMAjAJsmf2zZlbkCOtS+hV9+VB8spNoC4Z9Qdq4R1lFDL2xggttzEXEXCt
         lZwnp1llvJzk/vlbTo4P7paBVrqG3DN35TkJpOEs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Waiman Long <longman@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 3.18 02/86] trace: Fix preempt_enable_no_resched() abuse
Date:   Wed, 15 May 2019 12:54:39 +0200
Message-Id: <20190515090642.933744261@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090642.339346723@linuxfoundation.org>
References: <20190515090642.339346723@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

commit d6097c9e4454adf1f8f2c9547c2fa6060d55d952 upstream.

Unless the very next line is schedule(), or implies it, one must not use
preempt_enable_no_resched(). It can cause a preemption to go missing and
thereby cause arbitrary delays, breaking the PREEMPT=y invariant.

Link: http://lkml.kernel.org/r/20190423200318.GY14281@hirez.programming.kicks-ass.net

Cc: Waiman Long <longman@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: the arch/x86 maintainers <x86@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: huang ying <huang.ying.caritas@gmail.com>
Cc: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: stable@vger.kernel.org
Fixes: 2c2d7329d8af ("tracing/ftrace: use preempt_enable_no_resched_notrace in ring_buffer_time_stamp()")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/ring_buffer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -730,7 +730,7 @@ u64 ring_buffer_time_stamp(struct ring_b
 
 	preempt_disable_notrace();
 	time = rb_time_stamp(buffer);
-	preempt_enable_no_resched_notrace();
+	preempt_enable_notrace();
 
 	return time;
 }


