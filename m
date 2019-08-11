Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F4FC433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 18:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8C22085A
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 18:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpTg4xV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfHKStp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 14:49:45 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39998 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfHKStp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 14:49:45 -0400
Received: by mail-lj1-f196.google.com with SMTP id e27so1303926ljb.7
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2019 11:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IEYY3BqnM8b1RPxwyAoBl6+XjM31KhEUVwkBh71t+1U=;
        b=MpTg4xV3+ndLHG9PcSw3xMceaVbWrdjGv7sAyWBSVbuyIRB0tP/4hgtlmT3nTndWbe
         AOUhJdAGB0ATrTCHPDTltE22gLp6Zze8N7S8uUilSoVd+B4DHZa7HKDace1l0NimCGvA
         dxGkP3+KSf+qBUeoGxNZMh7f0ysnU8LXXuG+vTL3nPkfgeULyC4l+0uhflbGbuS+kiHA
         tOL006qzU1IzX1Ive1yFz4ej+mF+R677Na+vidCZIjispQHm+fjZm6O6c9tifTTkuQCA
         zjxtQNJOrDiDoKHi94OdXm3pbq6dJyksHj1F/2aQ+aq6Jm1Kv/nxx/+0iWsQM5lhnLoJ
         AE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IEYY3BqnM8b1RPxwyAoBl6+XjM31KhEUVwkBh71t+1U=;
        b=eySqYgbI6qkVFEEZZBTiFLtQJh7h6oRQh/cCxoHzdR61B1s/Y+wLdqcPbP3TE289TC
         KpeBB7drCbO9ILnv+/MZlEWBlUTC6w5exeZw/okoHuaanqyiMpg5pPjAw/tsvpbGbYGs
         8siiFlVpWsOvxTUB91lWYU0nNYQOofWTyON6nihcFrwudpi7NMYwsQfUwa4d4isAsvDa
         rUD0by/YFzfXgkM88lxRnGyR/b+NgdXxGWRAj4M/ezDCYfzMZ0xcMoPd7Jyv7Mz/5efl
         eE+iS3stU5VOKRN/0XKdn9tKMrHaBf7AQ6qmrgZ/KxE090hWb8/Uu5lUEU57Qma1rQer
         Ulpg==
X-Gm-Message-State: APjAAAVjeuiNteyoa9STgMGmTvFxCq273ERAj4AgEIxjQDpopBndwF3I
        NIEpNwGNSkhkJdS4RoMaufU=
X-Google-Smtp-Source: APXvYqw9IbeDzTFhPyIE6AdAYeziEw5Z/MJR9YKmCBkYpubNnWTlD0CXGda7DUdRhtclLnG09guITg==
X-Received: by 2002:a2e:2c09:: with SMTP id s9mr83390ljs.222.1565549383345;
        Sun, 11 Aug 2019 11:49:43 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-186-115.NA.cust.bahnhof.se. [158.174.186.115])
        by smtp.gmail.com with ESMTPSA id r21sm5250117lfi.32.2019.08.11.11.49.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 11 Aug 2019 11:49:42 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     rikard.falkeborn@gmail.com
Cc:     akpm@linux-foundation.org, joe@perches.com,
        johannes@sipsolutions.net, linux-kernel@vger.kernel.org,
        yamada.masahiro@socionext.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org
Subject: [PATCH v3 0/3] Add compile time sanity check of GENMASK inputs
Date:   Sun, 11 Aug 2019 20:49:35 +0200
Message-Id: <20190811184938.1796-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190801230358.4193-1-rikard.falkeborn@gmail.com>
References: <20190801230358.4193-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

A new attempt to try to add build time validity checks of GENMASK (and
GENMASK_ULL) inputs. There main differences from v2:

Remove a define of BUILD_BUG_ON in x86/boot to avoid a compiler warning
about redefining BUILD_BUG_ON. Instead, use the common one from
include/.

Drop patch 2 in v2 where GENMASK arguments where made more verbose.

Add a cast in the BUILD_BUG_ON_ZERO macro change the type to int to
avoid the somewhat clumpsy casts of BUILD_BUG_ON_ZERO. The second patch
in this series adds such a cast to BUILD_BUG_ON_ZERO, which makes it
possible to avoid casts when using BUILD_BUG_ON_ZERO in patch 3.

I have checked all users of BUILD_BUG_ON_ZERO and I did not find a case
where adding a cast to int would affect existing users but I'd feel much
more comfortable if someone else double (or tripple) checked (there are
~80 instances plus ~10 copies in tools). Perhaps I should have CC:d
maintainers of files using BUILD_BUG_ON_ZERO?

Finally, use __builtin_constant_p instead of __is_constexpr. This avoids
pulling in kernel.h in bits.h.

Joe Perches sent a patch series to fix existing misuses, currently there
are five such misuses (which patches pending) left in Linus tree and two
(with patches pending) in linux-next. Those patches should fix all
"simple" misuses of GENMASK (cases where the arguments are numerical
constants). Pushing v2 to linux-next also revealed an arm-specific
misuse where GENMASK was used in another macro (and also broke the
arm-builds). There is a patch to fix that by Nathan Chancellor (not in
linux-next yet). Those patches should be merged before the last patch of
this series to avoid breaking builds.

Changelog
Since v2
  - Use __builtin_constant_p instead of __is_constexpr to avoid pulling
    in kernel.h (that include was missing in v2, so the header was no
    longer builable standalone
  - add cast to BUILD_BUG_ON_ZERO to make the type int
  - Remove unnecessary casts due to the above
  - Drop patch that renamed macro arguments

Since v1
  - Add comment about why inputs are not checked when used in asm file
  - Use UL(0) instead of 0
  - Extract mask creation in a separate macro to improve readability
  - Use high and low instead of h and l (part of this was extracted to a
    separate patch)
  - Updated commit message

Rikard Falkeborn (3):
  x86/boot: Use common BUILD_BUG_ON
  linux/build_bug.h: Change type to int
  linux/bits.h: Add compile time sanity check of GENMASK inputs

 arch/x86/boot/boot.h      |  2 --
 arch/x86/boot/main.c      |  1 +
 include/linux/bits.h      | 21 +++++++++++++++++++--
 include/linux/build_bug.h |  4 ++--
 4 files changed, 22 insertions(+), 6 deletions(-)

-- 
2.22.0

