Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EBCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C2A21874
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbfCVOI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:08:29 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:58071 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbfCVOI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:08:28 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mqrjz-1gcevc2lvt-00mwa8; Fri, 22 Mar 2019 15:08:21 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ilya Dryomov <idryomov@gmail.com>, "Yan, Zheng" <zyan@redhat.com>,
        Sage Weil <sage@redhat.com>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Alex Elder <elder@linaro.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ceph: fix clang warning for CEPH_DEFINE_OID_ONSTACK
Date:   Fri, 22 Mar 2019 15:08:11 +0100
Message-Id: <20190322140819.300740-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xmzUNNjc8rjml5exAxA6yJVE0D0zQCC4pJ+goEu42NQOun028TV
 6x2o0AL8lelqRC1SuI6igqzUUFxnejyhCKa9e7n4UJwheNK8NE/0Z6OdNujVaRdIZPaWhJF
 qRyV/0YiFWz9iqxVBpjL084CKnoNvfNyVXJWnDhMnczBXQWh29liyzBnN5yiHwMCMYSLCOi
 flS02ny6nUIxlgZQQimdw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uWB2USANmXk=:4g9ePn/SIKxtGLVrQu0nMZ
 Bzu6OUPVPt8oFptL/OZbiJaJP0ftZ28UPRwtkzhivsP9g20f8w7flnkHJbv4410WLPkcmOMSQ
 BeeMkk1fnYyfZURYnMHVw3PKDi6wSTAcbmadxgWYbyN28O02vCaazi3MUK0NJnnBwiAZGM5Qk
 H2bpEFR6gyx8cWBddZePg0YDWLKA/1OsLzezgbXiBWbMOQo7s2YzPW82tNTgKGoS2KYD06heN
 ohdBkCKOdak+DdLN0TKzJD8rV5M87akdsFkPQgOImqrJExXlPi05WU1AUAOQ3CKXNorC3nNP9
 sWXR+hMboWOjIGi/s5mOqmWvtneQeBOJc2hOM9El74iFEQLYH0LAKZPrlEv/ESbi+EzWvC8+Y
 brNWOontrWyBeqlRFnedsCML/PhtNmzGWt/BzewAoqjAquCe32BeRRQbXR9YsMG2kYLqbKX5N
 rUUPTTyEYGGebDrhjKIErd63L7GrfbQYQ+/t2k2FFZu/2qJPA2DEyc71tgUlb9G/gQYUy689z
 2lGIHJckOXtw97JceHUtS4Xeg8n52a8Vm2W4Cu/GxTqAOcgnF6hdvYXDEv3U7vK4HFA+i7Fh9
 Ep9/h6aZUIooz6m+lBs4YCDeVUfSrCE57PxJbpSk7ska75ahlYRXNput+q4WvbOslvoa8u0Yj
 JmA2jxLaYT6KQdAgEtgMWlGuuqqJmEzHFj93EHB8hW+Fo6aVAEG5gPqZsFKzpd/ULKIVz8t3L
 h94CpkEo42ZTkPAgKxaOYrRNhvROUgA6ofsW+g==
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
 include/linux/ceph/osdmap.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
index 5675b1f09bc5..82f957a7a0d6 100644
--- a/include/linux/ceph/osdmap.h
+++ b/include/linux/ceph/osdmap.h
@@ -116,10 +116,8 @@ static inline void ceph_oid_init(struct ceph_object_id *oid)
 	oid->name_len = 0;
 }
 
-#define CEPH_OID_INIT_ONSTACK(oid)					\
-    ({ ceph_oid_init(&oid); oid; })
 #define CEPH_DEFINE_OID_ONSTACK(oid)					\
-	struct ceph_object_id oid = CEPH_OID_INIT_ONSTACK(oid)
+	struct ceph_object_id oid = { .name = oid.inline_name }
 
 static inline bool ceph_oid_empty(const struct ceph_object_id *oid)
 {
-- 
2.20.0

