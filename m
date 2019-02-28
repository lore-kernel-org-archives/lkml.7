Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5693C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC97218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551320380;
	bh=/cdccYebZC2a0wqaG1pVg17LWvTluClQSZnoKRycCbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0jDZLKWG7WgHtAOO1uyi1y3y8QdT0lbk7UuOsjjwKAntNYkXxB+FEkxnygsp/zdwQ
	 yAGm+46S9ljyl50uf7b0SFqP2B3pyQsYMq0kWKOjQXRwEtof9Wn9Fw7mgEr20FE2p5
	 XUbA+uQsoJpPxTfH+BsK3WLtwaXkQsULBtgwspqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730928AbfB1CTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 21:19:39 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34364 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730702AbfB1CSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 21:18:50 -0500
Received: by mail-qk1-f193.google.com with SMTP id a15so11200201qkc.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 18:18:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k81wrdCLr8miUfd7ykySbkmm4/3UN7J8vKeD0uvtXrQ=;
        b=neDVS6yrDPB95YIXBwB/MdKL6Uosxp/tEiJbT2erCLFTWS6uu8TZ0WawRvr5NxuV2y
         kFIvUcdzCYiVuhUxxJKe+6pC27pfS+Gn5y9J/QGpZeGNaM87PgJ0VdtuPtE86V+uvTEC
         th4eH3edW+bKVmXjVEaGK/+zVZ1pvz7ltLxVdZdxZQltWyw4Db+zmq1E6K65inhRL8HX
         ebma8y+50kQ7VtkrAAo0wjLBcKfbCoOzoo0fFY/WXkixwpW9LRu3nAefPgfttyXCtlEn
         4O/CROomykXmlHPSCDCzcjYhD5eNY9vDyqVXyt+HEQ10Z/AyX7WvvW0mtxWWyPLuCkK+
         r0hw==
X-Gm-Message-State: APjAAAVmFFPAtJG6yGqf4Z1P/L5NIJzbRsm4iRvnsQ3fRNeEh7To79Ba
        Qz2KZlDfjRkd3Yr3jMArX7Y=
X-Google-Smtp-Source: AHgI3IaWHXCkHr163XI+GDm51zWvCsu6nT3A6974OMkRlq4SeFTjwbzw7uDMT4aauozctk1ouUES3A==
X-Received: by 2002:a37:e40f:: with SMTP id y15mr4725411qkf.230.1551320329706;
        Wed, 27 Feb 2019 18:18:49 -0800 (PST)
Received: from localhost.localdomain (cpe-98-13-254-243.nyc.res.rr.com. [98.13.254.243])
        by smtp.gmail.com with ESMTPSA id y21sm12048357qth.90.2019.02.27.18.18.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Feb 2019 18:18:48 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>
Cc:     Vlad Buslov <vladbu@mellanox.com>, kernel-team@fb.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/12] percpu: manage chunks based on contig_bits instead of free_bytes
Date:   Wed, 27 Feb 2019 21:18:31 -0500
Message-Id: <20190228021839.55779-5-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20190228021839.55779-1-dennis@kernel.org>
References: <20190228021839.55779-1-dennis@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a chunk becomes fragmented, it can end up having a large number of
small allocation areas free. The free_bytes sorting of chunks leads to
unnecessary checking of chunks that cannot satisfy the allocation.
Switch to contig_bits sorting to prevent scanning chunks that may not be
able to service the allocation request.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 mm/percpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index b40112b2fc59..c996bcffbb2a 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -234,7 +234,7 @@ static int pcpu_chunk_slot(const struct pcpu_chunk *chunk)
 	if (chunk->free_bytes < PCPU_MIN_ALLOC_SIZE || chunk->contig_bits == 0)
 		return 0;
 
-	return pcpu_size_to_slot(chunk->free_bytes);
+	return pcpu_size_to_slot(chunk->contig_bits * PCPU_MIN_ALLOC_SIZE);
 }
 
 /* set the pointer to a chunk in a page struct */
-- 
2.17.1

