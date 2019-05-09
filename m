Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED1CC04A6B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 01:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1795214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 01:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfEIBgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 21:36:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56290 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfEIBgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 21:36:55 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7AAEB3082E03;
        Thu,  9 May 2019 01:36:54 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-17.pek2.redhat.com [10.72.12.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2752919744;
        Thu,  9 May 2019 01:36:48 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@kernel.org, bp@alien8.de, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, x86@kernel.org, dyoung@redhat.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v4 0/3] Add restrictions for kexec/kdump jumping between 5-level and 4-level kernel
Date:   Thu,  9 May 2019 09:36:41 +0800
Message-Id: <20190509013644.1246-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 09 May 2019 01:36:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is trying to fix several issues for kexec/kdump when
dynamic switching of paging mode is enabled in x86_64. The current
kernel supports 5-level paging mode, and supports dynamically choosing
paging mode during bootup according to kernel image, hardware and
kernel parameter setting. This flexibility brings several issues for
kexec/kdump:

Issues:
1)
Dynamic switching between paging mode requires code change in target
kernel. So we can't kexec jump from 5-level kernel to old 4-level
kernel which lacks the code change.

2)
Switching from 5-level paging to 4-level paging kernel would fail, if
kexec() put kernel image above 64TiB of memory.

3)
Kdump jumping has similar issue as 2). This require us to only
reserve crashkernel below 64TB, otherwise jumping from 5-level to
4-level kernel will fail.

Note:
Since we have two interfaces kexec_load() and kexec_file_load() to load
kexec/kdump kernel, handling for them is a little different. For
kexec_load(), most of the loading job is done in user space utility
kexec_tools. However, for kexec_file_load(), most of the loading codes
have moved into kernel because of kernel image verification.

Fixes:
a) For issue 1), we need check if XLF_5LEVEL is set, otherwise error out
   a message.
  -This need be done in both kernel and kexec_tools utility.
  -Patch 2/3 is the handling of kernel part.
  -Will post user space patch to kexec mailing list later.

b) For issue 2), we need check if both XLF_5LEVEL and XLF_5LEVEL_ENABLED
   are set, otherwise error out a message.
  -This only need be done in kexec_tools utility. Because for
   kexec_file_load(), the current code searches area to put kernel from
   bottom to up in system RAM, we usually can always find an area below
   4 GB, no need to worry about 5-level kernel jumping to 4-level
   kernel. While for kexec_load(), it's top down seraching area for kernel
   loading, and implemented in user space. We need make sure that
   5-level kernel find an area under 64 TB for a kexec-ed kernel of
   4-level.
  -Will post user space patch to kexec mailing list later.

c) For issues 3), just limit kernel to reserve crashkernel below 64 TB.
  -This only need be done in kernel.
  -It doesn't need to check bit XLF_5LEVEL or XLF_5LEVEL_ENABLED, we
   just simply limit it below 64 TB which should be enough. Because
   crashernel is reserved during the 1st kernel's bootup, we don't know
   what kernel will be loaded for kdump usage.
  -Patch 3/3 handles this.

Changelog:
v3->v4:
  No functional change.
  - Rewrite log of patch 1/3 tell who the newly added bits are gonna be
    used.
  - Rewrite log of patch 2/3 per tglx's words.
  - Add Kirill's Acked-by.
  
  
v2->v3:
  Change the constant to match the notation for the rest of defines as
  Kirill suggested;
v1->v2:
  Correct the subject of patch 1 according to tglx's comment;
  Add more information to cover-letter to address reviewers' concerns;

The original v1 post can be found here:
http://lkml.kernel.org/r/20180829141624.13985-1-bhe@redhat.com

Later a v1 RESEND version:
http://lkml.kernel.org/r/20190125022817.29506-1-bhe@redhat.com

V2 post is here:
http://lkml.kernel.org/r/20190312005004.19182-1-bhe@redhat.com

v3 post:
http://lkml.kernel.org/r/20190312103051.18086-1-bhe@redhat.com

Baoquan He (3):
  x86/boot: Add xloadflags bits for 5-level kernel checking
  x86/kexec/64: Error out if try to jump to old 4-level kernel from
    5-level kernel
  x86/kdump/64: Change the upper limit of crashkernel reservation

 arch/x86/boot/header.S                | 12 +++++++++++-
 arch/x86/include/uapi/asm/bootparam.h |  2 ++
 arch/x86/kernel/kexec-bzimage64.c     |  5 +++++
 arch/x86/kernel/setup.c               | 17 ++++++++++++++---
 4 files changed, 32 insertions(+), 4 deletions(-)

-- 
2.17.2

