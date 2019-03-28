Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCE7C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5912F2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbfC0RJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 13:09:36 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:50045 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728158AbfC0RJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 13:09:32 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 27 Mar 2019 10:09:16 -0700
Received: from namit-esx4.eng.vmware.com (sc2-hs2-general-dhcp-219-51.eng.vmware.com [10.172.219.51])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 9959EB2124;
        Wed, 27 Mar 2019 13:09:29 -0400 (EDT)
From:   Nadav Amit <namit@vmware.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
CC:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        <virtualization@lists.linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        Julien Freche <jfreche@vmware.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH v2 0/4] vmw_balloon: compaction and shrinker support
Date:   Thu, 28 Mar 2019 01:07:14 +0000
Message-ID: <20190328010718.2248-1-namit@vmware.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
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
 mm/balloon_compaction.c            | 145 ++++++---
 4 files changed, 554 insertions(+), 85 deletions(-)

-- 
2.19.1

