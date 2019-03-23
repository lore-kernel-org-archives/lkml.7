Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89417C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 17:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C80920870
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 17:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQhq4Q8/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfCWRNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 13:13:52 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:33981 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbfCWRNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 13:13:52 -0400
Received: by mail-wr1-f46.google.com with SMTP id p10so5653732wrq.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 10:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=JWcVM1nOWzyogBNDNwZdaxm1KMmoGMxMJLtWsmikbuw=;
        b=cQhq4Q8/V1usF++Z7z5Xh4gzFgXvf9MoOoWQSht7qPNLO6PDX2Eqwwvkn6e1NrAU2K
         l8uXMgo5oPHyRw8aK0i7PPtAs7i033ZQDsr3kF/8gz/vQxNqmbuZc2qwL2u9NUsZ5kgT
         P8uC9j0TBVL3iQlbBZ7ZcZPGCaB6/JLs20JJ/tbnVYEoNe8Ms0E/s9jnTp4HSeDUr2XJ
         w6JQ8awf8prNk1YGrad4JiHbekO7U6pmQ9lX3lH7mI2OUlIS/5y4bBa+QmHbfRecJe92
         sl3+0YuV2oPaeiIKxz/xIVoVc5EJWGGaD6jAIj0w2yxy/EF+8mtrLFBhYdSkfMH/o2W2
         QDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=JWcVM1nOWzyogBNDNwZdaxm1KMmoGMxMJLtWsmikbuw=;
        b=Ai38SwyacbHzMDLocAha1NBVi1kqRGeJlS7NdpyUFXz1ZVBELyM75TP1SQ8HxWlYeu
         jQVmVDZ7kKyAvdf5DD8jcbB2GBBxAlpCw8ab+ahx7iuF8SiVKnDMNypW+NTw2sqgCHUn
         32h5v7Wn9Qx1mHztoQ23r0C8FZA4hhatuteTZkhONVKH3KjB+FQX6a3fasT+MsQwjRzc
         l3ZJgIy7nd/CE3A+ep9iCI/B6upOmkrdh/wAOVKyo9HjuOT2sTkHDIE8PXhDJ32RXKko
         Dl9GfUXGQ78VhUoTngFLLR12YqXlyg5fpx83uDd1Azun541NGeXzzJypyWaPt9b16hK1
         35Fw==
X-Gm-Message-State: APjAAAVbS3SqzhhS9CSuz7TUT6e2l4Ne3wsuvZZ4XoWgLX79NB60UX5r
        UVf3GJ7+5Tc6jsWG+llabKI=
X-Google-Smtp-Source: APXvYqx5YORYWASiy8ipFABmoVlgSwF55MtUJdOY2JRoiId/yX62glLwfIbZ5t/v47/PZmK+rZc7oQ==
X-Received: by 2002:a5d:6a89:: with SMTP id s9mr10898016wru.58.1553361230604;
        Sat, 23 Mar 2019 10:13:50 -0700 (PDT)
Received: from gmail.com (79.108.96.12.dyn.user.ono.com. [79.108.96.12])
        by smtp.gmail.com with ESMTPSA id y132sm9648825wmg.38.2019.03.23.10.13.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Mar 2019 10:13:50 -0700 (PDT)
Date:   Sat, 23 Mar 2019 18:13:43 +0100
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mans Rullgard <mans@mansr.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] auxdisplay for v5.1-rc2
Message-ID: <20190323171343.GA19483@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these fixes and improvements for auxdisplay.

Cheers,
Miguel

The following changes since commit 1c163f4c7b3f621efff9b28a47abb36f7378d783:

  Linux 5.0 (2019-03-03 15:21:29 -0800)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.1-rc2

for you to fetch changes up to cc5d04d840d62d7c75e268c51da7cd0be2ee03c0:

  auxdisplay: charlcd: make backlight initial state configurable (2019-03-17 08:48:45 +0100)

----------------------------------------------------------------
A few fixes and improvements for auxdisplay:

  - Series to fix a memory leak in hd44780
    while introducing charlcd_free().
    From Andy Shevchenko

  - Series to clean up the Kconfig menus and
    a couple of improvements for charlcd.
    From Mans Rullgard

----------------------------------------------------------------
Andy Shevchenko (5):
      auxdisplay: hd44780: Fix memory leak on ->remove()
      auxdisplay: charlcd: Move to_priv() to charlcd namespace
      auxdisplay: charlcd: Introduce charlcd_free() helper
      auxdisplay: panel: Convert to use charlcd_free()
      auxdisplay: hd44780: Convert to use charlcd_free()

Mans Rullgard (3):
      auxdisplay: deconfuse configuration
      auxdisplay: charlcd: simplify init message display
      auxdisplay: charlcd: make backlight initial state configurable

 drivers/auxdisplay/Kconfig   | 38 ++++++++++++++++++++++++++----
 drivers/auxdisplay/Makefile  |  2 +-
 drivers/auxdisplay/charlcd.c | 55 ++++++++++++++++++++++++++++----------------
 drivers/auxdisplay/hd44780.c |  4 +++-
 drivers/auxdisplay/panel.c   |  4 ++--
 include/misc/charlcd.h       |  1 +
 6 files changed, 75 insertions(+), 29 deletions(-)
