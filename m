Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6205C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 942F5218A3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="QTkIh7Rx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbfC3QnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 12:43:13 -0400
Received: from forward500j.mail.yandex.net ([5.45.198.250]:37524 "EHLO
        forward500j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730154AbfC3QnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 12:43:12 -0400
Received: from mxback10o.mail.yandex.net (mxback10o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::24])
        by forward500j.mail.yandex.net (Yandex) with ESMTP id DD3F311C1158;
        Sat, 30 Mar 2019 19:43:08 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback10o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id LJUEnkYk4E-h1u0KTbQ;
        Sat, 30 Mar 2019 19:43:07 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1553964187;
        bh=OUonaHqNIuKuUvrOfReQxgIYdywNfRwJw0ekJZnpMB8=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=QTkIh7RxhBsvpIf8O9AskAid7JET1vywlk3mWjJZ+vvwnNW2lcsBj20bonUUwHwJb
         oxG/xWjFYIB4W//uLG9oQZbZQhZl6SM7CKb4uotorQlzAqMl1ik23ffFVW1XI+HxEQ
         QcR+IpKMGPfzhq5RsGNRYcx5WIQLKMf9S7uPhPms=
Authentication-Results: mxback10o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt5-f1576e7b5bad.qloud-c.yandex.net with HTTP;
        Sat, 30 Mar 2019 19:43:01 +0300
From:   Andrey Abramov <st5pub@yandex.ru>
To:     "vgupta@synopsys.com" <vgupta@synopsys.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "mark@fasheh.com" <mark@fasheh.com>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "richard@nod.at" <richard@nod.at>,
        "dedekind1@gmail.com" <dedekind1@gmail.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        George Spelvin <lkml@sdf.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
Cc:     "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        Morton Andrew <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "malat@debian.org" <malat@debian.org>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "jannh@google.com" <jannh@google.com>,
        "jslaby@suse.cz" <jslaby@suse.cz>,
        "ge.changwei@h3c.com" <ge.changwei@h3c.com>,
        "jiangyiwen@huawei.com" <jiangyiwen@huawei.com>,
        "piaojun@huawei.com" <piaojun@huawei.com>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "ashish.samant@oracle.com" <ashish.samant@oracle.com>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "lchen@suse.com" <lchen@suse.com>,
        "jiang.biao2@zte.com.cn" <jiang.biao2@zte.com.cn>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "kamalesh@linux.vnet.ibm.com" <kamalesh@linux.vnet.ibm.com>
In-Reply-To: <18626931553963861@sas1-b3ec53dbc12b.qloud-c.yandex.net>
References: <18626931553963861@sas1-b3ec53dbc12b.qloud-c.yandex.net>
Subject: [PATCH 4/5] ubifs: find.c: replace swap function with built-in one
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Sat, 30 Mar 2019 19:43:01 +0300
Message-Id: <16620851553964181@myt5-f1576e7b5bad.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace swap_dirty_idx function with built-in one,
because swap_dirty_idx does only a simple byte to byte swap.

Signed-off-by: Andrey Abramov <st5pub@yandex.ru>
---
 fs/ubifs/find.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/fs/ubifs/find.c b/fs/ubifs/find.c
index f9646835b026..5deaae7fcead 100644
--- a/fs/ubifs/find.c
+++ b/fs/ubifs/find.c
@@ -747,12 +747,6 @@ static int cmp_dirty_idx(const struct ubifs_lprops **a,
 	return lpa->dirty + lpa->free - lpb->dirty - lpb->free;
 }
 
-static void swap_dirty_idx(struct ubifs_lprops **a, struct ubifs_lprops **b,
-			   int size)
-{
-	swap(*a, *b);
-}
-
 /**
  * ubifs_save_dirty_idx_lnums - save an array of the most dirty index LEB nos.
  * @c: the UBIFS file-system description object
@@ -772,8 +766,7 @@ int ubifs_save_dirty_idx_lnums(struct ubifs_info *c)
 	       sizeof(void *) * c->dirty_idx.cnt);
 	/* Sort it so that the dirtiest is now at the end */
 	sort(c->dirty_idx.arr, c->dirty_idx.cnt, sizeof(void *),
-	     (int (*)(const void *, const void *))cmp_dirty_idx,
-	     (void (*)(void *, void *, int))swap_dirty_idx);
+	     (int (*)(const void *, const void *))cmp_dirty_idx, NULL);
 	dbg_find("found %d dirty index LEBs", c->dirty_idx.cnt);
 	if (c->dirty_idx.cnt)
 		dbg_find("dirtiest index LEB is %d with dirty %d and free %d",
-- 
2.21.0


