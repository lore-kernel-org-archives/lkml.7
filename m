Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67083C742B0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D922064B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfGLJFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 05:05:18 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:45061 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfGLJFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 05:05:17 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MV6G6-1hwH5Z2EoY-00SB3h; Fri, 12 Jul 2019 11:04:59 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] slab: work around clang bug #42570
Date:   Fri, 12 Jul 2019 11:04:39 +0200
Message-Id: <20190712090455.266021-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Ny01W1sDzoQkytMwytJIIrYFKJMAp43dk5NNDspRvnOllp9EkZr
 VuzyTUNjSse8EsEyCqr7kc40Ba4ziU5ZJeO+1M9SBaOgjKuIZikTFUdKqTjhsp1dC0hMyAb
 pzT0cscZoUzBS9aQuvnFE7VnM1CNm1uE1TfgnnqFyCIqm3ZduBeyRgSaa+3GiB+97zyK7Fg
 Vq+dXYbjGqocQuWH5gCnQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FRhumaWfoBg=:uF2ZId5iyFd22A6N4mOrDZ
 DtmIL69RcbPhxVSvodv4SUhsYV3+yTK/vCQrNs/qghahhIl06Oaaj1oGMBTiXb1ZEJ0kvWka/
 sKHJbkSki3UoNonkKIXFm6kJbKDjygapYoW0EpCAJQ7ysWmxe2LOwY5SeEOr18TmoogwlUW7w
 RWOiJpzdMDSPkR9+1kD5+ouGToWbg07Sh+iVwcqcvBLDRIFuY0Lr6K3WfrDh9+igLUXmNr9Dq
 +uoq6gYSfqg6ZQr1Ta+90TtUt9blY4SiRiiHiBz4uU6cw4VFzSa35XjGdq6LdAHaoA6zNigPQ
 ehN3T8Bwk+7/ZwQFIx8X6EJXFRMVpz36YVZwn208Q+krl8PTa17VZDTpRmxz4I6XyaHEcd7tw
 XNjGA21LQmrxeNMfuOTYT59cD6THL8xnGL4zEuVG5mn0+zotPWlKWihBZWGGp/zCQQDeMuqmg
 mH6GfOwLdOsSOQHM/7q1NYMkDcCLJvbKCqICmPvX12LY5VeJXgbjSbUlkr4D+aCIARFWGN4bu
 2/uYYtvJ8MkKxNyV0wjTIg0X5VtdPvj34xCu404qgrfovh86PGxQeY5y6lSi3G4kic5Rgz3tv
 4OlnfYOM+WO34ViWN+LZnpgELAknvuzOgatnlXyoQaf1ho4dY8cyqujhqcHuJeoiio9WKRjEU
 ZsSHw0gqQmRAi5jhR7aDBJr2ye0/ArzAZ+LEuIW1OOWycpVPns/zzcQh5FBLSnsM9+WagkJsQ
 RO479U51Z4FBGauyIZAB2MKq45G9BqYlZQN9eQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang gets rather confused about two variables in the same special
section when one of them is not initialized, leading to an assembler
warning later:

/tmp/slab_common-18f869.s: Assembler messages:
/tmp/slab_common-18f869.s:7526: Warning: ignoring changed section attributes for .data..ro_after_init

Adding an initialization to kmalloc_caches is rather silly here
but does avoid the issue.

Link: https://bugs.llvm.org/show_bug.cgi?id=42570
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
We might decide to wait until this is fixed in clang, but
so far all versions targetting x86 seem to be affected.
---
 mm/slab_common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 6c49dbb3769e..807490fe217a 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1028,7 +1028,8 @@ struct kmem_cache *__init create_kmalloc_cache(const char *name,
 }
 
 struct kmem_cache *
-kmalloc_caches[NR_KMALLOC_TYPES][KMALLOC_SHIFT_HIGH + 1] __ro_after_init;
+kmalloc_caches[NR_KMALLOC_TYPES][KMALLOC_SHIFT_HIGH + 1] __ro_after_init =
+{ /* initialization for https://bugs.llvm.org/show_bug.cgi?id=42570 */ };
 EXPORT_SYMBOL(kmalloc_caches);
 
 /*
-- 
2.20.0

