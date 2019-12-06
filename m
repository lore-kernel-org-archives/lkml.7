Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3511C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 21:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C782173E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 21:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgEJU+As"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfLFViu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 16:38:50 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34005 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfLFViu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 16:38:50 -0500
Received: by mail-pl1-f194.google.com with SMTP id h13so3269562plr.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 13:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZlgEGCoRBrwllaA7U2SAUVjC8HUYX60EMP5Y/3amAn0=;
        b=jgEJU+As5FSIOZlub2wjdTo8pVKmMIzTJr5KFD9NVZW/pwk10dhIFY3kkKPd4uQkFO
         K2Pqze31q2Jb6OFBkKYzHRkpGKc2zYgv86fBdP3lKy6CrfnOojTUndvbyEApTpueuk5R
         LKbZ+99rTKeaT/6kNTrom+qf0z0Av2QEHX6p6SyxL2rdjsCMLEwsn8Sn4KLopjGJz6ws
         occ+gBZw7JWqH4qyUz3ZFM+2dPMLO0rtttxR0MlqSqORqjBIy/vvqAFLfmWshGWgPlX7
         zn596lEZj6+KeNMMIMLPT9rzjagTBbwVfZm/KvV6lAFnc4D/pUjk63kJ5CTxy+X+xNtG
         Po0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZlgEGCoRBrwllaA7U2SAUVjC8HUYX60EMP5Y/3amAn0=;
        b=JjM84HjC/wgjXkkCL1LUSXrppaWJMZkuvyI7cyP1WozrHuRmyLAnZNmHv0fP2SzJ4t
         buf+Ev4OFll/tnHpGSa4IyruD9iBmv8JybzVveTKrSfbuAX8AAI/cUZ7vZuUvOi+Yf4/
         SJu7yBCORhX5ywF3X3LOrgh8GsuohFXXM/GGYDFV57np9iNEUae++r+t/wsmBr76OWLD
         XPXkddRsL5MQrVXYWJLWtcRopYCGv2CVdeVl8Hmzp8THVTJEAxrahmvVWBevW9u13lGb
         74uRdcEkmpbdisL9xoEMZG25wSN3dhuUp7dqminVPao+scwtohUnqu4dgKoKxOZUb44T
         J54A==
X-Gm-Message-State: APjAAAWH8V/rmvvRNHQeATTtpsPI79EE2zxiF4xiP17oEE7DnohQzuOu
        sCLPbHgVTIkQx7TPBhlZB04=
X-Google-Smtp-Source: APXvYqxe4zVmJNJ/Y2SwMtb3yAWgZFOU/4WmWsfv9qXCGeY4gymy26reF+DXb4wxVC87ebaO89EKMQ==
X-Received: by 2002:a17:90a:8c12:: with SMTP id a18mr9384987pjo.53.1575668329626;
        Fri, 06 Dec 2019 13:38:49 -0800 (PST)
Received: from tw-172-25-31-76.office.twttr.net ([8.25.197.24])
        by smtp.gmail.com with ESMTPSA id d65sm17368579pfa.159.2019.12.06.13.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 13:38:48 -0800 (PST)
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, joro@8bytes.org,
        Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch v3 0/3] iommu: reduce spinlock contention on fast path
Date:   Fri,  6 Dec 2019 13:38:00 -0800
Message-Id: <20191206213803.12580-1-xiyou.wangcong@gmail.com>
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
  iommu: avoid unnecessary magazine allocations
  iommu: optimize iova_magazine_free_pfns()
  iommu: avoid taking iova_rbtree_lock twice
---
 drivers/iommu/iova.c | 75 ++++++++++++++++++++++++++------------------
 1 file changed, 45 insertions(+), 30 deletions(-)

-- 
2.21.0

