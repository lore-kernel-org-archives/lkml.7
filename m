Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932A8C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DFE4218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbfDXHFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 03:05:33 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:38100 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725934AbfDXHFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 03:05:32 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 24 Apr 2019 00:05:28 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 83129B1BAC;
        Wed, 24 Apr 2019 03:05:31 -0400 (EDT)
From:   Nadav Amit <namit@vmware.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
CC:     Arnd Bergmann <arnd@arndb.de>, Julien Freche <jfreche@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        Jason Wang <jasowang@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>, <linux-mm@kvack.org>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH v3 0/4] vmw_balloon: compaction and shrinker support
Date:   Tue, 23 Apr 2019 16:45:27 -0700
Message-ID: <20190423234531.29371-1-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VMware balloon enhancements: adding support for memory compaction,
memory shrinker (to prevent OOM) and splitting of refused pages to
prevent recurring inflations.

Patches 1-2: Support for compaction
Patch 3: Support for memory shrinker - disabled by default
Patch 4: Split refused pages to improve performance

v2->v3:
* Fixing wrong argument type (int->size_t) [Michael]
* Fixing a comment (it) [Michael]
* Reinstating the BUG_ON() when page is locked [Michael] 

v1->v2:
* Return number of pages in list enqueue/dequeue interfaces [Michael]
* Removed first two patches which were already merged

Nadav Amit (4):
  mm/balloon_compaction: list interfaces
  vmw_balloon: compaction support
  vmw_balloon: add memory shrinker
  vmw_balloon: split refused pages

 drivers/misc/Kconfig               |   1 +
 drivers/misc/vmw_balloon.c         | 489 ++++++++++++++++++++++++++---
 include/linux/balloon_compaction.h |   4 +
 mm/balloon_compaction.c            | 144 ++++++---
 4 files changed, 553 insertions(+), 85 deletions(-)

-- 
2.19.1

