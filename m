Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6113CC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38FFC20693
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387637AbfGaMcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:32:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59676 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbfGaMcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:32:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9348185542;
        Wed, 31 Jul 2019 12:32:07 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-240.ams2.redhat.com [10.36.117.240])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 792775C1B5;
        Wed, 31 Jul 2019 12:32:02 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-acpi@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1] drivers/acpi/scan.c: Fixup "acquire device_hotplug_lock in acpi_scan_init()"
Date:   Wed, 31 Jul 2019 14:32:01 +0200
Message-Id: <20190731123201.13893-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 31 Jul 2019 12:32:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's document why we take the lock here. If we're going to overhaul
memory hotplug locking, we'll have to touch many places - this comment
will help to clairfy why it was added here.

Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/acpi/scan.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index cbc9d64b48dd..9193f1d46148 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2204,6 +2204,11 @@ int __init acpi_scan_init(void)
 	acpi_gpe_apply_masked_gpes();
 	acpi_update_all_gpes();
 
+	/*
+	 * We end up calling __add_memory(), which expects the
+	 * device_hotplug_lock to be held. Races with userspace and other
+	 * hotplug activities are not really possible - lock for consistency.
+	 */
 	lock_device_hotplug();
 	mutex_lock(&acpi_scan_lock);
 
-- 
2.21.0

