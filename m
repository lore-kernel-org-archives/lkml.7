Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B21C2D0CF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 06:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B232077B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 06:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfLYGdb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 01:33:31 -0500
Received: from m9a0013g.houston.softwaregrp.com ([15.124.64.91]:33172 "EHLO
        m9a0013g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725847AbfLYGda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 01:33:30 -0500
X-Greylist: delayed 948 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Dec 2019 01:33:29 EST
Received: FROM m9a0013g.houston.softwaregrp.com (15.121.0.191) BY m9a0013g.houston.softwaregrp.com WITH ESMTP
 FOR linux-kernel@vger.kernel.org;
 Wed, 25 Dec 2019 06:32:42 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 25 Dec 2019 06:15:27 +0000
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (15.124.72.11) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Wed, 25 Dec 2019 06:15:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJG0B5tOM6L/DABzHPW+fTKOA+HGZh3npdmkwNmY9PYWa0/gmQnLQ1rKKjABwielhNAyHkseEf9YnGUVWinIgJyDApaxBQdTCZ820dIcBZifnloqndnuFxBC8bP0Y+Cmt0UOJ1L7AgeSA/LWvlGBuPnOsc5k4qy4bw92s7BFGmNS64yB74GT5SZvxA+Y2UQ88vpW5yiZafTjWdCsecydtJ3mnDOi266ZLqzSS/1i0k8hiVo5RoSQcszky0GmNVFfFUxCVfyvF/i+L7q/hXn679QnN5rHostT8w5Kylmk2lbHu4zoxztAImg/A6DxJerIbbO5OKI0L1CLYfMVqJWxrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdNs6krga8opvF0rSxAo8xgdmm3YOshNPbFmYEeplKY=;
 b=Kk0a1/nVaJ2TB+19vAwnQrnI4N/3096V+dmkJ3zShvVhEDHW8mFuUrfXYxAdpEJHSELqRj7+TFNboL8+RZ/uq8IsVS1najTuxU+/h6+6XB0+tK4epfKx65yVHg9NWt2TGi/0hGrRBGr9YrSicIbOI8lDqwSvJm1L4qmxKb7KqZdLNDepHpMvcOwIYG8tuRu1bqafvX18uP//xgulNrd1I42lg9GJSIjzUBb18aRAD2ZYuvsiKnF1R28eGfe47/mRXiNUbmG+WyHXcOh3oJtUQ9UJXSKPZFyNW5LuS9cN9zA9d/U1I+NWF+h5lyBremD6oxcDvmqEGLX2g/SwQGtjFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from CH2PR18MB3206.namprd18.prod.outlook.com (52.132.247.79) by
 CH2PR18MB3271.namprd18.prod.outlook.com (52.132.245.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.19; Wed, 25 Dec 2019 06:15:25 +0000
Received: from CH2PR18MB3206.namprd18.prod.outlook.com
 ([fe80::54af:ef86:cd53:ba5c]) by CH2PR18MB3206.namprd18.prod.outlook.com
 ([fe80::54af:ef86:cd53:ba5c%5]) with mapi id 15.20.2559.017; Wed, 25 Dec 2019
 06:15:25 +0000
Received: from ghe-pc.suse.asia (45.122.156.254) by MAXPR0101CA0007.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:c::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2581.11 via Frontend Transport; Wed, 25 Dec 2019 06:15:21 +0000
From:   Gang He <GHe@suse.com>
To:     "mark@fasheh.com" <mark@fasheh.com>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>
CC:     Gang He <GHe@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: [PATCH] ocfs2: fix the crash due to call ocfs2_get_dlm_debug once
 less
Thread-Topic: [PATCH] ocfs2: fix the crash due to call ocfs2_get_dlm_debug
 once less
Thread-Index: AQHVuuqxJ867Wgxv9EOdDT6+lBFGfg==
Date:   Wed, 25 Dec 2019 06:15:24 +0000
Message-ID: <20191225061501.13587-1-ghe@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR0101CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::17) To CH2PR18MB3206.namprd18.prod.outlook.com
 (2603:10b6:610:14::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=GHe@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.12.3
x-originating-ip: [45.122.156.254]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37e78de2-82c8-4ad1-f8dd-08d78901d446
x-ms-traffictypediagnostic: CH2PR18MB3271:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR18MB3271A7FEBCC154368435DB39CF280@CH2PR18MB3271.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:651;
x-forefront-prvs: 02622CEF0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(189003)(199004)(16526019)(8676002)(498600001)(26005)(81156014)(81166006)(71200400001)(186003)(2906002)(52116002)(6506007)(6512007)(5660300002)(4326008)(66556008)(1076003)(66476007)(66946007)(8936002)(36756003)(110136005)(64756008)(86362001)(956004)(66446008)(6486002)(2616005)(54906003)(16060500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR18MB3271;H:CH2PR18MB3206.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mzjKG4O1LKcVP53zYfN4gnF+UcaCStnmRpxMynZWFmPOSiE/USEqU18jIxly5ATVvZo5bRjzeNvhMeIsBSlh9i6ffEMXHvNDgeflYNW13dbYiq6aUfgtX6DF3KQA4rdNUL88hXs9bu0cWL3XbXbu2Cy5ATqsefSK9tyoYZZZVxNTvDXMK0N1GQ1VRd+NHVSO1TSpZm3+9m6tWtiUYk74d6wlFl18a1BEB8pJB6WafY7uOJB/3Kcew2QSFp1GBhq6v1PJEjxxZV4ndoRoGNcvWwZzofGqAUrvs9JgKGlrk29vrJFdQ1SdKfQkMkuf+1lO3ljkOvVRCf6PYARERI1xRuaF+Yf47WuHtKYT5stYbjYjiRzD9SOaVrmz2y7PI820LIRdQzeWcbaO8DLdY/94PGBKCmnTkEmNQrd4/W6Q4V4BZfMOGTo5yDFJ8a97dHPAIrn0Wbrq+TOaGKN2ooVoU43bUz3X35GBQz8vjIB8s+czjdbT+4QICkpCqlWo2nCu
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e78de2-82c8-4ad1-f8dd-08d78901d446
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2019 06:15:25.0466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jU+As+1xeQop2QxAy2poiv3uQ3UGKed6qk6t/T8FjW6F2wcF2CvtKZ7avMQ1rfng
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR18MB3271
X-OriginatorOrg: suse.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because ocfs2_get_dlm_debug() function is called once less here,
ocfs2 file system will trigger the system crash, usually after
ocfs2 file system is unmounted.
this system crash is caused by a generic memory corruption, these
crash backtraces are not always the same, for exapmle,

[ 4106.597432] ocfs2: Unmounting device (253,16) on (node 172167785)
[ 4116.230719] general protection fault: 0000 [#1] SMP PTI
[ 4116.230731] CPU: 3 PID: 14107 Comm: fence_legacy Kdump:
[ 4116.230737] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
[ 4116.230772] RIP: 0010:__kmalloc+0xa5/0x2a0
[ 4116.230778] Code: 00 00 4d 8b 07 65 4d 8b
[ 4116.230785] RSP: 0018:ffffaa1fc094bbe8 EFLAGS: 00010286
[ 4116.230790] RAX: 0000000000000000 RBX: d310a8800d7a3faf RCX: 0000000000000000
[ 4116.230794] RDX: 0000000000000000 RSI: 0000000000000dc0 RDI: ffff96e68fc036c0
[ 4116.230798] RBP: d310a8800d7a3faf R08: ffff96e6ffdb10a0 R09: 00000000752e7079
[ 4116.230802] R10: 000000000001c513 R11: 0000000004091041 R12: 0000000000000dc0
[ 4116.230806] R13: 0000000000000039 R14: ffff96e68fc036c0 R15: ffff96e68fc036c0
[ 4116.230811] FS:  00007f699dfba540(0000) GS:ffff96e6ffd80000(0000) knlGS:00000
[ 4116.230815] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4116.230819] CR2: 000055f3a9d9b768 CR3: 000000002cd1c000 CR4: 00000000000006e0
[ 4116.230833] Call Trace:
[ 4116.230898]  ? ext4_htree_store_dirent+0x35/0x100 [ext4]
[ 4116.230924]  ext4_htree_store_dirent+0x35/0x100 [ext4]
[ 4116.230957]  htree_dirblock_to_tree+0xea/0x290 [ext4]
[ 4116.230989]  ext4_htree_fill_tree+0x1c1/0x2d0 [ext4]
[ 4116.231027]  ext4_readdir+0x67c/0x9d0 [ext4]
[ 4116.231040]  iterate_dir+0x8d/0x1a0
[ 4116.231056]  __x64_sys_getdents+0xab/0x130
[ 4116.231063]  ? iterate_dir+0x1a0/0x1a0
[ 4116.231076]  ? do_syscall_64+0x60/0x1f0
[ 4116.231080]  ? __ia32_sys_getdents+0x130/0x130
[ 4116.231086]  do_syscall_64+0x60/0x1f0
[ 4116.231151]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 4116.231168] RIP: 0033:0x7f699d33a9fb

This regression problem was introduced by commit e581595ea29c ("ocfs:
no need to check return value of debugfs_create functions").

Signed-off-by: Gang He <ghe@suse.com>
---
 fs/ocfs2/dlmglue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index 1c4c51f3df60..cda1027d0819 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -3282,6 +3282,7 @@ static void ocfs2_dlm_init_debug(struct ocfs2_super *osb)
 
 	debugfs_create_u32("locking_filter", 0600, osb->osb_debug_root,
 			   &dlm_debug->d_filter_secs);
+	ocfs2_get_dlm_debug(dlm_debug);
 }
 
 static void ocfs2_dlm_shutdown_debug(struct ocfs2_super *osb)
-- 
2.12.3

