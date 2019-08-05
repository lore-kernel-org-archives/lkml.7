Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18ABC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 06:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C6C20B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 06:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="OFrfSNcS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfHEGWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 02:22:40 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38828 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfHEGWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 02:22:39 -0400
Received: by mail-pf1-f195.google.com with SMTP id y15so39090555pfn.5
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2019 23:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wCmmwD53XttWvxo3IyfDIXHfbZJtgpbW8gfsweTknQc=;
        b=OFrfSNcS5B23jmgGaxKhHDxaRdtfG9Z/9t76o5z4mnZtYlEYQ91YZ0dKJbAEJlOi7Z
         g9KAI8tTJyy2tACIQe1DM1eKsOxnDmkMbQR9/o9sxMHYfzT21wmvfdQ3Yza1W6T0Ww5w
         wmTuD3Z8XKNFh3q3SRiWrAQ6pHlK5Zi4dMiPWHqRtIQYEE2DSe9trD/Kt5MGoDrriPU+
         OvOomkWC9/VFXvYAvQDqQbkppeE2qBMjBtXz/QXCTgxcCMn1wTnkQVLCcrJVFqrrJWSE
         0yl2BL4d7pszaUvl09p/k3KPNV+klnoAksnyhx3a4k5KXF4uhTrnf7gGlb4TOGRIvXT2
         iY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wCmmwD53XttWvxo3IyfDIXHfbZJtgpbW8gfsweTknQc=;
        b=isoMXc1Gi7ofui2TO4g3neKkG7XeBUqZJ3dxknJaIKqlCxcrACQ9ensmKZwKh3KJIc
         2U2EKdgjm3tKN9g+dTjR1++xYdwKiskZ5SqGo1EOwgX8yc1S0H0PQf0bI1ixB3vOWacF
         xYBq8nlxYxmpbkSP398AjIh4jokD4zO4/XDc9lMHpz5EkeCvZYz7uhz6RrdBwIy20DmA
         0d0BLHCJQUIk6CzsbIuNvusUF5z/SS/CRoWvh+VAmWzsHwDliHpG2o/mJvAOH3SWM48z
         EP+1bOQhgqsjMk7u2hVdtc+MEC8U5IKq+SAhP1vpDERcuOj3pBLJrq1nSX1r/SJM/qKn
         L7zg==
X-Gm-Message-State: APjAAAUbeELl5F+yU2ZXUwJ4OqFYCrcWYKQEaqqE1q1ov1qt11p9MS4f
        H9krQRBUuNH+noZh8KrLDj3/PA==
X-Google-Smtp-Source: APXvYqzhpCMHhcko/8qLIOGOygFC1h7OUS2KmJMEu13blLA1da/lJtYyGUdGlWhX+fadRuZLVXRKgQ==
X-Received: by 2002:a17:90a:8c06:: with SMTP id a6mr16996434pjo.45.1564986158367;
        Sun, 04 Aug 2019 23:22:38 -0700 (PDT)
Received: from santosiv.in.ibm.com ([129.41.84.66])
        by smtp.gmail.com with ESMTPSA id i14sm124680082pfk.0.2019.08.04.23.22.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 04 Aug 2019 23:22:37 -0700 (PDT)
From:   Santosh Sivaraj <santosh@fossix.org>
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel@vger.kernel.org
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        christophe leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v7 1/7] powerpc/mce: Schedule work from irq_work
Date:   Mon,  5 Aug 2019 11:52:19 +0530
Message-Id: <20190805062225.4354-2-santosh@fossix.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190805062225.4354-1-santosh@fossix.org>
References: <20190805062225.4354-1-santosh@fossix.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

schedule_work() cannot be called from MCE exception context as MCE can
interrupt even in interrupt disabled context.

fixes: 733e4a4c ("powerpc/mce: hookup memory_failure for UE errors")
Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 arch/powerpc/kernel/mce.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index b18df633eae9..0ab6fa7cbbbb 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -144,7 +144,6 @@ void save_mce_event(struct pt_regs *regs, long handled,
 		if (phys_addr != ULONG_MAX) {
 			mce->u.ue_error.physical_address_provided = true;
 			mce->u.ue_error.physical_address = phys_addr;
-			machine_check_ue_event(mce);
 		}
 	}
 	return;
@@ -275,8 +274,7 @@ static void machine_process_ue_event(struct work_struct *work)
 	}
 }
 /*
- * process pending MCE event from the mce event queue. This function will be
- * called during syscall exit.
+ * process pending MCE event from the mce event queue.
  */
 static void machine_check_process_queued_event(struct irq_work *work)
 {
@@ -292,6 +290,10 @@ static void machine_check_process_queued_event(struct irq_work *work)
 	while (__this_cpu_read(mce_queue_count) > 0) {
 		index = __this_cpu_read(mce_queue_count) - 1;
 		evt = this_cpu_ptr(&mce_event_queue[index]);
+
+		if (evt->error_type == MCE_ERROR_TYPE_UE)
+			machine_check_ue_event(evt);
+
 		machine_check_print_event_info(evt, false, false);
 		__this_cpu_dec(mce_queue_count);
 	}
-- 
2.20.1

