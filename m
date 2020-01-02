Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BEFC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 21:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D2520863
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 21:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fm34nlFr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgABViS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 16:38:18 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:32921 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbgABViS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 16:38:18 -0500
Received: by mail-oi1-f195.google.com with SMTP id v140so13611518oie.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 13:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=F50aQZ1kjKIMVuuxW4BK+VL0HEG+Osbrli2nWfW4mUY=;
        b=Fm34nlFrcElD5allYd9B3SSLmEfkCgEK99XyUr+pWTwAbD1iYECWFTZfKFoppWXmYM
         wmNTGdjEpYP4K9DPQ0EsuNRC1gyeFMZLHoFKppQfekEGVzzk/1VQMXHfhs0lDYPmVR6O
         XUUcy1BY01BmlAZznJ/hxX8gUznMkX1JQyoKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=F50aQZ1kjKIMVuuxW4BK+VL0HEG+Osbrli2nWfW4mUY=;
        b=Mv22jDHjUQlk01p/5v6zYHtALfMkXOk2PB6xbQLavP/hlMi8USb4XRdBrH2kXRFgP4
         mB8+g3HfxtPFfZ9ScmCKsJTLoVWeyYsZOtgKDvS2k/D9aVFjRsQe/bDtQGQtnrPo/Iu1
         hR6GGiqfntuutGanw5Ll4HBygTMB4KldHnKLmn6wTh88YhDv5m5QXFIaRAWJ2HGQKmnw
         PIGR4gMmYP9ouzZ3nFmCL6mOdQzkj4Sn76sDK6p/NFx6ZJyMzlqIU27DggIAWp/DJNgR
         CNz/qMhdQwnS6LVkPF0PJlGF3YYRhlNiZCclN8tUjM8HXQgl4SxzIdMgwC48SIUca187
         ocuA==
X-Gm-Message-State: APjAAAVxgO8/EAg32+XdZEr4xKqYNCu9XaPCQBzkKoTfFy6+LYNQJZmp
        iFbcUO9GVAHSHXZBfsX7tvai4D2KVPM=
X-Google-Smtp-Source: APXvYqxpZHsIOop8Kpoyr20UMsXaCqgVLohjMM/hGnDVIaTqjh3+hlVEcVud35dGOs2ZMS5G342a5g==
X-Received: by 2002:aca:2210:: with SMTP id b16mr2913978oic.32.1578001098099;
        Thu, 02 Jan 2020 13:38:18 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w6sm14605980oih.19.2020.01.02.13.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 13:38:17 -0800 (PST)
Date:   Thu, 2 Jan 2020 13:38:15 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [GIT PULL] gcc-plugins fix for v5.5-rc5
Message-ID: <202001021335.14622751ED@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this gcc-plugins fix for v5.5-rc5. This change will make
some builder's lives easier again for build configuration testing
with/without gcc-plugins. Masahiro asked that it go via my tree, so here
it is! :)

Thanks!

-Kees

The following changes since commit fd6988496e79a6a4bdb514a4655d2920209eb85d:

  Linux 5.5-rc4 (2019-12-29 15:29:16 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/gcc-plugins-v5.5-rc5

for you to fetch changes up to a5b0dc5a46c221725c43bd9b01570239a4cd78b1:

  gcc-plugins: make it possible to disable CONFIG_GCC_PLUGINS again (2020-01-02 13:30:14 -0800)

----------------------------------------------------------------
gcc-plugins build flexibility fix

- Allow builds to disable plugins even when plugins available (Arnd Bergmann)

----------------------------------------------------------------
Arnd Bergmann (1):
      gcc-plugins: make it possible to disable CONFIG_GCC_PLUGINS again

 scripts/gcc-plugins/Kconfig | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

-- 
Kees Cook
