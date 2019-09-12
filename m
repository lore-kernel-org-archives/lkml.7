Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA9CC4CEC7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 22:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 230EC2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 22:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="I4M6Pxiq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfILWTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 18:19:44 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38235 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfILWTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 18:19:44 -0400
Received: by mail-ed1-f68.google.com with SMTP id a23so23106408edv.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 15:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a8kQob7T6P+OUxEnry9vx0BLrZwP8NcH/ZlQgT/hDMk=;
        b=I4M6PxiqSj1HzelMnxYmutuvJ5kNnOMJMwN4JtxlADE6wp03E89oojH9G5qCsvXET5
         /DPknHEwnhhNNlbDBQejkpewwYZtHzEl5052vEPfSM/ZSxr1NHRzr66WBMqosUQ2i/EU
         EJpYwrVsCAydkPa/Tip2Z/36sNKB5Bsbe9gq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a8kQob7T6P+OUxEnry9vx0BLrZwP8NcH/ZlQgT/hDMk=;
        b=qP3wJTsTkwruMyUo6BT3P1L9q3BVWx9rmiIwyIXZ3NobrBWdgwu0lv3zjQyE8gsGW2
         H9ZOlAPl70qVz+fX/5TekFXiTJAxGE0mLg9HV+FLF2hdYhd+4GqOCS1SNB4LBsC/S4kL
         X5ZsJD6XJ/WPZDyNX2bPL0s9R0pYBPucN8cofBCr6vGd7cKCxgxAGzP+Mj6A9P2b1HbG
         RB1AF7QbnQdYRS30GK7VXkJU7gzVpswB5t9LMasl8iIHJNqli/xelYO0yzAD0GPFn93C
         Qhcdr27xeJgJGkVwaSry5Y1XpqK6BdTnP3MQRUlu15T9A742rNc72q36SsbP6a7B5+qf
         lq1Q==
X-Gm-Message-State: APjAAAUHurOyd1tKft8F2DzIU84Z8yVAaZCk0JelVE69s2Kr8d7zoo67
        3Mx5pJoM8ob+JL9NuXxyxqqF9A==
X-Google-Smtp-Source: APXvYqy92aZbqZiUDebvxVcHyyH0I3ckHwLhWxof2dt3G9U8CMkI7wJJh76QsZVEdK23nOtgOQi/jQ==
X-Received: by 2002:a50:c209:: with SMTP id n9mr44878590edf.215.1568326782473;
        Thu, 12 Sep 2019 15:19:42 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-115-35.cgn.fibianet.dk. [5.186.115.35])
        by smtp.gmail.com with ESMTPSA id 36sm4305228edz.92.2019.09.12.15.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 15:19:41 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        ndesaulniers@google.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 0/6] make use of gcc 9's "asm inline()"
Date:   Fri, 13 Sep 2019 00:19:21 +0200
Message-Id: <20190912221927.18641-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190830231527.22304-1-linux@rasmusvillemoes.dk>
References: <20190830231527.22304-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc 9+ (and gcc 8.3, 7.5) provides a way to override the otherwise
crude heuristic that gcc uses to estimate the size of the code
represented by an asm() statement. From the gcc docs

  If you use 'asm inline' instead of just 'asm', then for inlining
  purposes the size of the asm is taken as the minimum size, ignoring
  how many instructions GCC thinks it is.

For compatibility with older compilers, we obviously want a

  #if [understands asm inline]
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
400 lines smaller.

Changes since v2: Check support of "asm inline" in Kconfig rather than
based on gcc version, since the feature was backported to gcc 7.x and
gcc 8.x. That also automatically enables it if and when Clang grows
support, though that compiler apparently does not have the same
problems with overestimating sizes of asm()s that gcc has.

Patch 1 has already been picked up by Greg in staging-next, it's
included here for completeness. I don't know how to route the rest, or
if they should simply wait for 5.5 given how close we are to the merge
window for 5.4.

Rasmus Villemoes (6):
  staging: rtl8723bs: replace __inline by inline
  lib/zstd/mem.h: replace __inline by inline
  compiler_types.h: don't #define __inline
  compiler-types.h: add asm_inline definition
  x86: alternative.h: use asm_inline for all alternative variants
  x86: bug.h: use asm_inline in _BUG_FLAGS definitions

 arch/x86/include/asm/alternative.h              | 14 +++++++-------
 arch/x86/include/asm/bug.h                      |  4 ++--
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c    |  4 ++--
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c  |  2 +-
 drivers/staging/rtl8723bs/include/drv_types.h   |  6 +++---
 .../staging/rtl8723bs/include/osdep_service.h   | 10 +++++-----
 .../rtl8723bs/include/osdep_service_linux.h     | 14 +++++++-------
 drivers/staging/rtl8723bs/include/rtw_mlme.h    | 14 +++++++-------
 drivers/staging/rtl8723bs/include/rtw_recv.h    | 16 ++++++++--------
 drivers/staging/rtl8723bs/include/sta_info.h    |  2 +-
 drivers/staging/rtl8723bs/include/wifi.h        | 14 +++++++-------
 drivers/staging/rtl8723bs/include/wlan_bssdef.h |  2 +-
 include/linux/compiler_types.h                  | 17 ++++++++++++++++-
 init/Kconfig                                    |  3 +++
 lib/zstd/mem.h                                  |  2 +-
 15 files changed, 71 insertions(+), 53 deletions(-)

-- 
2.20.1

