Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A882C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 21:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3704A217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 21:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="imrt7o+N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgABVOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 16:14:01 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43349 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgABVOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 16:14:01 -0500
Received: by mail-qk1-f196.google.com with SMTP id t129so32335690qke.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 13:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id;
        bh=MLMP74Qul+kzC8cejQXgeuw3tNFBJiGyUZucJtJ/QlY=;
        b=imrt7o+Nqx58g1O6V2mkVBF0X3mpKD7xziHHz/l8CuGj82H8zbk9o0pJKvxc8wOmXV
         VJelDvV9Sarj7pQNjxsZvXh6YCVIipLEW2vgXE2sUrAenPUIFhV6h1UMd1w2fhJlrYVy
         9Zc9EtQAARm5MWqdbkMAd9Yc2rB/6ZIUq7cwRT74dGCjbCQhVNB4m4/XOBLFQ4SzVJVt
         xdNLPyTOC5jnXobeUSmc/vhUaK5AdcHt1UHQ8I4D0Cu/XGM1TPDf4y8swfAtoywA34oy
         JsTcvvAPH6Ixw+FmxMvlmP2LLQubnM7MI4xX4QBxOKvu0SnayI4ATkyYnd1nQ/44jWYF
         XZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=MLMP74Qul+kzC8cejQXgeuw3tNFBJiGyUZucJtJ/QlY=;
        b=EaOVIjxL3aNGzXwMX1ri7dm3VDee0QrEIRF/A5nOgGDpbP9vZdpwRknFft3KDc1ALc
         n/5l0FDAe2s7n/L9sGKTdy2EhSwFws4eIYNlbDItp4OicsWtcxqXr5Qcvc98UtUdNPfF
         oZJwvnPh89J6Hr+crMZ5sJK2UuSUwFBWdQf3Coa+gLKyKc49KtPuaAVQD3wkV/kHz5gS
         +Uv2k8g4y6C04ZCpug470Pz6PCzZs+v8+bBeQdVZ0qVCed1S/+Vkv83US3YakeIi78Xp
         gL2Ek7nt11xDhVPeVZqMrcqiOiuDlPKDkAuLQ0vZX2AyXr1M6PCiB6zYIV3rwkfFd8KO
         C0uA==
X-Gm-Message-State: APjAAAV1/pUXKCyva8vvKZ+RufloF4UUmPUau9zDbsKUzj6Q6In8psJM
        bedM9nI8skMQkBWAAzv2LmS2Zg==
X-Google-Smtp-Source: APXvYqxe1FkmrFoyzjV9jkb3V7sY9OvDubbb64WjyE82gpvQTibRMR/HebgLizW6nByQc9Tc7zrXdA==
X-Received: by 2002:a37:e308:: with SMTP id y8mr68320580qki.347.1577999640406;
        Thu, 02 Jan 2020 13:14:00 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id f97sm17384185qtb.18.2020.01.02.13.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 13:13:59 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, steve.capper@arm.com,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com, mark.rutland@arm.com,
        tglx@linutronix.de, gregkh@linuxfoundation.org,
        allison@lohutok.net, info@metux.net, alexios.zavras@intel.com,
        sstabellini@kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, stefan@agner.ch, yamada.masahiro@socionext.com,
        xen-devel@lists.xenproject.org, linux@armlinux.org.uk,
        andrew.cooper3@citrix.com, julien@xen.org
Subject: [PATCH v5 0/6] Use C inlines for uaccess
Date:   Thu,  2 Jan 2020 16:13:51 -0500
Message-Id: <20200102211357.8042-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
v5:
	- Fixed build issue reported by kbuild
	- Removed a comment fix from the first patch
	- Added reviewed-by's from Julien Grall
	- Now, these patches apply against mainline
v4:
	- Split the first patch into two as Julien Grall 
	- Also as Mark Rutland suggested removed alternatives
	  from __asm_flush_cache_user_range.
v3:
	- Added Acked-by from Stefano Stabellini
	- Addressed comments from Mark Rutland
v2:
	- Addressed Russell King's concern by not adding
	  uaccess_* to ARM.
	- Removed the accidental change to xtensa

Convert the remaining uaccess_* calls from ASM macros to C inlines.

These patches apply against maineline. I boot tested ARM64, and
compile tested ARM change

Previous discussions:
v4: https://lore.kernel.org/lkml/20191204232058.2500117-1-pasha.tatashin@soleen.com
v3: https://lore.kernel.org/lkml/20191127184453.229321-1-pasha.tatashin@soleen.com
v2: https://lore.kernel.org/lkml/20191122022406.590141-1-pasha.tatashin@soleen.com
v1: https://lore.kernel.org/lkml/20191121184805.414758-1-pasha.tatashin@soleen.com

Pavel Tatashin (6):
  arm/arm64/xen: hypercall.h add includes guards
  arm/arm64/xen: use C inlines for privcmd_call
  arm64: remove uaccess_ttbr0 asm macros from cache functions
  arm64: remove __asm_flush_icache_range
  arm64: move ARM64_HAS_CACHE_DIC/_IDC from asm to C
  arm64: remove the rest of asm-uaccess.h

 arch/arm/include/asm/xen/hypercall.h   | 10 ++++
 arch/arm/xen/enlighten.c               |  2 +-
 arch/arm/xen/hypercall.S               |  4 +-
 arch/arm64/include/asm/asm-uaccess.h   | 61 -----------------------
 arch/arm64/include/asm/cacheflush.h    | 55 +++++++++++++++++++--
 arch/arm64/include/asm/xen/hypercall.h | 28 +++++++++++
 arch/arm64/kernel/entry.S              | 27 +++++++++-
 arch/arm64/lib/clear_user.S            |  2 +-
 arch/arm64/lib/copy_from_user.S        |  2 +-
 arch/arm64/lib/copy_in_user.S          |  2 +-
 arch/arm64/lib/copy_to_user.S          |  2 +-
 arch/arm64/mm/cache.S                  | 68 +++++---------------------
 arch/arm64/mm/flush.c                  |  3 +-
 arch/arm64/xen/hypercall.S             | 19 +------
 include/xen/arm/hypercall.h            | 12 ++---
 15 files changed, 146 insertions(+), 151 deletions(-)
 delete mode 100644 arch/arm64/include/asm/asm-uaccess.h

-- 
2.17.1

