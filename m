Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD013C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80CE4217D8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eZYgThMO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfETXUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 19:20:07 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42492 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbfETXUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 19:20:05 -0400
Received: by mail-pl1-f195.google.com with SMTP id x15so7419263pln.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 16:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5q4ihNY2J75cnrZIRES8fAo4iQKm5IxBSJcCX4JVods=;
        b=eZYgThMO0MmLC/WHZ2dPHnJOr7+KHkU0fXOOKCdON8FfqOAre3vvVCYRJ1SR6kSUVb
         eqPTxxStSFEusl+CbXJApLq3D5CT5gx9prgZ1/PP6w+2P41VmcOJ6isnA2NR4o8FPhgQ
         D+GK+Jel3SOsPeno6jdKMM6tucPCbgap3qnks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5q4ihNY2J75cnrZIRES8fAo4iQKm5IxBSJcCX4JVods=;
        b=g8/MToHDUDD4wKSOpdkKTmifbCgOOXV0DBlh8rYhakBKJJo2c8WR5/Ibl3DIYZak0B
         kHZxQa5lHX9PfEDC+9HGAE9/fd2Cz2Pm8ck6R8HMMIrLEoWovYeQTBrEnvmFmKXKyd6k
         Iclb9RBXFWg5rjHsZPu4BVxgKdIjJG39A1vBeTFRZaDjUdpTUyVKv6xp4/BWXZwy8qX5
         LXs470U8zCFquID57vBYqHtMwvCdMS32NbW1NhomZF4eJMO11oriGa2X0pkqrgk98coN
         PYY4DCIroDdlSGKN2PqXamCMnQWqgr9uoso2InvielXDuAzGV1OXwhrhXsM4+UxL8eNR
         nbqQ==
X-Gm-Message-State: APjAAAXXvH+CeMvXF7744Co68RsoZB2i1zVOtJxP6b2IIzkPRmN/Cmru
        FHIMvHxC+Ki3L+x3kti7K3NNjg==
X-Google-Smtp-Source: APXvYqxkEqFzO8WUdGIhDFbmcz21X6NtsaHwl1E1vofYxC+QtWucxKvAs1tpP0vLEkhOpewal9sMyg==
X-Received: by 2002:a17:902:5066:: with SMTP id f35mr30205827plh.54.1558394405043;
        Mon, 20 May 2019 16:20:05 -0700 (PDT)
Received: from skynet.sea.corp.google.com ([2620:0:1008:1100:c4b5:ec23:d87b:d6d3])
        by smtp.gmail.com with ESMTPSA id h13sm19350861pgk.55.2019.05.20.16.20.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 16:20:04 -0700 (PDT)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nadav Amit <namit@vmware.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 02/12] x86: Use symbol name in jump table for PIE support
Date:   Mon, 20 May 2019 16:19:27 -0700
Message-Id: <20190520231948.49693-3-thgarnie@chromium.org>
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

Replace the %c constraint with %P. The %c is incompatible with PIE
because it implies an immediate value whereas %P reference a symbol.
Change the _ASM_PTR reference to .long for expected relocation size and
add a long padding to ensure entry alignment.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range below 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 arch/x86/include/asm/jump_label.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index 65191ce8e1cf..e47fad8ee632 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -25,9 +25,9 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
 		".pushsection __jump_table,  \"aw\" \n\t"
 		_ASM_ALIGN "\n\t"
 		".long 1b - ., %l[l_yes] - . \n\t"
-		_ASM_PTR "%c0 + %c1 - .\n\t"
+		_ASM_PTR "%P0 - .\n\t"
 		".popsection \n\t"
-		: :  "i" (key), "i" (branch) : : l_yes);
+		: :  "X" (&((char *)key)[branch]) : : l_yes);
 
 	return false;
 l_yes:
@@ -42,9 +42,9 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 		".pushsection __jump_table,  \"aw\" \n\t"
 		_ASM_ALIGN "\n\t"
 		".long 1b - ., %l[l_yes] - . \n\t"
-		_ASM_PTR "%c0 + %c1 - .\n\t"
+		_ASM_PTR "%P0 - .\n\t"
 		".popsection \n\t"
-		: :  "i" (key), "i" (branch) : : l_yes);
+		: : "X" (&((char *)key)[branch]) : : l_yes);
 
 	return false;
 l_yes:
-- 
2.21.0.1020.gf2820cf01a-goog

