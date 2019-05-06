Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27799C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA87820830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PoACZxLX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfEFRVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 13:21:42 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43835 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfEFRVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 13:21:42 -0400
Received: by mail-pl1-f193.google.com with SMTP id n8so6690995plp.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 10:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=FQES/awINLKp8vjjT0MVrYjxlbdDiHL5WpKJ+R6hatc=;
        b=PoACZxLX5rrhYsoWt+IxtJD0KN1yhwDxsrxK+v7ZMjstTNdikKbrW3JD5U350CZsYu
         cyXzYSuO83Po5xvscr/o+XD/syAWg43lDAZ1ZE3QYhtdmAmoRY/hMbGprYq+KofmxS7h
         15zXTpoCAL9ekQqOnmUU8G9P3Ztv0tM351/tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=FQES/awINLKp8vjjT0MVrYjxlbdDiHL5WpKJ+R6hatc=;
        b=Kn+EnW7MkyozpM8k3UtzGCqnmFVZ6bZzEEyaMYWPXjpcia3H/ndUDuxOpDqKiYDERH
         +9nwungpeTftPcHfOpFK5zESPRGk7AHVIalserwX5hfQnwQm7mSJS8t2Nu683SV5N3rX
         UHRf1W0yqSOnkDYkLDXYmSk7ZWPMBTw9wv2HtYjd7ZhKI2yEmIaRlRgbbMV4l4RjIUp8
         bHoRk+10QPLIuI8pzDRo3lh5neoboiXJCHINNA34h63zuArsu3ljfCjdsHadYlUwmXeM
         iyM1qnIGA6Jxg18L9H5f2uI/tz5hC/4+t7ftvcvrg+HbZOkycqA9r1hcNp4Rg/J6XXH2
         dAdw==
X-Gm-Message-State: APjAAAX2IQkgtnkB28JGL8jURHjTwCwKc/zPh1DO8nyq95zqTMUO/9q7
        VmVBK1KTFyFI2c9W47+9EnYeGKWTJhE=
X-Google-Smtp-Source: APXvYqwdS/BqSnxVMYyVoE1wHDdB2fQdp1e6A8SAqSjNr8BC/+neKZrEp+a0NbOMd+yvidJU7SzkoQ==
X-Received: by 2002:a17:902:7c93:: with SMTP id y19mr40741pll.268.1557163301758;
        Mon, 06 May 2019 10:21:41 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id c19sm13785837pgi.42.2019.05.06.10.21.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 10:21:40 -0700 (PDT)
Date:   Mon, 6 May 2019 10:21:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Popov <alex.popov@linux.com>,
        Alexander Potapenko <glider@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [GIT PULL] compiler-based variable-init updates for v5.2-rc1
Message-ID: <20190506172139.GA2121@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these changes for v5.2-rc1. This is effectively part of my
gcc-plugins tree, but as this adds some Clang support, it felt weird
to still call it "gcc-plugins". :) This consolidates Kconfig for the
existing stack variable initialization (via structleak and stackleak
gcc plugins) and adds Alexander Potapenko's support for Clang's new
similar functionality.

Thanks!

-Kees

The following changes since commit 8c2ffd9174779014c3fe1f96d9dc3641d9175f00:

  Linux 5.1-rc2 (2019-03-24 14:02:26 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/meminit-v5.2-rc1

for you to fetch changes up to 709a972efb01efaeb97cad1adc87fe400119c8ab:

  security: Implement Clang's stack initialization (2019-04-24 14:00:56 -0700)

----------------------------------------------------------------
compiler-based memory initialization

- Consolidate memory initialization Kconfigs (Kees)
- Implement support for Clang's stack variable auto-init (Alexander)

----------------------------------------------------------------
Kees Cook (3):
      security: Create "kernel hardening" config area
      security: Move stackleak config to Kconfig.hardening
      security: Implement Clang's stack initialization

 Makefile                    |   5 ++
 scripts/gcc-plugins/Kconfig | 126 ++--------------------------------
 security/Kconfig            |   2 +
 security/Kconfig.hardening  | 164 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 177 insertions(+), 120 deletions(-)
 create mode 100644 security/Kconfig.hardening

-- 
Kees Cook
