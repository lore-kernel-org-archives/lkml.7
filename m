Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1F0C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 10:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCDA1256D0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 10:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfE3KEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 06:04:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54148 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbfE3KEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 06:04:49 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 846329D0F7;
        Thu, 30 May 2019 10:04:42 +0000 (UTC)
Received: from kasong-rh-laptop.pek2.redhat.com (wlc-trust-154.pek2.redhat.com [10.72.3.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 32A497D54C;
        Thu, 30 May 2019 10:04:35 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Dave Young <dyoung@redhat.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
        Kairui Song <kasong@redhat.com>
Subject: [PATCH v5] vmcore: Add a kernel parameter novmcoredd
Date:   Thu, 30 May 2019 18:03:39 +0800
Message-Id: <20190530100339.3089-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 30 May 2019 10:04:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 2724273e8fd0 ("vmcore: add API to collect hardware dump in
second kernel"), drivers is allowed to add device related dump data to
vmcore as they want by using the device dump API. This have a potential
issue, the data is stored in memory, drivers may append too much data
and use too much memory. The vmcore is typically used in a kdump kernel
which runs in a pre-reserved small chunk of memory. So as a result it
will make kdump unusable at all due to OOM issues.

So introduce new 'novmcoredd' command line option. User can disable
device dump to reduce memory usage. This is helpful if device dump is
using too much memory, disabling device dump could make sure a regular
vmcore without device dump data is still available.

Signed-off-by: Kairui Song <kasong@redhat.com>
Reviewed-by: Bhupesh Sharma <bhsharma@redhat.com>
Acked-by: Dave Young <dyoung@redhat.com>

---

Hi Andrew, sorry for the trouble but could you help pick up this one
instead for "vmcore: Add a kernel parameter novmcoredd" patch? Previous
one is in mm tree but failed compile when CONFIG_MODULES is not set, I
fixed this issue and carried something else like your doc fix, thanks!

 Update from V4:
  - Document adjust by Andrew Morton, also move the text to a better
    position
  - Fix compile error when CONFIG_MODULES is not set
  - Return EPERM instead of EINVAL when device dump is disabled as
    suggested by Dave Young

 Update from V3:
  - Use novmcoredd instead of vmcore_device_dump. Use
    vmcore_device_dump and make it off by default is confusing,
    novmcoredd is a cleaner way to let user space be able to disable
    device dump to save memory.

 Update from V2:
  - Improve related docs

 Update from V1:
  - Use bool parameter to turn it on/off instead of letting user give
    the size limit. Size of device dump is hard to determine.

 Documentation/admin-guide/kernel-parameters.txt | 11 +++++++++++
 fs/proc/Kconfig                                 |  3 ++-
 fs/proc/vmcore.c                                |  9 +++++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 138f6664b2e2..90b25234d965 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3088,6 +3088,17 @@
 
 	nosync		[HW,M68K] Disables sync negotiation for all devices.
 
+	novmcoredd	[KNL,KDUMP]
+			Disable device dump. Device dump allows drivers to
+			append dump data to vmcore so you can collect driver
+			specified debug info.  Drivers can append the data
+			without any limit and this data is stored in memory,
+			so this may cause significant memory stress.  Disabling
+			device dump can help save memory but the driver debug
+			data will be no longer available.  This parameter
+			is only available when CONFIG_PROC_VMCORE_DEVICE_DUMP
+			is set.
+
 	nowatchdog	[KNL] Disable both lockup detectors, i.e.
 			soft-lockup and NMI watchdog (hard-lockup).
 
diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
index 62ee41b4bbd0..b74ea844abd5 100644
--- a/fs/proc/Kconfig
+++ b/fs/proc/Kconfig
@@ -58,7 +58,8 @@ config PROC_VMCORE_DEVICE_DUMP
 	  snapshot.
 
 	  If you say Y here, the collected device dumps will be added
-	  as ELF notes to /proc/vmcore.
+	  as ELF notes to /proc/vmcore. You can still disable device
+	  dump using the kernel command line option 'novmcoredd'.
 
 config PROC_SYSCTL
 	bool "Sysctl support (/proc/sys)" if EXPERT
diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 7bb96fdd38ad..936e9dbbfbec 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -26,6 +26,7 @@
 #include <linux/pagemap.h>
 #include <linux/uaccess.h>
 #include <linux/mem_encrypt.h>
+#include <linux/moduleparam.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
 #include "internal.h"
@@ -54,6 +55,9 @@ static struct proc_dir_entry *proc_vmcore;
 /* Device Dump list and mutex to synchronize access to list */
 static LIST_HEAD(vmcoredd_list);
 static DEFINE_MUTEX(vmcoredd_mutex);
+
+static bool vmcoredd_disabled;
+core_param(novmcoredd, vmcoredd_disabled, bool, 0);
 #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
 
 /* Device Dump Size */
@@ -1452,6 +1456,11 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
 	size_t data_size;
 	int ret;
 
+	if (vmcoredd_disabled) {
+		pr_err_once("Device dump is disabled\n");
+		return -EPERM;
+	}
+
 	if (!data || !strlen(data->dump_name) ||
 	    !data->vmcoredd_callback || !data->size)
 		return -EINVAL;
-- 
2.21.0

