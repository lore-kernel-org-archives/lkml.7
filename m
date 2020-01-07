Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CDCC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4EC24677
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgAGTom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 14:44:42 -0500
Received: from mail-qv1-f53.google.com ([209.85.219.53]:41260 "EHLO
        mail-qv1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgAGTol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 14:44:41 -0500
Received: by mail-qv1-f53.google.com with SMTP id x1so382706qvr.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 11:44:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1aRDnoCkrgOmMmN7UXf14u86f7PdcvQK2djuifmWlI4=;
        b=HLsoQQumL46OO/FVmMYOJveXw1p8EInUvs2kecwXlmMQCkOIsF6E61M2bYjotYIFSh
         QRmkQYtiALtlrT+EEHqon3OnHVnV+gOBUNwMj7j2hK0DZFp9qmnTcY5OLcmM8G1feHJK
         LfZGmc9hp1/grZhRmIC2izZ0u/Bw83AZrnhYBKf9n8pmXRg/7imPgsLI6xi86Om9DJNX
         3Z4SiCqamna9usludlhOw+AC/B1nMQN8O+aPOwrE2014+i3iBcqOEfIajVMo+16G8HP5
         HTXwsRpqshNJMCNFXp99J/4iJ7eh3rgkv2dnaIZS5oEXYBboO3jztIv5cFEFgmpw+RQr
         FfEg==
X-Gm-Message-State: APjAAAXYxkwqAj3g4ebGeeagxefHzHj+UQsfEIgDRlszEsoKLIF1oxq3
        Kna9VZsYVPIYUvsAULCjPWI=
X-Google-Smtp-Source: APXvYqwr6G34PbQgWamckAWk4cg7DS3iII8MySFbnR+SfLXav0e5NO2Kd48yZ+rZd0Hbv1OkYBovxA==
X-Received: by 2002:a05:6214:bc6:: with SMTP id ff6mr950441qvb.133.1578426279985;
        Tue, 07 Jan 2020 11:44:39 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id s20sm280137qkg.131.2020.01.07.11.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 11:44:39 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] x86/boot/compressed/64: Use 32-bit move for z_output_len
Date:   Tue,  7 Jan 2020 14:44:36 -0500
Message-Id: <20200107194436.2166846-3-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107194436.2166846-1-nivedita@alum.mit.edu>
References: <20200107194436.2166846-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

z_output_len is a 32-bit quantity, it's enough to use a 32-bit move to
load it.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/head_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index edd29340bcfd..17139c130ac9 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -531,7 +531,7 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 	leaq	input_data(%rip), %rdx  /* input_data */
 	movl	$z_input_len, %ecx	/* input_len */
 	movq	%rbp, %r8		/* output target address */
-	movq	$z_output_len, %r9	/* decompressed length, end of relocs */
+	movl	$z_output_len, %r9d	/* decompressed length, end of relocs */
 	call	extract_kernel		/* returns kernel location in %rax */
 	popq	%rsi
 
-- 
2.24.1

