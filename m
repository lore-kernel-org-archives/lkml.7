Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C0CC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 00:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D7A621D7D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 00:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="Dka6E6Kx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfLSAgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 19:36:37 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36220 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLSAgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 19:36:37 -0500
Received: by mail-pg1-f194.google.com with SMTP id k3so2173599pgc.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 16:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5NTtETEykOhr2nCmuKVWtyUmiz45NkjCC1EiRzotiV0=;
        b=Dka6E6KxQMKWIOq8r+b70xVQGVo4OdLoMXnwm6m0mMIhAJbUreti/BnUsZplcC3I5t
         6GAQjfkecTIR6/e4HR3gYnoHqRT2G92zcwNrRuEl+OBpwkq1wQoWTGNOlJhGkDhGvv+W
         DmQ7nlRQ3ekghRHA1hXbbgQbWCNx+vBJP1blU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5NTtETEykOhr2nCmuKVWtyUmiz45NkjCC1EiRzotiV0=;
        b=FvK5U3pDdUWSPDX96D64fQrnwBam9UEAxZGktSI5cmOwX3eyg07DVXeSoIFA6eGGnv
         Zz3PJNjqObfSK7vOA4JzoMw6zETps6fLOjFDI3MK2rwWwzwwJ1d/i7oCY5xj0u4cjY5/
         Hrc+/sZtHOLDp6DT5hpzNi+bOApes9NqRcdizc6YJwoKa3E1d7wDweKbakCDKC0pzVut
         Rp+J9Wi9af/fL6tZElO+TXBRi1ixQf1up1nnfVXVoSittnqf+AFEpW/yGvEBnx+Dy3cc
         8KpGYVyk1phffpXEOR23RSQ2Py9v1Qh6mth48X/J7yhGSAm97/sz8z/m9qGo7bFLbfa4
         OPDQ==
X-Gm-Message-State: APjAAAVqWdbE4Bd5B/6rbk/fPl0odCPX5JJoCLZAEe58eGSubVWDUnJE
        bDCN+FtdfWcatoqr/6/Q2+R6EfSG3FM=
X-Google-Smtp-Source: APXvYqzmq4U/2uhuZHM/lC5xUAdQDDtPlzppqNzyl6j6ILF9v1mdA5FmXeloldbfX3xoXhZz9lR/qg==
X-Received: by 2002:aa7:93ce:: with SMTP id y14mr6301702pff.185.1576715796122;
        Wed, 18 Dec 2019 16:36:36 -0800 (PST)
Received: from localhost (2001-44b8-111e-5c00-b05d-cbfe-b2ee-de17.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:b05d:cbfe:b2ee:de17])
        by smtp.gmail.com with ESMTPSA id l1sm4610430pgs.47.2019.12.18.16.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 16:36:35 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@c-s.fr, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH v4 0/4] KASAN for powerpc64 radix
Date:   Thu, 19 Dec 2019 11:36:26 +1100
Message-Id: <20191219003630.31288-1-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building on the work of Christophe, Aneesh and Balbir, I've ported
KASAN to 64-bit Book3S kernels running on the Radix MMU.

This provides full inline instrumentation on radix, but does require
that you be able to specify the amount of physically contiguous memory
on the system at compile time. More details in patch 4.

v4: More cleanups, split renaming out, clarify bits and bobs.
    Drop the stack walk disablement, that isn't needed. No other
    functional change.

v3: Reduce the overly ambitious scope of the MAX_PTRS change.
    Document more things, including around why some of the
    restrictions apply.
    Clean up the code more, thanks Christophe.

v2: The big change is the introduction of tree-wide(ish)
    MAX_PTRS_PER_{PTE,PMD,PUD} macros in preference to the previous
    approach, which was for the arch to override the page table array
    definitions with their own. (And I squashed the annoying
    intermittent crash!)

    Apart from that there's just a lot of cleanup. Christophe, I've
    addressed most of what you asked for and I will reply to your v1
    emails to clarify what remains unchanged.

Daniel Axtens (4):
  kasan: define and use MAX_PTRS_PER_* for early shadow tables
  kasan: Document support on 32-bit powerpc
  powerpc/mm/kasan: rename kasan_init_32.c to init_32.c
  powerpc: Book3S 64-bit "heavyweight" KASAN support

 Documentation/dev-tools/kasan.rst             |   7 +-
 Documentation/powerpc/kasan.txt               | 122 ++++++++++++++++++
 arch/powerpc/Kconfig                          |   2 +
 arch/powerpc/Kconfig.debug                    |  21 +++
 arch/powerpc/Makefile                         |  11 ++
 arch/powerpc/include/asm/book3s/64/hash.h     |   4 +
 arch/powerpc/include/asm/book3s/64/pgtable.h  |   7 +
 arch/powerpc/include/asm/book3s/64/radix.h    |   5 +
 arch/powerpc/include/asm/kasan.h              |  21 ++-
 arch/powerpc/kernel/prom.c                    |  61 ++++++++-
 arch/powerpc/mm/kasan/Makefile                |   3 +-
 .../mm/kasan/{kasan_init_32.c => init_32.c}   |   0
 arch/powerpc/mm/kasan/init_book3s_64.c        |  70 ++++++++++
 arch/powerpc/platforms/Kconfig.cputype        |   1 +
 include/linux/kasan.h                         |  18 ++-
 mm/kasan/init.c                               |   6 +-
 16 files changed, 346 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/powerpc/kasan.txt
 rename arch/powerpc/mm/kasan/{kasan_init_32.c => init_32.c} (100%)
 create mode 100644 arch/powerpc/mm/kasan/init_book3s_64.c

-- 
2.20.1

