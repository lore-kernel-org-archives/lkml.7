Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF28C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 04:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B350D20873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 04:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oIguEUe6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfFREAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 00:00:31 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38296 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfFREAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 00:00:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id v11so6907999pgl.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 21:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=PGRW1zXh2ap8/OD12kt0S9t8pvD3S5O8v5qpikhYxgk=;
        b=oIguEUe6ha9WmIWCN+ktuSNjiquZTaOU6yOvRdMToKP/jNr39rHZsuggorWapY4TVS
         FBlEJ7pOFRGPlN/gTG5fhkABtud60cDQGPH3HsTGYphbJ8XpDWLYRSLzUVxyYN6U2zSl
         mpTUzGCxOb4wpjo4C+UrWzGRuv8FF2jNbwU1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=PGRW1zXh2ap8/OD12kt0S9t8pvD3S5O8v5qpikhYxgk=;
        b=Z+LxciCn3tEMXc4QSKWnjqmxNVs9FQ7Q2qelBevf8y/udK9wwn+SRyXv3qjBsC8co2
         Xut205Hr0qEl/LOvUn8Lalc5iEnhjhN00t0xsY0b+gP546DVXjbBvNx2MJ1ccQ6RK2BR
         CfkAW42z7FDgcLPDz03Yn+0rdrKVlYEECYXzBay1kYR8OVWp5d2CR4saqWi4s4hdZeiE
         ZlzKGMd4oZU/n6CP9U0Cs6O90KcZinNq0Wo9qE4NpinMZhDcg8UEESLhrsuHjMEzUZoq
         /4BL9Zg4j87ugSG9f+Ui2b4YrSFHOzcU0aphVxsmVa88eDWDoKdl9iVpvLngIm3HpvXL
         dTYw==
X-Gm-Message-State: APjAAAUUHK+OgVIg3rjqjbYQVs9XtOrVcon/b71p/bTqMxWltI03a8mO
        4vaQou5ADe+VaEs5Izq+FC6CKqfgvW+nMQ==
X-Google-Smtp-Source: APXvYqymz4N6kXP6n58vo5DgjcNpSn4rZoJgn8V1Eez0FBSy44uFc+a26tWQdXQ4i50Z8ROv2d2dkg==
X-Received: by 2002:a17:90a:9385:: with SMTP id q5mr2741989pjo.126.1560830430249;
        Mon, 17 Jun 2019 21:00:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d1sm3456657pfn.86.2019.06.17.21.00.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Jun 2019 21:00:29 -0700 (PDT)
Date:   Mon, 17 Jun 2019 21:00:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [GIT PULL] meminit fix for v5.2-rc6
Message-ID: <201906172056.CDD757E@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this fix for what I'm calling "meminit" (the compiler-based
variable-init stuff) for v5.2-rc6. This is a small update to the stack
auto-initialization self-test code to deal with the Clang initialization
pattern. It's been in linux-next for a couple weeks; I had waited a bit
wondering if anything more substantial was going to show up, but nothing
has, so I'm sending this now before it gets too late.

Thanks!

-Kees

The following changes since commit f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a:

  Linux 5.2-rc3 (2019-06-02 13:55:33 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/meminit-v5.2-rc6

for you to fetch changes up to 8c30d32b1a326bb120635a8b4836ec61cba454fa:

  lib/test_stackinit: Handle Clang auto-initialization pattern (2019-06-05 07:36:43 -0700)

----------------------------------------------------------------
compiler-based memory initialization update

- Update stack auto-initialization selftest for Clang initialization pattern

----------------------------------------------------------------
Kees Cook (1):
      lib/test_stackinit: Handle Clang auto-initialization pattern

 lib/test_stackinit.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

-- 
Kees Cook
