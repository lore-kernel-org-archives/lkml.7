Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02393C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 22:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C735B20637
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 22:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gm9HwVK6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfLIWaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 17:30:21 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:37615 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfLIWaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 17:30:21 -0500
Received: by mail-pf1-f201.google.com with SMTP id 13so10096001pfj.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 14:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=t/1UStflpkba+9ZUNaSHKODK6B51M8rcDxieTuoYA4M=;
        b=gm9HwVK6fxD5suhOgCk7Tqmkef4vDSdqxt5K56QTUcNLFn1QZxRucbsJCBO5HXWsIJ
         sXBCidhNZIdgVhpJ4q9N208byXFqFjIenM5TCJoAty96z/QTJxUfLcshXlCan1Kmix4s
         O0LahjEnCOuKXPGayOFyTifTWvtYWP9dMXGZC/QiO+foAjPrABjJ2dktvJfTC0CsZmYG
         ZJy7Ha9i6tHEx13CClFg5S01ki+Kamb6Ruso+dGhqEZhJ1Yc/r1lppNmuGUnXNq8bddm
         ERMeXa8CH6HC4wcnpE1ppR7i5xJCgdRqPxOzcEDt922796CspxnpGDklNHqLfk4psCci
         6Jtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=t/1UStflpkba+9ZUNaSHKODK6B51M8rcDxieTuoYA4M=;
        b=CBQ8suIMSMia9YAK7oEpJdp/AigCV5jrh5vJnYAscram30Vr8wmCif+JMlNClP8G0G
         fFkT83b3+aoACOUa5Q8m22qB3gxL2YVur/UzQvi70uouaiXH++WXkZCAnQ57OV2xKEOK
         QljZTMEalsaMOw0QncD2u/p4gSCdrcXX6/I4LH2G1I04fiYwd5aapE+8097Fwvfxli3Q
         LCK1beWtdoNoUsZ3Kh0qiHZyUzJ7shxsaCRJYPLJLq6V40rUIL93G8Ju/3Raac0Am5Cp
         u7ogbpIcQJ6SxCNrfwJz3DvitCbxMXHaI68evUN24VgWpwQPttq6b8wmQlDZQv7tJ3DF
         83qw==
X-Gm-Message-State: APjAAAVyr5Ok2ZDKB2y7lzeB4cDaRMhSZNwqekrQKw6RowhF5l/RUith
        ofj8ScZ+nGbPjFzbrBZPeSKji8NcNlSptP3XB5E=
X-Google-Smtp-Source: APXvYqz/+vR/BO/XifTVHhuPFPKeRt5GgaHVo9pcQI3oSQy6uBUApzEgwqvvb36SYEnZAbt0EykOuPNLfVH7ZRRcZmQ=
X-Received: by 2002:a63:4f5c:: with SMTP id p28mr20715986pgl.409.1575930620462;
 Mon, 09 Dec 2019 14:30:20 -0800 (PST)
Date:   Mon,  9 Dec 2019 14:29:54 -0800
Message-Id: <20191209222956.239798-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH 0/2] Hexagon fixes
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     bcain@codeaurora.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>, lee.jones@linaro.org,
        andriy.shevchenko@linux.intel.com, ztuowen@gmail.com,
        mika.westerberg@linux.intel.com, mcgrof@kernel.org,
        gregkh@linuxfoundation.org, alexios.zavras@intel.com,
        allison@lohutok.net, will@kernel.org, rfontana@redhat.com,
        tglx@linutronix.de, peterz@infradead.org, boqun.feng@gmail.com,
        mingo@redhat.com, akpm@linux-foundation.org, geert@linux-m68k.org,
        linux-hexagon@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes 2 warnings when trying to build hexagon with Clang:
$ ARCH=hexagon CROSS_COMPILE=hexagon-linux-gnu- make -j71 \
  CC=clang AS=clang LD=ld.lld AR=llvm-ar

Fixes -Winline-asm and -Wimplicit-function-definition.

Nick Desaulniers (2):
  hexagon: define ioremap_uc
  hexagon: parenthesize registers in asm predicates

 arch/hexagon/include/asm/atomic.h   |  8 ++++----
 arch/hexagon/include/asm/bitops.h   |  8 ++++----
 arch/hexagon/include/asm/cmpxchg.h  |  2 +-
 arch/hexagon/include/asm/futex.h    |  6 +++---
 arch/hexagon/include/asm/io.h       |  1 +
 arch/hexagon/include/asm/spinlock.h | 20 ++++++++++----------
 arch/hexagon/kernel/vm_entry.S      |  2 +-
 7 files changed, 24 insertions(+), 23 deletions(-)

-- 
2.24.0.393.g34dc348eaf-goog

