Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C615C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 02:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC9920651
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 02:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfCNC32 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 22:29:28 -0400
Received: from mga07.intel.com ([134.134.136.100]:32344 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbfCNC31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 22:29:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2019 19:29:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,476,1544515200"; 
   d="scan'208";a="307050400"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga005.jf.intel.com with ESMTP; 13 Mar 2019 19:29:26 -0700
Received: from FMSMSX110.amr.corp.intel.com (10.18.116.10) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 13 Mar 2019 19:29:26 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 fmsmsx110.amr.corp.intel.com (10.18.116.10) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 13 Mar 2019 19:29:26 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.74]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.80]) with mapi id 14.03.0415.000;
 Thu, 14 Mar 2019 10:28:22 +0800
From:   "He, Bo" <bo.he@intel.com>
To:     "jikos@kernel.org" <jikos@kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Zhang, Jun" <jun.zhang@intel.com>,
        "Zhang, Yanmin" <yanmin.zhang@intel.com>
Subject: must hold the driver_input_lock in hid_debug_rdesc_show
Thread-Topic: must hold the driver_input_lock in hid_debug_rdesc_show
Thread-Index: AdTaDWtNLTEcOrQfQrCEZYJMmjpu/w==
Date:   Thu, 14 Mar 2019 02:28:21 +0000
Message-ID: <CD6925E8781EFD4D8E11882D20FC406D52A6168C@SHSMSX104.ccr.corp.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiM2VhMjBjY2EtZmY5Mi00MmZmLWE5ODctOTA0YWM0YzE4N2U1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSjlXSTViUnpvamk5bEVsa2xYWnBhUTdvUmsweG9CM0k3bzlGcGY3RWpIUTQrMUk2dkFJa1lxeG02cEZ4SlQ0bCJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

we see the below kernel panic logs when run suspend resume test with
usb mouse and usb keyboard connected.

the scenario is the userspace call the hid_debug_rdesc_show to dump
the input device while the device is removed. the patch
hold the driver_input_lock to avoid the race.

[ 5381.757295] selinux: SELinux:  Could not stat
/sys/devices/pci0000:00/0000:00:15.0/usb1/1-2/1-2:1.0/0003:03F0:0325.0320/input/input960/input960::scrolllock:
No such file or directory.
[ 5382.636498] BUG: unable to handle kernel paging request at 0000000783316040
[ 5382.651950] CPU: 1 PID: 1512 Comm: getevent Tainted: G     U     O 4.19.20-quilt-2e5dc0ac-00029-gc455a447dd55 #1
[ 5382.663797] RIP: 0010:hid_dump_device+0x9b/0x160
[ 5382.758853] Call Trace:
[ 5382.761581]  hid_debug_rdesc_show+0x72/0x1d0
[ 5382.766343]  seq_read+0xe0/0x410
[ 5382.769941]  full_proxy_read+0x5f/0x90
[ 5382.774121]  __vfs_read+0x3a/0x170
[ 5382.788392]  vfs_read+0xa0/0x150
[ 5382.791984]  ksys_read+0x58/0xc0
[ 5382.801404]  __x64_sys_read+0x1a/0x20
[ 5382.805483]  do_syscall_64+0x55/0x110
[ 5382.809559]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Signed-off-by: he, bo <bo.he@intel.com>
Signed-off-by: "Zhang, Jun" <jun.zhang@intel.com>
---
 drivers/hid/hid-debug.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index ebc9ffde41e9..a353a011fbdf 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -1060,10 +1060,15 @@ static int hid_debug_rdesc_show(struct seq_file *f, void *p)
 	seq_printf(f, "\n\n");
 
 	/* dump parsed data and input mappings */
+	if (down_interruptible(&hdev->driver_input_lock))
+		return 0;
+
 	hid_dump_device(hdev, f);
 	seq_printf(f, "\n");
 	hid_dump_input_mapping(hdev, f);
 
+	up(&hdev->driver_input_lock);
+
 	return 0;
 }
 
-- 
2.20.1



