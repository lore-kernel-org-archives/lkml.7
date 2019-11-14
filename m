Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1023C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 10:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D759B20709
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 10:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfKNK5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 05:57:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:33358 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725977AbfKNK5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 05:57:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C7E62AD5F;
        Thu, 14 Nov 2019 10:57:40 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.com>
To:     Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        "Yan, Zheng" <zyan@redhat.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Henriques <lhenriques@suse.com>
Subject: [RFC PATCH v2 3/4] ceph: add require_osd_release field to osdmap debugfs
Date:   Thu, 14 Nov 2019 10:57:35 +0000
Message-Id: <20191114105736.8636-4-lhenriques@suse.com>
In-Reply-To: <20191114105736.8636-1-lhenriques@suse.com>
References: <20191114105736.8636-1-lhenriques@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the require_osd_release information to debugfs.

Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 include/linux/ceph/rados.h | 22 ++++++++++++++++++++++
 net/ceph/ceph_strings.c    | 38 ++++++++++++++++++++++++++++++++++++++
 net/ceph/debugfs.c         |  2 ++
 3 files changed, 62 insertions(+)

diff --git a/include/linux/ceph/rados.h b/include/linux/ceph/rados.h
index 3eb0e55665b4..68bc65f971b4 100644
--- a/include/linux/ceph/rados.h
+++ b/include/linux/ceph/rados.h
@@ -164,6 +164,28 @@ extern const char *ceph_osd_state_name(int s);
 #define CEPH_OSDMAP_REQUIRE_LUMINOUS (1<<18) /* require l for booting osds */
 #define CEPH_OSDMAP_RECOVERY_DELETES (1<<19) /* deletes performed during recovery instead of peering */
 
+/*
+ * major ceph release numbers
+ */
+#define CEPH_RELEASE_ARGONAUT	1
+#define CEPH_RELEASE_BOBTAIL	2
+#define CEPH_RELEASE_CUTTLEFISH	3
+#define CEPH_RELEASE_DUMPLING	4
+#define CEPH_RELEASE_EMPEROR	5
+#define CEPH_RELEASE_FIREFLY	6
+#define CEPH_RELEASE_GIANT	7
+#define CEPH_RELEASE_HAMMER	8
+#define CEPH_RELEASE_INFERNALIS	9
+#define CEPH_RELEASE_JEWEL	10
+#define CEPH_RELEASE_KRAKEN	11
+#define CEPH_RELEASE_LUMINOUS	12
+#define CEPH_RELEASE_MIMIC	13
+#define CEPH_RELEASE_NAUTILUS	14
+#define CEPH_RELEASE_OCTOPUS	15
+#define CEPH_RELEASE_MAX	16 /* highest + 1 */
+
+extern const char *ceph_release_name(int r);
+
 /*
  * The error code to return when an OSD can't handle a write
  * because it is too large.
diff --git a/net/ceph/ceph_strings.c b/net/ceph/ceph_strings.c
index 10e01494993c..3f280f17bbcb 100644
--- a/net/ceph/ceph_strings.c
+++ b/net/ceph/ceph_strings.c
@@ -60,3 +60,41 @@ const char *ceph_osd_state_name(int s)
 		return "???";
 	}
 }
+
+const char *ceph_release_name(int r)
+{
+	switch (r) {
+	case CEPH_RELEASE_ARGONAUT:
+		return "argonaut";
+	case CEPH_RELEASE_BOBTAIL:
+		return "bobtail";
+	case CEPH_RELEASE_CUTTLEFISH:
+		return "cuttlefish";
+	case CEPH_RELEASE_DUMPLING:
+		return "dumpling";
+	case CEPH_RELEASE_EMPEROR:
+		return "emperor";
+	case CEPH_RELEASE_FIREFLY:
+		return "firefly";
+	case CEPH_RELEASE_GIANT:
+		return "giant";
+	case CEPH_RELEASE_HAMMER:
+		return "hammer";
+	case CEPH_RELEASE_INFERNALIS:
+		return "infernalis";
+	case CEPH_RELEASE_JEWEL:
+		return "jewel";
+	case CEPH_RELEASE_KRAKEN:
+		return "kraken";
+	case CEPH_RELEASE_LUMINOUS:
+		return "luminous";
+	case CEPH_RELEASE_MIMIC:
+		return "mimic";
+	case CEPH_RELEASE_NAUTILUS:
+		return "nautilus";
+	case CEPH_RELEASE_OCTOPUS:
+		return "octopus";
+	default:
+		return "unknown";
+	}
+}
diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
index 7cb992e55475..d42071f6ab57 100644
--- a/net/ceph/debugfs.c
+++ b/net/ceph/debugfs.c
@@ -65,6 +65,8 @@ static int osdmap_show(struct seq_file *s, void *p)
 	down_read(&osdc->lock);
 	seq_printf(s, "epoch %u barrier %u flags 0x%x\n", map->epoch,
 			osdc->epoch_barrier, map->flags);
+	seq_printf(s, "require_osd_release: %s\n",
+		   ceph_release_name(map->require_osd_release));
 
 	for (n = rb_first(&map->pg_pools); n; n = rb_next(n)) {
 		struct ceph_pg_pool_info *pi =
