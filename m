Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E93FC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 19:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2274A26E28
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 19:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfEaTX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 15:23:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44408 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbfEaTXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 15:23:55 -0400
Received: by mail-pf1-f193.google.com with SMTP id x3so1249809pff.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 12:23:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=aiQIM6f9frALGlBHOVEXZviohTaEbE7nb+FTGwUVD4A=;
        b=Jf4Pda5zd2i+iVak1K3twX7nHJi0uw8y/n9Vrj3tFN/OEYbzblnTwMpGQCPCIyQ9r2
         G0QkAyL+jUDsbF5F1pgxNED7yLOFSQetB4DpVVKzPTg93zR60oK/nz5rkFHMPIiYjzMB
         bARCxb11IahlPaVloUNnM06198yvzhV5tL5hhVPPTNEtTdc6qMvPblmEphqlan3wTCJv
         Gzw7w7X1X6xXLIbbryqA+iLSeAAjSTFdllP88H6kcOV3urLi4/XW7JhIU65BoPAsBp8r
         rIuyT2ofZjDCPET3I07Y60mLQivcNcADSNZ4OvOa4Mo7VptKgbffFfgHdTqpHUXpmGDz
         IFCw==
X-Gm-Message-State: APjAAAVBLSOEMlnvjULlDCI72RZPqGNafgnktePLZeRAllAdWYK/lf+f
        rosfUHb4CupxoRNniE9vPbritA==
X-Google-Smtp-Source: APXvYqxnHH048gsRvFfx6yXHqqmSGXwu8SiZWTfESkHE4QP5Ki/bYzl/4Onunf3wDQIsChfj3cuqqg==
X-Received: by 2002:a62:a511:: with SMTP id v17mr11832352pfm.129.1559330634068;
        Fri, 31 May 2019 12:23:54 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id x16sm6569182pff.30.2019.05.31.12.23.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2019 12:23:53 -0700 (PDT)
Subject: [PATCH 4/5] x86: Add fchmodat4 to syscall_64.tbl
Date:   Fri, 31 May 2019 12:12:03 -0700
Message-Id: <20190531191204.4044-5-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190531191204.4044-1-palmer@sifive.com>
References: <20190531191204.4044-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     linux-arch@vger.kernel.org, x86@kernel.org, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@sifive.com>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/x86/entry/syscalls/syscall_64.tbl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 92ee0b4378d4..998aa3eb09e2 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -349,6 +349,7 @@
 425	common	io_uring_setup		__x64_sys_io_uring_setup
 426	common	io_uring_enter		__x64_sys_io_uring_enter
 427	common	io_uring_register	__x64_sys_io_uring_register
+428	common	fchmodat4		__x64_sys_fchmodat4
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
-- 
2.21.0

