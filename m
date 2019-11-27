Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E4EC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 18:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E65207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 18:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="iY3WGmb4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfK0So5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 13:44:57 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41294 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfK0So5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 13:44:57 -0500
Received: by mail-qk1-f195.google.com with SMTP id m125so20429252qkd.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 10:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F/n86b6Kh7/7bx65ohsSuhkfsrRS1fX/ghGHBMXhZiA=;
        b=iY3WGmb47fenakYk1z1uQ4/43MV+16v1SYdlJk6JAl3euekC4kAR8C4/ECW6Rz4kVJ
         cLsUVHWp7fiU24FpQ96I3EO48/XAQq9zOHMo6Z88+oUoYA2qxHZj0u0HXL9lEU30dY8Y
         ep/6IBJL7UCp1cC77ME+6B+78g9QNgLonOnUPH9yYuQX/6yAiB2YXbytWuONSaskHBTl
         LO+aA8Fj3N/cz2+KGHOx7EUjM4pzrKWWB8RcJjxbmMvaWHLPjAHHqiyL6s8xsKcjinzu
         dxrpdBh9lEOmwBD1CeekX+TeZn/pMfMPeKE4YXl9vgLYYwvwh9btiumNMmwMJzXJJu62
         L9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F/n86b6Kh7/7bx65ohsSuhkfsrRS1fX/ghGHBMXhZiA=;
        b=EjI7tGBUuxGsP73IYzNNLF4PmaG7151AipKo5dz5QJ1DfqL1iAXSGSF5YeMWAIUkpf
         739puu9imNjcSkXxu/ER+McouUY32HPnsbAFV5tr19VgXgXred+1jQfvaeBfrpQnlqKx
         0EyPtjetqWQWhqczGS1Sw9hA+kLyNc7Ihu+dA2gqO6j5qaCyBzDSBmKUkJJZ6pOjgk/c
         ELp9y7LmUjTqc42eLaxWGdtrY9/cSEdSJaqHdBuUoVnjxcrcYqoKEVea1ZAPskDegSnI
         ehbIv3rDibat05h99g304thXlx/DNXxZsrh7BHt+xQMGywF1JiWV2fhI1hGBdqK9FXg5
         g6bg==
X-Gm-Message-State: APjAAAX4OAyoiB7pQCA311tTbOhkzyVb6QER2wnkAhvpUu5O7n9x0j+S
        8KCtlVNVk791fbVIFhvxX9uCww==
X-Google-Smtp-Source: APXvYqytTMLn9EqxEu+OgYBIR0W3UcV5QcnBL8/xWD7wWi7CQazQ0liRoDUunsojwesXXqeQBJ7PVQ==
X-Received: by 2002:a37:bd06:: with SMTP id n6mr5990382qkf.286.1574880295965;
        Wed, 27 Nov 2019 10:44:55 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id o62sm2748024qte.76.2019.11.27.10.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 10:44:55 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, steve.capper@arm.com,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com, mark.rutland@arm.com,
        tglx@linutronix.de, gregkh@linuxfoundation.org,
        allison@lohutok.net, info@metux.net, alexios.zavras@intel.com,
        sstabellini@kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, stefan@agner.ch, yamada.masahiro@socionext.com,
        xen-devel@lists.xenproject.org, linux@armlinux.org.uk
Subject: [PATCH 0/3] Use C inlines for uaccess
Date:   Wed, 27 Nov 2019 13:44:50 -0500
Message-Id: <20191127184453.229321-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog
v3:
	- Added Acked-by from Stefano Stabellini
	- Addressed comments from Mark Rutland
v2:
	- Addressed Russell King's concern by not adding
	  uaccess_* to ARM.
	- Removed the accidental change to xtensa

Convert the remaining uaccess_* calls from ASM macros to C inlines.

These patches apply against linux-next. I boot tested ARM64, and
compile tested ARM change
Pavel Tatashin (3):
  arm/arm64/xen: use C inlines for privcmd_call
  arm64: remove uaccess_ttbr0 asm macros from cache functions
  arm64: remove the rest of asm-uaccess.h

 arch/arm/include/asm/assembler.h       |  2 +-
 arch/arm/include/asm/xen/hypercall.h   | 10 +++++
 arch/arm/xen/enlighten.c               |  2 +-
 arch/arm/xen/hypercall.S               |  4 +-
 arch/arm64/include/asm/asm-uaccess.h   | 61 --------------------------
 arch/arm64/include/asm/cacheflush.h    | 39 ++++++++++++++--
 arch/arm64/include/asm/xen/hypercall.h | 28 ++++++++++++
 arch/arm64/kernel/entry.S              | 27 +++++++++++-
 arch/arm64/lib/clear_user.S            |  2 +-
 arch/arm64/lib/copy_from_user.S        |  2 +-
 arch/arm64/lib/copy_in_user.S          |  2 +-
 arch/arm64/lib/copy_to_user.S          |  2 +-
 arch/arm64/mm/cache.S                  | 42 ++++++------------
 arch/arm64/mm/flush.c                  |  2 +-
 arch/arm64/xen/hypercall.S             | 19 +-------
 include/xen/arm/hypercall.h            | 12 ++---
 16 files changed, 130 insertions(+), 126 deletions(-)
 delete mode 100644 arch/arm64/include/asm/asm-uaccess.h

-- 
2.24.0

