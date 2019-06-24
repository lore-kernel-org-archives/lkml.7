Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A79C48BE8
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0035A208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MCAr/cud"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfFXJYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 05:24:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44180 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfFXJYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rFd8r1wQO1GEPiOhTD6rTHNxkslgTiRvrEXbg6A1zF8=; b=MCAr/cudrqs43V08kOT0hnmnBv
        Hax38nB3bVDoJUFgwkvQJIu84B5aeDWzwGT3lHdQNtn7ePUM/CzJCN7E/P3tPcVgtQb/CqRsovdHn
        rOuKzXDpIrr+WO75c8f89XqwQzHWZPtzDiYXDKkYdZ+KbF/r4pywiq+EI3kfSt2THzy+6ZrPxj//O
        aEssWWgV6SXDk8XmxxANeHk5oZFgKKuPqfHSPCPwIz0pAtTJKlkk7qHqj+45gwqP2EArP6s1TOIho
        4wp9RyjoItGFGfm7oXeeNhvhvyQcHJfQmsgy6xUONBtp6GDIEjwCfiAsfa97iJi3zLCVxImTfiSjh
        n5Ox5GRA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfLCm-0006mR-6O; Mon, 24 Jun 2019 09:24:04 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5CF5720A0EF31; Mon, 24 Jun 2019 11:24:02 +0200 (CEST)
Message-Id: <20190624092109.863781858@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 24 Jun 2019 11:18:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com, jikos@kernel.org, mbenes@suse.cz,
        pmladek@suse.com, ast@kernel.org, daniel@iogearbox.net,
        akpm@linux-foundation.org, peterz@infradead.org
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH 3/3] module: Properly propagate MODULE_STATE_COMING failure
References: <20190624091843.859714294@infradead.org>
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

Cc: Jessica Yu <jeyu@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Song Liu <songliubraving@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/module.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3643,9 +3643,10 @@ static int prepare_coming_module(struct
 	if (err)
 		return err;
 
-	blocking_notifier_call_chain(&module_notify_list,
-				     MODULE_STATE_COMING, mod);
-	return 0;
+	err = blocking_notifier_call_chain_error(&module_notify_list,
+			MODULE_STATE_COMING, MODULE_STATE_GOING, mod);
+
+	return notifier_to_errno(err);
 }
 
 static int unknown_module_param_cb(char *param, char *val, const char *modname,


