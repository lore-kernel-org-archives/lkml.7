Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B717C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BAD320848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="W38weueg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730275AbfCYU3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:29:33 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:42032 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbfCYU3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 16:29:33 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id A70B075B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 20:29:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OmsqbbVAbtDA for <linux-kernel@vger.kernel.org>;
        Mon, 25 Mar 2019 15:29:31 -0500 (CDT)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 720E880E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 15:29:31 -0500 (CDT)
Received: by mail-it1-f198.google.com with SMTP id 9so9912144ita.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 13:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cYmBfUfAdcfQUMQk0UUWGDHr6j/vbPBvbhdd4LSLqZQ=;
        b=W38weuegHoFK7XNJ3IqsYKjWD4x+m4MrZAw0jcu2UqWGPlxtWneJK/lG96AO7/p6su
         +Gl89dffkOsiUd5zfVe1A/sxW7ci9ZMCcWxy2NutiXKyhTPYtxUls0FETlnA70cUIQdM
         rZ1xsS4Q1bE9phdDV9FO1X6zu9sQqwRLQzIIOwldknyPKLTqtkcFUMxM3cGiU8Wb013w
         7RQPA9sTinmIpwZ+LJaQ2QA4GObqHGD5dknheJAizXMCygS/lg8s5aTOCMOEgzNsS04D
         ahHPJQmH1nFA94/9HggwbrXT+MLU/M2zDJxveqBfU24StrDPgoJUp/mqBihdCoJc2Y/x
         1NBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cYmBfUfAdcfQUMQk0UUWGDHr6j/vbPBvbhdd4LSLqZQ=;
        b=pXcULGVsKezlHqcqqykZCu5u6K6zX2uqaSbzDAfE6XJE922lSUx6P5UwEy+D+1H1Wk
         QCuCPyMShk9t8qFXxXAN+xAGMrRxpLPv7mIUdT9pFUTkiSgqUDOvXTYt8PiLwAi2F4j4
         Zd6z/3aNEb4MyW6f3ggRCAWaVVNk1fbv0JZoxmlHBZkUT6uSMYMsOE2q3KPhJ+5Oyabd
         sa5LW0xLFqh63ojqOiBE4WDBuC9qksFTLVJrbRuzJ8kemle15tD4lCTAwDXSBWIVI8cm
         aczGT7qCbZFRErK44bnU3/DjbDkAgY9usDLh7xXhX6wiNyJIXD9L4MYT9Q22VVcagppR
         sDUQ==
X-Gm-Message-State: APjAAAXBkgfq5p2B+B0WuCS3+DcAR1CMtfRsJcYKd3o0FSvP1IyIRcyu
        aeFWERrwLmZm5gWlkQ6Cre9Edw2ersw7we/+iabLJ291gkvnVLa0ANFbhCgi81+2ZQGD7r3r6+v
        LMgUPoTD+VCxdzMxqNt+wbMdkTeSv
X-Received: by 2002:a5e:8f03:: with SMTP id c3mr18105598iok.21.1553545770900;
        Mon, 25 Mar 2019 13:29:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxAsSNCzR+kShiTxwq3nOLld0eYMJO8orfDU9EQIdDb+XLLSE+tWn+JPaH8aNGyjkvzTNjkfg==
X-Received: by 2002:a5e:8f03:: with SMTP id c3mr18105588iok.21.1553545770685;
        Mon, 25 Mar 2019 13:29:30 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id k4sm9620251itc.32.2019.03.25.13.29.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 13:29:29 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Kees Cook <keescook@chromium.org>,
        Andrew Banman <abanman@hpe.com>,
        Varsha Rao <rvarsha016@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Nicolai Stange <nstange@suse.de>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] platform: uv: fix missing checks for kcalloc
Date:   Mon, 25 Mar 2019 15:29:22 -0500
Message-Id: <20190325202924.4624-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190325125528.GM12016@zn.tnic>
References: <20190325125528.GM12016@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case kcalloc fails, the patch return an error to avoid
potential NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>

---
v2: reuse existing error path as suggested by
Borislav Petkov <bp@alien8.de>
---
 arch/x86/platform/uv/tlb_uv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/platform/uv/tlb_uv.c b/arch/x86/platform/uv/tlb_uv.c
index 2c53b0f19329..7b41b51b9a86 100644
--- a/arch/x86/platform/uv/tlb_uv.c
+++ b/arch/x86/platform/uv/tlb_uv.c
@@ -2133,14 +2133,18 @@ static int __init summarize_uvhub_sockets(int nuvhubs,
  */
 static int __init init_per_cpu(int nuvhubs, int base_part_pnode)
 {
-	unsigned char *uvhub_mask;
 	struct uvhub_desc *uvhub_descs;
+	unsigned char *uvhub_mask = NULL;
 
 	if (is_uv3_hub() || is_uv2_hub() || is_uv1_hub())
 		timeout_us = calculate_destination_timeout();
 
 	uvhub_descs = kcalloc(nuvhubs, sizeof(struct uvhub_desc), GFP_KERNEL);
+	if (!uvhub_descs)
+		goto fail;
 	uvhub_mask = kzalloc((nuvhubs+7)/8, GFP_KERNEL);
+	if (!uvhub_mask)
+		goto fail;
 
 	if (get_cpu_topology(base_part_pnode, uvhub_descs, uvhub_mask))
 		goto fail;
-- 
2.17.1

