Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CFDC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 18:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB3E20709
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 18:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Qd5DOiTE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfKUSsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 13:48:09 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:37907 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfKUSsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 13:48:09 -0500
Received: by mail-qv1-f68.google.com with SMTP id q19so1854806qvs.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 10:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c8nVRzgB0YDtJ+y9FNkA3x/d530+qZE+NnYikZNbCrY=;
        b=Qd5DOiTEUKkAbvWWBA600R4XlxLwFyDaJa4sle8qP7489uHD80RxMqUwg5kGz940pO
         Uy/pT7lJTR4GjlFlbX7dHMDtR211secMJRkotfPvB3o5DKTw1xv6+vrmxKW2htfMcNZX
         g98vk8RHBl+DeicsPE+4EaSyMYG2IvzwUx8keHJ3qp1ecHMWoDc07wiL++XC9dFUC0uh
         07RFJvQGvxdBHY09cPELbIbfaaty+SNFMSSt86Yd256lMjQTqyMjWc/5tY2oblfPJ/m+
         EgTVEXpzneOCRxHOBITpWNP/bgT484K6eQDsihDtqabDvyYJu/4Vl0nQYvaEC/PFgMOd
         GvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c8nVRzgB0YDtJ+y9FNkA3x/d530+qZE+NnYikZNbCrY=;
        b=KvljZrvmGDJc3LGGlwkRyfHF20OCRnrN28JlxrxRGKWYXQSrZzX4UKWlcBuduNBkwx
         HQ4s0ykAH1PL0alU0ltVvN6dihHQEJUl7DzCuWb6qEeKrqu4HN4vKTw2J8kXnbr9Q9CX
         buWf97KXmoJdU8OxTyetYmXPHoQ9HKWP5fujxCu/3E0i/f2BQQqVuxUN9tWMEM4rkM9Y
         xtAdjG4Gyff0RWi+3e/2KMD3kSj4RB06zI756RvDoEWwb88a+88h/+KXVxjp/DXmK3uZ
         ArWkAayvyT7X+ok5MH8DOQLwTjP0NAkA9SUe9U4LxkiYTr8J9ZRoVDVYoi1iOJPwKqhS
         wdUg==
X-Gm-Message-State: APjAAAV4CQ3qWfWWv/hP5MGeRrK2b30cP317Hhli1luEEFxFmDKe9M+6
        FvXZLHcb3mGXwpegYQIzQAlC7w==
X-Google-Smtp-Source: APXvYqwZjCYx8RRyhAGY177FzvhWk79OzV7zKnj87grfXziN6cxCQV8PczfcjMpEI7opQBzRuRrwkw==
X-Received: by 2002:a0c:f787:: with SMTP id s7mr9663802qvn.12.1574362087643;
        Thu, 21 Nov 2019 10:48:07 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id t2sm1811634qkt.95.2019.11.21.10.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 10:48:06 -0800 (PST)
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
Date:   Thu, 21 Nov 2019 13:48:02 -0500
Message-Id: <20191121184805.414758-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the remaining uaccess_* calls from ASM macros to C inlines.

These patches apply against linux-next. I boot tested ARM64, and
compile tested ARM changes.

Pavel Tatashin (3):
  arm/arm64/xen: use C inlines for privcmd_call
  arm64: remove uaccess_ttbr0 asm macros from cache functions
  arm64: remove the rest of asm-uaccess.h

 arch/arm/include/asm/assembler.h     |  2 +-
 arch/arm/include/asm/uaccess.h       | 32 ++++++++++++---
 arch/arm/xen/enlighten.c             |  2 +-
 arch/arm/xen/hypercall.S             | 15 +------
 arch/arm64/include/asm/asm-uaccess.h | 60 ----------------------------
 arch/arm64/include/asm/cacheflush.h  | 38 ++++++++++++++++--
 arch/arm64/kernel/entry.S            |  6 +--
 arch/arm64/lib/clear_user.S          |  2 +-
 arch/arm64/lib/copy_from_user.S      |  2 +-
 arch/arm64/lib/copy_in_user.S        |  2 +-
 arch/arm64/lib/copy_to_user.S        |  2 +-
 arch/arm64/mm/cache.S                | 31 +++++---------
 arch/arm64/mm/context.c              | 12 ++++++
 arch/arm64/mm/flush.c                |  2 +-
 arch/arm64/xen/hypercall.S           | 19 +--------
 arch/xtensa/kernel/coprocessor.S     |  1 -
 include/xen/arm/hypercall.h          | 23 +++++++++--
 17 files changed, 117 insertions(+), 134 deletions(-)
 delete mode 100644 arch/arm64/include/asm/asm-uaccess.h

-- 
2.24.0

