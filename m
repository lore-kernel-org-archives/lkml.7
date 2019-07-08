Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E4CC606AF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 12:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 042002064A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 12:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731062AbfGHMwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 08:52:36 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:34375 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbfGHMwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 08:52:35 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MALql-1hd0Lw2Uqh-00Bs63; Mon, 08 Jul 2019 14:52:19 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Peng Fan <peng.fan@nxp.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] percpu: fix pcpu_page_first_chunk return code handling
Date:   Mon,  8 Jul 2019 14:52:09 +0200
Message-Id: <20190708125217.3757973-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:cJtj1haBkBbWRm+C+Iua7rdvkbZLbR4MZWZ6z3vSC1X/PXqtkAs
 R+qNUxDsVrk6zgmmdUs6UXIxDw//8IMdKBSJyl1ZUQl9wsyHhvL31/QV8xXn9D8roifT7PY
 GZ1A9E8jTpmXrMwd7rc7egfuxl6cmhOPGYiLqpJKpDSL/DxvxmrJsuTXEe081AhSnUqL2GX
 Ub4oC7dZySA4sOigUqskA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ITl96BottfQ=:qqxhzos/aOanf3aqBADACV
 JwgD/BUjtgaC1QokhGuyrwx9DsbxnL44mYL17o/rvkq300Dt+Iyleg1ZQwXxaUQ3vnRZAvEF5
 xOEvUpaESSPGruqL33FOixV+UbWXKGDJn6tNBqOxunBZbQ2QQZT64w9L7ANwxAZwXsjrmmmT5
 Rl1TvI0bxyEg8Bzub6PXaQL89ZLZsCW9JVrV/ShakwTiJcIusHUcNTuBSXuuNd+QlKHB+3pb7
 PtwTXRrNEGANSh0UAi8Gw6HXax3DSOaqZcLy3nweZ2himUOJELhpVMQMPNcTypax5bEKG8TvD
 PL4QykHTINpFOQo7eu3Oj1CTPXEVazMUBTRjsuOGTR6pbjDRXvBZdxgl2XJRYpyYprEEnVl0t
 Ub1w5K4+yQG8XlHNCNPKUrtXz3TulnB9Wb7OSU/u4GAWRL7OEvsHHncCBgxyyta4+X3I/aPrn
 oTa8fnO+i8VLlgUYGmkZ32uv9tMjbNn1rao1HPmzu8QJ86UUbsNgdEg8UDh1iaGf2qNUOkarZ
 +hmD7nZH/2Y3jNzeO1gdirDawiVUBRztfjcloIbt++CucLtIuZmv3WBOK04ERzeawGNyRWyom
 HfeJn13r1mqX56Vg8d5IdgOiUSo+0XnvSOo37Iz3A7YZWP4uTCUPhV3nIESaeQd6Ukjf8U2fP
 Wb4ngytBXr4k5s64ogPVtk/CGed73Ns0xrh0/X2f+PCEQD0HvVVgmKCkD5A2vtFzhTfWSPrkN
 4R0t/U9YTMtk/TpTC68ZfJTIJDUhFNxssqnwRA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc complains that pcpu_page_first_chunk() might return an uninitialized
error code when the loop is never entered:

mm/percpu.c: In function 'pcpu_page_first_chunk':
mm/percpu.c:2929:9: error: 'rc' may be used uninitialized in this function [-Werror=maybe-uninitialized]

Make it return zero like before the cleanup.

Fixes: a13e0ad81216 ("percpu: Make pcpu_setup_first_chunk() void function")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/percpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/percpu.c b/mm/percpu.c
index 5a918a4b1da0..5b65f753c575 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -2917,6 +2917,7 @@ int __init pcpu_page_first_chunk(size_t reserved_size,
 		ai->reserved_size, ai->dyn_size);
 
 	pcpu_setup_first_chunk(ai, vm.addr);
+	rc = 0;
 	goto out_free_ar;
 
 enomem:
-- 
2.20.0

