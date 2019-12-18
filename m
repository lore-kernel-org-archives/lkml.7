Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F86BC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 04:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC1B120715
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 04:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UL0PfpNM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfLREkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 23:40:18 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46371 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLREkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 23:40:18 -0500
Received: by mail-pg1-f196.google.com with SMTP id z124so528672pgb.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 20:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HQJWlXLG6wIwMc0aEcbqaUZ0sC986f7UTtyRAVS20kc=;
        b=UL0PfpNM1vMMyCDUHBSnIFUHHrh3Vn6JWSKqsuKHxs34u58j2OEtg87+kqO/Fb0rNh
         NPFKLSPkfBl0slk9ERABT+HIp+YdWrEgxoroON1zDP/qhCOhurrsNhaL2isRr3rSJqj/
         Mpi2hqGwLa88m2W8+iX8YoOAJu7Pv0sPPdISUvl7y+0BNwfbydadsDOcLHEuwk28OwC4
         Lv2GbBcl1EGV5GvvXJQVWlMQKIrfRmFUJ0IciOmvObSVcO7BxFAGQLTeCfvVJIqa7oFr
         Lmo0wGhulCkYiVAjcLUcQfO6QwepXR8rks5XeNepM0CSJjFjWqCQYqW670YjSvNj1mlQ
         PVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HQJWlXLG6wIwMc0aEcbqaUZ0sC986f7UTtyRAVS20kc=;
        b=udXacIclLVwjF0T/HqShY2PoBjO6al5tgbC4tHx7DBQ0+iHkJ6P+ksgB5qr9js0JAt
         BPYH1Go47nImxuIeeYLRnGII+PzvuTGhg37Zv+/ury8XdzNFroQ11eEjcrQVjkUwPneV
         kzvf4GoprykJ5ZSh7FFoGJadZaC/46y+SrE/yJ4LCjQOOJqpTd8Nf89bG7G3JjGsN/PR
         QO4sZ1cDeRSvDbN6uzrKoQ3weFc+v6Je34fS+aJ5gs+gcg6kf2/xjQLuyxhXKVCqBZ9s
         znShDlHn38aGRRhUn8jrn0RJx4+ptYoBsqpEU41P0WZNU3NkydycMOzKzya5uy74l3Oo
         kq/A==
X-Gm-Message-State: APjAAAVvGEg+JX1JKIUPjkEjyS0MMFuBB0qE1zHNgu3HC7QC83UKn1Qa
        YJd50jmW10FAbz+6srPpdQDVhZ0q0so=
X-Google-Smtp-Source: APXvYqx4iNPHn22Lr5oaFHZmr8Lnu+1lktiB7oRLjpeOEOd9kUF651mdDGt88/A5DCgd46IlHm3fVQ==
X-Received: by 2002:a63:f202:: with SMTP id v2mr679275pgh.420.1576644017839;
        Tue, 17 Dec 2019 20:40:17 -0800 (PST)
Received: from tw-172-25-31-76.office.twttr.net ([8.25.197.24])
        by smtp.gmail.com with ESMTPSA id j21sm781105pfe.175.2019.12.17.20.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 20:40:17 -0800 (PST)
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     iommu@lists.linux-foundation.org
Cc:     robin.murphy@arm.com, linux-kernel@vger.kernel.org,
        joro@8bytes.org, Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch v3 0/3] iommu: reduce spinlock contention on fast path
Date:   Tue, 17 Dec 2019 20:39:48 -0800
Message-Id: <20191218043951.10534-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset contains three small optimizations for the global spinlock
contention in IOVA cache. Our memcache perf test shows this reduced its
p999 latency down by 45% on AMD when IOMMU is enabled.

(Resending v3 on Joerg's request.)

Cong Wang (3):
  iommu: avoid unnecessary magazine allocations
  iommu: optimize iova_magazine_free_pfns()
  iommu: avoid taking iova_rbtree_lock twice

---
v3: improve changelog, no code change
v2: fix a memory leak

 drivers/iommu/iova.c | 75 ++++++++++++++++++++++++++------------------
 1 file changed, 45 insertions(+), 30 deletions(-)

-- 
2.21.0

