Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD2BC3A5A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50ABA21726
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ilfAjllz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388065AbfHVO0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 10:26:18 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33518 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728049AbfHVO0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:26:17 -0400
Received: by mail-qk1-f194.google.com with SMTP id w18so5312320qki.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 07:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=vY9SF672PGIhEmlTEHx4Wy7K1LbIBp/7v3lK34xnhWY=;
        b=ilfAjllzoCMPfzCFxMXCpdcOblXgLTdDXLrWl9WJ/3JT+x2xYgPYwPk986kYmX1zK1
         PCnoXH1v4W+fUe8u61pUCfOlKLKpLLdnG3OnIvL4BWA/OWewpLhrM4PeNbw8LhWa9Gpl
         rRlS4yo9/BgpLHrBvNUq1Po0zfWljF0JYampS3yFe1Np3uL4x57YP8jCVBek4+PB1ZbW
         N33uTt4zF+nbzrUK3Vsi6p8zpqeLcH60CcEyIhk1MOQL9ATW7uy4xt017B/UtJT1zBK8
         /CVR2m1KGUgsvaKi0HuI9NmX2IrBjNezGIfRjGyl4OxB+vpijEUPK+ksFqbuItVJk8z0
         6r0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vY9SF672PGIhEmlTEHx4Wy7K1LbIBp/7v3lK34xnhWY=;
        b=qdokGXleSFhDDcslfuTracCwmWCN+k3bfyYs+V0pKGZ4p/NcIA7fvM5z2qFhmw4nkS
         AqBG7Q4W9U0W04HP24S15c2FXWN1vdlEjcIYabEh+fQkkBG8D8lTTpytN/oLVLTRzwEG
         B/zgU0s8KVI1CATV1g76WBswuAl2vL8VjZmXw5tQ078olWD+CMT+n9xY6hSGATCX3o2z
         j4NsE3M11ucHKj6BPQ1Nmi654bJZM5dFjXYeUrUGfn71KcLQR2N5R7OnRuiMa79f0BA6
         uYGyCt39FFESgFj3DPZV2cHzriTlSmt3iKlyVXC9sa0u8TNwn5LeIKMmC8l+CZ5aye6N
         MQkA==
X-Gm-Message-State: APjAAAWZk1Ex1x2QmrgRx06oK9MCxaHhshHkmTb2iKXMYYHNS3bVaXBq
        S58fZTCWpTkO7k5dJiZAOsXwEQ==
X-Google-Smtp-Source: APXvYqzjKoWjnfJj/RBIxwo4JjLut9jXLgMlnN0GJ/MwiTM8GzfZifUKUDW+4deNHlzjallCWBpudw==
X-Received: by 2002:a37:68ce:: with SMTP id d197mr35132061qkc.16.1566483976909;
        Thu, 22 Aug 2019 07:26:16 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o34sm14583571qtc.61.2019.08.22.07.26.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 07:26:16 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Cc:     bhe@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] x86/kaslr: simplify the code in mem_avoid_memmap()
Date:   Thu, 22 Aug 2019 10:26:02 -0400
Message-Id: <1566483962-10046-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If "i >= MAX_MEMMAP_REGIONS" already when entering mem_avoid_memmap(),
even without the return statement the loop will not run anyway. The only
time it needs to set "memmap_too_large = true" in this situation is
"memmap_too_large" is "false" currently. Hence, the code could be
simplified.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/x86/boot/compressed/kaslr.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 2e53c056ba20..35c6942fb95b 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -176,9 +176,6 @@ static void mem_avoid_memmap(char *str)
 {
 	static int i;
 
-	if (i >= MAX_MEMMAP_REGIONS)
-		return;
-
 	while (str && (i < MAX_MEMMAP_REGIONS)) {
 		int rc;
 		unsigned long long start, size;
@@ -206,7 +203,7 @@ static void mem_avoid_memmap(char *str)
 	}
 
 	/* More than 4 memmaps, fail kaslr */
-	if ((i >= MAX_MEMMAP_REGIONS) && str)
+	if (i >= MAX_MEMMAP_REGIONS && !memmap_too_large)
 		memmap_too_large = true;
 }
 
-- 
1.8.3.1

