Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D43C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CDEB264AA
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559285017;
	bh=7zR8n1JbSVJUiI7Y7JiZtIN7nub17NR1Pt+r50gzmCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0tDabBQE2EOZ6WVX9y4lHMFGs/YRtjZXx5RR0zCl5y+vP7aNvo/qIn3bXC4UWYk9k
	 oC+djFbTcPK0RtcOuodIM47v6NOBGTStPWltktxhH2IRLUbFk6yct9A3H3FPHnyg2o
	 TAhjEa/kvVrSV5zaNTpYpTC29sMUTbHZs9vQgfA8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfEaGng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 02:43:36 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45928 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfEaGng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 02:43:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id s11so5554348pfm.12;
        Thu, 30 May 2019 23:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7TXnJy3Wfu+ssJbkFIL06uViagM5VHDrErGSsKQYVSM=;
        b=YldrKVod3fVxNE60xQH2FBlSIRGcgnrEfJznpoRGFPlLTUui7kco8qaCVZtwA3bhxO
         hYV6qOtRKs9DEjdJuliqY1VcGmVNtDxRdK3B4xfQGI0oJHOdJIJHCnJRJKytoVYAyyqI
         pHPY1gaRCvxI7NnRrA1M3nQrDQqq/tdtwfsHpAg13+jhdHUbav7ntbJqZmk0XdHVZ657
         IAZ///cK1ZIILA1FYIIgdbVxUjBMd2zdujzy670NcJaHVlV2wlDGSYqZobqs/HEZZQTP
         iTASK90nsU/RVTkuQLt60xo5Xe29JCIA4qY6Oh/8/+p8Sh/PeL/kKnmcVQk25QOJ7eY8
         D7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=7TXnJy3Wfu+ssJbkFIL06uViagM5VHDrErGSsKQYVSM=;
        b=K1+drYy/DdxbR/Lr7vwtw9DMTlSxgfIqUCFB/bIfWL21Sj7b14Riim2T9OBjHOJ6i9
         6RslTH53HrKQFpkaQU/AQJyzZ0W/LfESEoviD1molTy8j+JJFQ6ycz1VbZ9s12I4LFHE
         AHcw7FX/cdbRdc8+kXm3btpoB32a00LvEcZ1BU5hIh1VGwDh8/M9XUssh1XCt3lxqd/8
         m3V7iFHee+nD8+wWRPdxsd/Hm7oKjZXEQDGI8U1vJLAr0oSqaP+gEHRI6CNETelTknos
         vmdFqX41Ckbdakvtpw/kpAH7Ty5C8b7jGC3dWzGkos/q9jzeGI6drljeYQmyFtWh1QUL
         IKgw==
X-Gm-Message-State: APjAAAUdDvGUC71Z3O5nslRq7z/q6e7fIwCrQ29jw/bAw0QP0iEUrAwq
        jIHxE3nOvR63PNkys8Dmi8k=
X-Google-Smtp-Source: APXvYqzM1347jezqrPNnjPMerTz/Z/t9a00AGumOLAAOkc1KTRjEfpypi+voz0AAAFuUr2Q0lFTnCA==
X-Received: by 2002:a17:90a:af8e:: with SMTP id w14mr7384065pjq.89.1559285015283;
        Thu, 30 May 2019 23:43:35 -0700 (PDT)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id f30sm4243340pjg.13.2019.05.30.23.43.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 23:43:34 -0700 (PDT)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, jannh@google.com,
        oleg@redhat.com, christian@brauner.io, oleksandr@redhat.com,
        hdanton@sina.com, Minchan Kim <minchan@kernel.org>
Subject: [RFCv2 2/6] mm: change PAGEREF_RECLAIM_CLEAN with PAGE_REFRECLAIM
Date:   Fri, 31 May 2019 15:43:09 +0900
Message-Id: <20190531064313.193437-3-minchan@kernel.org>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
In-Reply-To: <20190531064313.193437-1-minchan@kernel.org>
References: <20190531064313.193437-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The local variable references in shrink_page_list is PAGEREF_RECLAIM_CLEAN
as default. It is for preventing to reclaim dirty pages when CMA try to
migrate pages. Strictly speaking, we don't need it because CMA didn't allow
to write out by .may_writepage = 0 in reclaim_clean_pages_from_list.

Moreover, it has a problem to prevent anonymous pages's swap out even
though force_reclaim = true in shrink_page_list on upcoming patch.
So this patch makes references's default value to PAGEREF_RECLAIM and
rename force_reclaim with ignore_references to make it more clear.

This is a preparatory work for next patch.

* RFCv1
 * use ignore_referecnes as parameter name - hannes

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/vmscan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 84dcb651d05c..0973a46a0472 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1102,7 +1102,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 				      struct scan_control *sc,
 				      enum ttu_flags ttu_flags,
 				      struct reclaim_stat *stat,
-				      bool force_reclaim)
+				      bool ignore_references)
 {
 	LIST_HEAD(ret_pages);
 	LIST_HEAD(free_pages);
@@ -1116,7 +1116,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 		struct address_space *mapping;
 		struct page *page;
 		int may_enter_fs;
-		enum page_references references = PAGEREF_RECLAIM_CLEAN;
+		enum page_references references = PAGEREF_RECLAIM;
 		bool dirty, writeback;
 		unsigned int nr_pages;
 
@@ -1247,7 +1247,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 			}
 		}
 
-		if (!force_reclaim)
+		if (!ignore_references)
 			references = page_check_references(page, sc);
 
 		switch (references) {
-- 
2.22.0.rc1.257.g3120a18244-goog

