Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB7FC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C515C2184B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t/rJt4ZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390490AbfEXKdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 06:33:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36696 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389448AbfEXKdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 06:33:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id s17so9493602wru.3;
        Fri, 24 May 2019 03:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=43H7NEPhk13B4dzNlL0gCOKayUYB6rO3EyAsXttShWI=;
        b=t/rJt4ZKXr5z/Poulu/FjatdRCaCYjOm2V1fOmg9Z5Z/0zIQQzMykgDzX6PRH1PTaz
         SqdXRDCZFDF8Ey5F+62ueQuNH3eNoLnATAztmg1tqqvOVARpxNsGs9SAfKk+nG+S4awj
         kzJ39Xm8iITs6MhUkwXK2ZFOQO5XRYDxEzDPkdzgvClHZd/1UfH+TlQGEoFNzC6aAX2Z
         vngBWREvA0uFd+rfvAu+J1RmdO+zodE4MZLtTOb600cuN/K/rGlBuqZNTpi5jkL5PDAH
         KuwhA2T/hwh2I7davoS9GYavP7omcLV7ohn64rE+M9NngcL8vIGNrx895fvf9HCJUlxq
         ObzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=43H7NEPhk13B4dzNlL0gCOKayUYB6rO3EyAsXttShWI=;
        b=SwwlZAP8gI7XDpt+1wmpY/sslmDGjkLcj+3/pgLmxuLCYXcYOxKV2acj9CJ9CNsj9b
         ebG6OKrik6Xl0v3XEGab8pxf+Y6RjF7TxGynjFZyPBghTK1WN1Bpp/9QZaR5hOM6u/zI
         2lAP2xJdTrzklP64REMRGyxGrawgKM6qazTgcv1/JfNNjX51CBxVrM1k4q//oiLCwfOm
         iRoR1xGegKQlG+S6/WzQV+Mgs7kj2pzGADLB6tzEnBAHoup9G/gSMFdcS8vN677UK3F6
         8RatnEuuQrILzJdoVXDZZBnf6g1ZLociUjURyMdIYHujM9f5ht6OxjqEU5/yHqw+7YLa
         2Z9w==
X-Gm-Message-State: APjAAAWc+2wsoO/l+oUH4KdYoNxB+5ZBMtPSl+hjln7wH7L+tjHEhRgi
        1i84HK3g6MyMbH32BY4g4Ss=
X-Google-Smtp-Source: APXvYqy9hMbxDrGpmcWBZqGaOnxSh5id0OZbq5E53Xu7si60swphJIc8cBK1WhyxL072WvFo5bBWnQ==
X-Received: by 2002:a5d:5342:: with SMTP id t2mr169047wrv.71.1558693978476;
        Fri, 24 May 2019 03:32:58 -0700 (PDT)
Received: from macbookpro.malat.net ([2a01:e34:ee1e:860:6f23:82e6:aa2d:bbd1])
        by smtp.gmail.com with ESMTPSA id k184sm4818626wmk.0.2019.05.24.03.32.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 03:32:56 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 150C211415E7; Fri, 24 May 2019 12:32:55 +0200 (CEST)
From:   Mathieu Malaterre <malat@debian.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     trivial@kernel.org, kernel-janitors@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/tsc: Move inline keyword to the beginning of function declarations
Date:   Fri, 24 May 2019 12:32:51 +0200
Message-Id: <20190524103252.28575-1-malat@debian.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The inline keyword was not at the beginning of the function declarations.
Fix the following warnings triggered when using W=1:

  arch/x86/kernel/tsc.c:62:1: warning: 'inline' is not at beginning of declaration [-Wold-style-declaration]
  arch/x86/kernel/tsc.c:79:1: warning: 'inline' is not at beginning of declaration [-Wold-style-declaration]

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/x86/kernel/tsc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 0b29e58f288e..75a41bddbc9d 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -59,7 +59,7 @@ struct cyc2ns {
 
 static DEFINE_PER_CPU_ALIGNED(struct cyc2ns, cyc2ns);
 
-void __always_inline cyc2ns_read_begin(struct cyc2ns_data *data)
+__always_inline void cyc2ns_read_begin(struct cyc2ns_data *data)
 {
 	int seq, idx;
 
@@ -76,7 +76,7 @@ void __always_inline cyc2ns_read_begin(struct cyc2ns_data *data)
 	} while (unlikely(seq != this_cpu_read(cyc2ns.seq.sequence)));
 }
 
-void __always_inline cyc2ns_read_end(void)
+__always_inline void cyc2ns_read_end(void)
 {
 	preempt_enable_notrace();
 }
-- 
2.20.1

