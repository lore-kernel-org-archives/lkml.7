Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EB8C00319
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC0D218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551320329;
	bh=zPzb8lxItVqpsAFAF4LTqHRXyeDNIke4HMCdh1+UoSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RLQL4/ssCDHBskhtMSlL95gWZFi5lI6yF24bZUmQtrQphT0wqIIEBFwgme7s7/9sj
	 sFDfclCqjLmcT4oUgCBxqyUvFaqr31g3wlDnrdd6CxzYCNu5COR1pSJE1pqJozta8r
	 zd1nWXNwP7vAs24ZZetie/Kj9KvPE+eW4firbbcQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730690AbfB1CSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 21:18:48 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38889 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730240AbfB1CSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 21:18:46 -0500
Received: by mail-qk1-f195.google.com with SMTP id p15so11197817qkl.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 18:18:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ap32u9J2DjTEbnwK8tlI9EaVEAe0C092XmNehyAz4/8=;
        b=mEN4Let3Sqv0iA2JQoTjWRD0GB3konoMXmp7SoD3K4dPkHDnEQ2ugfw3gYe3vVzMGF
         i/Tbn/ShRkmoW2x/u+ekwhKrcTbqq9WkmBjkg6lkdRFrV3q6g+1eHs71tTvkKTkVxpFo
         ZIfD/Ry0UtfEGs4RHDMJ+ECmsfeELBGoBZ+xPfczcG8S8513P5qpLPopV5/m6ssnSk8E
         gLRDDxPmSWxSD7LaNRwWTn5gH5ZjTyLMqrKAeXK3V7wyFM+dTT3uO9ODs7S96SwngEvE
         wLYrQSUsuW8hYgdllMLr8JMYxYd9ulGGD2y6M3yrRbdxDGQpTk2HGo+SMQMZJYm0VHMS
         uuJg==
X-Gm-Message-State: AHQUAuY3vNAHhQ9RrAxMjc2h5kLdbCwpNWEgQnyO4k3EtbrJr9gmZPJH
        XEB1stSPvny27LRwG6IPTYv9uCLkc9E=
X-Google-Smtp-Source: AHgI3Ib9npUsIiyGRCnSbW0Gjjezvhtl8EJKNhNK6/9zB6/aj4x+e7X7Rv/8FH7Vb9liQTh/0R1Mrw==
X-Received: by 2002:a37:61d3:: with SMTP id v202mr4658157qkb.217.1551320325029;
        Wed, 27 Feb 2019 18:18:45 -0800 (PST)
Received: from localhost.localdomain (cpe-98-13-254-243.nyc.res.rr.com. [98.13.254.243])
        by smtp.gmail.com with ESMTPSA id y21sm12048357qth.90.2019.02.27.18.18.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Feb 2019 18:18:43 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>
Cc:     Vlad Buslov <vladbu@mellanox.com>, kernel-team@fb.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] percpu: update free path with correct new free region
Date:   Wed, 27 Feb 2019 21:18:28 -0500
Message-Id: <20190228021839.55779-2-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20190228021839.55779-1-dennis@kernel.org>
References: <20190228021839.55779-1-dennis@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When updating the chunk's contig_hint on the free path of a hint that
does not touch the page boundaries, it was incorrectly using the
starting offset of the free region and the block's contig_hint. This
could lead to incorrect assumptions about fit given a size and better
alignment of the start. Fix this by using (end - start) as this is only
called when updating a hint within a block.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 mm/percpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index db86282fd024..53bd79a617b1 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -871,7 +871,7 @@ static void pcpu_block_update_hint_free(struct pcpu_chunk *chunk, int bit_off,
 		pcpu_chunk_refresh_hint(chunk);
 	else
 		pcpu_chunk_update(chunk, pcpu_block_off_to_off(s_index, start),
-				  s_block->contig_hint);
+				  end - start);
 }
 
 /**
-- 
2.17.1

