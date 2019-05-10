Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD839C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 19:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78578217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 19:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0C0iDXq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbfEJTlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 15:41:22 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36333 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbfEJTlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 15:41:21 -0400
Received: by mail-lj1-f194.google.com with SMTP id z1so6062859ljb.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 12:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Wb6m/O8d+DXIkatA4xAsxw74L+R8D3ET/JMyosDN25I=;
        b=c0C0iDXqWaUAIG1ohB5tjTXZ/hf4DohrNmsMZMo1g+YMNRf0ErI84ambZfx2i1mMLp
         fQWJx0lzvaEpXoayJWzHvxRPzh5GdwNOYJvdRbk4RmNdmcsZu8WYITZOOTXNzWMU+B3o
         lvaihAf/O3SX2bJ194Alh/GTnq9zfYNjrRQyeAJhl/bqug12fu7KAS/2gMInqUs25N4r
         M6eDxFL0A8rjEdznxX1WCO/BPwWLac+7TV+K/DpkIpq3qQ4pMf6/OTgXRU85dYAypdKV
         DA9BPKijr6icsUlYeOK3gH+JthGKdqtFON3xz3Pr7k0NTYm7i09+ZG8OKCqAIoiC4+z6
         lRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Wb6m/O8d+DXIkatA4xAsxw74L+R8D3ET/JMyosDN25I=;
        b=St2W+YIT8UNNeXjVVa10+/7dt0lhF70hMn+bRIG0F2s3508Qj9npvpA/MuOW8bmFgK
         KktGwobYOGEvsG6IlFgcrWQnyeclQBUuiZbQCB0jtZtIndeoePaMcEE7uULiExL0hWKQ
         /MlqSW9yZ6h8gE5hsJ826B+DD1ccJOdGfnH9yEbBWYOrcwtTkRxxoyY74v6cbJbTznJI
         XSA/VYfacvzItObpdzmAQ0y6Z9AxUc2fEwHAq6hCU5vXIugLQAZ9gPWPs/2YC3VcqzfA
         oCfdRSqybQq8fTMYywS/IjbxPLkfOSb1JiGq81kDw+Fh3QEnJ//Kd4tHy23JLL0zuiDj
         ixdQ==
X-Gm-Message-State: APjAAAXGYr5wiXilfwqDKnC2/jake06q9YRWgq6jpP3iLf8T6JoGTyiA
        LqhuI/ldE3p3HpEE6Hck2grr8wVKU/0=
X-Google-Smtp-Source: APXvYqw+HCubHGtscCBX39N6Vu1XB5zecs9Yh+y6jonPtjxXKqn5BekZ+cJ9Mync7fQC4ZGaU0dHPg==
X-Received: by 2002:a2e:9c89:: with SMTP id x9mr6860384lji.28.1557517279493;
        Fri, 10 May 2019 12:41:19 -0700 (PDT)
Received: from octofox.cadence.com (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
        by smtp.gmail.com with ESMTPSA id x21sm1680558ljj.43.2019.05.10.12.41.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 12:41:18 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 0/7] xtensa updates for v5.2
Date:   Fri, 10 May 2019 12:41:02 -0700
Message-Id: <20190510194102.28038-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following batch of updates for the Xtensa architecture:

The following changes since commit e93c9c99a629c61837d5a7fc2120cd2b6c70dbdd:

  Linux 5.1 (2019-05-05 17:42:58 -0700)

are available in the git repository at:

  git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20190510

for you to fetch changes up to a5944195d00a359e28d6e093593609bcee37ed5e:

  xtensa: implement initialize_cacheattr for MPU cores (2019-05-07 10:36:34 -0700)

----------------------------------------------------------------
Xtensa updates for v5.2:

- implement atomic operations using exclusive access Xtensa option
  operations.
- add support for Xtensa cores with memory protection unit (MPU).
- clean up xtensa-specific kernel-only headers.
- fix error path in simdisk_setup.

----------------------------------------------------------------
Chengguang Xu (2):
      xtensa: fix incorrect fd close in error case of simdisk_setup()
      xtensa: set proper error code for simdisk_setup()

Max Filippov (5):
      xtensa: drop ifdef __KERNEL__ from kernel-only headers
      xtensa: replace variant/core.h with asm/core.h
      xtensa: clean up inline assembly in futex.h
      xtensa: add exclusive atomics support
      xtensa: implement initialize_cacheattr for MPU cores

 arch/xtensa/Kconfig                                |  26 ++++-
 arch/xtensa/boot/boot-redboot/bootstrap.S          |   2 +-
 arch/xtensa/include/asm/asmmacro.h                 |   2 +-
 arch/xtensa/include/asm/atomic.h                   |  66 ++++++++++-
 arch/xtensa/include/asm/barrier.h                  |   4 +
 arch/xtensa/include/asm/bitops.h                   | 125 ++++++++++++++++++++-
 arch/xtensa/include/asm/cache.h                    |   2 +-
 arch/xtensa/include/asm/checksum.h                 |   2 +-
 arch/xtensa/include/asm/cmpxchg.h                  |  36 +++++-
 arch/xtensa/include/asm/coprocessor.h              |   2 +-
 arch/xtensa/include/asm/core.h                     |  21 ++++
 arch/xtensa/include/asm/futex.h                    | 122 +++++++++++++-------
 arch/xtensa/include/asm/initialize_mmu.h           |  38 ++++++-
 arch/xtensa/include/asm/io.h                       |   3 -
 arch/xtensa/include/asm/irq.h                      |   2 +-
 arch/xtensa/include/asm/pci-bridge.h               |   3 -
 arch/xtensa/include/asm/pci.h                      |   4 -
 arch/xtensa/include/asm/pgalloc.h                  |   3 -
 arch/xtensa/include/asm/processor.h                |   2 +-
 arch/xtensa/include/asm/ptrace.h                   |   2 +-
 arch/xtensa/include/asm/vectors.h                  |   2 +-
 arch/xtensa/kernel/hw_breakpoint.c                 |   2 +-
 arch/xtensa/kernel/setup.c                         |   3 +
 arch/xtensa/kernel/vmlinux.lds.S                   |   2 +-
 arch/xtensa/lib/checksum.S                         |   2 +-
 arch/xtensa/lib/memcopy.S                          |   2 +-
 arch/xtensa/lib/memset.S                           |   2 +-
 arch/xtensa/lib/strncpy_user.S                     |   2 +-
 arch/xtensa/lib/strnlen_user.S                     |   2 +-
 arch/xtensa/lib/usercopy.S                         |   2 +-
 arch/xtensa/platforms/iss/simdisk.c                |   3 +-
 .../platforms/xt2000/include/platform/hardware.h   |   2 +-
 .../platforms/xt2000/include/platform/serial.h     |   2 +-
 33 files changed, 397 insertions(+), 98 deletions(-)
 create mode 100644 arch/xtensa/include/asm/core.h

-- 
Thanks.
-- Max
