Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9991C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DA712082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551788445;
	bh=muAqBsuLuMeGCrENnTLtvwXex78LHDkDTnH2rKVx9Kc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=sFJp3x3f34tuXdLhBQG+nWL8y8sSDx0zumP48FHVXrMPFGgnVhdl43BoPPzX8ALaO
	 5MRqHSQEHDIyRmCI7amiNkRzWkNroSOePGSPAu1Y3Hu1QpgcMIoMWSLHHLQSBNSsgg
	 ieolkU7cFGjwClFLOId1dveMjm/G9YpxmE/rYi+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbfCEMUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 07:20:44 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52198 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbfCEMUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 07:20:44 -0500
Received: by mail-wm1-f65.google.com with SMTP id n19so2351054wmi.1;
        Tue, 05 Mar 2019 04:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=N68KO+sCa7P/F5b+Qp6ZNtG9acCN/uh+O56Yfe5tpsg=;
        b=QkATOvVGZgIvkoqCB7qbooUEAYaMGBQeCbLxkC7eB2FqaJzlMfuWl8g0uonSosum+w
         hQgOD4dXdNDlyLZR8dAQPLCSfg/onUliZRT+CTqv1Iehqb3bT+QRggDEjh5irUPD2GXA
         x/SG3KNr17NyLKaCneyQpRgE9DNEUo8okb2gSBogfupPJR9v/2P+ntfiFBLsbbiq5Hbz
         +aD/v76SsgXVqL4ocobilgWdS37PINpw49qRUqE50R3PUWKHBdEukvZJHJ+9rs5CzqA0
         S87cEE27xLvJ7PjAsHTPcf3d+PJ8qCkxkyP0MzO4KkyhYc7RgPMo+/SgpmGNM+VZSBSR
         g2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=N68KO+sCa7P/F5b+Qp6ZNtG9acCN/uh+O56Yfe5tpsg=;
        b=Aw6hpkcMORoBwYluyczKkOfmcfMwxEKBOc54h4rHYuo5S6GCriLvJVHThOp4IzMGOS
         oDbdTZwFbZUpxt2jvaKC4K0cTK01S0GFoTQ5wdax9uUnOgUCKkZFNUGEXBsakf6dAXbe
         LRdVzoXjc4u/+wzUz8S4TRB+KlYBTJLqnNQEKjEC3f53dlTEBFziNUCjtFJuoc2TH23o
         8Rt8PGtudjJQfd61yXGRbVJp6eW/XhNyJ2CKDYRwXkpDRBwngt5yfKBFmRRksRPUT6bw
         nfJTW1y80u6lbb4gtXQW3fM20ecPdhPwaktsfEw0hx1iKuscX9Zt8BPogN14ipP0KpNu
         sAFg==
X-Gm-Message-State: APjAAAU5LWPZl2iIxveioVm2frM0FbSXiU5DCTDgbOvdnZ81yKYMTgfI
        cG+/Pi2Xx0I5KCrph9ugqHc=
X-Google-Smtp-Source: APXvYqyaizEtD0i+u8NP7juiud/kH/egUV4kjDKR0z19ge68E2kmVN22McoITI5Q+l2navCxCjt/JQ==
X-Received: by 2002:a1c:2dd1:: with SMTP id t200mr2496808wmt.148.1551788441394;
        Tue, 05 Mar 2019 04:20:41 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id q78sm7105166wme.43.2019.03.05.04.20.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 04:20:40 -0800 (PST)
Date:   Tue, 5 Mar 2019 13:20:38 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] EFI changes for v5.1
Message-ID: <20190305122038.GA2472@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest efi-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-core-for-linus

   # HEAD: 5c418dc789a3898717ebf2caa5716ba91a7150b2 efi: Fix build error due to enum collision between efi.h and ima.h

The main EFI changes in this cycle were:

 - Move BGRT table handling to earlier in the boot so we don't overwrite it
 - Use 32-bit alignment for efi_guid_t
 - Allow the SetVirtualAddressMap() call to be omitted
 - Implement earlycon=efifb based on existing earlyprintk code
 - Various minor fixes and code cleanups from Sai, Ard and me

 Thanks,

	Ingo

------------------>
Anders Roxell (1):
      efi: Fix build error due to enum collision between efi.h and ima.h

Ard Biesheuvel (6):
      efi/memattr: Don't bail on zero VA if it equals the region's PA
      efi: Use 32-bit alignment for efi_guid_t
      efi: Replace GPL license boilerplate with SPDX headers
      efi/arm/arm64: Allow SetVirtualAddressMap() to be omitted
      x86: Make ARCH_USE_MEMREMAP_PROT a generic Kconfig symbol
      efi/x86: Convert x86 EFI earlyprintk into generic earlycon implementation

Ingo Molnar (1):
      efi/fdt: Apply more cleanups

Sai Praneeth Prakhya (1):
      x86/efi: Mark can_free_region() as an __init function


 Documentation/admin-guide/kernel-parameters.txt |   8 +-
 arch/Kconfig                                    |   3 +
 arch/x86/Kconfig                                |   5 +-
 arch/x86/Kconfig.debug                          |  10 -
 arch/x86/include/asm/efi.h                      |   1 -
 arch/x86/kernel/early_printk.c                  |   4 -
 arch/x86/mm/ioremap.c                           |   4 +-
 arch/x86/platform/efi/Makefile                  |   1 -
 arch/x86/platform/efi/early_printk.c            | 240 ------------------------
 arch/x86/platform/efi/quirks.c                  |   6 +-
 drivers/firmware/efi/Kconfig                    |   6 +
 drivers/firmware/efi/Makefile                   |   1 +
 drivers/firmware/efi/apple-properties.c         |  13 +-
 drivers/firmware/efi/arm-init.c                 |   6 +-
 drivers/firmware/efi/arm-runtime.c              |   6 +-
 drivers/firmware/efi/capsule-loader.c           |   4 +-
 drivers/firmware/efi/capsule.c                  |   4 +-
 drivers/firmware/efi/cper-arm.c                 |  14 +-
 drivers/firmware/efi/cper.c                     |  14 +-
 drivers/firmware/efi/dev-path-parser.c          |   9 +-
 drivers/firmware/efi/earlycon.c                 | 206 ++++++++++++++++++++
 drivers/firmware/efi/efi-bgrt.c                 |   5 +-
 drivers/firmware/efi/efi-pstore.c               |   2 +
 drivers/firmware/efi/efibc.c                    |  10 +-
 drivers/firmware/efi/efivars.c                  |  58 +-----
 drivers/firmware/efi/esrt.c                     |   1 +
 drivers/firmware/efi/fake_mem.c                 |  16 +-
 drivers/firmware/efi/libstub/Makefile           |   4 +-
 drivers/firmware/efi/libstub/arm-stub.c         |   5 +
 drivers/firmware/efi/libstub/arm32-stub.c       |   6 +-
 drivers/firmware/efi/libstub/arm64-stub.c       |   6 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c  |  15 +-
 drivers/firmware/efi/libstub/efistub.h          |  12 ++
 drivers/firmware/efi/libstub/fdt.c              | 115 ++++++------
 drivers/firmware/efi/libstub/gop.c              |   4 +-
 drivers/firmware/efi/libstub/random.c           |   6 +-
 drivers/firmware/efi/libstub/secureboot.c       |   4 +-
 drivers/firmware/efi/libstub/tpm.c              |   4 +-
 drivers/firmware/efi/memattr.c                  |   7 +-
 drivers/firmware/efi/runtime-map.c              |   3 +-
 drivers/firmware/efi/runtime-wrappers.c         |  48 ++---
 drivers/firmware/efi/test/efi_test.c            |   1 +
 drivers/firmware/efi/test/efi_test.h            |   2 +-
 drivers/firmware/efi/tpm.c                      |   5 +-
 drivers/firmware/efi/vars.c                     |  15 +-
 include/linux/efi.h                             |  41 ++--
 46 files changed, 393 insertions(+), 567 deletions(-)
 delete mode 100644 arch/x86/platform/efi/early_printk.c
 create mode 100644 drivers/firmware/efi/earlycon.c

