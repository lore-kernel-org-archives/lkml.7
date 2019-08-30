Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87017C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 23:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54DC323431
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 23:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="cDQkZtN0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbfH3XPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 19:15:34 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44833 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728221AbfH3XPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 19:15:34 -0400
Received: by mail-ed1-f66.google.com with SMTP id a21so9695671edt.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 16:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xgZi6hgOEtnWuRYmibUFEKtPcNiERXTxf2GWhYadNq8=;
        b=cDQkZtN0yUyjlbpjrKbMde80SE/4gb3NYwoZQDaIvt2VFDcS6jWBNn+9YD9bK8uwtC
         XYIlFwvBHorcSZ0BryPShYrHNyTISpmK6acfWxDEYCHHzFTGFEHAJUsnPNFtwPAjfEed
         onW23iNYtN5RSLoAzQ4V6h7AVozMK8kv0JvxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xgZi6hgOEtnWuRYmibUFEKtPcNiERXTxf2GWhYadNq8=;
        b=VwN25yx96FIQ4hIsXxnaVNt/WBXlLg/nEdc0BEaL2Tn7A0pJAY4yD/+1vakb1HJjHe
         3Ekx9KIj1GHTYa7TuFfhXUCEBji6okGuijj+yVpqfCVRAK7JR03KwILuU0uhDHlr6fEl
         3i1YwQajkGDbN7se9ZDpTT/RST1YbIf9jc+uVtwjFowm4clSeGuuAdfvJeV2ywoBhmSM
         N7UwGV2V/XFBhO6jnK6gP0WASjyJdpMBcF42oyRK9sDFm7/gGzuI47lxv9Da3p7gzidx
         gP/Pks+EiVJ9k9GsSI4S/SEytRj/r/Om62vE1ZagDSqLssSmLcQNRae+sg41UA4UYgqx
         Y5/w==
X-Gm-Message-State: APjAAAVojWUuqV/1CEMuTBr+nRyiP77NfnexFBQIz3e85+rHvrmMKU00
        cVQ3CODnwpSsZCn3NcBn+at/+w==
X-Google-Smtp-Source: APXvYqwh5NZzINZPv+SrlEnKRtetSGD25eQN6ER3W0G9kppcfKI4KHYZWZggKCg2EgCbwc7IehEN4A==
X-Received: by 2002:a17:906:a88b:: with SMTP id ha11mr15184008ejb.116.1567206932482;
        Fri, 30 Aug 2019 16:15:32 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-115-35.cgn.fibianet.dk. [5.186.115.35])
        by smtp.gmail.com with ESMTPSA id s4sm875457ejx.33.2019.08.30.16.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 16:15:31 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        ndesaulniers@google.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 0/6] make use of gcc 9's "asm inline()"
Date:   Sat, 31 Aug 2019 01:15:21 +0200
Message-Id: <20190830231527.22304-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829083233.24162-1-linux@rasmusvillemoes.dk>
References: <20190829083233.24162-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc 9 provides a way to override the otherwise crude heuristic that
gcc uses to estimate the size of the code represented by an asm()
statement. From the gcc docs

  If you use 'asm inline' instead of just 'asm', then for inlining
  purposes the size of the asm is taken as the minimum size, ignoring
  how many instructions GCC thinks it is.

For compatibility with older compilers, we obviously want a

  #if new enough
  #define asm_inline asm inline
  #else
  #define asm_inline asm
  #endif

But since we #define the identifier inline to attach some attributes,
we have to use an alternate spelling of that keyword. gcc provides
both __inline__ and __inline, and we currently #define both to inline,
so they all have the same semantics. We have to free up one of
__inline__ and __inline, and the latter is by far the easiest. 

The two x86 changes cause smaller code gen differences than I'd
expect, but I think we do want the asm_inline thing available sooner
or later, so this is just to get the ball rolling.

Changes since v1: __inline instead of __inline__, making the diffstat
400 lines smaller. Probably no longer needs special handling (having
Linus run a script to generate patch 1), so if the x86 folks want 5/6
and 6/6, perhaps the whole thing can be routed that way.

Rasmus Villemoes (6):
  staging: rtl8723bs: replace __inline by inline
  lib/zstd/mem.h: replace __inline by inline
  compiler_types.h: don't #define __inline
  compiler-gcc.h: add asm_inline definition
  x86: alternative.h: use asm_inline for all alternative variants
  x86: bug.h: use asm_inline in _BUG_FLAGS definitions

 arch/x86/include/asm/alternative.h               | 14 +++++++-------
 arch/x86/include/asm/bug.h                       |  4 ++--
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c     |  4 ++--
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c   |  2 +-
 drivers/staging/rtl8723bs/include/drv_types.h    |  6 +++---
 .../staging/rtl8723bs/include/osdep_service.h    | 10 +++++-----
 .../rtl8723bs/include/osdep_service_linux.h      | 14 +++++++-------
 drivers/staging/rtl8723bs/include/rtw_mlme.h     | 14 +++++++-------
 drivers/staging/rtl8723bs/include/rtw_recv.h     | 16 ++++++++--------
 drivers/staging/rtl8723bs/include/sta_info.h     |  2 +-
 drivers/staging/rtl8723bs/include/wifi.h         | 14 +++++++-------
 drivers/staging/rtl8723bs/include/wlan_bssdef.h  |  2 +-
 include/linux/compiler-gcc.h                     |  4 ++++
 include/linux/compiler_types.h                   | 15 ++++++++++++++-
 lib/zstd/mem.h                                   |  2 +-
 15 files changed, 70 insertions(+), 53 deletions(-)

-- 
2.20.1

