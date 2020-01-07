Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DADC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1DF214D8
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578431190;
	bh=cqmuP6+aWyyH4B13fvBC7PZfi6hpHU/Y2FNOvIebqFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CNCU8p+svPLfihPjHN6AxadxPiLA/KUZmQkv9U9iSIXat2reJcrBNtg9ViXX8GoT9
	 zsmCwQjd1u/UIq47rS1hQOKZ8qKeAa+59FaSZL3f73Rk+wBDyxGlxzYyDhWx8X+nSI
	 I/2dAc5fqoUVZzyFDoirBDmdC2hm3JWUNziJjEhU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgAGVG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:06:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:55330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728631AbgAGVGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:06:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36F052077B;
        Tue,  7 Jan 2020 21:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431182;
        bh=cqmuP6+aWyyH4B13fvBC7PZfi6hpHU/Y2FNOvIebqFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ji6oG3zQS2mN2Qh47fxo/T3AvCT+81QFvrl81ZzHKL1wRO6HnLak9JUx7HeHzWtKV
         xopzaU39DwKoWOa6baSqObf5nzCqP5juEO6VD5nnf7wrwd5DwB6C3JEfLGZXE7YUgq
         q1WqhP84ueNcgzC71Q2w+/nD6cV9PzMMM2W3oKmQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zong Li <zong.li@sifive.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH 4.19 067/115] riscv: ftrace: correct the condition logic in function graph tracer
Date:   Tue,  7 Jan 2020 21:54:37 +0100
Message-Id: <20200107205303.691218306@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205240.283674026@linuxfoundation.org>
References: <20200107205240.283674026@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zong Li <zong.li@sifive.com>

commit 1d8f65798240b6577d8c44d20c8ea8f1d429e495 upstream.

The condition should be logical NOT to assign the hook address to parent
address. Because the return value 0 of function_graph_enter upon
success.

Fixes: e949b6db51dc (riscv/function_graph: Simplify with function_graph_enter())
Signed-off-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: stable@vger.kernel.org
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/riscv/kernel/ftrace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -142,7 +142,7 @@ void prepare_ftrace_return(unsigned long
 	 */
 	old = *parent;
 
-	if (function_graph_enter(old, self_addr, frame_pointer, parent))
+	if (!function_graph_enter(old, self_addr, frame_pointer, parent))
 		*parent = return_hooker;
 }
 


