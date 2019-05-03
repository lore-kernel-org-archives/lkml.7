Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EEEC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 19:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB3B206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 19:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hx23H1DM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfECTMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 15:12:30 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:50706 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfECTM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 15:12:29 -0400
Received: by mail-pf1-f202.google.com with SMTP id q73so3608482pfi.17
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 12:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=O2Vxsbw2zu+jyE40NtPtRm30b2ngTXxWqx+K4kLTmWE=;
        b=Hx23H1DMpzXrHfaM/QpifQPXcTEhJhckBh6ao3h1amBiE+2XYEMYapBwlYSjVB+teN
         OnUjs9WfrkDDyoXtKzMvz0m8/UMwuPu2YzysOWVEyvOz2FJMdbfyAr6+BxXMOdgkxyP4
         hgez0RKWV7cmUXF3NyYb49ErucoSds3mGFaHKpUCg7SZAqukFzga2DsCWeI48XGxZF5f
         o8lE2Z0PVAATcxT8+puCu5WEB8sHtyfWthy5Hs6ojxP0L3JFg7hyPh9G3CsDq4GluOpo
         6mdrmymd0+mw/rGnIInKxlS0khRfKIFBv0OaEMxXmIBpd5PdMC8OuzR3QXB1HZLs9jD5
         QJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=O2Vxsbw2zu+jyE40NtPtRm30b2ngTXxWqx+K4kLTmWE=;
        b=IGs9QCgfW4mNpqOpoKkgu4LZBQ4i6UL4KaxdumpKeHykmc5CSRvCni+IXlcvMeerHt
         ygDgplbLomGoWxZrHvCTxtNdscwcL4LsPZ2z9RdFHxxs+5sMddLPSF08XLK/Qhub9D5r
         KFe99SF/V7zMECVPuolNnIdOkhb0AV8ZBYSHBX2MdoLtvBI0uVCq0+VZYJulZCH9I0tJ
         5nCMl0U42ay/i0PI5jowFLqqAiUl/6w96Lk97WFdXppK8pUSvgqRaEptbq49WXH01uAA
         G2pId2sU2iVpNBqsn3YDKFrmwDxTq7XOmlxxE4CTVKDtpqzQzT6nGimrXX6tf6b4aFAO
         LaJA==
X-Gm-Message-State: APjAAAUCsv4NiWemmIOM34wM1cuM7BZwc6OJR0dn/MOHSNx8VbMM+7mv
        75ztZLpUfYYsoMnuABUQMp7klD/jLErAGDVGb68=
X-Google-Smtp-Source: APXvYqxsZAjO/Cr5QAMyVh+5vxGrimquZNEx1GMyBOtaek+vtybfj/5fHjagTf3nr2/qNevhxA41G7Kzkp4FzygW7uc=
X-Received: by 2002:a65:5c8c:: with SMTP id a12mr12635106pgt.452.1556910748545;
 Fri, 03 May 2019 12:12:28 -0700 (PDT)
Date:   Fri,  3 May 2019 12:12:22 -0700
Message-Id: <20190503191225.6684-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v2 0/3] fix function type mismatches in syscall wrappers
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches fix type mismatches in arm64 syscall wrapper
definitions, which trip indirect call checks with Control-Flow
Integrity.

Changes in v2:
- more informative commit message for the syscall_fn_t change
- added a patch for fixing sys_ni_syscall

Sami Tolvanen (3):
  arm64: fix syscall_fn_t type
  arm64: use the correct function type in SYSCALL_DEFINE0
  arm64: use the correct function type for __arm64_sys_ni_syscall

 arch/arm64/include/asm/syscall.h         |  2 +-
 arch/arm64/include/asm/syscall_wrapper.h | 18 +++++++++---------
 arch/arm64/kernel/sys.c                  | 14 +++++++++-----
 arch/arm64/kernel/sys32.c                | 12 ++++++++----
 4 files changed, 27 insertions(+), 19 deletions(-)

-- 
2.21.0.1020.gf2820cf01a-goog

