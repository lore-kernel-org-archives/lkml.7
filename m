Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A81C11FF4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 20:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCAEE20673
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 20:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="oWTaiXQU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502692AbfIWUes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 16:34:48 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35517 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502659AbfIWUep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 16:34:45 -0400
Received: by mail-pl1-f195.google.com with SMTP id y10so5697514plp.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 13:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4PNhEWMnxTPqUB+Gwx2nqJhU+kkzlGq5UWgg81CPAOk=;
        b=oWTaiXQUOW/n+bZ3aNPNA4OtwzBJkIcKJ7w8UHidzdwXhLyBh7H6XeCFOH4hrLa0TF
         5tO48HD+yimpY3hC6jgRBluPwrr5tgxt77/q6RSoQIg8t/tRCWOU6l8oYNCNvsXRKB4D
         Z8cHhyCyQ6gPEYAU2u5cdpMqDzvOZEnFOvri1Ewy4jmdOYjAh+x8UWdyU39v2SL5rPSV
         K4dkoFFYKtiBQ1BjRZfz7omkXdFczekyPXcpEcNWyxECRtdRYNCDtUFUDOsq8wHx+W9f
         xkjwmwwuLO8WLQ/ZZtLJsCija11LteHo6qyLnvLelyuoP2vORsoEtQA4U9vpzDPIcO1V
         1N7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4PNhEWMnxTPqUB+Gwx2nqJhU+kkzlGq5UWgg81CPAOk=;
        b=qRjJyQiQ+ELO06MoBRYfQn/pYy9TW8fEF/iS3GdNq6ckpomRmNXQ4M/HBPjnJV3CqK
         01MbPGNh5RJSsrcVzpr8uxK/fRrrs6kPFjIqfFqATI3mFz6uuJaVQfMqmPzgR6NyD+Gq
         6O7LOwwFYrqn1zIICuJcea2EnzhupphRCKJjuVQ1WHs+AZ+bwp7neCVRfPUVhlD67Ppw
         wrnT4nSg/bsR337AF1FNcnepOQjN36fwhOUwu9ZEJLw5KsiUQC3ONQmSOuzSZNpQ6Xoz
         2W+MB1vod71WQj5BfsTmHr2kLsscgCHGEwIy1YBvZmdo6y8zawIcoKMX5GP5YViMgrc7
         7P2Q==
X-Gm-Message-State: APjAAAVWgr8sCF3XJV3HTTjvbWbV3p3K4EHTH0fj69RgG9ANSB+BuKDP
        xtkYgnb35kzFD5Zrt7TzsC+wqA==
X-Google-Smtp-Source: APXvYqzyh38AtgfcuB6R0U6M0N80Ipw7rS/QgbnW4pA75DgBWBEPXi74l8ts5ld5MRP7duUrSaZIBA==
X-Received: by 2002:a17:902:8492:: with SMTP id c18mr1658221plo.279.1569270884919;
        Mon, 23 Sep 2019 13:34:44 -0700 (PDT)
Received: from xakep.corp.microsoft.com (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id n29sm12798676pgm.4.2019.09.23.13.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 13:34:44 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com
Subject: [PATCH v5 03/17] arm64: hibernate: check pgd table allocation
Date:   Mon, 23 Sep 2019 16:34:13 -0400
Message-Id: <20190923203427.294286-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190923203427.294286-1-pasha.tatashin@soleen.com>
References: <20190923203427.294286-1-pasha.tatashin@soleen.com>
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
index d52f69462c8f..ef46ce66d7e8 100644
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

