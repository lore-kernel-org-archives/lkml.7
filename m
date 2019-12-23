Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877B5C2D0D4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 08:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE8420715
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 08:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="W7i1Ah1D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfLWIqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 03:46:40 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43633 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfLWIqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 03:46:39 -0500
Received: by mail-pg1-f194.google.com with SMTP id k197so8457254pga.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 00:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mUTtbbQMP+MkijNUcJm66aR4PVCMb8ex0jR1j8T76sE=;
        b=W7i1Ah1DaVi0VrtUHgCix96WCPg3lt2WH+YFmFrQreaTFHa9No9pj0FhPJ4t9PP0b/
         SXGw+6mIPCYGt6xS94jT3+Q0KGUvXrkNmBoRNUeB3jsU4GGBaie28VzrQC+TL+syeBHJ
         fqRxBvK2JSjO4k9Gapb6NuUP0cuXFzhk7ZDkXYTYAIpynTU3nby7K+8L+mdvDcBPkZz7
         IwmM7X1c5JmVbCmIyNiaBz95aPnStKFUOEJcxN5rq8bz7BCT07P5yyDPNoxhNnS62Ayq
         nqPCY5dFUxNh1ThK1lG5OIBkVchE/HnOE//b3iSkhSht5tk9VL00+SMqDzZQFHq+xsk2
         VzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mUTtbbQMP+MkijNUcJm66aR4PVCMb8ex0jR1j8T76sE=;
        b=p2D7Ds+Vq5wK/4yYauTUcDhRtdY6dVp4ZQ7Tzav2QcmmL6bO9TRH/TTWFojWzMT2mR
         b3ghgg1b7FA9auq1KZNz5kMQYhQsdEwTAB0L0Z45rBTfxmsSovrOlPBfalDVwYVYLVKF
         +aJD0l2YVSFYokGLkuKV8RAM3oU0/NqhIecnr4wRNA3wY1v2gnolbvBkSODtCeS4Lfjo
         +ibU6+PwgtH4ykl55jLYib6oqPQgRgCBXRmlxa3KoyolWiGzpK2tX0/PbAap2FlVBBOI
         563E684s414OYLB6Cy6yiEpTe25G9ZBZ2SrbF6ZDMg4B83eZfIi3ZzqEo0OcTnV3OxA2
         x9sg==
X-Gm-Message-State: APjAAAUgh8On2Bl20a71MJsQjKCymBp38l7strOk4Y3RmCPbasL6hJwm
        8X+anMlai/nvB0Z0wt12rWrzNr2h54w=
X-Google-Smtp-Source: APXvYqx/ccXA1Bz+Pky/9s1hsSq6vCZkh+m2udFmyyAmxtTB5VNmldRlF64rJrpTo/09/dMep38XCA==
X-Received: by 2002:aa7:9111:: with SMTP id 17mr5179582pfh.163.1577090798825;
        Mon, 23 Dec 2019 00:46:38 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id m71sm22000516pje.0.2019.12.23.00.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 00:46:38 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, rostedt@goodmis.org,
        anup@brainfault.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 1/2] riscv: ftrace: correct the condition logic in function graph tracer
Date:   Mon, 23 Dec 2019 16:46:13 +0800
Message-Id: <20191223084614.67126-2-zong.li@sifive.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191223084614.67126-1-zong.li@sifive.com>
References: <20191223084614.67126-1-zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The condition should be logical NOT to assign the hook address to parent
address. Because the return value 0 of function_graph_enter upon
success.

Fixes: e949b6db51dc (riscv/function_graph: Simplify with function_graph_enter())

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/kernel/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index b94d8db5ddcc..c40fdcdeb950 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -142,7 +142,7 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 	 */
 	old = *parent;
 
-	if (function_graph_enter(old, self_addr, frame_pointer, parent))
+	if (!function_graph_enter(old, self_addr, frame_pointer, parent))
 		*parent = return_hooker;
 }
 
-- 
2.24.1

