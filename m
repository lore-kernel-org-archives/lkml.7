Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BF3C00319
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB5072083D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551320334;
	bh=1D2IZvr+/oZpgshFUyMiqbOkV+uoRs2Dd+B6ryYb6ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KBg/khVsT3TnJgaOZmjPocQvwivyDhmuYkQY+QkJv2TBF4lquUll5CTmEXVn+NcL1
	 aGv6dquQ1Z6WdX85wsNIzMV8ShKuJBNBNGQdFhS2cl2LaM0fH0ZQdVCs+Y19SHiQtm
	 6hV/8ADfU7pEsDSZtpED/V0Vj0cWsOBE+OarLXKM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730739AbfB1CSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 21:18:53 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33400 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730650AbfB1CSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 21:18:47 -0500
Received: by mail-qt1-f196.google.com with SMTP id z39so21859477qtz.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 18:18:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Vx2VZtOceXx/muNOFvOTUbvq8L4C1gUYQ/k1Qg6oF3M=;
        b=OA5NtGaAi7smxl+1bCpRBD/mHts2jQtSFn86yvnDeeVfTAgwbbwf0MZSgWh1e9AY5L
         rxRllJ2cbPvqSOkTii1Kjju/O8IU26h8Dsn6NaIyLCC7ZE8z+rjAG0+lEQbRZE/ZzwgU
         fKrAGWCndHkHovgDmthAGlHKpqdDp6WZnYGThKnoXFP/+Va+bxNc47UdSu971HTyEU6E
         nKEVXo0kh1dNVF1/scSM44EC7sO9cgyJVN/jFYCZehn7ej3ZHrAvxsZFyTuiSKIZWxXJ
         UM6kkKEj8x6cA4yt9C2ifStNI97qxX71Xe/DhwsO8OBfiQnuU1sPDx6N4Gz6fZ4SbYpx
         7ZJQ==
X-Gm-Message-State: APjAAAUwK/QTZiSQGYWyAbj3sUUa8fS85HMBtOKO+yu4HjPcYfl1dwVa
        IZirbDWOOzLMUnx1hZRJEjab61Qx3tY=
X-Google-Smtp-Source: APXvYqxT0Zazm3tmjv5xoUKZeesy8YEfKuPUZhr6x6oWUxafL1uMoGMXcNEnHEANX5YFiSEYe6MK5A==
X-Received: by 2002:a0c:b311:: with SMTP id s17mr4441198qve.69.1551320326433;
        Wed, 27 Feb 2019 18:18:46 -0800 (PST)
Received: from localhost.localdomain (cpe-98-13-254-243.nyc.res.rr.com. [98.13.254.243])
        by smtp.gmail.com with ESMTPSA id y21sm12048357qth.90.2019.02.27.18.18.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Feb 2019 18:18:45 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>
Cc:     Vlad Buslov <vladbu@mellanox.com>, kernel-team@fb.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/12] percpu: do not search past bitmap when allocating an area
Date:   Wed, 27 Feb 2019 21:18:29 -0500
Message-Id: <20190228021839.55779-3-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20190228021839.55779-1-dennis@kernel.org>
References: <20190228021839.55779-1-dennis@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pcpu_find_block_fit() guarantees that a fit is found within
PCPU_BITMAP_BLOCK_BITS. Iteration is used to determine the first fit as
it compares against the block's contig_hint. This can lead to
incorrectly scanning past the end of the bitmap. The behavior was okay
given the check after for bit_off >= end and the correctness of the
hints from pcpu_find_block_fit().

This patch fixes this by bounding the end offset by the number of bits
in a chunk.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 mm/percpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 53bd79a617b1..69ca51d238b5 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -988,7 +988,8 @@ static int pcpu_alloc_area(struct pcpu_chunk *chunk, int alloc_bits,
 	/*
 	 * Search to find a fit.
 	 */
-	end = start + alloc_bits + PCPU_BITMAP_BLOCK_BITS;
+	end = min_t(int, start + alloc_bits + PCPU_BITMAP_BLOCK_BITS,
+		    pcpu_chunk_map_bits(chunk));
 	bit_off = bitmap_find_next_zero_area(chunk->alloc_map, end, start,
 					     alloc_bits, align_mask);
 	if (bit_off >= end)
-- 
2.17.1

