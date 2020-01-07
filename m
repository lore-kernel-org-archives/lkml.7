Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F52FC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D82C120848
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgAGTok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 14:44:40 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35323 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgAGToj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 14:44:39 -0500
Received: by mail-qt1-f194.google.com with SMTP id e12so783859qto.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 11:44:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S9Z0mVFd2p1ZduER7Gd3T2LbO8+fNcpa0hKnMEswfbQ=;
        b=lSJgiO8089UpAtwUJI7TvS0d/uYTm6JLSGVRP6PE2Dn5xwVb1G+jKQtkRJjJJALCqk
         1L/xlHA0rqUvSQOLOfiBWlyc0cCqFTcu6WWyyMKKhNi+VE8zYGnoVaSNp8MOssbrvATa
         vM4BNznD5Ooo3AkkRkdnueP8IuTM3jjO6519yNFM8MQgQCZSPc1rFNTUXvYKP7ijaSeJ
         y3NyipPOeyoxEQCGaYWmnR2jXr29L9KbZE4PQ4m6ftaF1H9NT1ISx4CmgYGcSjlla7mT
         uERal/5DGYECRrFbvqp6E+//BFf2WPXMT7NTjhvx0ZQrbnweKHiPI/N9hqZUv0w3FhBI
         89Og==
X-Gm-Message-State: APjAAAVTBuvLbZvkwao+PKAGrQzUy20Kj/SB0lx2/EGQpzwrXwQtchcW
        oAZEE5wwLUKOik6t8XlMFAs=
X-Google-Smtp-Source: APXvYqyHfGfSsxR7jhJcSWqmGErVMmZtoEkd6N01QijnRO2clAtMjz4v9+klE3Mw0x9E3PUcL2SgnA==
X-Received: by 2002:ac8:86b:: with SMTP id x40mr542439qth.366.1578426278502;
        Tue, 07 Jan 2020 11:44:38 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id s20sm280137qkg.131.2020.01.07.11.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 11:44:37 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] x86/boot/compressed/32: Simplify calculation of output address
Date:   Tue,  7 Jan 2020 14:44:34 -0500
Message-Id: <20200107194436.2166846-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Condense the calculation of decompressed kernel start a little.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/head_32.S | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index f2dfd6d083ef..1cc55c79d1d0 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -240,11 +240,9 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 				/* push arguments for extract_kernel: */
 	pushl	$z_output_len	/* decompressed length, end of relocs */
 
-	movl    BP_init_size(%esi), %eax
-	subl    $_end, %eax
-	movl    %ebx, %ebp
-	subl    %eax, %ebp
-	pushl	%ebp		/* output address */
+	leal	_end(%ebx), %eax
+	subl    BP_init_size(%esi), %eax
+	pushl	%eax		/* output address */
 
 	pushl	$z_input_len	/* input_len */
 	leal	input_data(%ebx), %eax
-- 
2.24.1

