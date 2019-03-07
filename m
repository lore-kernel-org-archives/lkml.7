Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDBBC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B39B20840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cXprvTwn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfCGSwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:52:39 -0500
Received: from mail-yw1-f73.google.com ([209.85.161.73]:52146 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbfCGSwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 13:52:39 -0500
Received: by mail-yw1-f73.google.com with SMTP id l11so24196974ywl.18
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 10:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=vxPeICI1aFDlIKifVVs2OjTt1LL43ELKNS7JmYkNUFY=;
        b=cXprvTwnqq4q9FrocbFlL/yIf5EMxSO95QDCpJ3+LX+RkEz1ZqO2GPNonZFw0q+2VF
         KqMevdtZNqUDLVkweAJYG4H+KaUXqbLqGxnA3DVEbgR1ckQL29tc9xGBaWB49cupiJQQ
         Qs5bE5+h+NHZbyjj/bG6aquhKzwGJYiPPcq8ZiXkcJvJHUdHhZkV5Et2zzkWqVAFPoHM
         8OoTChaUt1Qr6oiWnzmGNvUxDyRS1XK2ZY0CKg3EO6bSw1EX5nokGWYr+mrBUxDabUJ2
         TPj4uMXb7no0cRrq6m2H22L8v1PSlPeGfBE0asCCitDCEe6Tx6MFM9VsHXOl2d4OaMCA
         pU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=vxPeICI1aFDlIKifVVs2OjTt1LL43ELKNS7JmYkNUFY=;
        b=M5d2l4/3QKEjco3HHLakWQ4fJJhc9cmXeoE57JMffqFe60yKDNkY25AMWNhCIpxM4n
         mc6JCVcrzbkHnDGT5ff+oe7RjlL86v9CzPJJJh1LQ3aNO4/tbX0Qu86+Zq3TRYC3tuGu
         ox9QWvy5cmurFH1wYObRGji44pQDt+eztZGcd/v/NOOiAJGx29jNA5ptG97YVkzdOZCR
         h81VVdQoOwOt+RSB6cEt/18IJHLKnK9uMOLrm3IpmUCtSXi2in3XH+XdWmFtAwDqR3RB
         Btn4GnBHkAFSy9eDsC6LBRGJx/+Wb2Kc875ebQH7Oc4yEzPYBb+OFM5VSbK4Y1KJq2V2
         1Oiw==
X-Gm-Message-State: APjAAAXivWtvIKDPGM3WyzHiOTiLGJeN9zniRHvR4f/6hX4pnF26pYU/
        io2I31MM0LUOna2M7j88l5pDa/kl9fadgByT2g+LsYOKvvcFitJy7ZuduItZrLJLN+TEsikWUEJ
        JOezuWquj18UgYzb9cSpOwnJC5/brZFoxJYw0zNtSz23X1X7GWG6MVsSgqm2sdQSDJBC1Rq6C
X-Google-Smtp-Source: APXvYqzDzUnddMlA2HmHuASkFE+Hd+ndINKTq0LdVOzM/cCB7SkENxkteloHoL8eP1x5Fx30zSNXST+8C7sY
X-Received: by 2002:a25:248b:: with SMTP id k133mr5362637ybk.79.1551984758025;
 Thu, 07 Mar 2019 10:52:38 -0800 (PST)
Date:   Thu,  7 Mar 2019 10:52:33 -0800
Message-Id: <20190307185233.225521-1-eranian@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
Subject: [PATCH] perf/core: restore mmap record type correctly
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, kan.liang@intel.com, peterz@infradead.org,
        mingo@elte.hu, acme@redhat.com, jolsa@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On mmap(), perf_events generates a RECORD_MMAP record and then checks
which events are interested in this record. There are currently 2 versions
of mmap records: RECORD_MMAP and RECORD_MMAP2. MMAP2 is larger. The event
configuration controls which version the user level tool accepts. If the
event->attr.mmap2=1 field then MMAP2 record is returned. The
perf_event_mmap_output() takes care of this. It checks attr->mmap2 and corrects
the record fields before putting it in the sampling buffer of the event.
At the end the function restores the modified MMAP record fields.

The problem is that the function restores the size but not the
type. Thus, if a subsequent event only accepts MMAP type, then it would
instead receive an MMAP2 record with a size of MMAP record.

This patch fixes the problem by restoring the record type on exit.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 kernel/events/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5f59d848171e..f170cd12beed 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7188,6 +7188,7 @@ static void perf_event_mmap_output(struct perf_event *event,
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
 	int size = mmap_event->event_id.header.size;
+	u32 type = mmap_event->event_id.header.type;
 	int ret;
 
 	if (!perf_event_mmap_match(event, data))
@@ -7231,6 +7232,7 @@ static void perf_event_mmap_output(struct perf_event *event,
 	perf_output_end(&handle);
 out:
 	mmap_event->event_id.header.size = size;
+	mmap_event->event_id.header.type = type;
 }
 
 static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
-- 
2.21.0.360.g471c308f928-goog

