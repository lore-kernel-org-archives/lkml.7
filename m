Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8136C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 02:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9750320679
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 02:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="juXdHl2/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfKVCYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 21:24:11 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41932 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfKVCYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 21:24:11 -0500
Received: by mail-qt1-f193.google.com with SMTP id 59so605691qtg.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 18:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hiLKK1+r4xrwDMfPVXvgdsqsmhpmz4wcDPltvr+YiPM=;
        b=juXdHl2/OTY1JDCI2WvisMRYkfyhCB9wL5baTK6u4p7eMyINED07coapH0Tt+jhDTZ
         pz0mU0Dl+9ZUlwgPMIllUSSMrvSNJvxM84FAxwu2TdgV95+/uj7U9npfrofHN2Vg2xBP
         AL/4MLKTSwV+OsUlPJVCLv+WEepm6sWacJ59AsPA0mIGJA2xvMttUK5wpHc2hbzSQDGA
         Hj46YAtBseFmPmD9OBoVcmsLYh7euLUgyIjHTJMMYCHNUy/Sp8SMj+4SiYqsNdkrb6yL
         lVFlX/JTHsJV+gxQz41tqhZFB+XZlGdmcR2A6yIShk049QI7rcWL1R1ea6zARZaR/6qg
         IrBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hiLKK1+r4xrwDMfPVXvgdsqsmhpmz4wcDPltvr+YiPM=;
        b=aAC0JtmMovJp5kdEdPpaoFS7b0asRtLdTLuHEfgyH+R66PkUgzQ8sg3HN84NZyiYVZ
         dQ5tH8mc5x9yPo9DFxLZOawRjfpTX6UsGQfQu7Yw4qvfXBBb3LdZARna3d6zPcTHXzdJ
         wUoBkTxHimEIRC93IzR/9w+mUj3RJaZVRwmHWf5awBgkbeTPLw6hEr27/m4M7008IS7b
         d/h+aGsJnJvoeAxm0TVJ6re86AyJX0ESe3DU87GcSdD4H7TrEev7l+Iy80drd3lG7jWy
         7DmA0go62py652d4vjB1QV3XvjuRcwRFJloPge3ayIDXdoKZRKiKK3ZN+pHZE+jA3XJG
         1wnQ==
X-Gm-Message-State: APjAAAVZjNG2bMGJiHm5stttEF4kO97YOF9f5h4zAp+bzcroRKvWWJ8T
        XAE7+L8wYJeEwU/IeXzUABCjJQ==
X-Google-Smtp-Source: APXvYqzgQzCnz8RAyDKTprcdXtRBKBNV8pw9G0OGoEv3raFUYmGZAJZFgHjMZtF26RBtdnjCSFPUmw==
X-Received: by 2002:ac8:51c3:: with SMTP id d3mr1690299qtn.14.1574389448532;
        Thu, 21 Nov 2019 18:24:08 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id z5sm2609801qtm.9.2019.11.21.18.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 18:24:07 -0800 (PST)
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
Subject: [PATCH v2 0/3] Use C inlines for uaccess
Date:   Thu, 21 Nov 2019 21:24:03 -0500
Message-Id: <20191122022406.590141-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog
v2:
	- Addressed Russell King's concern by not adding
	  uaccess_* to ARM.
	- Removed the accidental change to xtensa

Convert the remaining uaccess_* calls from ASM macros to C inlines.

These patches apply against linux-next. I boot tested ARM64, and
compile tested ARM changes.

Pavel Tatashin (3):
  arm/arm64/xen: use C inlines for privcmd_call
  arm64: remove uaccess_ttbr0 asm macros from cache functions
  arm64: remove the rest of asm-uaccess.h

 arch/arm/include/asm/assembler.h       |  2 +-
 arch/arm/include/asm/xen/hypercall.h   | 10 +++++
 arch/arm/xen/enlighten.c               |  2 +-
 arch/arm/xen/hypercall.S               |  4 +-
 arch/arm64/include/asm/asm-uaccess.h   | 60 --------------------------
 arch/arm64/include/asm/cacheflush.h    | 38 ++++++++++++++--
 arch/arm64/include/asm/xen/hypercall.h | 28 ++++++++++++
 arch/arm64/kernel/entry.S              |  6 +--
 arch/arm64/lib/clear_user.S            |  2 +-
 arch/arm64/lib/copy_from_user.S        |  2 +-
 arch/arm64/lib/copy_in_user.S          |  2 +-
 arch/arm64/lib/copy_to_user.S          |  2 +-
 arch/arm64/mm/cache.S                  | 31 +++++--------
 arch/arm64/mm/context.c                | 12 ++++++
 arch/arm64/mm/flush.c                  |  2 +-
 arch/arm64/xen/hypercall.S             | 19 +-------
 include/xen/arm/hypercall.h            | 12 +++---
 17 files changed, 115 insertions(+), 119 deletions(-)
 delete mode 100644 arch/arm64/include/asm/asm-uaccess.h

-- 
2.24.0

