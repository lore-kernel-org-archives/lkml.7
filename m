Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7F9C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 03:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E557B20644
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 03:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hu0MGuP2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbfGODTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 23:19:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38693 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729029AbfGODTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 23:19:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id y15so6738814pfn.5;
        Sun, 14 Jul 2019 20:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZXfThpBYXPevWP7jcmv6IbQmrSRH4OaB0mJT6tSCKPI=;
        b=hu0MGuP2X8jBZU/ZCxP1N5I9Vg21uWRuCrQQZXPyl84gqO8yv4P+6Eb668SylctbyC
         eQWMJyZKEHHudd9XgA1n6DbvKiNrMPJ80i6HKKCGuI0WItf5G22wmQWNX3szb9dPjSje
         KfaeE23XobQq1ZXW9wusRHFnfC7SqdKiFJN5A5SJQLP3eQANqJzwSxqVz5eJ5OQGc31G
         46QMsMXy265jrGECrNtZevPVfN9qLiDvCLI0kTOe8rcXX8u+PkvBipBxWdzeeyrzpyjr
         CmRQRUVl6ULWMNUpcJzUb2mFuvvsCOWUeYjxQhrmpc0D/eqQNpEu1e4HIqBv/pvx+MuJ
         3hYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZXfThpBYXPevWP7jcmv6IbQmrSRH4OaB0mJT6tSCKPI=;
        b=smLqAEr3trwJ6N2uNOCvid74qNZDXlxirSikwKPGe6uqKvUwwHF4NjDyZ6QIStMbFX
         rEkabhql7k/2aINd31KjwtdMtNK5A8n9FXCJPhuhAWiLo9wlmc6HS9xZRAdcwfPgDQV/
         M6iVEy8HNbkKFkgNbPNlqKXaPeatOXRxywVVGbN5PiLZX5wYXxmuEZrR5lzlXxjT9076
         bDLi/FF3pKTUP/swSD/XP/4+AY8Y6ZRgKClvOHfmaBAUF4Q2jgKNUte+mF7RNhzjI9dh
         0Cgc4rs6rZNdHR1D1/uBhxSgktVbbfQsyjdoyLDg8ZzwfzZ7+OmkHxkjh2usOLO0AD/J
         EOEQ==
X-Gm-Message-State: APjAAAUznjI5Og9AirvvqfBLje28/BgFWLuVAMvPtK0Q+Sibcbu2monB
        V9GR+Ta48H58eXdiBH+plrM=
X-Google-Smtp-Source: APXvYqzh6ifilVmnYs/WhTCI039Zylk51itQ0H5ghGtJvFzH4epdS5EdhoB/CiNAOFbesigGLURNXA==
X-Received: by 2002:a17:90a:d791:: with SMTP id z17mr25465085pju.40.1563160749925;
        Sun, 14 Jul 2019 20:19:09 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id r13sm17560449pfr.25.2019.07.14.20.19.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jul 2019 20:19:09 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 16/24] scsi: mptfusion: Remove call to memset after pci_alloc_consistent
Date:   Mon, 15 Jul 2019 11:18:58 +0800
Message-Id: <20190715031858.6936-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci_alloc_consistent calls dma_alloc_coherent directly.
In commit 518a2f1925c3
("dma-mapping: zero memory returned from dma_alloc_*"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v3:
  - Use actual commit rather than the merge commit in the commit message

 drivers/message/fusion/mptbase.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index c2dd322691d1..3eeb4cbdaf3b 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -4507,7 +4507,6 @@ PrimeIocFifos(MPT_ADAPTER *ioc)
 		dinitprintk(ioc, printk(MYIOC_s_DEBUG_FMT "Total alloc @ %p[%p], sz=%d[%x] bytes\n",
 			 	ioc->name, mem, (void *)(ulong)alloc_dma, total_size, total_size));
 
-		memset(mem, 0, total_size);
 		ioc->alloc_total += total_size;
 		ioc->alloc = mem;
 		ioc->alloc_dma = alloc_dma;
-- 
2.11.0

