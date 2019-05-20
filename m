Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE32C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3261217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JrVW7C+L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfETXUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 19:20:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38067 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbfETXUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 19:20:12 -0400
Received: by mail-pg1-f193.google.com with SMTP id j26so7517564pgl.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 16:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W7734R4i6yiyrpZ2h/0MZYkaSGjqvy874mw6G7v61To=;
        b=JrVW7C+LuAQDFNUSIHyGFsz0qBRTL2ZXfCcQco+/ovqwakUWfE/dZjhQKvz317S01W
         wQCGYHVGlpLmUrYgoTdSKOC2hUfqswQYjSLwQhd86heBQlNgOK5fzGaizR8ag3rfBwUw
         lcSrm1YKnCFi+86LywiA0MP5pGK/4PWx3RWMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W7734R4i6yiyrpZ2h/0MZYkaSGjqvy874mw6G7v61To=;
        b=DwKNl7Mh0DRv7Sgxx1n7r9TmC+sbEobC8y5lT+CRqcbAbb99mXbSF9D8sO9d7IfAQO
         oYptLGfVgPo6gCWnZ9waMd2MBJ8atx4X0E3ggHX4NRAfV9bQKEslwRmN2ONUBG7decyq
         6TmX0/R7q2WpQlkod71vPvH6RPWN5tVm4FOM0l5OOekjYbO/7sciw5KCTuJc7w4bBOt6
         yCZkE9atKPUJH0tiED6SGfLoxnlzlK/XOZBqPjG443Phh9t3U6K9vv591qgKUlW5xwSB
         FGrT2kRkgE3RX3195RcppRPXblALnCEFbRLzAKi5+2LfO+zmfq/iLnbqZJSU/qag8xIC
         lNqw==
X-Gm-Message-State: APjAAAX9jvBOZ/fkadKNvdbavE5qZPAM4gHbe9o9ZcI5tdFK8KKpeNfp
        rGvqhCLsGnF3XUFt2UME1jhiHA==
X-Google-Smtp-Source: APXvYqx11/wdMqn8zECWhWwJqm22F59FOLIqoVe2U28n9IpVe7w901Gx6+y2O7doblMLNbHs30IaWA==
X-Received: by 2002:aa7:87d7:: with SMTP id i23mr82812885pfo.211.1558394412346;
        Mon, 20 May 2019 16:20:12 -0700 (PDT)
Received: from skynet.sea.corp.google.com ([2620:0:1008:1100:c4b5:ec23:d87b:d6d3])
        by smtp.gmail.com with ESMTPSA id h13sm19350861pgk.55.2019.05.20.16.20.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 16:20:11 -0700 (PDT)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 06/12] x86: pm-trace - Adapt assembly for PIE support
Date:   Mon, 20 May 2019 16:19:31 -0700
Message-Id: <20190520231948.49693-7-thgarnie@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190520231948.49693-1-thgarnie@chromium.org>
References: <20190520231948.49693-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Garnier <thgarnie@google.com>

Change assembly to use the new _ASM_MOVABS macro instead of _ASM_MOV for
the assembly to be PIE compatible.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range below 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 arch/x86/include/asm/pm-trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pm-trace.h b/arch/x86/include/asm/pm-trace.h
index bfa32aa428e5..972070806ce9 100644
--- a/arch/x86/include/asm/pm-trace.h
+++ b/arch/x86/include/asm/pm-trace.h
@@ -8,7 +8,7 @@
 do {								\
 	if (pm_trace_enabled) {					\
 		const void *tracedata;				\
-		asm volatile(_ASM_MOV " $1f,%0\n"		\
+		asm volatile(_ASM_MOVABS " $1f,%0\n"		\
 			     ".section .tracedata,\"a\"\n"	\
 			     "1:\t.word %c1\n\t"		\
 			     _ASM_PTR " %c2\n"			\
-- 
2.21.0.1020.gf2820cf01a-goog

