Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595D1C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38BB12077B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730608AbgAIPCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 10:02:24 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:33927 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730273AbgAIPCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 10:02:22 -0500
Received: by mail-qv1-f68.google.com with SMTP id o18so3081122qvf.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 07:02:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kq0gWjFvasYsms+f/wE6GRRcFpiCXufjwhyt2Hb0yVU=;
        b=DEZVAly1nipDho5rwZxCz+fYCqHamOfa8Asgm0/xPo2c0q+OWVsABBil6mVC1VSg9o
         XAbq8Wy4myMiec7340PMgZBYuB5zUku0QQNRBwlOOZEWIhyf9ZrpeuwtZzZ1J686guhj
         34R4S/xzCYRSqcCt/8/PyZTvpbjI+d+jbwnDvFhTUJT1Opwga/gOBdNumCi1NywaS2nF
         Tm1W5q7ksPjZJDUxARqSqvK9KgkV+NcpXrV4zhie1zu2p9+UEJ2S9b3ZVBbVugv2lv8P
         e1Oo2rXAXriOg0GWxtEkJb6ANHQr8PJjm04xCVwNerjtuNHpu0Jh5/hF2gA0DJb0r4EN
         SxOQ==
X-Gm-Message-State: APjAAAVDTEvFm8X5NwKyqxJWphCGbCsGZeQfjk0rl1DHMXuU+QW4LhfL
        BNXshPcP9SDj8MiV/tJZbhc=
X-Google-Smtp-Source: APXvYqzAbTu+pnRg6HwaDPyoSqbHllys/+WgvuiHUYYRqiWGhj1drhijbNCXTD84M6TWwCSmw0JF8g==
X-Received: by 2002:ad4:5562:: with SMTP id w2mr9248570qvy.147.1578582141192;
        Thu, 09 Jan 2020 07:02:21 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t73sm3217837qke.71.2020.01.09.07.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 07:02:20 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] x86/boot/compressed: Remove unnecessary sections from bzImage
Date:   Thu,  9 Jan 2020 10:02:18 -0500
Message-Id: <20200109150218.16544-2-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200109150218.16544-1-nivedita@alum.mit.edu>
References: <20200109150218.16544-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Discarding the sections that are unused in the compressed kernel saves
about 10 KiB on 32-bit and 6 KiB on 64-bit, mostly from .eh_frame.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/vmlinux.lds.S | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 508cfa6828c5..12a20603d92e 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -73,4 +73,9 @@ SECTIONS
 #endif
 	. = ALIGN(PAGE_SIZE);	/* keep ZO size page aligned */
 	_end = .;
+
+	/* Discard all remaining sections */
+	/DISCARD/ : {
+		*(*)
+	}
 }
-- 
2.24.1

