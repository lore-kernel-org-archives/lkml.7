Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C727C3A59D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 02:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42FCF2173E
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 02:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="JDS9LlpV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfHQCqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 22:46:33 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36325 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfHQCqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 22:46:32 -0400
Received: by mail-qk1-f194.google.com with SMTP id d23so6421582qko.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 19:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p98dmgBDeDcssd4yKsWE/iQqs5p9wP/9+OXRV1ENewU=;
        b=JDS9LlpV2ta9byDzMY6b9v39r4r4effVrLjzxfOMxfazK25Y7wTPyhsbXZ66QpIJUP
         HcGNwuH3KpQVzNhgJ2NNBfm5jg8IhCzp+ffvV+Tc9K2hEPOrg0Kp0/28WE0CWLNhifxT
         yoJeW3JhBjArtLdX6XkSvzvEyxm8fdUp9hiaD4zeWviKaDpetWIY4AdemrlQA3Z97re2
         i/qBSDGjjETysQY9urMcD0rH1/EVNndFeiorcfXvA+yr7Dy6VTA65yXhPAXHqX6ip7iz
         LKOgTkMRtHG5FVjALunMYIuDqiBZBonlVu3APly7gtxaYleUcH+TGcvRZwHxAAu/abCa
         VPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p98dmgBDeDcssd4yKsWE/iQqs5p9wP/9+OXRV1ENewU=;
        b=HvHFHt6zgIEfpkVdlkxOZBUwhW7XOOZr2Z0aRSX9DHi3PCKLgTYYKwCQG84L33+ln9
         IRak7jkPr3yC0BDQm8GYvRwcnosYhTAKctzx0bdfo7iQ4wWjWM2w70wGU8Z1PAWQ6a/d
         SCli9SfkcY7hMgLpX0qscPEgJUiwO7+UnsJKkWCia/OcH8uy1TVuxOFWb0QJAN9HIkZK
         sVCiJm0nY4xPCu3KmrTOHKYl6i4T90VBSmFpigxMybYcVwHwsUhakp49ReHmEul+H0CW
         0tTvxkvrDlJ7Kp8qpRvlwvBH7D1M0Z21SnLaK9HptduJYrhTx6uEy5wVMAAofUczT/d3
         C/5g==
X-Gm-Message-State: APjAAAX9tarBhXiFxpMcTOhWAjhPaNkQjkl7VIxr0nh12sSJSpibHS0i
        HtiYlilGDnQIfkwean8qtq1j7A==
X-Google-Smtp-Source: APXvYqxk6U1QbP7pDBIw3UpMgdwmknnD6IQo5oeUJswdhs4UX5w4SKba4s8Bv/AQr8d6aSCLhUMxoA==
X-Received: by 2002:ae9:e707:: with SMTP id m7mr11883927qka.50.1566009991502;
        Fri, 16 Aug 2019 19:46:31 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id o9sm3454657qtr.71.2019.08.16.19.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 19:46:30 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org
Subject: [PATCH v2 00/14] arm64: MMU enabled kexec relocation
Date:   Fri, 16 Aug 2019 22:46:15 -0400
Message-Id: <20190817024629.26611-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
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
https://lore.kernel.org/lkml/20190801152439.11363-1-pasha.tatashin@soleen.com/
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

Pavel Tatashin (14):
  kexec: quiet down kexec reboot
  arm64, hibernate: create_safe_exec_page cleanup
  arm64, hibernate: add trans_table public functions
  arm64, hibernate: move page handling function to new trans_table.c
  arm64, trans_table: make trans_table_map_page generic
  arm64, trans_table: add trans_table_create_empty
  arm64, trans_table: adjust trans_table_create_copy interface
  arm64, trans_table: add PUD_SECT_RDONLY
  arm64, trans_table: complete generalization of trans_tables
  kexec: add machine_kexec_post_load()
  arm64, kexec: move relocation function setup and clean up
  arm64, kexec: add expandable argument to relocation function
  arm64, kexec: configure transitional page table for kexec
  arm64, kexec: enable MMU during kexec relocation

 arch/arm64/Kconfig                     |   4 +
 arch/arm64/include/asm/kexec.h         |  51 ++++-
 arch/arm64/include/asm/pgtable-hwdef.h |   1 +
 arch/arm64/include/asm/trans_table.h   |  64 ++++++
 arch/arm64/kernel/asm-offsets.c        |  14 ++
 arch/arm64/kernel/cpu-reset.S          |   4 +-
 arch/arm64/kernel/cpu-reset.h          |   8 +-
 arch/arm64/kernel/hibernate.c          | 261 ++++++-----------------
 arch/arm64/kernel/machine_kexec.c      | 199 ++++++++++++++----
 arch/arm64/kernel/relocate_kernel.S    | 196 +++++++++---------
 arch/arm64/mm/Makefile                 |   1 +
 arch/arm64/mm/trans_table.c            | 274 +++++++++++++++++++++++++
 kernel/kexec.c                         |   4 +
 kernel/kexec_core.c                    |   8 +-
 kernel/kexec_file.c                    |   4 +
 kernel/kexec_internal.h                |   2 +
 16 files changed, 755 insertions(+), 340 deletions(-)
 create mode 100644 arch/arm64/include/asm/trans_table.h
 create mode 100644 arch/arm64/mm/trans_table.c

-- 
2.22.1

