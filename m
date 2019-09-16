Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3758EC4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A795214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jWGdugBD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731396AbfIPVo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 17:44:57 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37537 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbfIPVo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 17:44:57 -0400
Received: by mail-pl1-f194.google.com with SMTP id b10so499515plr.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 14:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=7CuMMtbY7AzrTOjAKabWbbhCsQv6yRHgmrO+59U58lk=;
        b=jWGdugBDqK0J6754Xnzbh42TBYOiKqPDKkIKzsGDr/rU0/qHr1xgbHyDFw69Vbp4P0
         H8S94ybM9A37/vU9aGPVNszOqB3a/bFBp9DGVWMcil/MCEMDT2qmAz7HfJvLkooEeEjR
         EkhC06xzSyoCbj49UWgsPXoVsjrcZEYIk3u+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=7CuMMtbY7AzrTOjAKabWbbhCsQv6yRHgmrO+59U58lk=;
        b=UYepRlsrR015w4xmxDXgmCtrcGqABOnvvfnPRNjv+MdlMfkzfOXtXy8gXLUgRWorBN
         So38/94IQ27brKouTXh1Yc7DNF3PwpNjLx6qWKxBmwQ0wy1miHkOG6zfYzJpDvXJIORo
         G/4nXQkT1VhcNKpWfHxa60l6NAX/tqQfvtSFjkC6kLUiIxE94t7b177mRUH5WPRqi7+Q
         w9Bg8JZx/2b+yQNPBvHrNVoYXQYD1uy6qhrTuC1fQDtqv5Iy7HcJ/FGa7DkUU2h6QtOq
         zhE4+EYxfJaorEQVHEnrzmiYqXFubWMkTwQAkTYau4DbGPM20GqFmQBTBsLOu+FrN8tE
         KsFQ==
X-Gm-Message-State: APjAAAXkqU7ozf3jEU5Akncy0t6nWOxk9GcHdbCjTZIlp+chbiaA91Dv
        i/RkRLSkJxXtDYL8z/bdEDjr1A==
X-Google-Smtp-Source: APXvYqwxfp+lv/7B86BXr8piMfvJQ8FYkXsHbOONN/eEtCvBXcmO2MF/RMfyt1YDPBdyh5tvS/Ztmg==
X-Received: by 2002:a17:902:9a98:: with SMTP id w24mr246488plp.173.1568670296133;
        Mon, 16 Sep 2019 14:44:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u10sm56049pfm.71.2019.09.16.14.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 14:44:55 -0700 (PDT)
Date:   Mon, 16 Sep 2019 14:44:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Joonwon Kang <kjw1627@gmail.com>,
        Kees Cook <keescook@chromium.org>
Subject: [GIT PULL] gcc-plugins update for v5.4-rc1
Message-ID: <201909161443.8AB608118@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this tiny gcc-plugins update for v5.4-rc1. It fixes a
potential problem in structure auto-selection (that was not triggered by
any existing kernel structures). This has been in linux-next for about 5
weeks.

Thanks!

-Kees

The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:

  Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/gcc-plugins-v5.4-rc1

for you to fetch changes up to 60f2c82ed20bde57c362e66f796cf9e0e38a6dbb:

  randstruct: Check member structs in is_pure_ops_struct() (2019-07-31 13:13:22 -0700)

----------------------------------------------------------------
randomize_layout: Fix potential auto-selection bug

- Fix auto-selection bug in is_pure_ops_struct (Joonwon Kang)

----------------------------------------------------------------
Joonwon Kang (1):
      randstruct: Check member structs in is_pure_ops_struct()

 scripts/gcc-plugins/randomize_layout_plugin.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
Kees Cook
