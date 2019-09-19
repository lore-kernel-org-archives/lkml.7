Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A040DC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 21:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635F5208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 21:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6FLad1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733106AbfISVyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 17:54:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45564 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732504AbfISVyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 17:54:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id r5so4641620wrm.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 14:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=dDQhgqTVaKKerDS1Wnw7r8CYmkbiExuH1OvXVrz7qFg=;
        b=H6FLad1kEM+x9ztmI1BPxp4rJ6pp7Lfr6kexHYDsZH9Yi4OQN1GG9L53cf54qWm0nb
         TjsKT5ctnD2KPVohtEN+jx7NgDJPVvUZNAaCAaWbnNh1ySnOc2N61Dqo1dcrlrmayERw
         tf8Xg522bThDevE6ks/Vepp3BOta4dTJI/K+K4gZtce2lflrbbpT1kWCH61Mzl+2I1D0
         9x38M0qrJoAsyrZOYIRCrzZA/QJcNCrmcJTa05OK9SkTN0cuwRCkhqcbqU8R8EZPGbxh
         NkEctdt+LeliWs4Th6gPVildx75WFgMHZELzDUbXm1chL0akZHn19IdgCa/vD5u9Q3QY
         Qt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=dDQhgqTVaKKerDS1Wnw7r8CYmkbiExuH1OvXVrz7qFg=;
        b=Pu7dLlJL5EapE+svD1WHgC/fo+bLEeK8d7T91IpCZpWjL/4Rk3wkRB3df4TcJhI6Ad
         aLFdyaaTbFHzKec5nhuw11VgqZ7JJ4cFyk2cWGKUgkENLHgWc7RiNvXLEqXvCbdxkH5h
         wRSSrMCMu6ZMP9P7glFmLzFaJiYq4egI1XbfJzbwidAhFOTO+V3XLgDlACt5hOOQZgSP
         CWvHhH09Aby07Ql/IfyAYmvoZs2pibHmF6eA7hC+5TXY+GUVFV1XpACFTQFGSv2ye6+s
         6aMsLsv794Qr7i0zpW4k6j90kARDua9VnmMCPgct5YlZHDHg7dZEG2lAEjmNh0gfQc6X
         cjUQ==
X-Gm-Message-State: APjAAAWwwmaA4cZXvAB3l1ntAvZbmWB+8YuY6qtvhixgc2nbhSl86Lf4
        q/m31qBZqhpEmEhkbecuJq4=
X-Google-Smtp-Source: APXvYqwgUnNOVsR6gRzXDDdDITIQWQapnTm1vwR/Ap+JiO1rrnskvgjLArtyPDkWpzoKqV0+xlN3RA==
X-Received: by 2002:adf:f081:: with SMTP id n1mr8802933wro.273.1568930072408;
        Thu, 19 Sep 2019 14:54:32 -0700 (PDT)
Received: from gmail.com ([206.189.48.126])
        by smtp.gmail.com with ESMTPSA id z189sm10861620wmc.25.2019.09.19.14.54.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Sep 2019 14:54:31 -0700 (PDT)
Date:   Thu, 19 Sep 2019 23:54:21 +0200
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Borislav Petkov <bp@alien8.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] compiler-attributes for v5.4
Message-ID: <20190919215353.GA16429@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this patch series which make us take advantage of `asm inline`.

You will encounter an easy merge conflict on `init/Kconfig` due to
the (already merged) arm64 tree.

Cheers,
Miguel

The following changes since commit f74c2bb98776e2de508f4d607cd519873065118e:

  Linux 5.3-rc8 (2019-09-08 13:33:15 -0700)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/compiler-attributes-for-linus-v5.4

for you to fetch changes up to 32ee8230b2b06c50f583e14fcd174d7d2edb52f5:

  x86: bug.h: use asm_inline in _BUG_FLAGS definitions (2019-09-15 20:14:15 +0200)

----------------------------------------------------------------
Make use of gcc 9's "asm inline()" (Rasmus Villemoes):

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

----------------------------------------------------------------
Rasmus Villemoes (6):
      staging: rtl8723bs: replace __inline by inline
      lib/zstd/mem.h: replace __inline by inline
      compiler_types.h: don't #define __inline
      compiler-types.h: add asm_inline definition
      x86: alternative.h: use asm_inline for all alternative variants
      x86: bug.h: use asm_inline in _BUG_FLAGS definitions

 arch/x86/include/asm/alternative.h                      | 14 +++++++-------
 arch/x86/include/asm/bug.h                              |  4 ++--
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c            |  4 ++--
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c          |  2 +-
 drivers/staging/rtl8723bs/include/drv_types.h           |  6 +++---
 drivers/staging/rtl8723bs/include/osdep_service.h       | 10 +++++-----
 drivers/staging/rtl8723bs/include/osdep_service_linux.h | 14 +++++++-------
 drivers/staging/rtl8723bs/include/rtw_mlme.h            | 14 +++++++-------
 drivers/staging/rtl8723bs/include/rtw_recv.h            | 16 ++++++++--------
 drivers/staging/rtl8723bs/include/sta_info.h            |  2 +-
 drivers/staging/rtl8723bs/include/wifi.h                | 14 +++++++-------
 drivers/staging/rtl8723bs/include/wlan_bssdef.h         |  2 +-
 include/linux/compiler_types.h                          | 17 ++++++++++++++++-
 init/Kconfig                                            |  3 +++
 lib/zstd/mem.h                                          |  2 +-
 15 files changed, 71 insertions(+), 53 deletions(-)
