Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A49DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E651206DD
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KDamhEq1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfCDRsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 12:48:05 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42960 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbfCDRsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 12:48:05 -0500
Received: by mail-pg1-f195.google.com with SMTP id b2so3581538pgl.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 09:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=nxWpeNvoBHz6MhOEKVTTbQN5UJYK5y4wVuDNfyN/vVA=;
        b=KDamhEq1Tk21E6VcRHD8BTWacJicOhQGlFAo6ARJexFdj2OIhOThcBOx61or/D+tsd
         O6uxj1tHVNYjWyPtwbP+Vuirp9TVi72XXMn4af6Se9x1nZ/4Ukh3MocmMLACIRahXbvk
         MMCK6Xn4kWJioFxOMIw8p2X33EBQ/QgrIMA3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=nxWpeNvoBHz6MhOEKVTTbQN5UJYK5y4wVuDNfyN/vVA=;
        b=fQV2hXOhir9+dmkxIdvc2mz+/8Xw1oB4HXWDhNf0Qh979pXzningRNafjd/mUxKW8x
         hRWU36qX+4FMmRBkXQGVLd0yYlgXz4/kkExPHH/bRPkXtGOOeTEXDOO0JOFUDDjWOZ8Y
         jRyOBFr4DZGXM6bXVefWgpUqeTbVeUKqlVTjQoWKpcBXjVM8XXxxd+tdbH36Dym1WA6K
         msjIP0QReTeY2Rcdp7QzTpUFlroPA5O78BQfp/0vqLnrcPIU2sH4unNHluH7uAcaYt+w
         23ZWZgRCRMG/qmb/KrIOiqT5HbgPCYlElEAlorUaElRaDVHRVgOsHPeqQ4TWY3EFussW
         /5TA==
X-Gm-Message-State: AHQUAublvPGR/nsCnKBEO+z0qTeNWp1wY8TyV7G3cE/OZIoVZKKPepbq
        X9fGXUmlrpS6Cw4tw8jue1Efbg==
X-Google-Smtp-Source: AHgI3IayhEoQK0oYu7bAoHPCzo/ysTz6jdlwV5UQVqvAEtDTeQ7N3tuIlv0lio0VnpCQIyT+j6bJSA==
X-Received: by 2002:a62:1bd4:: with SMTP id b203mr20822494pfb.144.1551721684523;
        Mon, 04 Mar 2019 09:48:04 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id g188sm10736884pfc.24.2019.03.04.09.48.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 09:48:03 -0800 (PST)
Date:   Mon, 4 Mar 2019 09:48:02 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [GIT PULL] gcc-plugin updates for v5.1-rc1
Message-ID: <20190304174802.GA6629@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these gcc-plugin changes for v5.1-rc1. This adds additional
type coverage to the existing structleak plugin and adds a large set of
selftests to help evaluate stack variable zero-initialization coverage
(which can be used to test whatever instrumentation might be performing
zero-initialization: either with the structleak plugin or with Clang's
coming "-ftrivial-auto-var-init=zero" option).

Note that there is a minor conflict seen in linux-next with KASAN changes
in -mm, which removes the !KASAN_EXTRA depends from structleak. sfr's
resolution is correct:
https://lkml.kernel.org/r/20190213170345.656c3030@canb.auug.org.au

Thanks!

-Kees

The following changes since commit 49a57857aeea06ca831043acbb0fa5e0f50602fd:

  Linux 5.0-rc3 (2019-01-21 13:14:44 +1300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/gcc-plugins-v5.1-rc1

for you to fetch changes up to 50ceaa95ea09703722b30b4afa617c972071cd7f:

  lib: Introduce test_stackinit module (2019-03-04 09:29:52 -0800)

----------------------------------------------------------------
increased structleak coverage

- And scalar and array initialization coverage
- Refactor Kconfig to make options more clear
- Add self-test module for testing automatic initialization

----------------------------------------------------------------
Kees Cook (2):
      gcc-plugins: structleak: Generalize to all variable types
      lib: Introduce test_stackinit module

 lib/Kconfig.debug                       |  10 +
 lib/Makefile                            |   1 +
 lib/test_stackinit.c                    | 378 ++++++++++++++++++++++++++++++++
 scripts/Makefile.gcc-plugins            |   2 +
 scripts/gcc-plugins/Kconfig             |  58 ++++-
 scripts/gcc-plugins/structleak_plugin.c |  36 ++-
 6 files changed, 463 insertions(+), 22 deletions(-)
 create mode 100644 lib/test_stackinit.c

-- 
Kees Cook
