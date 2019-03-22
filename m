Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB88C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E1E2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbfCVPrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:47:43 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:56459 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfCVPrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:47:41 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MPosX-1hKuvq2lZj-00Mtqj; Fri, 22 Mar 2019 16:47:13 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Hugh Dickins <hughd@google.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Vasily Averin <vvs@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [BACKPORT 4.4.y 12/25] mm/rmap: replace BUG_ON(anon_vma->degree) with VM_WARN_ON
Date:   Fri, 22 Mar 2019 16:44:03 +0100
Message-Id: <20190322154425.3852517-13-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190322154425.3852517-1-arnd@arndb.de>
References: <20190322154425.3852517-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:x9JLVby8r9r7TUxGTqLadFU79q0Pp1coCzkDeRV4r6c3+Dj8drW
 w3wZyzmVLkCOYTZj7d1rl88zJZduSJcyDx7T15j+BD/3ifn1JSCjet7XYnM20CaSy6N1FqD
 7oLYAODBmF5j39idn1uZOpAtb5Pka75NOa5OilzhmcKHyWFj6CykM7EbL/824ma//x/PSon
 oX+qL1Ko/GgJFwkbg64yQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Tc+wj3NMZgw=:RU5Wsg8S3mds99gc6a+cXf
 24zk4q6XyhTdtuLlc4ogImJLY4QiG24v/yy09Tl/6LHmXdSKfSSz0YHGE29MfuqrdWegfJOkP
 HARXOKftZgpOMl+c9zVYH0PEzaM8Tif2m3cTj4zkvf1Y2f8q2ma3eHQ+po2nSuoicrIhb9EJS
 lp2Pe4Ws18R1OVojCdmuEoK4o8x/lOCAkOF4stpcg4PpCzti1AzmQ0ZB5dEcPdRAAhN19JqBv
 2qmULxrOYCuIWVcX5tLf5DMlamm5q1llRTPHC2dZkj1fL42dCF8D+NegqIH4gMhOZdqy3dW1l
 KfFLyp6JOnY9vbztmz3bqyshvyqyogXFd8yivOCzuTmQkItbHHziDVXUR72l0yepI5FAHT4wE
 clQHva8klOUopNyxz6rK45XmcYuZXe3BgbEfyVqT8H0F1z+0upYceQcNDsgGo/Pnk0L88JPj/
 Q2M3FiuLkzN2pXg9ZshcAprVQytMU19AeN8vxAbJ0rbeESp42ZovYrdku5j+ozGN2tMGaGUXY
 FOdw5kl+ItdZaAy1Bn1RgeiSc0nKsNTkaxQaYJyyOFfjJnJDqun+X2FYIxzQBKspWyKBjRYZn
 qLA9ma6JXewR4OR+icxH2Dbq/A78inl8+s0rTxu7gP20oapeMz6R5ZkijTrjybWV8mDLCjzUL
 EBDekinZo6eUHBS6RGHjAtXh0h5mDJ6BaWPIBuiDTr2iAAMkUf3mcAXwwLWLggKUf5zWJzuFQ
 BEzDhhnnoHNiCvGc7jkiDMBXH3aSJW+lLtm8aA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

This check effectively catches anon vma hierarchy inconsistence and some
vma corruptions.  It was effective for catching corner cases in anon vma
reusing logic.  For now this code seems stable so check could be hidden
under CONFIG_DEBUG_VM and replaced with WARN because it's not so fatal.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Suggested-by: Vasily Averin <vvs@virtuozzo.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
(cherry picked from commit e4c5800a3991f0c6a766983535dfc10d51802cf6)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/rmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 488dda209431..cf733fab230f 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -408,7 +408,7 @@ void unlink_anon_vmas(struct vm_area_struct *vma)
 	list_for_each_entry_safe(avc, next, &vma->anon_vma_chain, same_vma) {
 		struct anon_vma *anon_vma = avc->anon_vma;
 
-		BUG_ON(anon_vma->degree);
+		VM_WARN_ON(anon_vma->degree);
 		put_anon_vma(anon_vma);
 
 		list_del(&avc->same_vma);
-- 
2.20.0

