Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95B3C433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 00:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A0A52084F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 00:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="BLnqqaQj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbfHOAkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 20:40:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43183 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfHOAkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 20:40:09 -0400
Received: by mail-pg1-f195.google.com with SMTP id k3so460819pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 17:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YJYgBqte5Ii/VSliQ8oA8G2Ha5PCLW/st87+39mATT8=;
        b=BLnqqaQjeHeynjb2upKtSsQU8m3cioAHFRtTkjUpzDGa/XUf8CkP/ErCoH+EBSHzHx
         hkBF2gLJHzQi2sxZjkq1FhGkaTTyy5/FE+pJRaXsArXJg+8P8tdJtjzcG0/bKLgjlPl5
         4i9amV7QwcIvrK7kOf1QputrHeg43JC8BvGjAq2KA6ufzlBVt9CK0J+Ql8BWvJqyglmk
         dDtC6YbeidQZZqFVzuT8uoNugTM3e7CbEphDDOaMSKksVNT0M+hIX6zv11t8Q81SdgDv
         Yv8MrI+zfN0Zud3yFkFk0wfzr9krSc7MGDuPFsC3p5G4qiYBP8WRtsvjq3Fx3HGfJVvJ
         y1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJYgBqte5Ii/VSliQ8oA8G2Ha5PCLW/st87+39mATT8=;
        b=ZxYHsXc/uzQq4S6mKC/pem/o5LGhJ4z4+HhUDRzz4oooZuDdC8DmtbC2LnGm5Kk3x0
         GPKn+qrldrJghO5TsfnoJ8TprO4PH1zWmtVnPhpFKxQuQPwYWFguiWQd6KeV4r4N5FCb
         bzHwMc8RKfSS4XB5hKVuNDFhJY2py3VU4xyxsE6DKZSR4lDynHsfbdFQ1REoOrrFsrry
         LDO1wrpRFlDn+WXiur0wJ9GsbEwZANJN8ROkk2keF4/3wGvNQX2Yv2cRVboYZyFjwfcF
         XDkzFE4kuYePJYDV8P53/gvs3I9LlWWydf3C1Ed6e0oTZvmYQaUe6CKLOfGwb5KCe4bw
         BXdQ==
X-Gm-Message-State: APjAAAVypXgYZIghQkArnfeX0wdHIXLek1tuL9etglbHC4UTFov25JgK
        AaP4o3GDQdU+viu2xK3JU7870Q==
X-Google-Smtp-Source: APXvYqynGfUANrP4f5hZr25klluqQldG/UIZYzBNgm3PsD2gdEL5UyBoWWIRuHzjIptw+X0314DW4g==
X-Received: by 2002:a63:69c1:: with SMTP id e184mr1451823pgc.198.1565829608298;
        Wed, 14 Aug 2019 17:40:08 -0700 (PDT)
Received: from santosiv.in.ibm.com ([49.205.218.176])
        by smtp.gmail.com with ESMTPSA id g8sm815917pgk.1.2019.08.14.17.40.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 17:40:07 -0700 (PDT)
From:   Santosh Sivaraj <santosh@fossix.org>
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Chandan Rajendra <chandan@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        christophe leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v10 3/7] powerpc/mce: Make machine_check_ue_event() static
Date:   Thu, 15 Aug 2019 06:09:37 +0530
Message-Id: <20190815003941.18655-4-santosh@fossix.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190815003941.18655-1-santosh@fossix.org>
References: <20190815003941.18655-1-santosh@fossix.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Reza Arbab <arbab@linux.ibm.com>

The function doesn't get used outside this file, so make it static.

Signed-off-by: Reza Arbab <arbab@linux.ibm.com>
Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/mce.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index cff31d4a501f..a3b122a685a5 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -34,7 +34,7 @@ static DEFINE_PER_CPU(struct machine_check_event[MAX_MC_EVT],
 
 static void machine_check_process_queued_event(struct irq_work *work);
 static void machine_check_ue_irq_work(struct irq_work *work);
-void machine_check_ue_event(struct machine_check_event *evt);
+static void machine_check_ue_event(struct machine_check_event *evt);
 static void machine_process_ue_event(struct work_struct *work);
 
 static struct irq_work mce_event_process_work = {
@@ -212,7 +212,7 @@ static void machine_check_ue_irq_work(struct irq_work *work)
 /*
  * Queue up the MCE event which then can be handled later.
  */
-void machine_check_ue_event(struct machine_check_event *evt)
+static void machine_check_ue_event(struct machine_check_event *evt)
 {
 	int index;
 
-- 
2.21.0

