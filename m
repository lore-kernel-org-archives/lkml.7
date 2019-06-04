Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DE5C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC8752070B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E900YRtg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfFDXpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 19:45:22 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38936 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfFDXpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 19:45:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id g9so8961495plm.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 16:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Q4JWFL9DePErvGO9qsbHL0QkxmXMM03CukJMak3SgGU=;
        b=E900YRtgVRnCMc/Rs85r8+Zp+OlDma14yMbxQLEMNMMDpIM1B0u+S1SUYKljVg2HJF
         mP7yJNMi/0UjXSZvks5r79f0h2UIFSqvnDvahgE/cFelgxVDH0YHea0S8qoOc9BnveqI
         e44vvYuqpj7e9pamH2Gdc8BDmSU5dtPt8PtKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Q4JWFL9DePErvGO9qsbHL0QkxmXMM03CukJMak3SgGU=;
        b=iPbys00VsiWTYlPZLYEoT8/fXUOZL0DLROPN+LMbm0RZdIefjpNR0xXxJuObnH60DV
         Lx83knYdN4pSpTEnEN2pPw1rEvwkd6597R2UUlgtayBsubJGeaR2GePbF6ptCOGptuI2
         k/hZ7LDvIu3AjRLbWDJp7uUq7rymWm5+Ru1tyiKDhHUcvcGiezrET0Sba23oRMJoqAwh
         eNUh6S5hZGL9NMG+SzV+9cEsnzX8DAP4BLTyUee9pTMVy4Z/ZQqtbuCetTBWUTh7TtAW
         wDaektEu52IWlmsp+JBTomR6DWM9I5LwK1E3UdeMcHJBwsKoAasCdip6saJlwV0eCKzt
         JVSQ==
X-Gm-Message-State: APjAAAWVXT0qUZvHzt3zC/C1dW+vu0O2cibjTUlS+aW7dXpEf2A7250Q
        fDfvs+tamDCO6nVbnTlxC5+/Ilq1rhY=
X-Google-Smtp-Source: APXvYqzCFexmOTgjDeZYXhal4pxi4iXkpJMTobHWl0qTo4G2sIuEd6RehnfsDbwiKcA6R/9xbZjUMA==
X-Received: by 2002:a17:902:8c94:: with SMTP id t20mr38110527plo.141.1559691914883;
        Tue, 04 Jun 2019 16:45:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f17sm19441187pgv.16.2019.06.04.16.45.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Jun 2019 16:45:12 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] x86/asm: Pin sensitive CR4 and CR0 bits
Date:   Tue,  4 Jun 2019 16:44:20 -0700
Message-Id: <20190604234422.29391-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a v2 that hopefully addresses the concerns from the v1 thread[1] on
CR4 pinning. Now it's using static branches to avoid potential atomicity
problems (though perhaps that is overkill), and it has dropped the
needless volatile marking in favor of proper asm constraint flags. The
one piece that eluded me, but which I think is okay, is delaying bit
setting on a per-CPU basis. But since the bits are global state and we
don't have read-only per-CPU data, it seemed safe as I've got it here.

Full patch 1 commit log follows, just in case it's useful to have it
in this cover letter...

[1] https://lkml.kernel.org/r/CAHk-=wjNes0wn0KUMMY6dOK_sN69z2TiGpDZ2cyzYF07s64bXQ@mail.gmail.com

-Kees


Several recent exploits have used direct calls to the native_write_cr4()
function to disable SMEP and SMAP before then continuing their exploits
using userspace memory access. This pins bits of CR4 so that they cannot
be changed through a common function. This is not intended to be general
ROP protection (which would require CFI to defend against properly), but
rather a way to avoid trivial direct function calling (or CFI bypasses
via a matching function prototype) as seen in:

https://googleprojectzero.blogspot.com/2017/05/exploiting-linux-kernel-via-packet.html
(https://github.com/xairy/kernel-exploits/tree/master/CVE-2017-7308)

The goals of this change:
 - pin specific bits (SMEP, SMAP, and UMIP) when writing CR4.
 - avoid setting the bits too early (they must become pinned only after
   CPU feature detection and selection has finished).
 - pinning mask needs to be read-only during normal runtime.
 - pinning needs to be checked after write to avoid jumps past the
   preceding "or".

Using __ro_after_init on the mask is done so it can't be first disabled
with a malicious write.

Since these bits are global state (once established by the boot CPU
and kernel boot parameters), they are safe to write to secondary CPUs
before those CPUs have finished feature detection. As such, the bits are
written with an "or" performed before the register write as that is both
easier and uses a few bytes less storage of a location we don't have:
read-only per-CPU data. (Note that initialization via cr4_init_shadow()
isn't early enough to avoid early native_write_cr4() calls.)

A check is performed after the register write because an attack could
just skip over the "or" before the register write. Such a direct jump
is possible because of how this function may be built by the compiler
(especially due to the removal of frame pointers) where it doesn't add
a stack frame (function exit may only be a retq without pops) which
is sufficient for trivial exploitation like in the timer overwrites
mentioned above).

The asm argument constraints gain the "+" modifier to convince the
compiler that it shouldn't make ordering assumptions about the arguments
or memory, and treat them as changed.

---
v2:
- move setup until after CPU feature detection and selection.
- refactor to use static branches to have atomic enabling.
- only perform the "or" after a failed check.
---

Kees Cook (2):
  x86/asm: Pin sensitive CR4 bits
  x86/asm: Pin sensitive CR0 bits

 arch/x86/include/asm/special_insns.h | 41 ++++++++++++++++++++++++++--
 arch/x86/kernel/cpu/common.c         | 18 ++++++++++++
 2 files changed, 57 insertions(+), 2 deletions(-)

-- 
2.17.1

