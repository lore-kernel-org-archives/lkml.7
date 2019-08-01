Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A229DC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC3B206A3
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732318AbfHAPC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 11:02:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44260 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbfHAPC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:02:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 687B43092409;
        Thu,  1 Aug 2019 15:02:57 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-18.pek2.redhat.com [10.72.12.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 62C9A579B4;
        Thu,  1 Aug 2019 15:02:53 +0000 (UTC)
From:   lijiang <lijiang@redhat.com>
Subject: crash: `kmem -s` reported "kmem: dma-kmalloc-512: slab:
 ffffe192c0001000 invalid freepointer: e5ffef4e9a040b7e" on a dumped vmcore
To:     "Lendacky, Thomas" <thomas.lendacky@amd.com>,
        Dave Young <dyoung@redhat.com>,
        Lianbo Jiang <lijiang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dave Anderson <anderson@redhat.com>
Message-ID: <e640b50a-a962-8e56-33a2-2ba2eb76e813@redhat.com>
Date:   Thu, 1 Aug 2019 23:02:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 01 Aug 2019 15:02:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tom

Recently, i ran into a problem about SME and used crash tool to check the vmcore as follow: 

crash> kmem -s | grep -i invalid
kmem: dma-kmalloc-512: slab: ffffe192c0001000 invalid freepointer: e5ffef4e9a040b7e
kmem: dma-kmalloc-512: slab: ffffe192c0001000 invalid freepointer: e5ffef4e9a040b7e

And the crash tool reported the above error, probably, the main reason is that kernel does not
correctly handle the first 640k region when SME is enabled.

When SME is enabled, the kernel and initramfs images are loaded into the decrypted memory, and
the backup area(first 640k) is also mapped as decrypted, but the first 640k data is copied to
the backup area in purgatory(). Please refer to this file: arch/x86/purgatory/purgatory.c
......
static int copy_backup_region(void)
{
        if (purgatory_backup_dest) {
                memcpy((void *)purgatory_backup_dest,
                       (void *)purgatory_backup_src, purgatory_backup_sz);
        }
        return 0;
}
......

arch/x86/kernel/machine_kexec_64.c
......
machine_kexec_prepare()->
arch_update_purgatory()->
.....

Actually, the firs 640k area is encrypted in the first kernel when SME is enabled, here kernel
copies the first 640k data to the backup area in purgatory(), because the backup area is mapped
as decrypted, this copying operation makes that the first 640k data is decrypted(decoded) and
saved to the backup area, but probably kernel can not aware of SME in purgatory(), which causes
kernel mistakenly read out the first 640k.

In addition, i hacked kernel code as follow:

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 7bcc92add72c..a51631d36a7a 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -377,6 +378,16 @@ static ssize_t __read_vmcore(char *buffer, size_t buflen, loff_t *fpos,
                                            m->offset + m->size - *fpos,
                                            buflen);
                        start = m->paddr + *fpos - m->offset;
+                       if (m->paddr == 0x73f60000) {//the backup area's start address:0x73f60000
+                               tmp = read_from_oldmem(buffer, tsz, &start,
+                                               userbuf, false);
+                       } else
                                tmp = read_from_oldmem(buffer, tsz, &start,
                                               userbuf, mem_encrypt_active());
                        if (tmp < 0)

Here, i used the crash tool to check the vmcore, i can see that the backup area is decrypted,
except for the dma-kmalloc-512. So i suspect that kernel did not correctly read out the first
640k data to backup area. Do you happen to know how to deal with the first 640k area in purgatory()
when SME is enabled? Any idea?

BTW: I' curious the reason why the address of dma-kmalloc-512k always falls into the first 640k
region, and i did not see the same issue on another machine.

Machine:
Serial Number 	diesel-sys9079-0001
Model           AMD Diesel (A0C)
CPU             AMD EPYC 7601 32-Core Processor


Background:
On x86_64, the first 640k region is special because of some historical reasons. And kdump kernel will
reuse the first 640k region, so kernel will back up(copy) the first 640k region to a backup area in
purgatory(), in order not to rewrite the old region(640k) in kdump kernel, which makes sure that kdump
can read out the old memory from vmcore.


Thanks.
Lianbo
