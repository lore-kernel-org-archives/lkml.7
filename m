Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C176C33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C76720721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cmsHhG+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732959AbgAIQFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:05:13 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54168 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732941AbgAIQFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:05:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578585910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GLC9hNezWUeQVArYqnoEaqxCV4y5v31FOWiE9b3pIzA=;
        b=cmsHhG+xEFbjMqM56f4aF5G7Cjven9voXEdojdaPDycvuGrmM1+d+EZIJ2W6P93aittjhY
        lfk9ffQnlnMj9QhS7WF4Btk7ti6BKovwOEKo5RQZLHRddbz+reHAQ/gVdbbNk6rYZCSdkC
        0iiw4ZweFRdacXIvu41VZS4HRFc/STE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-3XiMh6ucOeGjyc6HjgiUBg-1; Thu, 09 Jan 2020 11:05:09 -0500
X-MC-Unique: 3XiMh6ucOeGjyc6HjgiUBg-1
Received: by mail-wr1-f72.google.com with SMTP id v17so3036532wrm.17
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:05:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GLC9hNezWUeQVArYqnoEaqxCV4y5v31FOWiE9b3pIzA=;
        b=RLkl+x6ObOGZhNcqljuIbCa4rPoMpBQ+ZF/62FjGwtfAErsMmX7kwllW5NHGK+E5Yw
         eA2kMr+hDhh0VFRCeG7PC0vd0AnV9uXrSUB6DFeCepK+v3bLeRDweAbOXc/qLGKdgYBE
         U8RR3mo2tn/AxyTGl3G0sJhaKd2sLD+gkt+qSHcLbNwpUCHNUMV4E+0uOdkIXtao5Fz0
         ZzkVTrrriHrr3oacQKtuCc4MYLs71KskyBiuNslS0IoGxjHlsmGokEHWyGBBLO7+iIRk
         wNxQCNwcwhgG3d+uJ4TPxXQzr1qGuo4lvTUg+RAHmSzsX7lFG+MJ6+QHKgfUkld4Wgvt
         ua4Q==
X-Gm-Message-State: APjAAAWddgdmk9w5LUKR4BpMuXSYKGXskdbOPl5XvdR0mpeAxbc7+HOg
        n7AlhvpuGae/hbDjNh/VbltrSOVBu9Yd0BmU5inH29ymeH5tz4rO2aD0PZl7LX+8nvE80aRSfHa
        9CIFF/wW0APera+Gi0zHFfsO0
X-Received: by 2002:a5d:6652:: with SMTP id f18mr12130811wrw.246.1578585907739;
        Thu, 09 Jan 2020 08:05:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqxcuGHLY97/ieBCy+A431B2pbzBsFD5NdBbjJV9wyCtGKMcOfTDY33FxJb8HaIZjLm8Wp/zNA==
X-Received: by 2002:a5d:6652:: with SMTP id f18mr12130779wrw.246.1578585907516;
        Thu, 09 Jan 2020 08:05:07 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id d16sm9285303wrg.27.2020.01.09.08.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:05:06 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 17/57] objtool: Make stack validation more generic
Date:   Thu,  9 Jan 2020 16:02:20 +0000
Message-Id: <20200109160300.26150-18-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On x86, when calling a function, the new call frame is alway placed at
the start of the stack space this function can freely use. So the frame
pointer is always saved at <function stack start> - 16.

This is not true for the calling convention of all architecture.

When validating the call frame before a call instruction, all that can
be done is check that a frame was created by the current function and
that the frame pointer is correctly pointing to it.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0a5c51e4e24c..04434cdbdab6 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1176,7 +1176,7 @@ static bool has_modified_stack_frame(struct insn_state *state)
 static bool has_valid_stack_frame(struct insn_state *state)
 {
 	if (state->cfa.base == CFI_BP && state->regs[CFI_BP].base == CFI_CFA &&
-	    state->regs[CFI_BP].offset == -16)
+	    state->regs[CFI_BP].offset == -state->cfa.offset)
 		return true;
 
 	if (state->drap && state->regs[CFI_BP].base == CFI_BP)
-- 
2.21.0

