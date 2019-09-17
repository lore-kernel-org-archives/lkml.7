Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86A3C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ECAD2171F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="MuzcZnQa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfIQNBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 09:01:48 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:35304 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfIQNBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 09:01:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id BB5AE3F528;
        Tue, 17 Sep 2019 15:01:39 +0200 (CEST)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=MuzcZnQa;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0qXzDPOTNKk2; Tue, 17 Sep 2019 15:01:38 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id CAA363F5D8;
        Tue, 17 Sep 2019 15:01:35 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 495603601AA;
        Tue, 17 Sep 2019 15:01:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1568725295; bh=RLvxQ7WAvOuonm/EyAFj5Gl1MzZMICjdAxHIdlgS4O8=;
        h=From:To:Cc:Subject:Date:From;
        b=MuzcZnQaT3xXFf3jdvOwqMsW1YTUXEVAMfK7JKUSIwJFMUFs8JiRw748t5Bnpmfeh
         rxxiKJjQ9QZrL1atIYP1pqy/bgR0+b2zJT280zTff31lVdz81WmqQWchNAsmvwldbq
         tDbot+6+ogD5+5X+/Zg4U88wRdWFteVgLnj8ZjUY=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-kernel@vger.kernel.org
Cc:     pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com,
        x86@kernel.org,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Christoph Hellwig <hch@infradead.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v3 0/2] Fix SEV user-space mapping of unencrypted coherent memory
Date:   Tue, 17 Sep 2019 15:01:13 +0200
Message-Id: <20190917130115.51748-1-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes dma_mmap_coherent() mapping of unencrypted memory in
otherwise encrypted environments, where it would incorrectly map that memory as
encrypted.

With SEV and sometimes with SME encryption, The dma api coherent memory is
typically unencrypted, meaning the linear kernel map has the encryption
bit cleared. However, default page protection returned from vm_get_page_prot()
has the encryption bit set. So to compute the correct page protection we need
to clear the encryption bit.

Also, in order for the encryption bit setting to survive across do_mmap() and
mprotect_fixup(), We need to make pgprot_modify() aware of it and not touch it.
Therefore make sme_me_mask part of _PAGE_CHG_MASK and make sure
pgprot_modify() preserves also cleared bits that are part of _PAGE_CHG_MASK,
not just set bits. The use of pgprot_modify() is currently quite limited and
easy to audit.

(Note that the encryption status is not logically encoded in the pfn but in
the page protection even if an address line in the physical address is used).

The patchset has seen some sanity testing by exporting dma_pgprot() and
using it in the vmwgfx mmap handler with SEV enabled.

As far as I can tell there are no current users of dma_mmap_coherent() with
SEV or SME encryption which means that there is no need to CC stable.

Changes since:
RFC:
- Make sme_me_mask port of _PAGE_CHG_MASK rather than using it by its own in
  pgprot_modify().
v2:
- Clarify which use-cases this patchset actually fixes.
v3:
- Use _PAGE_ENC instead of sme_me_mask in the definition of _PAGE_CHG_MASK

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Christian König <christian.koenig@amd.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
