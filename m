Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5584AC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1320C217F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="a/21JQkT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388106AbfKFDIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:08:07 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37099 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388081AbfKFDIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:08:04 -0500
Received: by mail-pf1-f196.google.com with SMTP id p24so11224530pfn.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 19:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=io42nr5GEPs0pfn13L4hlLJiHXMQomrZ5qcRKTkiezg=;
        b=a/21JQkTH7UKW7PqNv0dJjwH+ZtUvz7pxIDq070SAJBqqTJcVlQ2WweWVzvECPcfps
         7+NU5qbL/l6oEApRnpLBObZFhbrQDUI7A5y7A6v7a7BR6eo3Eid2Jtc/KECybayr8VR3
         P20Wzqz5hXGOmgnKHCawJ/LEV/kO5m4aIqe0wTBziuWEsDg7Di+le+FaQLR6xJEoFH2K
         wEMfJTA4eEwP73YJ1qfmTo4PbJhXt7APeeDjENcCcd7SRDahWKSH8t9nnh3DXCsNLX2N
         S5kyEY38YJ/gnziTOGpTStPkile13418qrzj7txgYrvYaZIlFmdlbCGn1lggLO/D+7A+
         aSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=io42nr5GEPs0pfn13L4hlLJiHXMQomrZ5qcRKTkiezg=;
        b=Z4obRwwrrVI2geNOJxoiElX/K9lXWc91btBt4Z6TMRCsO8vpwCz1yLUyI1Ts+Eydx/
         0BPVDQe/PhI/FDGRdgC3LxJHeGK/6WssZ+22bgLf3nw3sr9k1UF3wkTOsaukD+iJLqe2
         xTRF9dWbPqz7UXhbtrjnZuLF0DlFQPFT3QjvrJALPHDHfBGDgET7W1VEHlxrjHUgkxGZ
         4mxQ715H1J/l21/Sg4lddWbbsOEdOPJw6puke+zA/lFsa+8ev44nSJSu8ovKGr+mHR0B
         FhBOr74130BTTW8cHW9qyWWqX+0fgGqwIQ+1rtPY/98BV5T4IghPaq8comrpxESEv3CS
         m8Jg==
X-Gm-Message-State: APjAAAXsWygEhfs4vl+8ucl60FhnDc1ZgAbM5lMb261X7z209+sBMfhG
        M0+uD1l7D6XXaZdotHBFdso8FVr9oDE=
X-Google-Smtp-Source: APXvYqybClkOX+JRUfvkEiHPClbgMwdtHetrO6+PtPaknfq8Nb/X6npTEoaruNa2yfxJZKRzYOsQ4g==
X-Received: by 2002:a17:90a:234c:: with SMTP id f70mr569834pje.109.1573009683377;
        Tue, 05 Nov 2019 19:08:03 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:08:02 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Subject: [PATCH 30/50] sh: Remove needless printk()
Date:   Wed,  6 Nov 2019 03:05:21 +0000
Message-Id: <20191106030542.868541-31-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191106030542.868541-1-dima@arista.com>
References: <20191106030542.868541-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently `data' is always an empty line "".
No need for additional printk() call.

Cc: Rich Felker <dalias@libc.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/sh/kernel/dumpstack.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/kernel/dumpstack.c b/arch/sh/kernel/dumpstack.c
index 6784b914fba0..2c1a78e5776b 100644
--- a/arch/sh/kernel/dumpstack.c
+++ b/arch/sh/kernel/dumpstack.c
@@ -118,7 +118,6 @@ static int print_trace_stack(void *data, char *name)
  */
 static void print_trace_address(void *data, unsigned long addr, int reliable)
 {
-	printk("%s", (char *)data);
 	printk_address(addr, reliable);
 }
 
-- 
2.23.0

