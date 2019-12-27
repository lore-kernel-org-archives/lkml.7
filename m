Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A430C2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 02:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E316621775
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 02:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfL0CcF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 21:32:05 -0500
Received: from m9a0013g.houston.softwaregrp.com ([15.124.64.91]:44833 "EHLO
        m9a0013g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726277AbfL0CcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 21:32:05 -0500
Received: FROM m9a0013g.houston.softwaregrp.com (15.121.0.190) BY m9a0013g.houston.softwaregrp.com WITH ESMTP;
 Fri, 27 Dec 2019 02:31:13 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 27 Dec 2019 02:30:18 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (15.124.8.13) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Fri, 27 Dec 2019 02:30:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mICVdVZsnsTQPlfzovzCOiTUsvCw0em4mjvNeqezjeMT5aATXFfyN44PnRcLBkGnXj0EjnjAEmDUbMSN07WC+wbiobcVcvcrdUNMHzv5vbVf4hKzbduzEKJQchEBICM0N5PLEmKZIguoj0OhWFQmsNOXgfZ4TY/wM7Hr7JoMXLYkY1u+CHrlNU/A4HWiEE0M/DWCafXvJEKvdJNawjbXQU/Bb9/uRqwYY5IxDePWZuojbW0w3L8ffvWWTDYoeWV1kk5wz6+k51/RtOaEZ0JvIGMuURJHW+kjb0kQPh9KFw0OQSzj8Qd9dIgVQUj5K7MdQAMTE0LxYKZvj95A/+rjQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/Fm0a1M2hL+gPCd8puD2UbqAdMIsc6AxvP6YEtczz0=;
 b=RRWjzIhoJ27rYJD7ensTNeEEaqL7nHT5VnBJgvS6fXy7Pb7lbrkPSA8oMY/4pSGJwlPvmqLAdqs/PQUs5WqEI2vNlnHQLM2hjAZu1eNHqNVGT9/8aYXVWWl91REMXKza70qr06KQ044fcGpMPNy3FxwwqOPZ3m8Y95+KVTfyx57/96BRb1mcFc59IWpXb1zx2/8hyoEg18m1by6jPuNvZJDmaKFpHxvfdUxM7dHTRAx9z2NU773vOqrRNSyHOOLq2NPCSzkoBB7oPmQ/SBPd7GvyZNt1zVOuLfzSkqmeWgz1TxAOszRyEU+K/ShHeTYpCil/zwJinFxC5klbkRLoUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from CH2PR18MB3206.namprd18.prod.outlook.com (52.132.247.79) by
 CH2PR18MB3431.namprd18.prod.outlook.com (52.132.245.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.12; Fri, 27 Dec 2019 02:30:16 +0000
Received: from CH2PR18MB3206.namprd18.prod.outlook.com
 ([fe80::54af:ef86:cd53:ba5c]) by CH2PR18MB3206.namprd18.prod.outlook.com
 ([fe80::54af:ef86:cd53:ba5c%5]) with mapi id 15.20.2559.017; Fri, 27 Dec 2019
 02:30:15 +0000
Received: from ghe-pc.suse.asia (45.122.156.254) by MAXPR01CA0116.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2581.11 via Frontend Transport; Fri, 27 Dec 2019 02:30:12 +0000
From:   Gang He <GHe@suse.com>
To:     "mark@fasheh.com" <mark@fasheh.com>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>
CC:     Masahiro Yamada <masahiroy@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: [PATCH] ocfs2: make local header paths relative to C files
Thread-Topic: [PATCH] ocfs2: make local header paths relative to C files
Thread-Index: AQHVvF2SpO4UWe7QVUe61FL4lsbHZw==
Date:   Fri, 27 Dec 2019 02:30:15 +0000
Message-ID: <20191227022950.14804-1-ghe@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR01CA0116.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::34) To CH2PR18MB3206.namprd18.prod.outlook.com
 (2603:10b6:610:14::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=GHe@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.12.3
x-originating-ip: [45.122.156.254]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28cae516-85b3-40d8-73c4-08d78a74b4f2
x-ms-traffictypediagnostic: CH2PR18MB3431:
x-microsoft-antispam-prvs: <CH2PR18MB343128DA80E695A194CDB4E6CF2A0@CH2PR18MB3431.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0264FEA5C3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(199004)(189003)(956004)(478600001)(2616005)(26005)(36756003)(52116002)(1076003)(86362001)(5660300002)(71200400001)(186003)(66476007)(6506007)(64756008)(66446008)(66946007)(66556008)(54906003)(110136005)(316002)(2906002)(6486002)(8676002)(81156014)(81166006)(4326008)(16526019)(6512007)(8936002)(16060500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR18MB3431;H:CH2PR18MB3206.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l+JaxN8hIRaNTForEci8O5XiSXJWQxWPGg9J4QYxIF/1hddAcVbz0wWEBTMhM4B2WkjVpXvqv/61Q1qof+JmuABBHO9yiN4vg6zeTQ6btXkP79RlfC/ridLmUDkaHq67a0Pi3UB15LOodTw7hRF4PGSIEeqm4txduCrpT/guY+wCpdCz2tGHvClPReNppIJgwlzXz/Z9Vb1YST4MtrAXmT2HUgiMWQKJFgUJC2py0Z00tIqYgek31eVQZHCaF4XxiiKgrHk0PwqWldpof+/8nrIZPNVUUXMNzOiW0ArgxZsVacLCMp3N6KNjmMf4nlbHExgp3vp21l7A90yvcb6F9H6QtneIe1gDkkM7B2/mqwdRpBHcdvcwB3NG1VuNaD85Jg679GmDIgWjypF94AdVP3R8A/SfT/RUNEH1F1b/brNW6TpvDsV9lFbI2Is9xUQ6fYONRy0wA46fU0YtOeD7VSUM2361tffzvsz5fck2+1NJ3hh7ufgVpzX/WgNBCKWH
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 28cae516-85b3-40d8-73c4-08d78a74b4f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2019 02:30:15.8139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8gJ59lJfvhBtJWNq5KCCq6Sf3vGf2wsHgzRqkCj2S51uCOgm7+f3rkjU4Iz940zI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR18MB3431
X-OriginatorOrg: suse.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org>

Gang He reports the failure of building fs/ocfs2/ as an external module
of the kernel installed on the system:

 $ cd fs/ocfs2
 $ make -C /lib/modules/`uname -r`/build M=`pwd` modules

If you want to make it work reliably, I'd recommend to remove ccflags-y
from the Makefiles, and to make header paths relative to the C files.
I think this is the correct usage of the #include "..." directive.

Reported-by: Gang He <ghe@suse.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Gang He <ghe@suse.com>
---
 fs/ocfs2/dlm/Makefile      | 2 --
 fs/ocfs2/dlm/dlmast.c      | 8 ++++----
 fs/ocfs2/dlm/dlmconvert.c  | 8 ++++----
 fs/ocfs2/dlm/dlmdebug.c    | 8 ++++----
 fs/ocfs2/dlm/dlmdomain.c   | 8 ++++----
 fs/ocfs2/dlm/dlmlock.c     | 8 ++++----
 fs/ocfs2/dlm/dlmmaster.c   | 8 ++++----
 fs/ocfs2/dlm/dlmrecovery.c | 8 ++++----
 fs/ocfs2/dlm/dlmthread.c   | 8 ++++----
 fs/ocfs2/dlm/dlmunlock.c   | 8 ++++----
 fs/ocfs2/dlmfs/Makefile    | 2 --
 fs/ocfs2/dlmfs/dlmfs.c     | 4 ++--
 fs/ocfs2/dlmfs/userdlm.c   | 6 +++---
 13 files changed, 41 insertions(+), 45 deletions(-)

diff --git a/fs/ocfs2/dlm/Makefile b/fs/ocfs2/dlm/Makefile
index 38b224372776..5e700b45d32d 100644
--- a/fs/ocfs2/dlm/Makefile
+++ b/fs/ocfs2/dlm/Makefile
@@ -1,6 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-ccflags-y := -I $(srctree)/$(src)/..
-
 obj-$(CONFIG_OCFS2_FS_O2CB) += ocfs2_dlm.o
 
 ocfs2_dlm-objs := dlmdomain.o dlmdebug.o dlmthread.o dlmrecovery.o \
diff --git a/fs/ocfs2/dlm/dlmast.c b/fs/ocfs2/dlm/dlmast.c
index 4de89af96abf..6abaded3ff6b 100644
--- a/fs/ocfs2/dlm/dlmast.c
+++ b/fs/ocfs2/dlm/dlmast.c
@@ -23,15 +23,15 @@
 #include <linux/spinlock.h>
 
 
-#include "cluster/heartbeat.h"
-#include "cluster/nodemanager.h"
-#include "cluster/tcp.h"
+#include "../cluster/heartbeat.h"
+#include "../cluster/nodemanager.h"
+#include "../cluster/tcp.h"
 
 #include "dlmapi.h"
 #include "dlmcommon.h"
 
 #define MLOG_MASK_PREFIX ML_DLM
-#include "cluster/masklog.h"
+#include "../cluster/masklog.h"
 
 static void dlm_update_lvb(struct dlm_ctxt *dlm, struct dlm_lock_resource *res,
 			   struct dlm_lock *lock);
diff --git a/fs/ocfs2/dlm/dlmconvert.c b/fs/ocfs2/dlm/dlmconvert.c
index 965f45dbe17b..6051edc33aef 100644
--- a/fs/ocfs2/dlm/dlmconvert.c
+++ b/fs/ocfs2/dlm/dlmconvert.c
@@ -23,9 +23,9 @@
 #include <linux/spinlock.h>
 
 
-#include "cluster/heartbeat.h"
-#include "cluster/nodemanager.h"
-#include "cluster/tcp.h"
+#include "../cluster/heartbeat.h"
+#include "../cluster/nodemanager.h"
+#include "../cluster/tcp.h"
 
 #include "dlmapi.h"
 #include "dlmcommon.h"
@@ -33,7 +33,7 @@
 #include "dlmconvert.h"
 
 #define MLOG_MASK_PREFIX ML_DLM
-#include "cluster/masklog.h"
+#include "../cluster/masklog.h"
 
 /* NOTE: __dlmconvert_master is the only function in here that
  * needs a spinlock held on entry (res->spinlock) and it is the
diff --git a/fs/ocfs2/dlm/dlmdebug.c b/fs/ocfs2/dlm/dlmdebug.c
index 4d0b452012b2..c5c6efba7b5e 100644
--- a/fs/ocfs2/dlm/dlmdebug.c
+++ b/fs/ocfs2/dlm/dlmdebug.c
@@ -17,9 +17,9 @@
 #include <linux/debugfs.h>
 #include <linux/export.h>
 
-#include "cluster/heartbeat.h"
-#include "cluster/nodemanager.h"
-#include "cluster/tcp.h"
+#include "../cluster/heartbeat.h"
+#include "../cluster/nodemanager.h"
+#include "../cluster/tcp.h"
 
 #include "dlmapi.h"
 #include "dlmcommon.h"
@@ -27,7 +27,7 @@
 #include "dlmdebug.h"
 
 #define MLOG_MASK_PREFIX ML_DLM
-#include "cluster/masklog.h"
+#include "../cluster/masklog.h"
 
 static int stringify_lockname(const char *lockname, int locklen, char *buf,
 			      int len);
diff --git a/fs/ocfs2/dlm/dlmdomain.c b/fs/ocfs2/dlm/dlmdomain.c
index ee6f459f9770..357cfc702ce3 100644
--- a/fs/ocfs2/dlm/dlmdomain.c
+++ b/fs/ocfs2/dlm/dlmdomain.c
@@ -20,9 +20,9 @@
 #include <linux/debugfs.h>
 #include <linux/sched/signal.h>
 
-#include "cluster/heartbeat.h"
-#include "cluster/nodemanager.h"
-#include "cluster/tcp.h"
+#include "../cluster/heartbeat.h"
+#include "../cluster/nodemanager.h"
+#include "../cluster/tcp.h"
 
 #include "dlmapi.h"
 #include "dlmcommon.h"
@@ -30,7 +30,7 @@
 #include "dlmdebug.h"
 
 #define MLOG_MASK_PREFIX (ML_DLM|ML_DLM_DOMAIN)
-#include "cluster/masklog.h"
+#include "../cluster/masklog.h"
 
 /*
  * ocfs2 node maps are array of long int, which limits to send them freely
diff --git a/fs/ocfs2/dlm/dlmlock.c b/fs/ocfs2/dlm/dlmlock.c
index baff087f3863..83f0760e4fba 100644
--- a/fs/ocfs2/dlm/dlmlock.c
+++ b/fs/ocfs2/dlm/dlmlock.c
@@ -25,9 +25,9 @@
 #include <linux/delay.h>
 
 
-#include "cluster/heartbeat.h"
-#include "cluster/nodemanager.h"
-#include "cluster/tcp.h"
+#include "../cluster/heartbeat.h"
+#include "../cluster/nodemanager.h"
+#include "../cluster/tcp.h"
 
 #include "dlmapi.h"
 #include "dlmcommon.h"
@@ -35,7 +35,7 @@
 #include "dlmconvert.h"
 
 #define MLOG_MASK_PREFIX ML_DLM
-#include "cluster/masklog.h"
+#include "../cluster/masklog.h"
 
 static struct kmem_cache *dlm_lock_cache;
 
diff --git a/fs/ocfs2/dlm/dlmmaster.c b/fs/ocfs2/dlm/dlmmaster.c
index 74b768ca1cd8..c9d7037b6793 100644
--- a/fs/ocfs2/dlm/dlmmaster.c
+++ b/fs/ocfs2/dlm/dlmmaster.c
@@ -25,9 +25,9 @@
 #include <linux/delay.h>
 
 
-#include "cluster/heartbeat.h"
-#include "cluster/nodemanager.h"
-#include "cluster/tcp.h"
+#include "../cluster/heartbeat.h"
+#include "../cluster/nodemanager.h"
+#include "../cluster/tcp.h"
 
 #include "dlmapi.h"
 #include "dlmcommon.h"
@@ -35,7 +35,7 @@
 #include "dlmdebug.h"
 
 #define MLOG_MASK_PREFIX (ML_DLM|ML_DLM_MASTER)
-#include "cluster/masklog.h"
+#include "../cluster/masklog.h"
 
 static void dlm_mle_node_down(struct dlm_ctxt *dlm,
 			      struct dlm_master_list_entry *mle,
diff --git a/fs/ocfs2/dlm/dlmrecovery.c b/fs/ocfs2/dlm/dlmrecovery.c
index 064ce5bbc3f6..bcaaca5112d6 100644
--- a/fs/ocfs2/dlm/dlmrecovery.c
+++ b/fs/ocfs2/dlm/dlmrecovery.c
@@ -26,16 +26,16 @@
 #include <linux/delay.h>
 
 
-#include "cluster/heartbeat.h"
-#include "cluster/nodemanager.h"
-#include "cluster/tcp.h"
+#include "../cluster/heartbeat.h"
+#include "../cluster/nodemanager.h"
+#include "../cluster/tcp.h"
 
 #include "dlmapi.h"
 #include "dlmcommon.h"
 #include "dlmdomain.h"
 
 #define MLOG_MASK_PREFIX (ML_DLM|ML_DLM_RECOVERY)
-#include "cluster/masklog.h"
+#include "../cluster/masklog.h"
 
 static void dlm_do_local_recovery_cleanup(struct dlm_ctxt *dlm, u8 dead_node);
 
diff --git a/fs/ocfs2/dlm/dlmthread.c b/fs/ocfs2/dlm/dlmthread.c
index 61c51c268460..fd40c17cd022 100644
--- a/fs/ocfs2/dlm/dlmthread.c
+++ b/fs/ocfs2/dlm/dlmthread.c
@@ -25,16 +25,16 @@
 #include <linux/delay.h>
 
 
-#include "cluster/heartbeat.h"
-#include "cluster/nodemanager.h"
-#include "cluster/tcp.h"
+#include "../cluster/heartbeat.h"
+#include "../cluster/nodemanager.h"
+#include "../cluster/tcp.h"
 
 #include "dlmapi.h"
 #include "dlmcommon.h"
 #include "dlmdomain.h"
 
 #define MLOG_MASK_PREFIX (ML_DLM|ML_DLM_THREAD)
-#include "cluster/masklog.h"
+#include "../cluster/masklog.h"
 
 static int dlm_thread(void *data);
 static void dlm_flush_asts(struct dlm_ctxt *dlm);
diff --git a/fs/ocfs2/dlm/dlmunlock.c b/fs/ocfs2/dlm/dlmunlock.c
index 3883633e82eb..dcb17ca8ae74 100644
--- a/fs/ocfs2/dlm/dlmunlock.c
+++ b/fs/ocfs2/dlm/dlmunlock.c
@@ -23,15 +23,15 @@
 #include <linux/spinlock.h>
 #include <linux/delay.h>
 
-#include "cluster/heartbeat.h"
-#include "cluster/nodemanager.h"
-#include "cluster/tcp.h"
+#include "../cluster/heartbeat.h"
+#include "../cluster/nodemanager.h"
+#include "../cluster/tcp.h"
 
 #include "dlmapi.h"
 #include "dlmcommon.h"
 
 #define MLOG_MASK_PREFIX ML_DLM
-#include "cluster/masklog.h"
+#include "../cluster/masklog.h"
 
 #define DLM_UNLOCK_FREE_LOCK           0x00000001
 #define DLM_UNLOCK_CALL_AST            0x00000002
diff --git a/fs/ocfs2/dlmfs/Makefile b/fs/ocfs2/dlmfs/Makefile
index a9874e441bd4..c7895f65be0e 100644
--- a/fs/ocfs2/dlmfs/Makefile
+++ b/fs/ocfs2/dlmfs/Makefile
@@ -1,6 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-ccflags-y := -I $(srctree)/$(src)/..
-
 obj-$(CONFIG_OCFS2_FS) += ocfs2_dlmfs.o
 
 ocfs2_dlmfs-objs := userdlm.o dlmfs.o
diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
index 4f1668c81e1f..8e4f1ace467c 100644
--- a/fs/ocfs2/dlmfs/dlmfs.c
+++ b/fs/ocfs2/dlmfs/dlmfs.c
@@ -33,11 +33,11 @@
 
 #include <linux/uaccess.h>
 
-#include "stackglue.h"
+#include "../stackglue.h"
 #include "userdlm.h"
 
 #define MLOG_MASK_PREFIX ML_DLMFS
-#include "cluster/masklog.h"
+#include "../cluster/masklog.h"
 
 
 static const struct super_operations dlmfs_ops;
diff --git a/fs/ocfs2/dlmfs/userdlm.c b/fs/ocfs2/dlmfs/userdlm.c
index 525b14ddfba5..3df5be25bfb1 100644
--- a/fs/ocfs2/dlmfs/userdlm.c
+++ b/fs/ocfs2/dlmfs/userdlm.c
@@ -21,12 +21,12 @@
 #include <linux/types.h>
 #include <linux/crc32.h>
 
-#include "ocfs2_lockingver.h"
-#include "stackglue.h"
+#include "../ocfs2_lockingver.h"
+#include "../stackglue.h"
 #include "userdlm.h"
 
 #define MLOG_MASK_PREFIX ML_DLMFS
-#include "cluster/masklog.h"
+#include "../cluster/masklog.h"
 
 
 static inline struct user_lock_res *user_lksb_to_lock_res(struct ocfs2_dlm_lksb *lksb)
-- 
2.17.1

