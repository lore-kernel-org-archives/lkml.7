Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708AFC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 12:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32294206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 12:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="qIJMFS9o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387575AbfHVMch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 08:32:37 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44651 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfHVMcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 08:32:36 -0400
Received: by mail-qt1-f194.google.com with SMTP id 44so7366425qtg.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 05:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=SKd7tHvS25v+xFAjdTMZ8xUUN2hktGC+1Q3uTOIAcd4=;
        b=qIJMFS9obGkkIs9l3K9nbkDjo89VnnT9K0a/1MyrIK62u5dBM8Ey/8DxXqWc8HDNU9
         3Yi6fc77sdL3p3on/9zpdJWmn/cmoNx1dAMbXWCHuUdWBKpWheu3X8qEZz4nBFGAXVAV
         1EFusmzPAmPS9iM8hqIH3s708AgTrE0IacxHutHNPBJxwdrJJdLvzH17eeYgkFyqHlmn
         GpibvhhzgWWKQwOKv8C9QlZGPA3E1fM8crHgGgTnQuSFZ6JNsNMQMk+6gT9aSpDwzPv/
         ngo+0pJUFe5kBgMyFiokzHXjJoIyv58ex5diMmmyd/1NHTSAtwAGrq66F7KHBuZSepDP
         Wh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SKd7tHvS25v+xFAjdTMZ8xUUN2hktGC+1Q3uTOIAcd4=;
        b=d8NIwkdyXPMxToPIB0Ru211/BffoaBzzwI6iL/+gn1j/DEY1YUzS6eEwtE/cbjGg+G
         97vWDiZjpGtNfJTQjeA4rsaSyHy3D//SafdFfYu7YNitcUMZ3gwiFw4piyl/ZiyVdX6J
         HI6T/hJpa4sXQQ9j3HspZIYSVPR58U/AAslny0rZ4l5zd/hqM15p3lShXiGgMlkY8o5T
         mcQ4lc75KtiUDZZyLIvJtJOIhxGYRdmmmlmJ6RdheqnDNjHP2i6XaNRSXf/P2bN116Kl
         Z3PXPVlrRgP2fVOJAqRzWaCEeA6DW7DKGVm5jlgBYrir21GnxXqqFqcRxJxhlXOP2m8A
         Ic9A==
X-Gm-Message-State: APjAAAV8bYwUjl6X3AFrBRHuNLbmxdyNfJxRTzD4cpuzR6pdtOxT3PY4
        l+K4Jy0uH+6mGOMeXKuVJ9806Q==
X-Google-Smtp-Source: APXvYqwgwWac85rR503CXohTdxd6kuWwhKoM1zEsfdPIQdlFmqbL5XnehlFxmRM4sxoR8Wh1ZPaZXA==
X-Received: by 2002:ac8:4a0d:: with SMTP id x13mr34953645qtq.356.1566477155802;
        Thu, 22 Aug 2019 05:32:35 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 65sm9030143qkk.132.2019.08.22.05.32.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 05:32:35 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Cc:     bhe@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] x86/kaslr: remove useless code in mem_avoid_memmap
Date:   Thu, 22 Aug 2019 08:32:26 -0400
Message-Id: <1566477146-32484-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAX_MEMMAP_REGIONS is a macro that equal to 4. "i" is static local
variable that default to 0. The comparison "i >= MAX_MEMMAP_REGIONS"
will always be false.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/x86/boot/compressed/kaslr.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 2e53c056ba20..a4a5a88edb94 100644
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
-- 
1.8.3.1

