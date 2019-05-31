Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD08FC28CC0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 02:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 939F0261D7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 02:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hQweFfgK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfEaCSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 22:18:03 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:40022 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfEaCSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 22:18:03 -0400
Received: by mail-pf1-f175.google.com with SMTP id u17so5155825pfn.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 19:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=y0l4MSgM+Yds60GT3t9v/VNmWhsPb5+VRL0kC/9ltio=;
        b=hQweFfgK4U0k2+M+fvBOiy/+D+KP4b1jHoN38+OF6fOpefMz8duKwjwNgqgSmyfWyJ
         RYWDjNgs4DYKKsJWTg3MHTrdlfyMMdmmVYz7gT8FCkOsVgnw+NKL4LnbqmHp97NEfsyl
         1Wtg93LjCKbkxq/WVbB4W83ScB9wno8i8zVgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=y0l4MSgM+Yds60GT3t9v/VNmWhsPb5+VRL0kC/9ltio=;
        b=ClOPK3NSdE/7dZ6Zl4D1g/VS381C/uzep1oEfMSW054+LGnqdnqXYszsd3rWjnTzxb
         FkkA+KwBl3gRArxc+2s+lZs8LKNn6NGW3eVTsGg6cnFA0+o8ADkXLUPMmaxd8e9s61cJ
         Ac75C2CBuYOIPC9BedyUZ7zBJZM0WB5TTFFd1EGxZunNodjJ80vM1B8i/2VliJ2TFRPy
         16kR39R7Qgj1WU7JjAxSrHecRrj8EufRCTePxt2uFR6i3ToqXHVp8ZK/XPiSLne80uIq
         EchHk9+B0my7r6hKO7wfcbUVfiG7TZuuS4K9327ESzE1TMyU2SO5ifdhSreC/iDHXjGP
         ysaA==
X-Gm-Message-State: APjAAAULzzvfBsy4csZIhFZZa6W2KDDr4cLnthpjljBFItXDzzFr3Od3
        yHYkyo78WNthWdxzChV39EZKJCOiO50=
X-Google-Smtp-Source: APXvYqzgI3LwIiavS+xumMph/rLjn/e4Ys8QIqJ2t0Q0n3u4LG8ob5h8e7wZJQzXaUcNCHwEePDGdw==
X-Received: by 2002:aa7:842f:: with SMTP id q15mr6999242pfn.161.1559269082653;
        Thu, 30 May 2019 19:18:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n2sm3626200pgp.27.2019.05.30.19.18.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 19:18:01 -0700 (PDT)
Date:   Thu, 30 May 2019 19:18:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [GIT PULL] gcc-plugins update for v5.2-rc3
Message-ID: <201905301916.79D7BF6AB8@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this gcc-plugins fix for v5.2-rc3. This has lived in
linux-next for about a week now.

Thanks!

-Kees

The following changes since commit 259799ea5a9aa099a267f3b99e1f7078bbaf5c5e:

  gcc-plugins: arm_ssp_per_task_plugin: Fix for older GCC < 6 (2019-05-10 15:35:01 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/gcc-plugins-v5.2-rc3

for you to fetch changes up to 7210e060155b9cf557fb13128353c3e494fa5ed3:

  gcc-plugins: Fix build failures under Darwin host (2019-05-20 13:30:54 -0700)

----------------------------------------------------------------
gcc-plugins: Handle unusual header environment

- Fix redefined macro error under a Darwin build host

----------------------------------------------------------------
Kees Cook (1):
      gcc-plugins: Fix build failures under Darwin host

 scripts/gcc-plugins/gcc-common.h | 4 ++++
 1 file changed, 4 insertions(+)

-- 
Kees Cook
