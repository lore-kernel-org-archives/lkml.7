Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CDCC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23632084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfFQMQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:16:25 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:39229 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFQMQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:16:25 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mn1iT-1iIoa32p7v-00kBBk; Mon, 17 Jun 2019 14:14:44 +0200
From:   Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Roman Penyaev <rpenyaev@suse.de>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [BUG]: mm/vmalloc: uninitialized variable access in pcpu_get_vm_areas
Date:   Mon, 17 Jun 2019 14:14:11 +0200
Message-Id: <20190617121427.77565-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:tTeqNGd4TVlIml5CMtu2lMEK72C2cmu0L9gWMplwst9AdyblEhs
 /0GtS05lmzrqMN+S4zaQlZdDFpVtXvZDzOGUU/lEIyDDojFmYV7qBw5N800RdJ/exviAEh2
 bwxyVHQcntNpqtK3OsDbSbxrB1vvLAa9d/sppldXDeuvrcB81qPmTI0bBovbNv4DbdqOhX6
 /VeAekZToBibxtpGIUakg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5xtYdggVb/A=://lSt3xAZ83zGcKRhCe14J
 +CuhOHiyn4wqvnJJkAfHxsJmn+sIb1JQ3abjypPEJGTzZsew1dIaDOszL54oqYOAEshi+eDRm
 jymPkZpcYMppwZfoCDckrWlK8/RidzMkTcUxoYKzRNI9FD0exgdoqu/wOqS9JkfqT8NBTTJun
 zsoeoK/LJptEQ43ByItpeW6hzvg5BHJLz+jGFu6SsEvw5kA93RvdMrJgLvsiwBfCLz2itlfkX
 Aqu/MAwQ1nHA69Ga0qIr2VDHUsEMf1sw3RUoEaAe/SkpTY65dnhsIOzccSyOtXafgEPT/PVVN
 ReseF9Rs8yM2MqTNwJ8Qec/4EQ8ikeiME+An4TXwic7SCmsfgKiNspk5eaYWLGD5Hprgu5dC7
 OgsfkSqwXf0M1d9kbS0t8R22rQg6q+vYChxvYspng5AjkdAjhQPfHGlelY3sqSfaipWuh/0K+
 pRuPrQK2vez1y+1cOGcsuI0LWa5/dwqUkl9cCq29nn9dxTkQzhimFk1OoAqTEZ5Li88iOIjT/
 cIbXwWiEDsCd44CPzNXFWTXjmmvfs53T8GUPir6iK0L+n029eFmS9Y9q8cDVeSEZQoWItCVyO
 ybQPzt+Hv79ihJrzbAh2tOsZ2DHcKazrYMi3AdajY2sJhlONFxC75LkJ62KG0q5/telLrRmXn
 iXGN3AFE7THZt6qIYKmqNawGoswPSgpVfOD953kict+xZH3R5l8IJic3d4nZYPkYQn3nO0BEq
 4DlevSOlSCpFdd4yNVTiLK0lyMukQ3MuK8UxaA==
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc points out some obviously broken code in linux-next

mm/vmalloc.c: In function 'pcpu_get_vm_areas':
mm/vmalloc.c:991:4: error: 'lva' may be used uninitialized in this function [-Werror=maybe-uninitialized]
    insert_vmap_area_augment(lva, &va->rb_node,
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     &free_vmap_area_root, &free_vmap_area_list);
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
mm/vmalloc.c:916:20: note: 'lva' was declared here
  struct vmap_area *lva;
                    ^~~

Remove the obviously broken code. This is almost certainly
not the correct solution, but it's what I have applied locally
to get a clean build again.

Please fix this properly.

Fixes: 68ad4a330433 ("mm/vmalloc.c: keep track of free blocks for vmap allocation")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/vmalloc.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index a9213fc3802d..bfcf0124a773 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -984,14 +984,9 @@ adjust_va_to_fit_type(struct vmap_area *va,
 		return -1;
 	}
 
-	if (type != FL_FIT_TYPE) {
+	if (type == FL_FIT_TYPE)
 		augment_tree_propagate_from(va);
 
-		if (type == NE_FIT_TYPE)
-			insert_vmap_area_augment(lva, &va->rb_node,
-				&free_vmap_area_root, &free_vmap_area_list);
-	}
-
 	return 0;
 }
 
-- 
2.20.0

