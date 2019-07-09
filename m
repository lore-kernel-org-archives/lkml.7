Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255E1C73C42
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB071216FD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="WOizcZs9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfGIMPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 08:15:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39621 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfGIMPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 08:15:45 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so8871279pgi.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 05:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QEGm5RO370+1d5IRbqWLncN9g8dMNoXOhptUJSSSVGY=;
        b=WOizcZs9v6vfzMjSAwsxUTZr8HRQuZkMIXs35U6NVDapUVL1hscQFMSZl0VemXWbwQ
         wPtTNPuEckt0rmSIp5VkYT8DBlzwnNAwJwXpsLocRULPPjrlCuX6lmudgxDJW5PfFAco
         lNMFE8wDqvByBx27hTYwxihYQDpj9KpSF8GERrmg+6metVI5zjjFLIv3AvPzTf+GjEWW
         Ayh9CuWVlHutAMuZtbNO/eHjDAw2llAzK0bL+kfLPlzAxDF9lTCQmiAsR9o2i5MVDtmq
         M4Q0IyDODehuc038NLwnyNfomepPCoHYc776YVtx2kO9pS1nV+Cg08ByHtdJDYFf+szs
         TjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QEGm5RO370+1d5IRbqWLncN9g8dMNoXOhptUJSSSVGY=;
        b=PanL1vvZ/390NCesz6Ig8m6S1s1khfpMedDOGmzP+KoEFmMv5ziXH1AHhFF1m73sV7
         RJbpID749TGMG9hMq6TJrqFFRB2i9KzfOgiOMmdSE9iwEUDpPx2oaE8PtF5YjzuRxRXF
         DwoYsu1kR5OyC/e1ttHKJ6YQHUDJ09Uo6YfVh/dyEVK+v2nECpgvvN6M1Fbb2ORcJz9E
         VhCeTz/LAlcDhlbEaC6SSU1+CDTIsKKsJt+3T0fPX0awtZ3AOCioEjKCIB5UgYbiITpa
         QUgAO17Yi8knU1VEAx/P9AMgBPItfWrlJUW2Jmb2sgZOZcMhkN0lTi+RUVDmseZ03ptl
         ShLg==
X-Gm-Message-State: APjAAAUvP1kzljHCtxBfuErChp1a47vyUEXpoO2pyPmcXbMiGty4b8DK
        0lJrODwIiaY1CHubopM0kRR3ng==
X-Google-Smtp-Source: APXvYqwgynr3BUnrTGLgu4deUSaQXIo1BtFn5NAG/AplpsZcUMvzgFzdvi1iY5oZukQevHnvTZh0rQ==
X-Received: by 2002:a17:90a:8d0c:: with SMTP id c12mr31348441pjo.140.1562674544487;
        Tue, 09 Jul 2019 05:15:44 -0700 (PDT)
Received: from santosiv.in.ibm.com ([223.186.121.175])
        by smtp.gmail.com with ESMTPSA id o15sm21243933pgj.18.2019.07.09.05.15.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 05:15:43 -0700 (PDT)
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
Subject: [v5 1/6] powerpc/mce: Make machine_check_ue_event() static
Date:   Tue,  9 Jul 2019 17:45:19 +0530
Message-Id: <20190709121524.18762-2-santosh@fossix.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190709121524.18762-1-santosh@fossix.org>
References: <20190709121524.18762-1-santosh@fossix.org>
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
index b18df633eae9..e78c4f18ea0a 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -33,7 +33,7 @@ static DEFINE_PER_CPU(struct machine_check_event[MAX_MC_EVT],
 					mce_ue_event_queue);
 
 static void machine_check_process_queued_event(struct irq_work *work);
-void machine_check_ue_event(struct machine_check_event *evt);
+static void machine_check_ue_event(struct machine_check_event *evt);
 static void machine_process_ue_event(struct work_struct *work);
 
 static struct irq_work mce_event_process_work = {
@@ -203,7 +203,7 @@ void release_mce_event(void)
 /*
  * Queue up the MCE event which then can be handled later.
  */
-void machine_check_ue_event(struct machine_check_event *evt)
+static void machine_check_ue_event(struct machine_check_event *evt)
 {
 	int index;
 
-- 
2.20.1

