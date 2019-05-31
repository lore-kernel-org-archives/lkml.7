Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066A6C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 19:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE5FB26E46
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 19:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfEaTYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 15:24:02 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:38197 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbfEaTX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 15:23:56 -0400
Received: by mail-pf1-f172.google.com with SMTP id a186so6070525pfa.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 12:23:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=iIsIHJ/E9sb9iivYOWYTrHBdX9wvV0BVSK9WYc+2hhY=;
        b=IkaEDUkiL01v96cvpqrh5aLEZuqIVBoVsW6kjbVj4JgpN0FAnbo7SaaFHrdWzRnG9B
         GyEygz/JVsIfaween1jmzqdvhADsvk6cSO5wQkDlfkPcQDfSOyPNq3ma6wk7I00wXXS3
         qyvZytb9CvZDvzFgf/ryYZo5T2+JMyAuGF3EV6naw3UejWl//fkEqjx3D5Ybs2xrbSrR
         fINhqBzSRCpbeFwSibG17+zmHKTTn8wUY1oBAVSIf6d1i8SFg+w/HkJ+CftxfZ0zNTdp
         x3hqpcM2e2GpMebFoCGMUkjw813oRteLRor6ctSvudX97i4TUgFhF35QX7t+ACoqRriD
         yHcA==
X-Gm-Message-State: APjAAAUpMYsk/n2qdDJL6oFT2aJkHyrqwgAbCNyKlkdy52PnVcEsFMxL
        1geN0gSZboBpCLqLpfSxGodpdQ==
X-Google-Smtp-Source: APXvYqwqjBeSRHkNhprVnlAw/2N8AmL71UGiONuyr+S2FzywQVEi5ye6pcOigbDzCrp3j+bmycDwJw==
X-Received: by 2002:a62:d410:: with SMTP id a16mr4454667pfh.167.1559330635344;
        Fri, 31 May 2019 12:23:55 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id m1sm6059048pjv.22.2019.05.31.12.23.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2019 12:23:54 -0700 (PDT)
Subject: [PATCH 5/5] x86: Add fchmod4 to syscall_32.tbl
Date:   Fri, 31 May 2019 12:12:04 -0700
Message-Id: <20190531191204.4044-6-palmer@sifive.com>
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
 arch/x86/entry/syscalls/syscall_32.tbl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 1f9607ed087c..319c7a6d3f02 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -433,3 +433,4 @@
 425	i386	io_uring_setup		sys_io_uring_setup		__ia32_sys_io_uring_setup
 426	i386	io_uring_enter		sys_io_uring_enter		__ia32_sys_io_uring_enter
 427	i386	io_uring_register	sys_io_uring_register		__ia32_sys_io_uring_register
+428	i386	fchmodat4		sys_fchmodat4			__ia32_sys_fchmodat4
-- 
2.21.0

