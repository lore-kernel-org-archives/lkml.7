Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D946C742B0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2443521537
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfGLJMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 05:12:03 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:35829 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfGLJMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 05:12:02 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MnaTt-1iDnxj0N1B-00jd8T; Fri, 12 Jul 2019 11:11:50 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Hugh Dickins <hughd@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] thp: fix unused shmem_parse_huge() function warning
Date:   Fri, 12 Jul 2019 11:11:31 +0200
Message-Id: <20190712091141.673355-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2eYIEw+FuGFLaFFnKIH/ts58p8jvvELIVRGUWlzkTykX3ykX0/v
 ts+nAn49miAUJt8DvK+mqbmcyi6PwAVzbh9XnS5MWrU1+0O/eSmcmtzcL9ONUd/zHoqYZcr
 fsERZV6Xr78UtnbuWoFCE8702Z6CLbbbh8uTN8jvzkak2k/Uz76hgbkwxo/Sl1gDg9Wr9RL
 vH2DwCgQDpxF8RtsHhT/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kB4x/oMdogU=:EO0/ZP+FT9QwyUf+U6kfWc
 7qWi0vAfAJ0UNZxCoPw1s9vdsQR5HuuxaUcG620tLFT5CDfqfKRlAZZ2zi09a1BGb7yxqoIqs
 dXF7oouoNuO8xAB9EwpGaBiEzWxZIXheV8BK4jZ1wYdrMVrvEYx+G39Ltz0ecHVVOd8fgh66o
 HFRmBkzd81ZvnRLNE30PdmqghI1UMsKfQ4gf00oSovZ9UU0wRhXENIcgQLuJzA9rTcMX203Bq
 aubOpVMzPrrxwCZxb2bpRmgAL9PnYCwHqw7vBG5BDxlPD40BZdXfq2hzCTsKhM+FigKAr5y80
 auciZSt6hMaNNlL8AqEERLNvLNgvGES2Z7Gc8lOtYlyvR8I/wSg/x1Ke998J3R8oGwrutri/Z
 Xw15NZr+Oh+i3sGPXFx7K5SVXJPXJ0F3hQhk0LwBwITvpcNwFDGsGQAsow2L1yJRItHppX901
 7rHz2v7ZaC/8vdF04KI9HM+LftErdeoJHUDXBYpFJMJKx50Ja/JLDPLDlrufKTizK5oCATuZv
 KD0pTtN/NQdld53T3TbwP0T7386ZTJvtRlP+LyHZioJxy/RsnaaSwPkWz3xXK5ou0WtLNUyOw
 Es67mvHLLd5k/DylVctvadLlv1rNaqd8TlemH7KRuNT3bh9gDDCdiwz0d6BkmPr9tjf8Kq2FM
 wAUBQZ2G2DwJ8HAPIOTLd3bTMLSdM2cbK7Tvl/wQCz0XpCvZ2ugC+PBDteVUooi3bLMAdaC15
 fCKn4ZEtReAb3mM0txlBiUjFw2vGxdSET/R6pg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_SYSFS is disabled but CONFIG_TMPFS is enabled, we get a warning
about shmem_parse_huge() never being called:

mm/shmem.c:417:12: error: unused function 'shmem_parse_huge' [-Werror,-Wunused-function]
static int shmem_parse_huge(const char *str)

Change the #ifdef so we no longer build this function in that configuration.

Fixes: 144df3b288c4 ("vfs: Convert ramfs, shmem, tmpfs, devtmpfs, rootfs to use the new mount API")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/shmem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index ba40fac908c5..32aa9d46b87c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -413,7 +413,7 @@ static bool shmem_confirm_swap(struct address_space *mapping,
 
 static int shmem_huge __read_mostly;
 
-#if defined(CONFIG_SYSFS) || defined(CONFIG_TMPFS)
+#if defined(CONFIG_SYSFS)
 static int shmem_parse_huge(const char *str)
 {
 	if (!strcmp(str, "never"))
@@ -430,7 +430,9 @@ static int shmem_parse_huge(const char *str)
 		return SHMEM_HUGE_FORCE;
 	return -EINVAL;
 }
+#endif
 
+#if defined(CONFIG_SYSFS) || defined(CONFIG_TMPFS)
 static const char *shmem_format_huge(int huge)
 {
 	switch (huge) {
-- 
2.20.0

