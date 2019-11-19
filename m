Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52781C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25B75208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141916;
	bh=ejzH4C0ZMnnrZTHEFtbFTF8j1yCHZmWtysIfU/gwCGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=caDvE+Jw4zEs5WaUMNlhIrUpa16VxkpKKv/NM7bpMQ+7a16hidVW2+GKNaPVp1tCk
	 vpEwzLhYuWp9euyf7tbHtkVtl5EXhrZQvwiw5gtAnEBJUdkE+Y1ID5ALRzAcxCbrLj
	 BJhX+yNYlZV4jreeBzErS9Kc2DNp+KqtwpYPFB2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbfKSFie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:38:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:60386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730197AbfKSFiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:38:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EB6D214DE;
        Tue, 19 Nov 2019 05:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141903;
        bh=ejzH4C0ZMnnrZTHEFtbFTF8j1yCHZmWtysIfU/gwCGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h8rOPD0EUy227idSLqFgP9DQpkUITzStc8yR5qs3/ZcA78uqLcNhgQLo/obCHOvff
         ej7P17ucKDbWfdrFIQ+xYM0WoBtMohPmxJjaeE8itcBFtTI4Z2G4qnuibhfBbafH7G
         qkUDflOT3gfaNjGqY8BXyZ0lonXtDm5sZHtEjVyw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
        Matthew Whitehead <tedheadster@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 321/422] x86/CPU: Change query logic so CPUID is enabled before testing
Date:   Tue, 19 Nov 2019 06:18:38 +0100
Message-Id: <20191119051419.796318097@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Whitehead <tedheadster@gmail.com>

[ Upstream commit 2893cc8ff892fa74972d8dc0e1d0dc65116daaa3 ]

Presently we check first if CPUID is enabled. If it is not already
enabled, then we next call identify_cpu_without_cpuid() and clear
X86_FEATURE_CPUID.

Unfortunately, identify_cpu_without_cpuid() is the function where CPUID
becomes _enabled_ on Cyrix 6x86/6x86L CPUs.

Reverse the calling sequence so that CPUID is first enabled, and then
check a second time to see if the feature has now been activated.

[ bp: Massage commit message and remove trailing whitespace. ]

Suggested-by: Andy Lutomirski <luto@amacapital.net>
Signed-off-by: Matthew Whitehead <tedheadster@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Andy Lutomirski <luto@amacapital.net>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180921212041.13096-3-tedheadster@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 1e07814f02bc6..a6458ab499c21 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1133,6 +1133,9 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 	memset(&c->x86_capability, 0, sizeof c->x86_capability);
 	c->extended_cpuid_level = 0;
 
+	if (!have_cpuid_p())
+		identify_cpu_without_cpuid(c);
+
 	/* cyrix could have cpuid enabled via c_identify()*/
 	if (have_cpuid_p()) {
 		cpu_detect(c);
@@ -1150,7 +1153,6 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 		if (this_cpu->c_bsp_init)
 			this_cpu->c_bsp_init(c);
 	} else {
-		identify_cpu_without_cpuid(c);
 		setup_clear_cpu_cap(X86_FEATURE_CPUID);
 	}
 
-- 
2.20.1



