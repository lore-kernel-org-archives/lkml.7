Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C7EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B6420854
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731257AbfCYMwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:52:11 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:38175 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731088AbfCYMwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 08:52:10 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N1Oft-1gy2xS483n-012s2n; Mon, 25 Mar 2019 13:51:50 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ilya Dryomov <idryomov@gmail.com>, "Yan, Zheng" <zyan@redhat.com>,
        Sage Weil <sage@redhat.com>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Alex Elder <elder@linaro.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] ceph: fix clang warning for CEPH_DEFINE_OID_ONSTACK
Date:   Mon, 25 Mar 2019 13:51:43 +0100
Message-Id: <20190325125147.1436083-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KWvfQc+4evNO9m8S8p3AoDmHUjX122/NcSdbgNhhaPGoBLr2fC3
 PZnt8of6Rnv8G4b4Ppnp6L30MFl96pxnIIjlLTJ2uSgHb0boHEol0gWaP7sPtKBPiOEXh+4
 dpKmvTIuSVBknRjZBX0B98K+x9NZp3w48l7AC8fJ7DAXwyPZHbpHL5MpkjUjQF5uWcpjvD9
 Y05wUJVGLKDdvUUE0qzCg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eua1NsCnv1M=:L+K/YOrApGbhdwyDDeSJ8j
 uJ3V8KvnJxU95e0ftrqbkXQ1vlG0x/22VfE4/opMABDFsjE4IDm17Nur3yFMN0GPKPY7FNPtj
 4Pa/eZM/kKKmFh+Et5pF99pJV+A1Fji8uID9YFt0fDcVFbQh6CAsd7drKdXXX+yGVUR7Xs+Vr
 y4olNimSb+1AcY1/jAJlHD523K0NJL5VsODDQKAY3OyanwlJvHGoDtscgy1xpsml9WRFBE24s
 xV6OWO+N7hqfYUqAy8hEphPVyCNGfhuEvm3623taxvoJwAWBxIg9IYoonqVgCrSuCIvU91qj6
 4lx5VWYxD5yn/Q10udxap2Y/umFdONUhK9xyMcdbPawb/xhFEyCFBYeW+IXD8WSonX+q5DXRX
 jgG2PjHsjdB8LwMRNk3ZBRbinqvgKDD2wMW0WaHwZ9C5AL2K6WVZGARyMum8uIfos0ae472Xu
 REDE98raCMtZUSPK8H0gyQYqS9V8hGdjuDf4EaectfboZburMKWk4NNHSbDb7iaAia+gF2mC6
 Y48XO2IFHIBUEcdBd5ZcUT6687JMHLOmBFMiDsqBnS2o5+WiBlrmIPeWnXZKIgO5xb/zRx/s4
 rRWZs+kuuLJuQdEPW4GVmIOoro82wB381J2P8CQrzHMpTxxOt161nYl5ZOh/YaXq2jMuluB8j
 FjVfG1bIMWI520eIF3hJtxHYBnrYfZIXETg774/TXrk7GjT9dbBPYs7HgRlNd/Ji4jZ1e6PKN
 3o6eYofop2HUxbSuWEHhnDmWP2skuNsev2TenA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang complains about assigning a variable to itself during the
declaration:

fs/ceph/ioctl.c:187:26: error: variable 'oid' is uninitialized when used within its own initialization [-Werror,-Wuninitialized]
        CEPH_DEFINE_OID_ONSTACK(oid);
                                ^~~
include/linux/ceph/osdmap.h:122:52: note: expanded from macro 'CEPH_DEFINE_OID_ONSTACK'
        struct ceph_object_id oid = CEPH_OID_INIT_ONSTACK(oid)
                              ~~~                         ^~~
include/linux/ceph/osdmap.h:120:29: note: expanded from macro 'CEPH_OID_INIT_ONSTACK'
    ({ ceph_oid_init(&oid); oid; })
                            ^~~

We use this trick in other places, but it is completely unnecessary
here, as we can just use a regular struct initializer.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: rearrange to only have one instance of the initializer
---
 include/linux/ceph/osdmap.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
index 5675b1f09bc5..8794cf0f0b39 100644
--- a/include/linux/ceph/osdmap.h
+++ b/include/linux/ceph/osdmap.h
@@ -110,17 +110,16 @@ struct ceph_object_id {
 	int name_len;
 };
 
+#define CEPH_OID_INITIALIZER(oid) { .name = (oid).inline_name }
+
+#define CEPH_DEFINE_OID_ONSTACK(oid)				\
+	struct ceph_object_id oid = CEPH_OID_INITIALIZER(oid)
+
 static inline void ceph_oid_init(struct ceph_object_id *oid)
 {
-	oid->name = oid->inline_name;
-	oid->name_len = 0;
+	*oid = (struct ceph_object_id)CEPH_OID_INITIALIZER(*oid);
 }
 
-#define CEPH_OID_INIT_ONSTACK(oid)					\
-    ({ ceph_oid_init(&oid); oid; })
-#define CEPH_DEFINE_OID_ONSTACK(oid)					\
-	struct ceph_object_id oid = CEPH_OID_INIT_ONSTACK(oid)
-
 static inline bool ceph_oid_empty(const struct ceph_object_id *oid)
 {
 	return oid->name == oid->inline_name && !oid->name_len;
-- 
2.20.0

