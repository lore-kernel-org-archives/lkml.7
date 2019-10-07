Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0629C352AA
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E4A21655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ulXHz4f7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbfJGLY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:24:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58426 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbfJGLXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8w7+6tXm8Cbatt6iSi3EWSSGQa+15O9GwCHiBC4CD7A=; b=ulXHz4f7WW7364dUiGQvC56pD2
        xZwJbVwNySo6seuSQIekOQghheceObV9JDTPq1182FMRb2PRDWNcbIdn9E8ZeVcOqHO4Y/SJS24ua
        /olfNzDmFuo3umDMBKpL0IQhqDv6XtwQ/Arato6A+7MuWVUx6GTvViRFTYrwTdrInQN0cYKP/Rlwm
        TuQan99S8ClcmPAsmvZoASQdy3t4NwIGhbrul9bwGXgJbYThMZwwOncVK9e2VtnpKgcRjnUry+nvo
        3RviFwO/MSzxqYluYqcos9vsYTso3mrxjKH+61VHZoMXxw2garKrGvAtIz4umPu4WLztDSAIqFYuR
        N334e3xA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHR6w-0002BD-R8; Mon, 07 Oct 2019 11:23:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 027AB30703D;
        Mon,  7 Oct 2019 13:22:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8DB7220244E22; Mon,  7 Oct 2019 13:23:26 +0200 (CEST)
Message-Id: <20191007082700.14428791.6@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 07 Oct 2019 10:25:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Jessica Yu <jeyu@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH v2 3/4] module: Properly propagate MODULE_STATE_COMING failure
References: <20191007082541.64146933.7@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that notifiers got unbroken; use the proper interface to handle
notifier errors and propagate them.

There were already MODULE_STATE_COMING notifiers that failed; notably:

 - jump_label_module_notifier()
 - tracepoint_module_notify()
 - bpf_event_notify()

By propagating this error, we fix those users.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Yonghong Song <yhs@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Song Liu <songliubraving@fb.com>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
---
 kernel/module.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3751,9 +3751,13 @@ static int prepare_coming_module(struct
 	if (err)
 		return err;
 
-	blocking_notifier_call_chain(&module_notify_list,
-				     MODULE_STATE_COMING, mod);
-	return 0;
+	err = blocking_notifier_call_chain_robust(&module_notify_list,
+			MODULE_STATE_COMING, MODULE_STATE_GOING, mod);
+	err = notifier_to_errno(err);
+	if (err)
+		klp_module_going(mod);
+
+	return err;
 }
 
 static int unknown_module_param_cb(char *param, char *val, const char *modname,


