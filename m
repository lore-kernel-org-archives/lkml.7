Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D346C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EBE2208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="VK98QHJQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732386AbfHOQkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 12:40:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37979 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732147AbfHOQjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 12:39:21 -0400
Received: by mail-wm1-f66.google.com with SMTP id m125so1774895wmm.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 09:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GnwJnGDWcqQEa8ukjqPOjGYwDlsA8+VgoLza7ivYpuU=;
        b=VK98QHJQp58r4MG/VMQ2/X8C4g7K+jd1wWgAJGc04+4RuRF1VZprsHSpUZoJo+2Huw
         N+xWJ1IF009s65KxEfQ4AjWRseLaM5xD2wgRTA+tMKRbA64bOWbGt2GhPXhXwNfrCzAq
         1wsBBCDUn7k4bZs2JhPRh4/N3iEwnFfzR7bb7WNtLA1TT0OPUywTx19QzZxQPU1SFBMs
         wlaZPPDHhQxsSxea9BklM3Iq78CSFKVlqprUPlPG29tktqAv/OF7oD47/7/vbN0HNO4h
         azIQk+5Bpo3zU8U5veQadHFoU5vlyENj/pPKKQt6NiMf6YSd/NVGs8udSaANPvt6mM1s
         x0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GnwJnGDWcqQEa8ukjqPOjGYwDlsA8+VgoLza7ivYpuU=;
        b=F9Tw5RRMzQk5sEt+zSGLmIBOvQ8KfzWjXIgaDCxeQjwgH140xawx/jJCh/QXt4eKEW
         If4M2EJ4Jzwbl2UhzbHT0T1xLNiZceZ7ia5Ya5KCILQLB2h9GDCG8LfFQ/rd8lzoQLYY
         PDIeCNb5cDPVbTV07pXew/I4d9q8ezPGXHxHpi5lLGDMC9igi/Rx6qcuekhgTtyYRRMW
         IgULMbu5j+eO3aQpO1WRMl6UaULcay8gpwt7jS1po9gDASnCmVpUTNE6I50XTqTfmLPA
         CRI+KSSQpAu6mVu3mfPNuCTUR+x0+F+JcigHhbRJO6riwj/cs5yuCgnCC0xiXfgQwiAC
         CAzQ==
X-Gm-Message-State: APjAAAWKOYdHAS4JhcTFEd/L+2ovUA4Te0jFwUOKLWKr4AcEc/Bzu+YG
        /QfQry+3s1DVVJkrzVSIraMyaabXwL4=
X-Google-Smtp-Source: APXvYqzaWfUHfcgN30w8w/Hh8uPgfDlDg7IOhqbO0A5S0rFHYCc4oL9zwrvsgNDVlFZHev9iucu1gg==
X-Received: by 2002:a05:600c:28c:: with SMTP id 12mr3503235wmk.157.1565887159619;
        Thu, 15 Aug 2019 09:39:19 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f7sm5755046wrf.8.2019.08.15.09.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 09:39:19 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv6 28/36] posix-clocks: Add align for timens_offsets
Date:   Thu, 15 Aug 2019 17:38:28 +0100
Message-Id: <20190815163836.2927-29-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190815163836.2927-1-dima@arista.com>
References: <20190815163836.2927-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align offsets so that time namespace will work for ia32 applications on
x86_64 host.

Co-developed-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/timens_offsets.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/timens_offsets.h b/include/linux/timens_offsets.h
index e93aabaa5e45..05da1b0563ce 100644
--- a/include/linux/timens_offsets.h
+++ b/include/linux/timens_offsets.h
@@ -2,9 +2,17 @@
 #ifndef _LINUX_TIME_OFFSETS_H
 #define _LINUX_TIME_OFFSETS_H
 
+/*
+ * Time offsets need align as they're placed on VVAR page,
+ * which is used by x86_64 and ia32 VDSO code.
+ * On ia32 offset::tv_sec (u64) has align(4), so re-align offsets
+ * to the same positions as 64-bit offsets.
+ * On 64-bit big-endian systems VDSO should convert to timespec64
+ * to timespec because of a padding occurring between the fields.
+ */
 struct timens_offsets {
-	struct timespec64 monotonic;
-	struct timespec64 boottime;
+	struct timespec64 monotonic __aligned(8);
+	struct timespec64 boottime __aligned(8);
 };
 
 #endif
-- 
2.22.0

