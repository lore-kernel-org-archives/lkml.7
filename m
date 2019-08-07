Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7120C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A43322293
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="GLMrLdsE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387899AbfHGO5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 10:57:23 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39246 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729278AbfHGO5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 10:57:23 -0400
Received: by mail-pl1-f194.google.com with SMTP id b7so41270013pls.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 07:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H/M6TqzLiuanVCliBc3NhrwyBR/yMVzqsnz9WE14WyI=;
        b=GLMrLdsEfsoREUBYlWy8vT8pdGthJ92pv+sWNHZjUTL3BDROZ8LRVrj6pG+CAGUw+9
         qEfKOLMdyv+zJWzfXdefMFdBt8ly+ZWmVWeGz4SorPm3xYND6vMo5wBarHZn+xuHZ7a8
         C75UO9/+gdOMJM4W3faH5fXZQuQ/+A4hjMIu7mbjBBBKsKbculP3m3OLKGQCTxfhfUL2
         WFgDAXSxycs1N+6FMFh4GclR7Ltboc/zLF+rOucZxGrZblH3UFAqMadSWKr3ZgwRkDMQ
         /3qWkOIWlefdSCitcVVCvlRYGfhL6sYQaFP8UDFIoICb3dDDpPzWgNTApOAauqA1wd/c
         CcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H/M6TqzLiuanVCliBc3NhrwyBR/yMVzqsnz9WE14WyI=;
        b=MHdI7SbfDKcAUEAnFn699KrFj3Nobe4KBnNcdtCH1ycHP8cgIhP9nsmcV3NCpVftYi
         FkH/DhhKYnv/8L9fK1ZRsrKtR7RxjO6k0JNQNROdjAcTJFcZMX7+u6T8n/VPBEinjP+T
         SKjfKMuAnHKBlUJFJAYJ2mNApLEZ0rDhrhj0vy3tJ7XW112ltHBY/Ym2hQjNqABtT5zJ
         3Oef79LjnUZlFgTQmH2IlAmYNWRMqom4xb99ZfO7aViXDPdm9/OV/IF1gTjUlSSm/Jpt
         XoUXk8vB6+fZzKcsB09OKOnSpXsWT3hLTnlyygSIAE3LxbAjg0M6rEWDyBZWmbLEo4vk
         vnTg==
X-Gm-Message-State: APjAAAXP8/2hWt7vGR324U//WHXDRY0hRCf74qMyIVFWyed0Z0OwyOv7
        CqsC2xULWHBPHOXqxgqCi3c2EA==
X-Google-Smtp-Source: APXvYqxzMReHYAEsSHL6ZuwbnY64jPC5qnuBeknw3Xb7bNVWZPF4JNwuf2donTQXV7yUbF0LMOE7nA==
X-Received: by 2002:aa7:93a8:: with SMTP id x8mr9992935pff.49.1565189842221;
        Wed, 07 Aug 2019 07:57:22 -0700 (PDT)
Received: from santosiv.in.ibm.com.com ([183.82.17.96])
        by smtp.gmail.com with ESMTPSA id l4sm93617475pff.50.2019.08.07.07.57.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 07:57:21 -0700 (PDT)
From:   Santosh Sivaraj <santosh@fossix.org>
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        christophe leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v8 2/7] powerpc/mce: Make machine_check_ue_event() static
Date:   Wed,  7 Aug 2019 20:26:55 +0530
Message-Id: <20190807145700.25599-3-santosh@fossix.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807145700.25599-1-santosh@fossix.org>
References: <20190807145700.25599-1-santosh@fossix.org>
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
index 0ab6fa7cbbbb..8c0b471658a7 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -33,7 +33,7 @@ static DEFINE_PER_CPU(struct machine_check_event[MAX_MC_EVT],
 					mce_ue_event_queue);
 
 static void machine_check_process_queued_event(struct irq_work *work);
-void machine_check_ue_event(struct machine_check_event *evt);
+static void machine_check_ue_event(struct machine_check_event *evt);
 static void machine_process_ue_event(struct work_struct *work);
 
 static struct irq_work mce_event_process_work = {
@@ -202,7 +202,7 @@ void release_mce_event(void)
 /*
  * Queue up the MCE event which then can be handled later.
  */
-void machine_check_ue_event(struct machine_check_event *evt)
+static void machine_check_ue_event(struct machine_check_event *evt)
 {
 	int index;
 
-- 
2.20.1

