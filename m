Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B545C31E54
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 08:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10AB820848
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 08:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQ+sGkca"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbfFQIv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 04:51:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40258 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbfFQIvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 04:51:24 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so775219pgj.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 01:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gCvopVOfobmQuesAHChPgfYpOIfGb/WLFM1WRDKCe3s=;
        b=TQ+sGkcajXwECm/kdggg7cStsdl/xrIv8JRcqDarn1eaKV7HpTpxHzFzmPiIO2veOO
         NmpbhXs8RgDzXFSLCanM9x0sn56F6UQVYzSYsvB88xIbnF6xNaYVN35CkuTkAwv6n7pO
         xlu5R0Gek1L3rI1EDkXJ5jxpl6GjWfKyf5H2zX0f8p5/gIj388t9qbiQSldmzqNLir3S
         RFKt8jwMNaOq5RK1kXkiKeb7nbbttkg0NiAdQ9NiR+WRljT7VHaQ4pMslTPu4rawhAq0
         b1flMfAfDPePnHunFaWJYDrf31uZBnto1a44HkHR4QonqpMRJ9gJK9c1y3yWNQDTPQfB
         jtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=gCvopVOfobmQuesAHChPgfYpOIfGb/WLFM1WRDKCe3s=;
        b=jXXvWs01AWqyyp6SmayZen/AaanjMvaPFD7A9ysNw5O/mzJdKyJLIm+HktR3BTzvk7
         Sg2iMsq6PxZ2/wB2shgov7U0dpXEg7eUntxjB4dkfWAYd9m2V7apxj9IJCVnAnLGx2Rb
         snTyAGZpe8Pcteje78Zw/Zpq9irOc7qSVEGGDz5hgWcr9z+uS0SmeD4/JzBFDp9EKcEE
         SiiDPtqJ3wYsKPPLihq138BCKX6JW3fbdvrqTa/5PZow6UqMLwalGL01EksQuSsuRZwE
         +TDrTGTxXU5P5xqGhu8Snve0Ik1p7W4J9U0H5d2ovuMQBf5dHFGndReWG2fkdbFpijoj
         Ie1w==
X-Gm-Message-State: APjAAAXjd6k2wi5nmlG+oiGFd02mNqWMFwv4CQhRQZo/8SGf8mBZxL5e
        j/RTZb64mMWJcWqSoLUHjA==
X-Google-Smtp-Source: APXvYqxZ6jAOFq1a/yScy7F54rqF0AQdZ/ngI0YkSFJy9ic4uyu+tAExO1MnqQLZocW0LQnt2P4/jA==
X-Received: by 2002:a17:90a:be0a:: with SMTP id a10mr23682369pjs.112.1560761484028;
        Mon, 17 Jun 2019 01:51:24 -0700 (PDT)
Received: from www9186uo.sakura.ne.jp (www9186uo.sakura.ne.jp. [153.121.56.200])
        by smtp.gmail.com with ESMTPSA id d4sm9443514pju.19.2019.06.17.01.51.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 01:51:23 -0700 (PDT)
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        xishi.qiuxishi@alibaba-inc.com,
        "Chen, Jerry T" <jerry.t.chen@intel.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v3 1/2] mm: soft-offline: return -EBUSY if set_hwpoison_free_buddy_page() fails
Date:   Mon, 17 Jun 2019 17:51:15 +0900
Message-Id: <1560761476-4651-2-git-send-email-n-horiguchi@ah.jp.nec.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1560761476-4651-1-git-send-email-n-horiguchi@ah.jp.nec.com>
References: <1560761476-4651-1-git-send-email-n-horiguchi@ah.jp.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pass/fail of soft offline should be judged by checking whether the
raw error page was finally contained or not (i.e. the result of
set_hwpoison_free_buddy_page()), but current code do not work like that.
So this patch is suggesting to fix it.

Without this fix, there are cases where madvise(MADV_SOFT_OFFLINE) may
not offline the original page and will not return an error.  It might
lead us to misjudge the test result when set_hwpoison_free_buddy_page()
actually fails.

Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Fixes: 6bc9b56433b76 ("mm: fix race on soft-offlining")
Cc: <stable@vger.kernel.org> # v4.19+
---
ChangeLog v2->v3:
- update patch description to clarify user visible change
---
 mm/memory-failure.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git v5.2-rc4/mm/memory-failure.c v5.2-rc4_patched/mm/memory-failure.c
index 8da0334..8ee7b16 100644
--- v5.2-rc4/mm/memory-failure.c
+++ v5.2-rc4_patched/mm/memory-failure.c
@@ -1730,6 +1730,8 @@ static int soft_offline_huge_page(struct page *page, int flags)
 		if (!ret) {
 			if (set_hwpoison_free_buddy_page(page))
 				num_poisoned_pages_inc();
+			else
+				ret = -EBUSY;
 		}
 	}
 	return ret;
-- 
2.7.0

