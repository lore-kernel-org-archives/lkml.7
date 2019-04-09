Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE2AC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1612920883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="ApftFrBp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfDIVZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:25:53 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45725 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfDIVZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 17:25:53 -0400
Received: by mail-ed1-f68.google.com with SMTP id o26so95818edv.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 14:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DEibYvnJOT/AXrEykbQH+ZEm0O+Co96okaAqfEd0oe0=;
        b=ApftFrBp2GKWzpizNkRot6/E2kafAeHEayvgCvWkzyqFMUHkPv0Puo84qIaJIvHuOG
         7E9HbLIukZFDuX/ZSXdx8fRQYnraVsKdfurUV90y8HiVkho++04I5EJjBUUhLwH5lUUX
         GrcQFZwHiCD34KHgRUcacicW+Gf80EXMJVX90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DEibYvnJOT/AXrEykbQH+ZEm0O+Co96okaAqfEd0oe0=;
        b=ShoW/XV7yARgl//GXpReYvtdXRPn4eWsHomiHA2zoRYTdKlcH1Cb6l0EVgjmZqlHeu
         o2ClMsLA2rUffxTwDKTv9UtVr+b41LO9bfDTatd6gCVIJPjFE94ULImvm5oc2+4MHk2M
         LAbdxeqVJDQJEOx+WjsLD0j83q1XDlRYfT1zu/RCzr7hu6ecA0+IizKJChoyT7GF/UBX
         nLZd+UkT1aHWvJF8mYvd/m7AvyDPOC2OdL8E4rlJVG8jJOjab+oYTj1cQr6WRrOIvAEC
         dsC+EI8OPg4c7lOvAeT6wJmceOZLwHPmp13RRir/IXqmpH8hKre5Kb+PzPvSeNuaqOr6
         U27w==
X-Gm-Message-State: APjAAAVKp4gpQ+p/hR2lJ5u4TX/QzMXjugfQ6u6jIf+qTECRvbix8Tcg
        L1nwFRn02/sDJSIr5UTo/KlV4JH4FEbPmkCr
X-Google-Smtp-Source: APXvYqwRRQpYse2JKy7O0+MQPpjToIC2KiJl10KZ5FIj1p46BJAckzLHtv1USMyNV6zx14fgC0GcCQ==
X-Received: by 2002:a17:906:5149:: with SMTP id s9mr21353914ejl.25.1554845151506;
        Tue, 09 Apr 2019 14:25:51 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-118-63.cgn.fibianet.dk. [5.186.118.63])
        by smtp.gmail.com with ESMTPSA id i26sm3477986ejc.51.2019.04.09.14.25.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 14:25:50 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 00/10] implement DYNAMIC_DEBUG_RELATIVE_POINTERS
Date:   Tue,  9 Apr 2019 23:25:07 +0200
Message-Id: <20190409212517.7321-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to CONFIG_GENERIC_BUG_RELATIVE_POINTERS that replaces (8 byte)
const char* members by (4 byte) signed offsets from the bug_entry,
this implements the similar thing for struct _ddebug, the descriptors
underlying pr_debug() and friends in a CONFIG_DYNAMIC_DEBUG kernel.

Since struct _ddebug has four string members, we save 16 byte per
instance. The total savings seem to be comparable to what is saved by
an architecture selecting GENERIC_BUG_RELATIVE_POINTERS (see patch 8
for some numbers for a common distro config).

While refreshing these patches, which were orignally just targeted at
x86-64, it occured to me that despite the implementation relying on
inline asm, there's nothing x86 specific about it, and indeed it seems
to work out-of-the-box for ppc64 and arm64 as well, but those have
only been compile-tested.

The first 6 patches are rather pedestrian preparations. The fun stuff
is in patch 7, and the remaining three patches are just the minimal
boilerplate to hook up the config option and asm-generic header on the
three architectures.

Rasmus Villemoes (10):
  linux/device.h: use unique identifier for each struct _ddebug
  linux/net.h: use unique identifier for each struct _ddebug
  linux/printk.h: use unique identifier for each struct _ddebug
  dynamic_debug: introduce accessors for string members of struct
    _ddebug
  dynamic_debug: drop use of bitfields in struct _ddebug
  dynamic_debug: introduce CONFIG_DYNAMIC_DEBUG_RELATIVE_POINTERS
  dynamic_debug: add asm-generic implementation for
    DYNAMIC_DEBUG_RELATIVE_POINTERS
  x86-64: select DYNAMIC_DEBUG_RELATIVE_POINTERS
  arm64: select DYNAMIC_DEBUG_RELATIVE_POINTERS
  powerpc: select DYNAMIC_DEBUG_RELATIVE_POINTERS for PPC64

 arch/arm64/Kconfig                          |   1 +
 arch/arm64/include/asm/Kbuild               |   1 +
 arch/powerpc/Kconfig                        |   1 +
 arch/powerpc/include/asm/Kbuild             |   1 +
 arch/x86/Kconfig                            |   1 +
 arch/x86/entry/vdso/vdso32/vclock_gettime.c |   1 +
 arch/x86/include/asm/Kbuild                 |   1 +
 include/asm-generic/dynamic_debug.h         | 116 ++++++++++++++++++++
 include/linux/device.h                      |   4 +-
 include/linux/dynamic_debug.h               |  26 +++--
 include/linux/jump_label.h                  |   2 +
 include/linux/net.h                         |   4 +-
 include/linux/printk.h                      |   4 +-
 lib/Kconfig.debug                           |   3 +
 lib/dynamic_debug.c                         | 111 ++++++++++++++-----
 15 files changed, 237 insertions(+), 40 deletions(-)
 create mode 100644 include/asm-generic/dynamic_debug.h

-- 
2.20.1

