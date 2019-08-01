Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D4EC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B15720665
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="atLlsRo/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732464AbfHAPYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 11:24:43 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36272 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfHAPYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:24:43 -0400
Received: by mail-qk1-f194.google.com with SMTP id g18so52318259qkl.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 08:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tv/fOnD6YC9u+5WmWm5gwywTsIsmHeTM0Q1GSWNKYUk=;
        b=atLlsRo/HsLlYJHkAHesgcO9qfPaQjZk+gYOvxKZpX5zmCTxt7zu8tiCRhoteNN7dd
         6HAmzBsFnGGSMNK2C1/2c095tMDLJ4ZXLXLn7i+ZEgdYwpo1qYHK/Q1xRHZwxOfakJw6
         /7ct9TY6fVLVY5D3c86/4ePweUPMk5TKNh2ZI97gVVKUkfE3dvmvGGH5WFhqRYhDDdNj
         MN0U1s86suOZc/o8BsUsL3OJ8/tYd9JgVijBxGQUq2ZZTq5MshwLKDUEHOPwOnM0CjpD
         UlAySrOA8+Uey1c7x2oPbu2GeSyZevsm2xsSMvkzV3E2NKwjBTx9zLYFJGZQjyw6+Y/3
         BOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tv/fOnD6YC9u+5WmWm5gwywTsIsmHeTM0Q1GSWNKYUk=;
        b=aCGPhW3wjdoZJ0WFJXnpNbHC1M7kfV3Xq+phDeDgvvSWz1sMmV7vuFTjn1q1Vv6T/T
         tp8VLq6MlENrIinfhhSO3G9qUJEKx4GQS8gOvNjwQTv3InIbxkAYIMauBx9KO4wUSSui
         tnQ5A4UKpoWDpqnJoI+/oxpQq7QB0+apH3IWvYkuS+mti4mwg9kHHtfjbUYExo/OHfHV
         zyMw03oNIP1sZwQ+YGlO/CiWI+CcZOc8FqXVk1ilT8qSUaGEVCar0dkvpEehchSCIU7n
         Ufp7sMkEX9WYEK3Tr5bOdOJt6Ivzkg4aEqxaa6wO57sGmI9Uw6Il5HxS5CPL/VOBYyRs
         Pycg==
X-Gm-Message-State: APjAAAW95GVZmDP8raEVGHOI/lQigwT9tbOqxA1ECkudc0yuIcDH+sg/
        fyLIk/4m7uF82P4jv/OLc1o8khKu
X-Google-Smtp-Source: APXvYqzZD3a7tT1okA0boG+U3Hsp3SOLhKzDGE1jT3CDvSGW9wPow4/sMDwhXS8im+A6DBmuvHqQWA==
X-Received: by 2002:a37:4dc6:: with SMTP id a189mr84646858qkb.41.1564673081928;
        Thu, 01 Aug 2019 08:24:41 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id o5sm30899952qkf.10.2019.08.01.08.24.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 08:24:41 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org
Subject: [PATCH v1 0/8] arm64: MMU enabled kexec relocation
Date:   Thu,  1 Aug 2019 11:24:31 -0400
Message-Id: <20190801152439.11363-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable MMU during kexec relocation in order to improve reboot performance.

If kexec functionality is used for a fast system update, with a minimal
downtime, the relocation of kernel + initramfs takes a significant portion
of reboot.

The reason for slow relocation is because it is done without MMU, and thus
not benefiting from D-Cache.

Performance data
----------------
For this experiment, the size of kernel plus initramfs is small, only 25M.
If initramfs was larger, than the improvements would be greater, as time
spent in relocation is proportional to the size of relocation.

Previously:
kernel shutdown	0.022131328s
relocation	0.440510736s
kernel startup	0.294706768s

Relocation was taking: 58.2% of reboot time

Now:
kernel shutdown	0.032066576s
relocation	0.022158152s
kernel startup	0.296055880s

Now: Relocation takes 6.3% of reboot time

Total reboot is x2.16 times faster.

Previous approaches and discussions
-----------------------------------
https://lore.kernel.org/lkml/20190709182014.16052-1-pasha.tatashin@soleen.com
reserve space for kexec to avoid relocation, involves changes to generic code
to optimize a problem that exists on arm64 only:

https://lore.kernel.org/lkml/20190716165641.6990-1-pasha.tatashin@soleen.com
The first attempt to enable MMU, some bugs that prevented performance
improvement. The page tables unnecessary configured idmap for the whole
physical space.

https://lore.kernel.org/lkml/20190731153857.4045-1-pasha.tatashin@soleen.com
No linear copy, bug with EL2 reboots.

Pavel Tatashin (8):
  kexec: quiet down kexec reboot
  arm64, mm: transitional tables
  arm64: hibernate: switch to transtional page tables.
  kexec: add machine_kexec_post_load()
  arm64, kexec: move relocation function setup and clean up
  arm64, kexec: add expandable argument to relocation function
  arm64, kexec: configure transitional page table for kexec
  arm64, kexec: enable MMU during kexec relocation

 arch/arm64/Kconfig                     |   4 +
 arch/arm64/include/asm/kexec.h         |  51 ++++-
 arch/arm64/include/asm/pgtable-hwdef.h |   1 +
 arch/arm64/include/asm/trans_table.h   |  68 ++++++
 arch/arm64/kernel/asm-offsets.c        |  14 ++
 arch/arm64/kernel/cpu-reset.S          |   4 +-
 arch/arm64/kernel/cpu-reset.h          |   8 +-
 arch/arm64/kernel/hibernate.c          | 261 ++++++-----------------
 arch/arm64/kernel/machine_kexec.c      | 199 ++++++++++++++----
 arch/arm64/kernel/relocate_kernel.S    | 196 +++++++++---------
 arch/arm64/mm/Makefile                 |   1 +
 arch/arm64/mm/trans_table.c            | 273 +++++++++++++++++++++++++
 kernel/kexec.c                         |   4 +
 kernel/kexec_core.c                    |   8 +-
 kernel/kexec_file.c                    |   4 +
 kernel/kexec_internal.h                |   2 +
 16 files changed, 758 insertions(+), 340 deletions(-)
 create mode 100644 arch/arm64/include/asm/trans_table.h
 create mode 100644 arch/arm64/mm/trans_table.c

-- 
2.22.0

