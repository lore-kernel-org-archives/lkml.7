Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5496EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8C52339E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k1kTYLaz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfH1RhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 13:37:02 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37810 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbfH1Rgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 13:36:53 -0400
Received: by mail-pf1-f194.google.com with SMTP id y9so254622pfl.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 10:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=4SO8Nj1+4SzuVczSaJVQEHv0FzcAX86GeNSMAO5PGWI=;
        b=k1kTYLazq5E7hpVTIcVA9qxSIvWgCr0++uXXnkRwg1Hzl77iMvsGdUFb8QS/eaEkWQ
         Kb4Qj0av18mbGbLXc4SYquSssupYSrVfJq3x4N7rEQ4uIdDYsuObDoS1pV88GqB5bO95
         hDqKDp+yu+TxqNaPP1OlQHFonpvEk9e3cJo48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=4SO8Nj1+4SzuVczSaJVQEHv0FzcAX86GeNSMAO5PGWI=;
        b=J5j8jfoCS/DSZ8QMlgeZBVpS+OvKu7NMo8OkDc1LDA+w8MlJ2tnDyCWzGR8UZPQXGi
         hLmFG+dDfLmDJdS3ubAqS3DRv4yCPDYiiXoLXP0tx8AVZk+4iBO9jrAST/FN/ZSYFvfi
         +o5y6Qs5XuKAVkrCNRfw3wgNlQkn8MnUaySk+IgRn/fMwF6I27rklScWiAQnB/aCJJh5
         aQr7R2R4+Pfsdw/RPQSH0G5DQxe3lHHM6ytKgO12VFxOmSh/lPKry8uu0LtSOHpxaCo+
         IXHliWzfaFd1cYlc4Hn9sMvFj7rUaBYgiXH6TMhN5JQQQidwzyoMvDMxv9Ussh8kHfe6
         +3OA==
X-Gm-Message-State: APjAAAWxV7oOujFrkeODguoOVtEcknz+wjtrmiCkYbgrZknReaNh+Ghm
        uRZwt2Yh2tep9D5ID0C00EcKAA==
X-Google-Smtp-Source: APXvYqzZi24RJgDceq99KiARohh+8DBOCvlhPGbDJiYJ/jbJ+YIu+wwUCDBT5E+R7tKKgOLliIN3nw==
X-Received: by 2002:a17:90a:f0c7:: with SMTP id fa7mr5491393pjb.115.1567013813054;
        Wed, 28 Aug 2019 10:36:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l123sm7187592pfl.9.2019.08.28.10.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 10:36:51 -0700 (PDT)
Date:   Sun, 25 Aug 2019 15:23:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: [GIT PULL drivers/misc] lkdtm updates for next
Message-ID: <201908251522.DEAF618@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please pull these LKDTM updates for next.

Thanks!

-Kees

The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:

  Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/lkdtm-next

for you to fetch changes up to 1ee170ea3f0dcf3a4b34f7e7c36559e84bb0d3d6:

  lkdtm: Split WARNING into separate tests (2019-08-19 11:13:21 -0700)

----------------------------------------------------------------
Updates to LKDTM for -next

- split WARNING into two tests: with message and without
- add prototype-granularity forward CFI test

----------------------------------------------------------------
Kees Cook (2):
      lkdtm: Add Control Flow Integrity test
      lkdtm: Split WARNING into separate tests

 drivers/misc/lkdtm/Makefile |  1 +
 drivers/misc/lkdtm/bugs.c   |  7 ++++++-
 drivers/misc/lkdtm/cfi.c    | 42 ++++++++++++++++++++++++++++++++++++++++++
 drivers/misc/lkdtm/core.c   |  2 ++
 drivers/misc/lkdtm/lkdtm.h  |  4 ++++
 5 files changed, 55 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/lkdtm/cfi.c

-- 
Kees Cook
