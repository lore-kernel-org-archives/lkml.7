Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FFFC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86324206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V8cIsVTc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732752AbgAIQDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:03:17 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42990 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729757AbgAIQDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:03:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578585795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cv9OEnoxm5jqEof6Q4MR3S73IbKofEk1lKfADeLvzKM=;
        b=V8cIsVTc2A67aWHgyEgLw5BhgVMdBiEr9SYV5eMdCTozllbdxGVUE0K4YUIxIV6j0fIHMj
        5wx/MQGBDL+yrZ6nRJz/hom87s0Cd2WiRA8WqbzstN3jWJUZ/CWGx74gaKVm7qdWBDWGAa
        Z/bEID/5O6FazBL/BYdcdxmRUSROp8o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-AQEbG4UsNYaC_a6wriMluw-1; Thu, 09 Jan 2020 11:03:13 -0500
X-MC-Unique: AQEbG4UsNYaC_a6wriMluw-1
Received: by mail-wr1-f70.google.com with SMTP id v17so3033378wrm.17
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:03:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cv9OEnoxm5jqEof6Q4MR3S73IbKofEk1lKfADeLvzKM=;
        b=tZW1vBXN6JJkU/P7hSyOcnOjP0Y6iTqQlD8v0FFUPVYAL7i+iSfQdEULOhokdcD2T0
         GpAMIIlbBRjAYe/HVnJCkjqGaiSlMvIObZr1KxBw79PCWBdtF7cS4cCpevBnGs2nmD82
         V1whtoZAwhKKEKDjXszisMjB2A0kkbvVqxwN064lLjriuomFkMyAgU0B72P0coItSVfq
         YvhQ9LSDppXvg8HMe1SVGC7H5SKpalZzJR2/8fzA8mX8Dilq8R7CilukEIy1gbWeymcx
         cflkRHLXaJN2VWDm1Ht0qaKdItAYAHjfcYJl3W1whh6MffVwmljIi0hTm0sGxkr/jtc7
         SKsg==
X-Gm-Message-State: APjAAAXDHTEnjmoJgZtksR8Q5zEs08aJUOHSydp8xZ2bz7v7f91IV+c7
        e5QmiocRR0G2ABZqIZMRhUHXQJ85uLwi+FMvT+omJZZhU2fs2VeSpIQwtlOnzm27laPhQCj9dL5
        7wzND3sm/ct65RB2XuQnQVcnq
X-Received: by 2002:a5d:538e:: with SMTP id d14mr11942321wrv.358.1578585792182;
        Thu, 09 Jan 2020 08:03:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqywPwV2UvQwN4s2qv+/dJ9GOKMz9Upk2KnoXLCCN9ETrzeZJVoqAGjRgbLtFMAu3XU2NN4UVw==
X-Received: by 2002:a5d:538e:: with SMTP id d14mr11942292wrv.358.1578585791962;
        Thu, 09 Jan 2020 08:03:11 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id z21sm3258969wml.5.2020.01.09.08.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:03:11 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 01/57] objtool: check: Remove redundant checks on operand type
Date:   Thu,  9 Jan 2020 16:02:04 +0000
Message-Id: <20200109160300.26150-2-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

POP operations are already in code path where destination operand
is OP_DEST_REG. There is no need to check the operand type again.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/check.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4768d91c6d68..a04778421144 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1672,15 +1672,13 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state)

 		case OP_SRC_POP:
 		case OP_SRC_POPF:
-			if (!state->drap && op->dest.type == OP_DEST_REG &&
-			    op->dest.reg == cfa->base) {
+			if (!state->drap && op->dest.reg == cfa->base) {

 				/* pop %rbp */
 				cfa->base = CFI_SP;
 			}

 			if (state->drap && cfa->base == CFI_BP_INDIRECT &&
-			    op->dest.type == OP_DEST_REG &&
 			    op->dest.reg == state->drap_reg &&
 			    state->drap_offset == -state->stack_size) {

--
2.21.0

