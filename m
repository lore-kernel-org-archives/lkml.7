Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF7EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 21:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C7F206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 21:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbfC0Vgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 17:36:49 -0400
Received: from ale.deltatee.com ([207.54.116.67]:58640 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727140AbfC0Vgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 17:36:48 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1h9GE3-0006DI-51; Wed, 27 Mar 2019 15:36:47 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1h9GE2-0006Cb-0t; Wed, 27 Mar 2019 15:36:46 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Christoph Hellwig <hch@lst.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jonathan Corbet <corbet@lwn.net>
Date:   Wed, 27 Mar 2019 15:36:38 -0600
Message-Id: <20190327213643.23789-3-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327213643.23789-1-logang@deltatee.com>
References: <20190327213643.23789-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, sbates@raithlin.com, palmer@sifive.com, hch@lst.de, aou@eecs.berkeley.edu, logang@deltatee.com, corbet@lwn.net
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 2/7] RISC-V: doc: Add file describing the virtual memory map
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file is similar to the x86_64 equivalent (in
Documentation/x86/x86_64/mm.txt) and describes the virtuas address space
usage for RISC-V.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
---
 Documentation/riscv/mm.txt | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/riscv/mm.txt

diff --git a/Documentation/riscv/mm.txt b/Documentation/riscv/mm.txt
new file mode 100644
index 000000000000..725dc85f2c65
--- /dev/null
+++ b/Documentation/riscv/mm.txt
@@ -0,0 +1,24 @@
+Sv32:
+
+00000000 - 7fffffff   user space, different per mm (2G)
+80000000 - 81ffffff   virtual memory map (32MB)
+82000000 - bfffffff   vmalloc/ioremap space (1GB - 32MB)
+c0000000 - ffffffff   direct mapping of lower phys. memory (1GB)
+
+Sv39:
+
+0000000000000000 - 0000003fffffffff  user space, different per mm (256GB)
+hole caused by [38:63] sign extension
+ffffffc000000000 - ffffffc0ffffffff  virtual memory map (4GB)
+ffffffc100000000 - ffffffd0ffffffff  vmalloc/ioremap spac (64GB)
+ffffffd100000000 - ffffffffffffffff  linear mapping of physical space (188GB)
+  ffffffd200000000 - 0xfffffff200000000 linear mapping of all physical memory
+
+The RISC-V architecture defines virtual address bits in multiples of nine
+starting from 39. These are referred to as Sv39, Sv48, Sv57 and Sv64.
+Currently only Sv39 is supported. Bits 63 through to the most-significant
+implemented bit are sign extended. This causes a hole between user space
+and kernel addresses if you interpret them as unsigned.
+
+The direct mapping covers as much of the physical memory space as
+possible so that it may cover some IO memory.
-- 
2.20.1

