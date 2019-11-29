Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2105DC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 00:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B342176D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 00:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJSvsdf/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfK2AtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 19:49:19 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37947 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfK2AtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 19:49:19 -0500
Received: by mail-pg1-f194.google.com with SMTP id t3so13147570pgl.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 16:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Er0BveApuGpZcCQ7MJvTFXGgSFZgN3u+8yAIisXO87k=;
        b=KJSvsdf/0VvkENZRJVgDMQrRC+eIsYDs5/nOxYRpDi/NLvNxd3TKM324hYHW/yrlWl
         4JsY9BDUGZtjvXHId+SaDNc4pVBQ+Gmi0v8mswcl6zDhYkEDK4gFRkbNwhe8SXNoe6P0
         heiQSIcALpjL3aVz1ZVdTvvsHgLrjJBOplBQXSX8BikLjuAlkLoBHcjdi49J/52uWfOs
         nXRQUCSm3c4BXU+7SRY8pL1rGg3zxcayX1oxs8KRnBF/yROeKJVHEP/xkPRA4LihuRkY
         aCeWiHbhJuG1ZfEw84K4aHjUwVmDQ8VToBfJ87kQROx4bgG7/ouUjJjuSzVYHzqiXO8h
         88JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Er0BveApuGpZcCQ7MJvTFXGgSFZgN3u+8yAIisXO87k=;
        b=GR4ldHIoSRL4Waw1RKfFpaMHos4gQr+z371nqzvjadgQDZQ2TcWeVrTse5ff4pQ9Fk
         uapoZGp/Tnl29cqdSUzFfdNOjwTF4BlvLfuyKprtGYa/j5Oa3CYVu04ISkFgZ21mTUUK
         XQQ0PSwKhbGymxlUMeK5hLAjzYHioR/z8KkK/N+GLzd6kWuetyUmZP6T7+SHeKwvOiYn
         WyG0NtnwO+u4jUpd5VAYivd0SZZxzDn7sz21Vbog1P8maGBd4Druc7Xld5AoQ7CB4INT
         l6bHQj0sa3WFaGx3ho2rcti494iEOHtH5Bdu0z62nnEFFSSZtDjezL1xLl/Vk1tbmaBR
         iKqA==
X-Gm-Message-State: APjAAAWHInoxd7YdKngwDgR5waeFupdGLCk7cOUfk/aBxgeJ9TsKp02e
        Dhm3KZOcdFx3UudmG0rKwFM=
X-Google-Smtp-Source: APXvYqyApdPpftN+vV2nvmBBowUli4X7V/J8sYEkkUmC4LcmBfkr4EU4ECpWEHmh1EQEAxffn9W5nQ==
X-Received: by 2002:a63:334f:: with SMTP id z76mr13701756pgz.277.1574988558791;
        Thu, 28 Nov 2019 16:49:18 -0800 (PST)
Received: from tw-172-25-31-76.office.twttr.net ([8.25.197.24])
        by smtp.gmail.com with ESMTPSA id 64sm22418202pfe.147.2019.11.28.16.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 16:49:18 -0800 (PST)
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, joro@8bytes.org,
        Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch v2 0/3] iommu: reduce spinlock contention on fast path
Date:   Thu, 28 Nov 2019 16:48:52 -0800
Message-Id: <20191129004855.18506-1-xiyou.wangcong@gmail.com>
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

Cong Wang (3):
  iommu: match the original algorithm
  iommu: optimize iova_magazine_free_pfns()
  iommu: avoid taking iova_rbtree_lock twice

---
 drivers/iommu/iova.c | 75 ++++++++++++++++++++++++++------------------
 1 file changed, 45 insertions(+), 30 deletions(-)

-- 
2.21.0

