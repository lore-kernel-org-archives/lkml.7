Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32FCC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07D32176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfLRVpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:45:52 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35503 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfLRVpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:45:23 -0500
Received: by mail-qt1-f193.google.com with SMTP id e12so3221736qto.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 13:45:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=smdZf1o+sX783B1zfvINLQ+T4hhryNo5pnaWNDicN+w=;
        b=Nkh5Ip7SZmbZymYjXgRNVT8hpuP+H+1DBCUm/eKcvPvLxx7kk5kKSVpdVxRQvw6vE5
         XUN4tHnqhpiulhSwI2M5CjYdZ7TQIE27ECW1vNb3xZY5+SxJGnDegaRFIDXKiX5JD0BU
         xDTceFkS+XR4xN1zwz870FqoLsrll4zA7Y/7AuSP70RGBOBnLKZy2UMUnezJo5xTxu8P
         2h8/ykDV1y6K0Lq43IxfaVM1o1w8vGxEWS1raLCpHwewNI7VpjHKbymAKQIpzh5k9307
         ObwA4p8c7OJ51PoSpnb/Hz/6czF39gpK+2Af2u8VIIRE/Fq9FrBfqOFaxajGyt+QbS70
         L1+g==
X-Gm-Message-State: APjAAAWpIQKnrTU77N0w4Uo+bO+4bDC8+HInIhIZTVnHDpWHa8dcyxoy
        jBPi5Uz5QPGzIZjThC5jNi4=
X-Google-Smtp-Source: APXvYqxz4aQkah1tsveWVSYFDT41z4OhxIBGwyXDIbTrnzGGHpMUzLrAUNC4vouWn/W/tjlWDjiKCw==
X-Received: by 2002:ac8:4257:: with SMTP id r23mr4223243qtm.126.1576705522731;
        Wed, 18 Dec 2019 13:45:22 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u4sm1059851qkh.59.2019.12.18.13.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:45:22 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 18/24] arch/riscv/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 16:45:00 -0500
Message-Id: <20191218214506.49252-19-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218214506.49252-1-nivedita@alum.mit.edu>
References: <20191218211231.GA918900@kroah.com>
 <20191218214506.49252-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

con_init in tty/vt.c will now set conswitchp to dummy_con if it's unset.
Drop it from arch setup code.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/riscv/kernel/setup.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 365ff8420bfe..9babfcf3bb70 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -78,9 +78,5 @@ void __init setup_arch(char **cmdline_p)
 	setup_smp();
 #endif
 
-#ifdef CONFIG_DUMMY_CONSOLE
-	conswitchp = &dummy_con;
-#endif
-
 	riscv_fill_hwcap();
 }
-- 
2.24.1

