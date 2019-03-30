Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164A5C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D589D218CD
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="XQbJE7yQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbfC3Qkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 12:40:37 -0400
Received: from forward501o.mail.yandex.net ([37.140.190.203]:44565 "EHLO
        forward501o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730395AbfC3Qkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 12:40:37 -0400
Received: from mxback21g.mail.yandex.net (mxback21g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:321])
        by forward501o.mail.yandex.net (Yandex) with ESMTP id 1458A1E80077;
        Sat, 30 Mar 2019 19:40:32 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback21g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id ppVQJ39iEk-eObCmM4j;
        Sat, 30 Mar 2019 19:40:31 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1553964031;
        bh=wUFI0A/Hfi2T5Xw16erqiqcqWUAYT1HNRh6fD4qBsQ0=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=XQbJE7yQ6mIuKw2yugAYZR4wXvmTRE+PODfLC6c8Gx/2w5sW5SVvbS5WFC7jygiey
         PvB7DrToo02sJhGmCMZKW4gTBCVJ+nZV6g/Z6kOFe/+WAciTXjjpfCtCNX+cTC/IAl
         Ds7vDi7SOO1L7UjXwrnzuz24o1XzlbE5kl1t48No=
Authentication-Results: mxback21g.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt2-dc4bba9bb23c.qloud-c.yandex.net with HTTP;
        Sat, 30 Mar 2019 19:40:24 +0300
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
Subject: [PATCH 1/5] arch/arc: unwind.c: replace swap function with built-in one
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Sat, 30 Mar 2019 19:40:24 +0300
Message-Id: <20170071553964024@myt2-dc4bba9bb23c.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace swap_eh_frame_hdr_table_entries with built-in one, because
swap_eh_frame_hdr_table_entries does a simple byte to byte swap.

Signed-off-by: Andrey Abramov <st5pub@yandex.ru>
---
 arch/arc/kernel/unwind.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/arch/arc/kernel/unwind.c b/arch/arc/kernel/unwind.c
index 271e9fafa479..7610fe84afea 100644
--- a/arch/arc/kernel/unwind.c
+++ b/arch/arc/kernel/unwind.c
@@ -248,20 +248,6 @@ static int cmp_eh_frame_hdr_table_entries(const void *p1, const void *p2)
 	return (e1->start > e2->start) - (e1->start < e2->start);
 }
 
-static void swap_eh_frame_hdr_table_entries(void *p1, void *p2, int size)
-{
-	struct eh_frame_hdr_table_entry *e1 = p1;
-	struct eh_frame_hdr_table_entry *e2 = p2;
-	unsigned long v;
-
-	v = e1->start;
-	e1->start = e2->start;
-	e2->start = v;
-	v = e1->fde;
-	e1->fde = e2->fde;
-	e2->fde = v;
-}
-
 static void init_unwind_hdr(struct unwind_table *table,
 			    void *(*alloc) (unsigned long))
 {
@@ -354,10 +340,8 @@ static void init_unwind_hdr(struct unwind_table *table,
 	}
 	WARN_ON(n != header->fde_count);
 
-	sort(header->table,
-	     n,
-	     sizeof(*header->table),
-	     cmp_eh_frame_hdr_table_entries, swap_eh_frame_hdr_table_entries);
+	sort(header->table, n,
+	     sizeof(*header->table), cmp_eh_frame_hdr_table_entries, NULL);
 
 	table->hdrsz = hdrSize;
 	smp_wmb();
-- 
2.21.0


