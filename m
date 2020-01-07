Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AA8C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31B520678
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578430848;
	bh=cqmuP6+aWyyH4B13fvBC7PZfi6hpHU/Y2FNOvIebqFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=coSI0Du1Xll2e49E0T9paill0EwARCBFTWFMGFI0T9ekppIgJMeOv+f1B4ykFJxzl
	 QlTTjbS0FKm+JzdVY0qqBvpMg09V7EQuqfLEKrdIkfuYDV7OcsO5jOHlCLM2B3SK+z
	 Ass/b+SmHSYdLO+SNDhBAzsYJW0GkORmFJ6y5nHM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgAGVAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:00:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:35604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727967AbgAGVAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:00:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BCD821744;
        Tue,  7 Jan 2020 21:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578430831;
        bh=cqmuP6+aWyyH4B13fvBC7PZfi6hpHU/Y2FNOvIebqFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D9T+9GG/KR4F46fneVlG9yq5b9mFLtstjo9ncaC11hU7P3Woyji1qRFPY5p35XWYv
         4Zc+YkoOtJ2x5kZPlgKwyKenhTE+AN2tNwZJ2Qlt3KuUg6w3ouAD+QKXDAKgXYaAHK
         NoQlh7PaSuS7XwJT71rVWMAIrGzUg+uEbn0UQ8Rs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zong Li <zong.li@sifive.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH 5.4 113/191] riscv: ftrace: correct the condition logic in function graph tracer
Date:   Tue,  7 Jan 2020 21:53:53 +0100
Message-Id: <20200107205339.031063867@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205332.984228665@linuxfoundation.org>
References: <20200107205332.984228665@linuxfoundation.org>
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
 


