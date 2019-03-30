Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98950C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61ACE218CD
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="r2yLcjas"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730650AbfC3Qlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 12:41:42 -0400
Received: from forward501j.mail.yandex.net ([5.45.198.251]:43288 "EHLO
        forward501j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730395AbfC3Qlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 12:41:42 -0400
Received: from mxback15o.mail.yandex.net (mxback15o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::66])
        by forward501j.mail.yandex.net (Yandex) with ESMTP id 0A0063380055;
        Sat, 30 Mar 2019 19:41:38 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback15o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id FwYt6bfWhz-fUuGwdtu;
        Sat, 30 Mar 2019 19:41:37 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1553964097;
        bh=BAGuq6aY41vQoMTVybblCDo6g+wTKuB5ZkNrCMXNEeI=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=r2yLcjasL66jIafN59BUK+sNyksLUyMg6rcLPmogPy/2DlS0P/jSubx07PiOJqTv4
         UrX91bPScueQ2KihFcebl6F7npigS0F0/mtjTfsIKZ3lZYvTmqBZ1MzsKkxVLCINhx
         CLR56e2I5oHl+LwxkL8NnPLdj6sMk5V+40LdDaG8=
Authentication-Results: mxback15o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by iva7-8a22bc446c12.qloud-c.yandex.net with HTTP;
        Sat, 30 Mar 2019 19:41:30 +0300
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
Subject: [PATCH 2/5] powerpc: module_[32|64].c: replace swap function with built-in one
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Sat, 30 Mar 2019 19:41:30 +0300
Message-Id: <21287961553964090@iva7-8a22bc446c12.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace relaswap with built-in one, because of relaswap
does a simple byte to byte swap.

Signed-off-by: Andrey Abramov <st5pub@yandex.ru>
---
 arch/powerpc/kernel/module_32.c | 17 +----------------
 arch/powerpc/kernel/module_64.c | 17 +----------------
 2 files changed, 2 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/kernel/module_32.c b/arch/powerpc/kernel/module_32.c
index 88d83771f462..c311e8575d10 100644
--- a/arch/powerpc/kernel/module_32.c
+++ b/arch/powerpc/kernel/module_32.c
@@ -79,21 +79,6 @@ static int relacmp(const void *_x, const void *_y)
 		return 0;
 }
 
-static void relaswap(void *_x, void *_y, int size)
-{
-	uint32_t *x, *y, tmp;
-	int i;
-
-	y = (uint32_t *)_x;
-	x = (uint32_t *)_y;
-
-	for (i = 0; i < sizeof(Elf32_Rela) / sizeof(uint32_t); i++) {
-		tmp = x[i];
-		x[i] = y[i];
-		y[i] = tmp;
-	}
-}
-
 /* Get the potential trampolines size required of the init and
    non-init sections */
 static unsigned long get_plt_size(const Elf32_Ehdr *hdr,
@@ -130,7 +115,7 @@ static unsigned long get_plt_size(const Elf32_Ehdr *hdr,
 			 */
 			sort((void *)hdr + sechdrs[i].sh_offset,
 			     sechdrs[i].sh_size / sizeof(Elf32_Rela),
-			     sizeof(Elf32_Rela), relacmp, relaswap);
+			     sizeof(Elf32_Rela), relacmp, NULL);
 
 			ret += count_relocs((void *)hdr
 					     + sechdrs[i].sh_offset,
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 8661eea78503..0c833d7f36f1 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -231,21 +231,6 @@ static int relacmp(const void *_x, const void *_y)
 		return 0;
 }
 
-static void relaswap(void *_x, void *_y, int size)
-{
-	uint64_t *x, *y, tmp;
-	int i;
-
-	y = (uint64_t *)_x;
-	x = (uint64_t *)_y;
-
-	for (i = 0; i < sizeof(Elf64_Rela) / sizeof(uint64_t); i++) {
-		tmp = x[i];
-		x[i] = y[i];
-		y[i] = tmp;
-	}
-}
-
 /* Get size of potential trampolines required. */
 static unsigned long get_stubs_size(const Elf64_Ehdr *hdr,
 				    const Elf64_Shdr *sechdrs)
@@ -269,7 +254,7 @@ static unsigned long get_stubs_size(const Elf64_Ehdr *hdr,
 			 */
 			sort((void *)sechdrs[i].sh_addr,
 			     sechdrs[i].sh_size / sizeof(Elf64_Rela),
-			     sizeof(Elf64_Rela), relacmp, relaswap);
+			     sizeof(Elf64_Rela), relacmp, NULL);
 
 			relocs += count_relocs((void *)sechdrs[i].sh_addr,
 					       sechdrs[i].sh_size
-- 
2.21.0


