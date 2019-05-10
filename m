Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F87FC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 10:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F34620989
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 10:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfEJKfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 06:35:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48500 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727251AbfEJKfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 06:35:09 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3467A85376;
        Fri, 10 May 2019 10:35:09 +0000 (UTC)
Received: from kasong-rh-laptop.pek2.redhat.com (wlc-trust-190.pek2.redhat.com [10.72.3.190])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E547600C7;
        Fri, 10 May 2019 10:35:03 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Young <dyoung@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        Kairui Song <kasong@redhat.com>
Subject: [RFC PATCH] vmcore: Add a kernel cmdline device_dump_limit
Date:   Fri, 10 May 2019 18:20:51 +0800
Message-Id: <20190510102051.25647-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 10 May 2019 10:35:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device dump allow drivers to add device related dump data to vmcore as
they want. This have a potential issue, the data is stored in memory,
drivers may append too much data and use too much memory. The vmcore is
typically used in a kdump kernel which runs in a pre-reserved small
chunk of memory. So as a result it will make kdump unusable at all due
to OOM issues.

So introduce new device_dump_limit= kernel parameter, and set the
default limit to 0, so device dump is not enabled unless user specify
the accetable maxiam memory usage for device dump data. In this way user
will also have the chance to adjust the kdump reserved memory
accordingly.

Signed-off-by: Kairui Song <kasong@redhat.com>
---
 fs/proc/vmcore.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 3fe90443c1bb..e28695ef2439 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -53,6 +53,9 @@ static struct proc_dir_entry *proc_vmcore;
 /* Device Dump list and mutex to synchronize access to list */
 static LIST_HEAD(vmcoredd_list);
 static DEFINE_MUTEX(vmcoredd_mutex);
+
+/* Device Dump Limit */
+static size_t vmcoredd_limit;
 #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
 
 /* Device Dump Size */
@@ -1465,6 +1468,11 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
 	data_size = roundup(sizeof(struct vmcoredd_header) + data->size,
 			    PAGE_SIZE);
 
+	if (vmcoredd_orig_sz + data_size >= vmcoredd_limit) {
+		ret = -ENOMEM;
+		goto out_err;
+	}
+
 	/* Allocate buffer for driver's to write their dumps */
 	buf = vmcore_alloc_buf(data_size);
 	if (!buf) {
@@ -1502,6 +1510,18 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
 	return ret;
 }
 EXPORT_SYMBOL(vmcore_add_device_dump);
+
+static int __init parse_vmcoredd_limit(char *arg)
+{
+	char *end;
+
+	if (!arg)
+		return -EINVAL;
+	vmcoredd_limit = memparse(arg, &end);
+	return end > arg ? 0 : -EINVAL;
+
+}
+__setup("device_dump_limit=", parse_vmcoredd_limit);
 #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
 
 /* Free all dumps in vmcore device dump list */
-- 
2.20.1

