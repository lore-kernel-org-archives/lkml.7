Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E31C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708D3233A2
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="HHJukI5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbfHUScJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 14:32:09 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37692 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfHUScH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 14:32:07 -0400
Received: by mail-qk1-f194.google.com with SMTP id s14so2734965qkm.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 11:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3VISVZWuGNTiVd6JKqfbutJFN34lrqN05fvYPH9Kreg=;
        b=HHJukI5cKFcu78i/O1Yn8iw05mYEjKQotNnDCY7uW/VDROaso248Cz4QQVCEUqJcRv
         EBzDUyZOfUDX0OqfFfNYvmLzaOIniVyftuF2AgycrkM0czlodTpOiI5hsWSB3EmJ2IOF
         Sdf0QIF5vjVVnt5v/fb4faCNkExE0O0J9E/u7OrVqBv3KwAkDQY25mF4NF6uZGiJmJaq
         V5rSY+0126UdxSnVxgCpzdNP9IOeLPAdBIaRSaDqEYxUJRdmoxnf7zCcQdaMR1gPUppS
         eit1DPkEzoQPfq6qmFm0NeeZa9yVUmAjXHBjiWUl8i01GTKsv8qd8JE2lN5bdfa1Jkf4
         TRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3VISVZWuGNTiVd6JKqfbutJFN34lrqN05fvYPH9Kreg=;
        b=jOaO+BWIwb2q1ZzPOkBeGfIJznIbw1iXZGt42sbX+CuBFmuYLNs72W4JyzX6+/yBHv
         Al+x0ewmu9HiUxKYTCMpbVggAAek3jTyKD6dg9hUppE8rn3H6zR06jlqEgJv4AEVoYCj
         9A2j+8AwzDdBS0r/Id3/lH0kmoIBLouER8yd+Qnl616iRPYejvbBDH8M+W0jmyhelhVa
         t9YHxNtF05aDpBOiH2s9eE7bNNiaoLJdrH35ja+A+f1ZeuopctmnKPqnYwBeqwSLDiXG
         x9bgoySE1X6N1Qjoe2G4IBGTHBAVtFnxIe3lVwQ07P4U2NfGvIqsNMeHUt6xC7DCYVwx
         NrEA==
X-Gm-Message-State: APjAAAWlwRf2ADXQ+Sag6Gr21/DPdZpCkFazR0KYEBPnEnHxP6dTDns9
        KKYNiW3Zx/rskLZFf92sTR2O7g==
X-Google-Smtp-Source: APXvYqxQXpDqPyZwJQWEPUkusjd/UilDz4Mpzt+wUtcrvVVsDPsRqQ1Np6P1GcXQU3ssA/+pWMdUqw==
X-Received: by 2002:a37:a9c6:: with SMTP id s189mr32305161qke.191.1566412326277;
        Wed, 21 Aug 2019 11:32:06 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id q13sm10443332qkm.120.2019.08.21.11.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 11:32:05 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com
Subject: [PATCH v3 00/17] arm64: MMU enabled kexec relocation
Date:   Wed, 21 Aug 2019 14:31:47 -0400
Message-Id: <20190821183204.23576-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
v3:
	- Split changes to create_safe_exec_page() into several patches for
	  easier review as request by Mark Rutland. This is why this series
	  has 3 more patches.
	- Renamed trans_table to tans_pgd as agreed with Mark. The header
	  comment in trans_pgd.c explains that trans stands for
	  transitional page tables. Meaning they are used in transition
	  between two kernels.
v2:
	- Fixed hibernate bug reported by James Morse
	- Addressed comments from James Morse:
	  * More incremental changes to trans_table
	  * Removed TRANS_FORCEMAP
	  * Added kexec reboot data for image with 380M in size.

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

With bigger userland (fitImage 380M), the reboot time is improved by 3.57s,
and is reduced from 3.9s down to 0.33s

Previous approaches and discussions
-----------------------------------
https://lore.kernel.org/lkml/20190817024629.26611-1-pasha.tatashin@soleen.com
version 2 of this series

https://lore.kernel.org/lkml/20190801152439.11363-1-pasha.tatashin@soleen.com
version 1 of this series

https://lore.kernel.org/lkml/20190709182014.16052-1-pasha.tatashin@soleen.com
reserve space for kexec to avoid relocation, involves changes to generic code
to optimize a problem that exists on arm64 only:

https://lore.kernel.org/lkml/20190716165641.6990-1-pasha.tatashin@soleen.com
The first attempt to enable MMU, some bugs that prevented performance
improvement. The page tables unnecessary configured idmap for the whole
physical space.

https://lore.kernel.org/lkml/20190731153857.4045-1-pasha.tatashin@soleen.com
No linear copy, bug with EL2 reboots.

Pavel Tatashin (17):
  kexec: quiet down kexec reboot
  arm64, hibernate: use get_safe_page directly
  arm64, hibernate: remove gotos in create_safe_exec_page
  arm64, hibernate: rename dst to page in create_safe_exec_page
  arm64, hibernate: check pgd table allocation
  arm64, hibernate: add trans_pgd public functions
  arm64, hibernate: move page handling function to new trans_pgd.c
  arm64, trans_pgd: make trans_pgd_map_page generic
  arm64, trans_pgd: add trans_pgd_create_empty
  arm64, trans_pgd: adjust trans_pgd_create_copy interface
  arm64, trans_pgd: add PUD_SECT_RDONLY
  arm64, trans_pgd: complete generalization of trans_pgds
  kexec: add machine_kexec_post_load()
  arm64, kexec: move relocation function setup and clean up
  arm64, kexec: add expandable argument to relocation function
  arm64, kexec: configure trans_pgd page table for kexec
  arm64, kexec: enable MMU during kexec relocation

 arch/arm64/Kconfig                     |   4 +
 arch/arm64/include/asm/kexec.h         |  51 ++++-
 arch/arm64/include/asm/pgtable-hwdef.h |   1 +
 arch/arm64/include/asm/trans_pgd.h     |  63 ++++++
 arch/arm64/kernel/asm-offsets.c        |  14 ++
 arch/arm64/kernel/cpu-reset.S          |   4 +-
 arch/arm64/kernel/cpu-reset.h          |   8 +-
 arch/arm64/kernel/hibernate.c          | 261 ++++++------------------
 arch/arm64/kernel/machine_kexec.c      | 199 ++++++++++++++----
 arch/arm64/kernel/relocate_kernel.S    | 196 +++++++++---------
 arch/arm64/mm/Makefile                 |   1 +
 arch/arm64/mm/trans_pgd.c              | 270 +++++++++++++++++++++++++
 kernel/kexec.c                         |   4 +
 kernel/kexec_core.c                    |   8 +-
 kernel/kexec_file.c                    |   4 +
 kernel/kexec_internal.h                |   2 +
 16 files changed, 750 insertions(+), 340 deletions(-)
 create mode 100644 arch/arm64/include/asm/trans_pgd.h
 create mode 100644 arch/arm64/mm/trans_pgd.c

-- 
2.23.0

