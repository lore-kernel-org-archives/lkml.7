Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84236C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5384D20721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gEeJgQzt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731268AbgAIQDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:03:17 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44758 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729854AbgAIQDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:03:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578585795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2TbvKMt2I2jso1SowXcHnsxCi6YkVVHUp/mczZ9qxkU=;
        b=gEeJgQztMVt6+2jt5IBGI+zPzSyZxuwUAjOAt/5Vh/LB7q6LOg+At6sHXwGNLU870l7Msh
        w2vrY1eUxMOckfUM8ofDqCq7F26D1E8O/SvRgT7UQnLEnL9Gtm+CKKxImmNBQTcfYVFFrH
        8Oxe9GzUrPo4VA4gx7CObnJginrNUkk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-E-Nu1eyuNnOtLb6ar8ZmXg-1; Thu, 09 Jan 2020 11:03:14 -0500
X-MC-Unique: E-Nu1eyuNnOtLb6ar8ZmXg-1
Received: by mail-wr1-f71.google.com with SMTP id v17so3033403wrm.17
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:03:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2TbvKMt2I2jso1SowXcHnsxCi6YkVVHUp/mczZ9qxkU=;
        b=kMbI2PmhYQJtX/mgXYqLy3RvmI+bWBqvoIL5gmnbs6NbsvtdUVdjODyewESXmygily
         Mwq2mIw1apgssV86Fvno5Hof2YyM3ifjWOnUWCY6GDB8K+lhXekNuB5RBJe6/umTSBrB
         be8g1Q2eK3n9OiG3gC8TDOHXoG6VhNa93y47cmb+EKUfZmEJVb9QKZNRHXjlXz4vXqsx
         Q1glIdwAhSAsQcwHb0YfMxSmyNTLSrOQZLU1CJvDVKU0QcSTR3pGsBuXf0PBKpNZuDuT
         j61rt5e/Bk+JTpyy/IfPb772ZfWxh+UwosIhvwvtulKcDnWoTcldwdlYuu+k6ZmFCP94
         VYFw==
X-Gm-Message-State: APjAAAXB+EvqOC/ARU3W8kYT+/0FlEwcILJq5hBNs8GEzxbwNYKPEaTb
        JRUIImEB7vD/vhM2zuMGFkhUTTjz74NNAYMo7n/w4z1VV7HAjPoLLQJTEVyu/E/Vcs2Gj8HrCvY
        zz9UFVYpot5VUqYZXvjMpawQU
X-Received: by 2002:a7b:c3d2:: with SMTP id t18mr5903403wmj.90.1578585793360;
        Thu, 09 Jan 2020 08:03:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqx1i6RTYzKo5WMbgBgJvZ21maBSBOwlzW/NH2DdpXZf53ZMSa43jR/D3EBbhqlU18Cm4YAYbg==
X-Received: by 2002:a7b:c3d2:: with SMTP id t18mr5903384wmj.90.1578585793218;
        Thu, 09 Jan 2020 08:03:13 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id z21sm3258969wml.5.2020.01.09.08.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:03:12 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 02/57] objtool: check: Clean instruction state before each function validation
Date:   Thu,  9 Jan 2020 16:02:05 +0000
Message-Id: <20200109160300.26150-3-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a function fails its validation, it might leave a stale state
that will be used for the validation of other functions. That would
cause false warnings on potentially valid functions.

Reset the instruction state before the validation of each individual
function.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/check.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index a04778421144..4784f0f6a3ae 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2348,13 +2348,6 @@ static int validate_functions(struct objtool_file *file)
 	struct insn_state state;
 	int ret, warnings = 0;

-	clear_insn_state(&state);
-
-	state.cfa = initial_func_cfi.cfa;
-	memcpy(&state.regs, &initial_func_cfi.regs,
-	       CFI_NUM_REGS * sizeof(struct cfi_reg));
-	state.stack_size = initial_func_cfi.cfa.offset;
-
 	for_each_sec(file, sec) {
 		list_for_each_entry(func, &sec->symbol_list, list) {
 			if (func->type != STT_FUNC)
@@ -2373,6 +2366,12 @@ static int validate_functions(struct objtool_file *file)
 			if (!insn || insn->ignore || insn->visited)
 				continue;

+			clear_insn_state(&state);
+			state.cfa = initial_func_cfi.cfa;
+			memcpy(&state.regs, &initial_func_cfi.regs,
+			       CFI_NUM_REGS * sizeof(struct cfi_reg));
+			state.stack_size = initial_func_cfi.cfa.offset;
+
 			state.uaccess = func->uaccess_safe;

 			ret = validate_branch(file, func, insn, state);
--
2.21.0

