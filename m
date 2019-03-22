Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D6FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0512721939
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257007;
	bh=kFgImT/uRNeTgqaQiPqPI8/kOiGLu/6EWoCcJokvKWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y1r8b052Fw9Zm/xuDikLGXitOvmUINQbNHLaTwXVDvyxTtXSJWzNjdBNNnRG4AykF
	 aiEKlvZhBnQGPR1mpNaO0TGadTvXJeRYh+MYN14nV3pJRsEXlNtqoKh+Y/gDvUfFJH
	 ZrCCUZQtg2XMIQ3TAORBzV8R2456NPe0N9zwgV/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390037AbfCVMQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:16:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390027AbfCVMQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:16:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 646BE2082C;
        Fri, 22 Mar 2019 12:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257002;
        bh=kFgImT/uRNeTgqaQiPqPI8/kOiGLu/6EWoCcJokvKWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UWpr5zMtyx4lkmxnDpYArNPsBfbCneMtLMdNZn08emn3EqEYp5wqW0EJdfV/2Msrp
         6iLt6HbCiC9BZOPsS1gJ1/S2ef/LrbIcj/6jTml1e2EoiPZafLR7O5Kv/aMsQbCBkk
         Bqr5IidFhQt4vkE/HEws7gZFe3VaVdwd3xnpdB1k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrea Righi <righi.andrea@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 5.0 103/238] x86/kprobes: Prohibit probing on optprobe template code
Date:   Fri, 22 Mar 2019 12:15:22 +0100
Message-Id: <20190322111304.618039750@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>

commit 0192e6535ebe9af68614198ced4fd6d37b778ebf upstream.

Prohibit probing on optprobe template code, since it is not
a code but a template instruction sequence. If we modify
this template, copied template must be broken.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andrea Righi <righi.andrea@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Fixes: 9326638cbee2 ("kprobes, x86: Use NOKPROBE_SYMBOL() instead of __kprobes annotation")
Link: http://lkml.kernel.org/r/154998787911.31052.15274376330136234452.stgit@devbox
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/kprobes/opt.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -141,6 +141,11 @@ asm (
 
 void optprobe_template_func(void);
 STACK_FRAME_NON_STANDARD(optprobe_template_func);
+NOKPROBE_SYMBOL(optprobe_template_func);
+NOKPROBE_SYMBOL(optprobe_template_entry);
+NOKPROBE_SYMBOL(optprobe_template_val);
+NOKPROBE_SYMBOL(optprobe_template_call);
+NOKPROBE_SYMBOL(optprobe_template_end);
 
 #define TMPL_MOVE_IDX \
 	((long)optprobe_template_val - (long)optprobe_template_entry)


