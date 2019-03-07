Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3243EC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F0B20835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551948177;
	bh=hCSqW6malXBUnAflq6OJugYq9TE5T/1xlAaWmeNfe2I=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=rRrjsbAaf88Dc1QRb7Ys+Ud/nzpUm03JUURxtXMZdHhPAYmAbmONi0yuskSn6VeZF
	 Ybc7ZLLWzy/onyuA0pbfzRokjYRrJCy0sQlW8Y6W5O350D7ixbn+OjFgJRq+Mfkcs4
	 EMSlYSdZBq4CX26ad0JyqsIAcERj0y83S3VYMZbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfCGImz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 03:42:55 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44091 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCGImy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 03:42:54 -0500
Received: by mail-wr1-f66.google.com with SMTP id w2so16372997wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 00:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=m6bDaGHHhWQ2R7efbfgBlNywPAhztoHCEiq+0RXxwRk=;
        b=itziB5weUyx3uzs3lsodTP+PF9w2NYjCR5mjtkuWrLchn5spwF/2LZ2dooVUVycH6Z
         11xxa04Z43lzjqtGrvH/T8YA5WdBFYHqjfFqQJZlJrGqyxKeJeu9jMGLwU1dk/6AHXRu
         JxrQKfM1nOFZZfX0BnpgAxgZe4h3rvK4qyf709qXxbJ1kDDTbRgjbKgz9VTnC2rAYC8E
         nOQ1r24TG1UcIEXV459EGUxGKOHAd4pCTXV+sk1n7FhmqINWZmHwCrtS1zrP3l2WwSDy
         Gqzm8xg5UPj88tHL2VlQ5JxD1VFU8d5/uWww/NS7IEzT1lalu1fttEuBP0dzELGqnQH+
         vNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=m6bDaGHHhWQ2R7efbfgBlNywPAhztoHCEiq+0RXxwRk=;
        b=PwXzU28/DW2v6Vi+lpAIxOZEJf0xazbjc4txD2bpDt8HqQ9KdCaExUcRl3JXJ2wcAB
         /4NktM5OEGJ+dGyDer32UWHsdzxFO+OK6zEt1Z06iHuV5cujEK1nuqKzcAeyB+Khe5dk
         b/f3T9Oz20Jy2DBf2nj7yVQ2zlWhuBiFtqqbYWtDtbklDt3GiNW/Q2G5hcLpXmtHslxI
         1UYKQhluAXyCFk3NSBbELK3wmHmV8RdE3VhOfzF8w0eWQJR6Eb7OUBKzz4wFsTzQDy9w
         w8uenqaLYYOd1zj/q7ZIeInPSixvpwqofZ9BkkXcJoNr32gyAXE/tYUJVXF8AaikmtYR
         dOVg==
X-Gm-Message-State: APjAAAUH58aoBTQ7trxV58ZE8KnqgP6aQ8UL/XtRBypwdCoFrDajpQyS
        u7DCr2/5sYTKIh/7JH0K3ZQ=
X-Google-Smtp-Source: APXvYqx+trc8t6VaLUHg2Ow/i3N4rw5pc8oBcfut5sz12aKQYBGwjQvZ2AzWhnk+kypcpjDBj3voBQ==
X-Received: by 2002:adf:f690:: with SMTP id v16mr6044587wrp.139.1551948173240;
        Thu, 07 Mar 2019 00:42:53 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a22sm3811843wmj.35.2019.03.07.00.42.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 00:42:52 -0800 (PST)
Date:   Thu, 7 Mar 2019 09:42:50 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/boot changes for v5.1
Message-ID: <20190307084250.GA122542@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-boot-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-for-linus

   # HEAD: 6f913de3231e1d70a871135b38219da7810df218 x86/boot/compressed/64: Do not read legacy ROM on EFI system

Most of the changes center around the difficult problem of KASLR pinning 
down hot-removable memory regions. At the very early stage KASRL is 
making irreversible kernel address layout decisions we don't have full 
knowledge about the memory maps yet. So the changes from Chao Fan add 
this (parsing the RSDP table early), together with fixes from Borislav 
Petkov.

 Thanks,

	Ingo

------------------>
Borislav Petkov (4):
      x86/boot: Build the command line parsing code unconditionally
      x86/boot: Fix cmdline_find_option() prototype visibility
      x86/boot: Fix randconfig build error due to MEMORY_HOTREMOVE
      x86/boot: Correct RSDP parsing with 32-bit EFI

Chao Fan (7):
      x86/boot: Copy kstrtoull() to boot/string.c
      x86/boot: Add "acpi_rsdp=" early parsing
      x86/boot: Search for RSDP in the EFI tables
      x86/boot: Search for RSDP in memory
      x86/boot: Early parse RSDP and save it in boot_params
      x86/boot: Parse SRAT table and count immovable memory regions
      x86/boot/KASLR: Limit KASLR to extract the kernel in immovable memory only

Kairui Song (1):
      x86/kexec: Fill in acpi_rsdp_addr from the first kernel

Kirill A. Shutemov (1):
      x86/boot/compressed/64: Do not read legacy ROM on EFI system


 arch/x86/boot/compressed/Makefile     |   2 +
 arch/x86/boot/compressed/acpi.c       | 338 ++++++++++++++++++++++++++++++++++
 arch/x86/boot/compressed/cmdline.c    |   4 -
 arch/x86/boot/compressed/kaslr.c      |  75 ++++++--
 arch/x86/boot/compressed/misc.c       |   3 +
 arch/x86/boot/compressed/misc.h       |  23 ++-
 arch/x86/boot/compressed/pgtable_64.c |  19 +-
 arch/x86/boot/string.c                | 141 ++++++++++++++
 arch/x86/boot/string.h                |   1 +
 arch/x86/kernel/kexec-bzimage64.c     |   4 +-
 10 files changed, 585 insertions(+), 25 deletions(-)
 create mode 100644 arch/x86/boot/compressed/acpi.c

