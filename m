Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEEBC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 10:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC87214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 10:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="HzPImJ5C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730774AbfFTKEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 06:04:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35129 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfFTKEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 06:04:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5KA3IqW907930
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 20 Jun 2019 03:03:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5KA3IqW907930
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561025000;
        bh=PZckn3lCSiUSIpT3DisREcwVRo73zjJKZsS5wSAPdvE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=HzPImJ5CZAc99xLBooX1axgn7EBpR9sQeu6Z+p9yXxnxmwoiOycY3/PvUSz/UVgds
         4khRUNK2bCu0xlmh3gEmR43/vB8dB5X71NyoPrIJIbdRiCeFhLbPszMj1YGHo6DCcz
         gawNonpqNeSvXikY3C7MgVm3w8WUQC3L1f2SY6kb0RoXIMmMqH+UwdboguQx1naBuq
         Z6h37rxTeNIA2icUew9Vrj0D4DFa4wD0jXYT4pRKqv3ApYlp3Wx6u+fIdOVu/IoIvy
         g+u+v8hQQDJfZoUxKC4m5hBwZjiVE9e80NPhAzV5/5BfnjYU2ku0StywlqVoptKyCs
         VDZ9/uJDsTc2Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5KA3HTP907920;
        Thu, 20 Jun 2019 03:03:17 -0700
Date:   Thu, 20 Jun 2019 03:03:17 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Lianbo Jiang <tipbot@zytor.com>
Message-ID: <tip-4eb5fec31e613105668a1472d5876f3d0558e5d8@git.kernel.org>
Cc:     rppt@linux.vnet.ibm.com, thomas.lendacky@amd.com, hpa@zytor.com,
        tglx@linutronix.de, adobriyan@gmail.com, arnd@arndb.de,
        jrdr.linux@gmail.com, mingo@kernel.org, x86@kernel.org,
        lijiang@redhat.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, bp@suse.de, ganeshgr@chelsio.com,
        akpm@linux-foundation.org, rahul.lakkireddy@chelsio.com,
        brijesh.singh@amd.com
Reply-To: hpa@zytor.com, thomas.lendacky@amd.com, rppt@linux.vnet.ibm.com,
          tglx@linutronix.de, lijiang@redhat.com, jrdr.linux@gmail.com,
          mingo@kernel.org, x86@kernel.org, arnd@arndb.de,
          adobriyan@gmail.com, brijesh.singh@amd.com, ganeshgr@chelsio.com,
          rahul.lakkireddy@chelsio.com, akpm@linux-foundation.org,
          bp@suse.de, linux-kernel@vger.kernel.org, willy@infradead.org
In-Reply-To: <20190430074421.7852-4-lijiang@redhat.com>
References: <20190430074421.7852-4-lijiang@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/kdump] fs/proc/vmcore: Enable dumping of encrypted memory
 when SEV was active
Git-Commit-ID: 4eb5fec31e613105668a1472d5876f3d0558e5d8
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  4eb5fec31e613105668a1472d5876f3d0558e5d8
Gitweb:     https://git.kernel.org/tip/4eb5fec31e613105668a1472d5876f3d0558e5d8
Author:     Lianbo Jiang <lijiang@redhat.com>
AuthorDate: Tue, 30 Apr 2019 15:44:21 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 20 Jun 2019 10:07:49 +0200

fs/proc/vmcore: Enable dumping of encrypted memory when SEV was active

In the kdump kernel, the memory of the first kernel gets to be dumped
into a vmcore file.

Similarly to SME kdump, if SEV was enabled in the first kernel, the old
memory has to be remapped encrypted in order to access it properly.

Commit

  992b649a3f01 ("kdump, proc/vmcore: Enable kdumping encrypted memory with SME enabled")

took care of the SME case but it uses sme_active() which checks for SME
only. Use mem_encrypt_active() instead, which returns true when either
SME or SEV is active.

Unlike SME, the second kernel images (kernel and initrd) are loaded into
encrypted memory when SEV is active, hence the kernel elf header must be
remapped as encrypted in order to access it properly.

 [ bp: Massage commit message. ]

Co-developed-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: bhe@redhat.com
Cc: dyoung@redhat.com
Cc: Ganesh Goudar <ganeshgr@chelsio.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: kexec@lists.infradead.org
Cc: linux-fsdevel@vger.kernel.org
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: mingo@redhat.com
Cc: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Cc: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190430074421.7852-4-lijiang@redhat.com
---
 fs/proc/vmcore.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 7bb96fdd38ad..57957c91c6df 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -166,7 +166,7 @@ void __weak elfcorehdr_free(unsigned long long addr)
  */
 ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
 {
-	return read_from_oldmem(buf, count, ppos, 0, false);
+	return read_from_oldmem(buf, count, ppos, 0, sev_active());
 }
 
 /*
@@ -174,7 +174,7 @@ ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
  */
 ssize_t __weak elfcorehdr_read_notes(char *buf, size_t count, u64 *ppos)
 {
-	return read_from_oldmem(buf, count, ppos, 0, sme_active());
+	return read_from_oldmem(buf, count, ppos, 0, mem_encrypt_active());
 }
 
 /*
@@ -374,7 +374,7 @@ static ssize_t __read_vmcore(char *buffer, size_t buflen, loff_t *fpos,
 					    buflen);
 			start = m->paddr + *fpos - m->offset;
 			tmp = read_from_oldmem(buffer, tsz, &start,
-					       userbuf, sme_active());
+					       userbuf, mem_encrypt_active());
 			if (tmp < 0)
 				return tmp;
 			buflen -= tsz;
