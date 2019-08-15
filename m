Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE02EC32753
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 00:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF052084F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 00:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="aCwGXfz9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbfHOAkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 20:40:03 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35407 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfHOAkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 20:40:01 -0400
Received: by mail-pl1-f196.google.com with SMTP id gn20so382108plb.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 17:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hX9FcR9k27bW2r47hkwwmrOs6JunuLhROiik32U8Jn4=;
        b=aCwGXfz94wukudd9tuojbYRnyA7WGGS1y8gkVhsbLxhws+h/RMlWiwFmWy8tiw/weF
         coHyjch09dwLyo4bP/3v3iRs3oi3+SaT7ebzJ9/d+6Ng4qIi+cWMqgvTbyimIFPPm9Le
         dO/MwznrDnYGoQwXstSsEBd9sK+g8sjYRFu/wMnGXY2a+/FN5DcPGldtOvw4cMzNAQuT
         y7/JIRe2hdTh9HgcTX+hN/JWm8yBFjgsJ6Qina+BqBe02RcgGTwwYfK19nPEFhES5rgK
         L0QvRTjLgkwNKfZWFxxRqoSSiEVrrfA8QA+5QCwn/u7XeVyLgfHU+DxD7yuVVGLbQxOZ
         qP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hX9FcR9k27bW2r47hkwwmrOs6JunuLhROiik32U8Jn4=;
        b=Yw0iyX3Dr+TLUHxZ+NCqEc6vMJtmnPXNtpj4Z95OJ6UT5cY0OCfuut//y6dT9zrzzB
         DpNHmjiQPJcFCMdR15BEVt4IphdxkRLSUlvF7HtPxyr+I8EWZ4TrRLutQQt/vESJh7m5
         Y+za6DQoYTNpQ5lKfxwMnRnj0lMNDmD7PxX+3fuhnNFLrG0ZJ+WWe+/3kgWa5FJXwlI5
         lpstU2Fd/WY6Z0HCw8xH9O6BVBYAdnP/tMmxh5WeZETH+INkl25pkQqU1xogfTCdGTjm
         ZVOC85hOTdpc1EocHJsLSuADFgjJUylneX9TsjP5fbPMNku806+UeZUXc630IN705SJU
         DbDg==
X-Gm-Message-State: APjAAAWp8pwhuIJxryQS0R8sOLZZ9FhXPoRjsfGJ95Edm2vxRuTBSoL4
        1eEz1DaH9vldfFDCqsGt4jBWSw==
X-Google-Smtp-Source: APXvYqwxcOx+m23mKTnmX2OStoG3e6DOzHFNzvhFqCGTVqAhAdIJ5qOLmc4HnWhJPnrTOIHJi+F09g==
X-Received: by 2002:a17:902:1a4:: with SMTP id b33mr1859694plb.141.1565829600382;
        Wed, 14 Aug 2019 17:40:00 -0700 (PDT)
Received: from santosiv.in.ibm.com ([49.205.218.176])
        by smtp.gmail.com with ESMTPSA id g8sm815917pgk.1.2019.08.14.17.39.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 17:39:59 -0700 (PDT)
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
        christophe leroy <christophe.leroy@c-s.fr>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        stable@vger.kernel.org
Subject: [PATCH v10 1/7] powerpc/mce: Schedule work from irq_work
Date:   Thu, 15 Aug 2019 06:09:35 +0530
Message-Id: <20190815003941.18655-2-santosh@fossix.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190815003941.18655-1-santosh@fossix.org>
References: <20190815003941.18655-1-santosh@fossix.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

schedule_work() cannot be called from MCE exception context as MCE can
interrupt even in interrupt disabled context.

fixes: 733e4a4c ("powerpc/mce: hookup memory_failure for UE errors")
Suggested-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
Reviewed-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Acked-by: Balbir Singh <bsingharora@gmail.com>
Cc: stable@vger.kernel.org # v4.15+
---
 arch/powerpc/kernel/mce.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index b18df633eae9..cff31d4a501f 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -33,6 +33,7 @@ static DEFINE_PER_CPU(struct machine_check_event[MAX_MC_EVT],
 					mce_ue_event_queue);
 
 static void machine_check_process_queued_event(struct irq_work *work);
+static void machine_check_ue_irq_work(struct irq_work *work);
 void machine_check_ue_event(struct machine_check_event *evt);
 static void machine_process_ue_event(struct work_struct *work);
 
@@ -40,6 +41,10 @@ static struct irq_work mce_event_process_work = {
         .func = machine_check_process_queued_event,
 };
 
+static struct irq_work mce_ue_event_irq_work = {
+	.func = machine_check_ue_irq_work,
+};
+
 DECLARE_WORK(mce_ue_event_work, machine_process_ue_event);
 
 static void mce_set_error_info(struct machine_check_event *mce,
@@ -199,6 +204,10 @@ void release_mce_event(void)
 	get_mce_event(NULL, true);
 }
 
+static void machine_check_ue_irq_work(struct irq_work *work)
+{
+	schedule_work(&mce_ue_event_work);
+}
 
 /*
  * Queue up the MCE event which then can be handled later.
@@ -216,7 +225,7 @@ void machine_check_ue_event(struct machine_check_event *evt)
 	memcpy(this_cpu_ptr(&mce_ue_event_queue[index]), evt, sizeof(*evt));
 
 	/* Queue work to process this event later. */
-	schedule_work(&mce_ue_event_work);
+	irq_work_queue(&mce_ue_event_irq_work);
 }
 
 /*
-- 
2.21.0

