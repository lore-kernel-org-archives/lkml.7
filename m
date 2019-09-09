Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BFFC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 18:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2181C218DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 18:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="lGvVtacz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbfIISMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 14:12:37 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39253 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405413AbfIISM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 14:12:29 -0400
Received: by mail-qt1-f193.google.com with SMTP id n7so17275942qtb.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 11:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=hIvv7JZmNGiFtMsjwPiXKldWZ14j/ed2TQl7Sv/FusU=;
        b=lGvVtaczZepcY3pVB902EwUXMLPY+wfRloMScgteToa6kMFSBvVkWpsD7vtQgvSnpb
         n/a54fuNHqwxUvxcFSzx0cdrSI3mvLlUG+wIbjNeDvCSbMpPXxVZiNC3frr/K8fEKaC5
         CexW4Wn3gLJtqbiGVGh4QhuREdkhbMZJsiQpyIH2GbgbDZWnUIFdVP9M4rfJSr+W/OqJ
         xfYnNoOEc6u+Yyu9eBmybePWEGSyM+5bPWq/2wFa59phJZztRB4Lcn61oUtH4Zxxm7uW
         hyvJXiag0PQpx5U2WS0yHf8InIp947VYjVgAUFFyWL9SJvJ/5W880Im12Kt7v3afQCVJ
         EQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hIvv7JZmNGiFtMsjwPiXKldWZ14j/ed2TQl7Sv/FusU=;
        b=Y7cjQyl7lzeBNJWllJF426WYscDCINTsZ8xigaeGkp4QbyREuScnmmZO44flnV5Cce
         qbhG2FWOKDUL/cT6iQGmJBIB0o+b3NM2Kjs10CPDtdYT7hgkVhp5R89i7bqFho8zOkhp
         P4ZiWqK7jgxI0aSF1HIJLtoeFWO7VySP9EB23zyHFL1+6NMlBwz6xTPJbRo/SbsoNes+
         3OlvJVABVZfJ5w4LzaUS7e0HjESGsJzZFNeQTdcFL6NdS9NT6d0BMTp0Q5iii9SLpIIe
         aVs9Le0z0ANUQRCijO6wzrRoeYIP+9NYoQLbUaeUaksDKFjEIh5ZvOSojjyI7BDoI4/A
         zBSA==
X-Gm-Message-State: APjAAAXeKcXa8Y7RdfX9m3eRppnTHrgf1t3BgucYB6Kj7/Gu4NL0hQzC
        PXHfbQT48x2Sz+448nPdfUjjAw==
X-Google-Smtp-Source: APXvYqzqCGrV++beTKTDQJdhdQgon7XutZsT6/j1WY0FvUCkwan7YuQ95/1EShbY3LwmpFjAnArpdw==
X-Received: by 2002:a0c:a0e6:: with SMTP id c93mr15594165qva.109.1568052748291;
        Mon, 09 Sep 2019 11:12:28 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id q8sm5611310qtj.76.2019.09.09.11.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 11:12:27 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com
Subject: [PATCH v4 03/17] arm64: hibernate: check pgd table allocation
Date:   Mon,  9 Sep 2019 14:12:07 -0400
Message-Id: <20190909181221.309510-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909181221.309510-1-pasha.tatashin@soleen.com>
References: <20190909181221.309510-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a bug in create_safe_exec_page(), when page table is allocated
it is not checked that table is allocated successfully:

But it is dereferenced in: pgd_none(READ_ONCE(*pgdp)).  Check that
allocation was successful.

Fixes: 82869ac57b5d ("arm64: kernel: Add support for hibernate/suspend-to-disk")

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/hibernate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 025221564252..227cc26720f7 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -217,6 +217,11 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	__flush_icache_range(dst, dst + length);
 
 	trans_pgd = allocator(mask);
+	if (!trans_pgd) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
 	pgdp = pgd_offset_raw(trans_pgd, dst_addr);
 	if (pgd_none(READ_ONCE(*pgdp))) {
 		pudp = allocator(mask);
-- 
2.23.0

