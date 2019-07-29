Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD80C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 04:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A04F20651
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 04:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="TktXLfId"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfG2EAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 00:00:25 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45067 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfG2EAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 00:00:24 -0400
Received: by mail-pf1-f196.google.com with SMTP id r1so27272031pfq.12
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 21:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QEGm5RO370+1d5IRbqWLncN9g8dMNoXOhptUJSSSVGY=;
        b=TktXLfIdMPz/+Bjgtn5c0ycVGKS9Y7wSHxpO/a+O71rjQAzWhK12tGj5OR/ZqnbemN
         zNUwWdc/AOrcYszNB7f7fIGi344D/K87A/M6kNHxV6OS87FPOGgwrL4JZxdU9pgpVOq4
         x4LOJrwqpnxhzGVSoMFxE5SjafY0XDa9eanCC05N63udkJOcYOO2ov+I+6cS717oDJqf
         KR6h9IOlNMIu2jRmO75HsycJGekZqdnZdrIbxvhZTYDXD+bxcU+aXM/v7CsJz9eUr6Nm
         UCaoJML9mAVyD13/6H2wfZIfpw7CRFlWD+i6QNqet4fs7gSLw66wXa4mLdaNXiOs+BPn
         VTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QEGm5RO370+1d5IRbqWLncN9g8dMNoXOhptUJSSSVGY=;
        b=Klv6E0GPE4BGnd/ToObkp2/GG73D0EWiLMpMXdVfLTF2vWyx9qbYMQGPtRS7wjor5c
         6LTO76/no5O1RwR8YG71mie681DNB/frle6aLQbzmUvP5eS7ZRJFxbXP/eYb/2kOQbl5
         e4TRhgbusEWDz53zkR1PD/hLUtZPqA5XARrvDyaWcbrwzbuVIXvWif6u06Jmy4TglxWk
         YsEP4qoRNRSRcDw8JTeoPSPqvTW136oXSJPpfUUEMgE3UqkNWFiukwNaTh3ErkW8W7bW
         Hx02dG/dNMiB0uBrxAPoFAOKcMFmnR5lgxu2vwAl/Fgbq6E39BOut6U5seQbMOg3PC1K
         +0xg==
X-Gm-Message-State: APjAAAXpeBgQ5bd1bgPxWueYHlVyCltqjIaOsHsv8n+MRxwp4Ko1OjSs
        HkTzzJ/K03TQFWhjyJvB9RE=
X-Google-Smtp-Source: APXvYqyeOtCjd7IFnPjeLrei396o9gxgYCqFus+m2Ph6YPME9ayUrsVbW4Hbd17abtRLpGeoRHDIzw==
X-Received: by 2002:a65:57ca:: with SMTP id q10mr105420085pgr.52.1564372823983;
        Sun, 28 Jul 2019 21:00:23 -0700 (PDT)
Received: from santosiv.in.ibm.com ([183.82.17.52])
        by smtp.gmail.com with ESMTPSA id g1sm100033948pgg.27.2019.07.28.21.00.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Jul 2019 21:00:23 -0700 (PDT)
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
Subject: [v6 1/6] powerpc/mce: Make machine_check_ue_event() static
Date:   Mon, 29 Jul 2019 09:30:06 +0530
Message-Id: <20190729040011.5086-2-santosh@fossix.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190729040011.5086-1-santosh@fossix.org>
References: <20190729040011.5086-1-santosh@fossix.org>
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

