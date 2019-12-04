Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3A0C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 23:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA52A20656
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 23:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="XFyzL5rT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbfLDXVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 18:21:02 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:37799 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbfLDXVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 18:21:02 -0500
Received: by mail-qv1-f65.google.com with SMTP id t7so577683qve.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 15:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GKIfn1X+i6X56lqVXfyDzwPMZCzheNRzcKTaF4L1NP0=;
        b=XFyzL5rTBwrAztY5nL0Ms1sPvQucTdFNTX8M14EOWrh36IgXf4zoI522rtxEKRoa52
         iLqCy/91jRbUTDBGb3bllaMoyeqCln4xl1FZqj+b3eCzWUr5TgFGFbAmfZ/qpae4CijU
         35EW4FQh7ww/prBUP0rcMSvO++mJcfO+k+fB3+BP0A1lGoquComcKT6UDiDreQjckSUg
         k2hjQvUPo2N86qG8pbxlMAC6Kn6AAxDYJsEGt+O6B9zeTaxWSo/9qm7e42sxKv/Xabey
         MFKaBloUYjQUJ5KZCxkfZDaZn+HAuOoWlPpNu3Gh25wuUFzC7MSzHyNs/Xar9ayJQjzK
         BvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GKIfn1X+i6X56lqVXfyDzwPMZCzheNRzcKTaF4L1NP0=;
        b=tqatoBQobvBedum+QK0tB7xUUHxhYaZg/t+841DG0mzjrtSLkJi3yysGizt+1F5qEa
         ggH5m4EJxDG+Vko92x6R0q05Ra4SPr9uSrzvEKPjIGtw059gkBtZ1JPRyxV6CG7zop6W
         UTxeKpQ7gtGs4gccFEI2gq/dPE8U8T9kdWKcdW/b/zXMEk0NcCewLcrclmIMgaa9I4EC
         1gr+Oy0IajsfBXv4+edKrRPp3BjDtAlkJz040FaaN41Ql8PnyD8/NR0fR0xPZFH+H7cM
         o0MDWjgbmHUwN2OSXu8l0TP3luV1vQAXrBqz3IgQhiMvv3AgV2hSQ2GTTkNNYe9cps3r
         iEWQ==
X-Gm-Message-State: APjAAAWEf9UWfOi1TkfzB8JlilOHZufNlVsiqQUBke72ovWI93j15OAd
        +JBIiEE7W76Uqfjn4x6XxUv3gA==
X-Google-Smtp-Source: APXvYqwN8rVvbdjEWOZ3Dsr7ynba65KMLwXI/KiByr8BhvRWV22aS+4kNOZAN22diwAm+JbXcarUcQ==
X-Received: by 2002:ad4:4949:: with SMTP id o9mr4823945qvy.189.1575501661393;
        Wed, 04 Dec 2019 15:21:01 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id t38sm4667864qta.78.2019.12.04.15.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 15:21:00 -0800 (PST)
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
Subject: [PATCH v4 0/6] Use C inlines for uaccess
Date:   Wed,  4 Dec 2019 18:20:52 -0500
Message-Id: <20191204232058.2500117-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:

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

These patches apply against linux-next. I boot tested ARM64, and
compile tested ARM change

Previous discussions:
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

 arch/arm/include/asm/assembler.h       |  2 +-
 arch/arm/include/asm/xen/hypercall.h   | 10 ++++
 arch/arm/xen/enlighten.c               |  2 +-
 arch/arm/xen/hypercall.S               |  4 +-
 arch/arm64/include/asm/asm-uaccess.h   | 61 -----------------------
 arch/arm64/include/asm/cacheflush.h    | 51 +++++++++++++++++--
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
 16 files changed, 143 insertions(+), 152 deletions(-)
 delete mode 100644 arch/arm64/include/asm/asm-uaccess.h

-- 
2.24.0

