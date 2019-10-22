Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746BECA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B48E2084B
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYSzsZif"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389388AbfJVQV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 12:21:58 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42459 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388850AbfJVQV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:21:57 -0400
Received: by mail-lj1-f196.google.com with SMTP id u4so3719859ljj.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 09:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WAmIOUJQL3AqxKJr+gmH9vSIN+RyG3cvJyazjbmRq6M=;
        b=FYSzsZifEEp6JUGLe9YbQHgByfHvJTEvCS5RxjeXhl/zcBa47wVJk1Nd4vV5ZQGNGc
         +vnOqM8BLGBLLq3HuTODGzsGjjhMNa0xdHy0Zzv/2nk9cvP9IIz9zFQkM7AZp/kHbEZI
         oB6/JlnMH4hUJUg91uswK28Eh6gIvn49ZJ2nMHtbGz8au+3vSHt7jjoKq2KXfEni4JsG
         4FAkYIvjnr6ehHLZzZxMYaQvmoHa8DK2BlegJoySoEVdnyAclyJg5xnWhXAu1TxBdAQZ
         A7pTEq6TgM0TwBGHw4BraQmffd/NjtlHtl5Eit6Qs6pErs4gtnxBOua4OhbPhVhGw+IZ
         oZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WAmIOUJQL3AqxKJr+gmH9vSIN+RyG3cvJyazjbmRq6M=;
        b=hGMdgWFDwdLtdLJKo2Km+2BXb9OJG8Tf9AQ8r9HHEcFQ9IpgSt+FQCxoOJd8JToba9
         1lOrGYPi9i/iXTbZv1Do4O1YR536AHsSVI8+L6SeZGdHeMEGv82YEsm/xkHcj219ypoY
         a2MZWpBkIUHTZ/DsoobeObUyg3Dbm9joJueEEnXI6o6JJ+PG7cwOh+HOsbtoctiXRtSe
         kBgXEfsN2gAKZTtUjpiXVG/floy4ZBSfBFSMjw7r3o1me8awMCdd8EC/pcczEy7chogS
         9HidC3MxrR2i+9G66BxHoqNzcHPUadLqqhrX3BizM0qN3sSe/oTG9ijSGXaJmTR6wjV0
         UUxQ==
X-Gm-Message-State: APjAAAWX3u7TJfygiQHWe1iJoffcJMm/cunLj7Dri85hvvglhvQ7aHcH
        sB0+fUkk3quOqo+CUsgrKr03Ncwt
X-Google-Smtp-Source: APXvYqzFVOA6vzn1dAYsPMSZHUGU2XqqWVZIWewYHpxeG9rkDjgIvYd4LBvQMuL6lLiozIMmwnMSbw==
X-Received: by 2002:a2e:7404:: with SMTP id p4mr6605735ljc.47.1571761315303;
        Tue, 22 Oct 2019 09:21:55 -0700 (PDT)
Received: from localhost.localdomain (78-63-27-146.static.zebra.lt. [78.63.27.146])
        by smtp.gmail.com with ESMTPSA id o13sm7595118ljh.35.2019.10.22.09.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 09:21:54 -0700 (PDT)
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
X-Google-Original-From: David Abdurachmanov <david.abdurachmanov@sifive.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <Anup.Patel@wdc.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        "Stefan O'Rear" <sorear2@gmail.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Logan Gunthorpe <logang@deltatee.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     david.abdurachmanov@gmail.com
Subject: [PATCH] riscv: fix fs/proc/kcore.c compilation with sparsemem enabled
Date:   Tue, 22 Oct 2019 19:21:35 +0300
Message-Id: <20191022162136.19076-1-david.abdurachmanov@sifive.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Failed to compile Fedora/RISCV kernel (5.4-rc3+) with sparsemem enabled:

fs/proc/kcore.c: In function 'read_kcore':
fs/proc/kcore.c:510:8: error: implicit declaration of function 'kern_addr_valid'; did you mean 'virt_addr_valid'? [-Werror=implicit-function-declaration]
  510 |    if (kern_addr_valid(start)) {
      |        ^~~~~~~~~~~~~~~
      |        virt_addr_valid

Looking at other architectures I don't see kern_addr_valid being guarded by
CONFIG_FLATMEM.

Fixes: d95f1a542c3d ("RISC-V: Implement sparsemem")
Signed-off-by: David Abdurachmanov <david.abdurachmanov@sifive.com>
Tested-by: David Abdurachmanov <david.abdurachmanov@sifive.com>
---
 arch/riscv/include/asm/pgtable.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 42292d99cc74..7110879358b8 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -428,9 +428,7 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)	((pte_t) { (x).val })
 
-#ifdef CONFIG_FLATMEM
 #define kern_addr_valid(addr)   (1) /* FIXME */
-#endif
 
 extern void *dtb_early_va;
 extern void setup_bootmem(void);
-- 
2.21.0

