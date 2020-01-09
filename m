Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2842C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7107920721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jEENcwE3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732938AbgAIQFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:05:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43288 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730524AbgAIQFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:05:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578585907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KfRYv85TKcvAOdoeytsotoDBeN5NjVxxna+B8zLHPVA=;
        b=jEENcwE3Tw/kdPDSWCtx4uPLZMpWA4S+vyPp0owcDjUuTrzVONbf7hSQRqE0Rlmru4lcon
        ZzVrf5ccKMSRbUcRWnioeZ7pSekDg0wcE8y/SK82Fssl/yzGYM1c/WlZLqAfRoZu+3bfCp
        x6nBq5islsbQ1LB5TLnQARicDXtryo0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-cGlyDw-pMA2OmdcyTsD1Cw-1; Thu, 09 Jan 2020 11:05:06 -0500
X-MC-Unique: cGlyDw-pMA2OmdcyTsD1Cw-1
Received: by mail-wm1-f70.google.com with SMTP id w205so1095451wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:05:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KfRYv85TKcvAOdoeytsotoDBeN5NjVxxna+B8zLHPVA=;
        b=fAZyzGqJn8Q08g1Z11zNyK5TVVUwQ9uq+OsFKjtKf1jLZtT7rMdNlWQybzB+IBR7rf
         eIalRx0AGucb5VRKFD5fXQfBcn5BdG9grkpP3/HEqXmu81+pyjWMCAwVIc4GdnmdM6cA
         2nA1vjkGQP+f6+kT34RUD/xbSFToe/G+OP7h8MwF56xCM8bw8MtNcXNkSrGNP4YiZo0+
         TPY5hLLrND9DZNnna/Kf7LE9fr94E6alJjqB8gXb5OqxId+dcVywoSooV4s5zxGEn2/a
         WYtVUJYPHxRXMmz0Dne+/MRKaXZXcI5DJ8Q70qTXj4kMWGWkke+GmQ6htELQpU9Fizym
         3Y+g==
X-Gm-Message-State: APjAAAU8yI3NpHGSOr1EDyOM5z1qlJCdOmyUI2yjKmvv66giKrOTbedX
        OdENvrO6+YMKD8B8I98UNLHxAjjjOX4dGOq+ilfzRBsvtqABp5SydWzXUhH8JNUoDUDmWBQcKYX
        EgcZ58lKwoiF4LiYIvjI2uH3A
X-Received: by 2002:adf:f2c1:: with SMTP id d1mr11478794wrp.111.1578585904835;
        Thu, 09 Jan 2020 08:05:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqyPEXxUZBqvxm0pvveTyPQvZPZhyqo90SAmgLADCLxa+3+kAarj0a6aRfYAABQykiNl2ucrZw==
X-Received: by 2002:adf:f2c1:: with SMTP id d1mr11478765wrp.111.1578585904635;
        Thu, 09 Jan 2020 08:05:04 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id d16sm9285303wrg.27.2020.01.09.08.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:05:03 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 15/57] objtool: Support addition to set frame pointer
Date:   Thu,  9 Jan 2020 16:02:18 +0000
Message-Id: <20200109160300.26150-16-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support updating the frame pointer by adding an immediate value to the
stack pointer in the CFA tracking code.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/check.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 19e96c4ad0a3..5b2539eaccba 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1394,6 +1394,18 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state)
 				break;
 			}
 
+			if (op->src.reg == CFI_SP && cfa->base == CFI_SP &&
+			    op->dest.reg == CFI_BP &&
+			    regs[CFI_BP].base == CFI_CFA &&
+			    regs[CFI_BP].offset == -cfa->offset + op->src.offset) {
+
+				/* lea disp(%rsp), %rbp */
+				cfa->base = CFI_BP;
+				cfa->offset -= op->src.offset;
+				state->bp_scratch = false;
+				break;
+			}
+
 			if (op->src.reg == CFI_SP && cfa->base == CFI_SP) {
 
 				/* drap: lea disp(%rsp), %drap */
-- 
2.21.0

