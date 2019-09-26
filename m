Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E25C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 18:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06EA621D56
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 18:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FbHWJ5e5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbfIZSfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 14:35:46 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33640 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfIZSfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 14:35:46 -0400
Received: by mail-pl1-f194.google.com with SMTP id d22so19318pls.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 11:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=xqyqmD5GX/EEp8qGv/ybZ9xAmuKvDeLoKv9DsbBuMDQ=;
        b=FbHWJ5e5GIn3c1An34lHOdYR7yZRnSFsMnQi3h80AoihggomZpR25cz7mxjCx42Or8
         eUF6sWFjzNuuViK2yG6aT8RozYVsPq1XwCWIp+OadGljJ2mxZ849LYucfERKahMPSki2
         UyMlL1FTSiWHcwxXKqnGN61u/ED5ahvd6lRZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=xqyqmD5GX/EEp8qGv/ybZ9xAmuKvDeLoKv9DsbBuMDQ=;
        b=YHphZ9B0kTvQ7kThaE50LTT95hm+h9mtLt7LcEClo+kWSePEziLS7faFeokWiPmpmk
         sCul7xr8rY2SFoWzxW8XELd4RMBfO94ZR7nUS60rGprBBkc3zQm8fGdOxLeCdug3RTzy
         XXPgpRgZQPc/OYjwWAlKooZkLtSb8vRMvhj3hfUk/dQQaDNVvDJK25z8XCTV90Xlr2yJ
         ErlivHwzZOJ6K+qIc1fM34WH2oWV4/j0RyEyYvxS1NG6qy+H4c6PyRzUvOyJwlb5gg0Q
         OXochwI3AgI7XNbsTtF4OPj9L8zXyd9jFE1xYIssI3UJhSq1cJyPhZpikjnHAW6Yf261
         kjoQ==
X-Gm-Message-State: APjAAAUBLrV8dUQzrzB5qK85BsxJtdP5TXWOhmXn+VLvXhm25FEiYdl0
        hL5267XE4hqVvQvluB58ekKCTw==
X-Google-Smtp-Source: APXvYqwg6m3BLvFxJRQOjKOmPMDmY2I9UbM16EXi1rUxDfNO7km1QdaPhu01Vn6BiwuFEch+qNb2GQ==
X-Received: by 2002:a17:902:6b05:: with SMTP id o5mr5394481plk.33.1569522943629;
        Thu, 26 Sep 2019 11:35:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q13sm3180814pjq.0.2019.09.26.11.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 11:35:42 -0700 (PDT)
Date:   Thu, 26 Sep 2019 11:35:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [GIT PULL] usercopy fix for v5.4-rc1
Message-ID: <201909261131.65DA27B@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this usercopy fix for v5.4-rc1. Randy found a corner case
(HIGHMEM, DEBUG_VIRTUAL, >512MB RAM) with hardened usercopy that went
unnoticed since v4.8. This adds HIGHMEM awareness to hardened usercopy,
and has been living in -next for a bit more than a week now.

Thanks!

-Kees

The following changes since commit 4d856f72c10ecb060868ed10ff1b1453943fc6c8:

  Linux 5.3 (2019-09-15 14:19:32 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/usercopy-v5.4-rc1

for you to fetch changes up to 314eed30ede02fa925990f535652254b5bad6b65:

  usercopy: Avoid HIGHMEM pfn warning (2019-09-17 15:20:17 -0700)

----------------------------------------------------------------
Fix hardened usercopy under CONFIG_DEBUG_VIRTUAL

----------------------------------------------------------------
Kees Cook (1):
      usercopy: Avoid HIGHMEM pfn warning

 mm/usercopy.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
Kees Cook
