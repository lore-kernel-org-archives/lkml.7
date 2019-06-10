Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BDFC468BC
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5136120861
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pLBa7uRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388486AbfFJISP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 04:18:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33901 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387825AbfFJISO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 04:18:14 -0400
Received: by mail-pf1-f193.google.com with SMTP id c85so4855768pfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 01:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iNQfPT8546HoVkc+KeLP46IyhzvKWlvUhgKz4CHOiq0=;
        b=pLBa7uRDTt0HdEaYhnYCGSSTqtbJsyUhgLj8rV/meDyKT5l/ANlgcsuaRyq+FctOQf
         vkXat1v915SvluefadfC0+/69wDlPeCKFMr66nOIB16yBNiCTZ9ZkPnqQE72DYrnaiZx
         uO5c2UjNqZ0AZe5bRPEDXi1mD0w/CJAqTd3ILvW8pRQerE24TWmgD44ibnkHFfHh1KUR
         sq8EGVbycsowcgqaGIm5SA1Qp590Zngp60DuLdiL6sM9xpgGYTLLomAvRmuZtru5HimQ
         xa3C7vTR/VPjP5Q7sGP+JpRb92qTWbKI7j+9OgCx3/mMwZ42CUUSXoGmVUrVC35CiOi5
         pMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=iNQfPT8546HoVkc+KeLP46IyhzvKWlvUhgKz4CHOiq0=;
        b=OHdICpeIgT5ACejKMVQCkwxogXLm3ofmbFVuHMPLoI7OxV5nhKnhY19oAjLV63HHe/
         Hb5DnWozzNtSxPOJ0or90EzEftJ39cvCUGUCKYZ7OZYAS7goNcLPc4x4+IjyhaXzXbId
         PE9GM02B5cApr6UNVIcMdx6ELU0DU2Nnu8D7mkQ2xI1TKH85fK7gC+9DDBeou4b88i43
         cwOS7sKpytGCkkMAEQTqTS4Ugw4L55nNDUa8bTEgCgwdLOou0+N4yFkix3hx6iJzrDwo
         FIzYi27mH76v3ZDv6faDK4KDp+AfpYYWv8BnZF5vm5WRoU1rgYr45t9toXp3HWRUMaIC
         f58w==
X-Gm-Message-State: APjAAAWOiyrSZAGDmTQH5rGcMDQky7jAsD2BTAC8scNk3GWt7/BXYHKQ
        /rDRo3yEWZkVQp6dK/1jAg==
X-Google-Smtp-Source: APXvYqyjElRHo3flIjclpuZdAQgPxpO6E2MkKHQy57sQhuXnYK2eV1rHFs0k7t0O5S4l+S8Nflykag==
X-Received: by 2002:a17:90a:b115:: with SMTP id z21mr19917631pjq.64.1560154693464;
        Mon, 10 Jun 2019 01:18:13 -0700 (PDT)
Received: from www9186uo.sakura.ne.jp (www9186uo.sakura.ne.jp. [153.121.56.200])
        by smtp.gmail.com with ESMTPSA id j7sm9525014pfa.184.2019.06.10.01.18.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 01:18:12 -0700 (PDT)
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        xishi.qiuxishi@alibaba-inc.com,
        "Chen, Jerry T" <jerry.t.chen@intel.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] mm: soft-offline: return -EBUSY if set_hwpoison_free_buddy_page() fails
Date:   Mon, 10 Jun 2019 17:18:05 +0900
Message-Id: <1560154686-18497-2-git-send-email-n-horiguchi@ah.jp.nec.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1560154686-18497-1-git-send-email-n-horiguchi@ah.jp.nec.com>
References: <1560154686-18497-1-git-send-email-n-horiguchi@ah.jp.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pass/fail of soft offline should be judged by checking whether the
raw error page was finally contained or not (i.e. the result of
set_hwpoison_free_buddy_page()), but current code do not work like that.
So this patch is suggesting to fix it.

Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Fixes: 6bc9b56433b76 ("mm: fix race on soft-offlining")
Cc: <stable@vger.kernel.org> # v4.19+
---
 mm/memory-failure.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git v5.2-rc3/mm/memory-failure.c v5.2-rc3_patched/mm/memory-failure.c
index fc8b517..7ea485e 100644
--- v5.2-rc3/mm/memory-failure.c
+++ v5.2-rc3_patched/mm/memory-failure.c
@@ -1733,6 +1733,8 @@ static int soft_offline_huge_page(struct page *page, int flags)
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

