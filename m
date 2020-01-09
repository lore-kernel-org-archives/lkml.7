Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1029C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED742072E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TphrO7H+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732949AbgAIQFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:05:11 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56072 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730524AbgAIQFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:05:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578585908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RN81Hr2F3scNb0RyFSSlR24ibWGqr/jAb3l0nXd6mwk=;
        b=TphrO7H+sUCgO6oBvBRLVc3ltFe6rbfz6aFgZoLVNVkFIO37g1QE4ERWYxBCePiuteJ5yK
        W5viicofmsnFz9r1t45WlRLiFgIb8m7JM/81S3bE0eLvoZ7ycSudpjp34smIwRaGWGfydu
        JA0MOI7qTh8/AlHTaKuupp455tkvBzQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-5snLfkrINPuXtfi29s7z_A-1; Thu, 09 Jan 2020 11:05:07 -0500
X-MC-Unique: 5snLfkrINPuXtfi29s7z_A-1
Received: by mail-wr1-f69.google.com with SMTP id k18so3061697wrw.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:05:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RN81Hr2F3scNb0RyFSSlR24ibWGqr/jAb3l0nXd6mwk=;
        b=XvW0Fmw5YePhexLq4vxEttqdlUIcB3iqD43hR2YSEFKsdDjz84JIws8qgCxqcG1BqY
         XPtN5wVtk++N/dPmpp6bX7f2wb+ASSbtWs4hzmjNjQy/SvLpFapeQs6eq8NsdWDkojRD
         yzDepI3ZTck4Unt18gIG6K869qmKq8Ti7iSrLa/6PBjQAgldMDmPy9hwc2yNZv9+rDm1
         Pd1b7g4EnqoIWJSk2O59WTLT+vqU6rj9Hs8+EEn2idis18PtQpsnTgrrTDx9EtHx/wOF
         4ouI+J2QOHwO87PvyXqb/+Ehmw8AlcCLqaV62rZ+Ta9PzvC8kxEDJpQoJMmAwyuRU0sE
         ya6Q==
X-Gm-Message-State: APjAAAXLN4K7TAMcVPxbS5MCCCBwZ0fdN0Ho5BsKqMkIcQ26VJXCc/lQ
        m7sglzyxJatky6xknUqO3EnT1cGEQPi2WajF3bVQ31JeZCYmbe5FcYa3GuJleBQmn5PDGbGwpRv
        TrJITZBxivzGnDBofY7YaNbcy
X-Received: by 2002:a5d:608e:: with SMTP id w14mr12212474wrt.256.1578585906281;
        Thu, 09 Jan 2020 08:05:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqzelCxqz+HY+vptIAIaeoW/L/+6jX9Gnq+tDYYFZlPnGBvNBZJ14bHw1aP3g+H7x8mUB7kekA==
X-Received: by 2002:a5d:608e:: with SMTP id w14mr12212440wrt.256.1578585905967;
        Thu, 09 Jan 2020 08:05:05 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id d16sm9285303wrg.27.2020.01.09.08.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:05:05 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 16/57] objtool: Support restoring BP from the stack without POP
Date:   Thu,  9 Jan 2020 16:02:19 +0000
Message-Id: <20200109160300.26150-17-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support instruction that set BP to its previous value (base on the
current CFA state) from the stack without modifying the stack pointer.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/check.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 5b2539eaccba..0a5c51e4e24c 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1507,6 +1507,12 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state)
 				cfa->base = state->drap_reg;
 				cfa->offset = 0;
 				state->drap_offset = -1;
+			} else if (!state->drap && op->src.reg == CFI_SP &&
+				op->dest.reg == cfa->base) {
+
+				/* mov disp(%rsp), %rbp */
+				cfa->base = CFI_SP;
+				cfa->offset += op->src.offset;
 			}
 
 			if (state->drap && op->src.reg == CFI_BP &&
-- 
2.21.0

