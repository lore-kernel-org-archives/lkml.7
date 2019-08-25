Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37125C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 17:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0338120578
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 17:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MD7FaYs3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbfHYRiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 13:38:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51422 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbfHYRiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 13:38:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id k1so13336854wmi.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 10:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=nUBff10lsASBE91F8KigCpGgGqpKzg5hEBg0Knu8bCo=;
        b=MD7FaYs3Po93LP2EVlwniuTCClIUheV1+e4SE7O7U05CgbYG9+0Tz52709kBM7lzGH
         mdO6l4i12vl6Uzc3njlmgjbXqSUi48C41OEWxQM7AYnVZyfKjjM7t330SvWuyEjtY6s/
         HVaLCcJeagUKP/q3uIvlgp/5061kmyOMW+BYNmEwWakSOMKT4SaLpCNdlMj81VMzPtXu
         ZvbzbwbExL2AliXB27sQLxuw2uZGK9qW/Jou+Uhbx6fpCdzQKv/Y948mBTWv46yYHHIc
         ah8qwouWvGIk6poTnmek2NazZHcOHmbD66wEkjTR8LGbd/v+H9iooFjFEgYVJHKhS2NT
         NUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=nUBff10lsASBE91F8KigCpGgGqpKzg5hEBg0Knu8bCo=;
        b=DQObd38kEtiIHZ/uamgcYELjMj+C+KzPo6YWWvOKAKnmX4PeRFWYSflTkunCh2goil
         kATA4JCAzjKLu2jw543aWM4plZHIa5oRCi1CRvCI4jLCt0biJc9UlkEXecPs8W6yl10+
         h2VdG9pqJK5h3nUah1yKUpZmjD+4LECdjfzYfDUoo3M5xHni8FLgg9xJtogQDA+jnIl+
         uglMc+9LL5fXtpbhjbsoWTdyJ9x6wkg3PSFZBvFDlhLMb6lp+txX5ZUf+gARtMAnqwc/
         cz4N5SIMmKwzCr314GXDj3AIPC4BEliZcflW3DFpH5+ZfNJaWFRYmhPcR5wywrAj7si6
         B0Fw==
X-Gm-Message-State: APjAAAWaL/Lq/dCjb3r7HcpLEBXytr5BRcBafAgVODAKzuaVd82yEhGN
        bFtS1Xpqltit+qNLrepYAbiZXEHA
X-Google-Smtp-Source: APXvYqzFD5J9xm9Djp2lvUE2tM8UAhKNmIuyggfhQ/wFx0rAGud00RsDQmwjOlIYe3c34/4NTdqvxQ==
X-Received: by 2002:a1c:760b:: with SMTP id r11mr17569898wmc.41.1566754682714;
        Sun, 25 Aug 2019 10:38:02 -0700 (PDT)
Received: from gmail.com (82.159.32.155.dyn.user.ono.com. [82.159.32.155])
        by smtp.gmail.com with ESMTPSA id o8sm17049994wma.1.2019.08.25.10.38.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Aug 2019 10:38:02 -0700 (PDT)
Date:   Sun, 25 Aug 2019 19:37:55 +0200
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] auxdisplay for v5.3-rc7
Message-ID: <20190825173755.GA19827@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this cleanup.

Cheers,
Miguel

The following changes since commit d1abaeb3be7b5fa6d7a1fbbd2e14e3310005c4c1:

  Linux 5.3-rc5 (2019-08-18 14:31:08 -0700)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.3-rc7

for you to fetch changes up to a180d023ec7ba0e43b2385876950d9ce7ab618f1:

  auxdisplay: ht16k33: Make ht16k33_fb_fix and ht16k33_fb_var constant (2019-08-20 11:48:54 +0200)

----------------------------------------------------------------
A minor auxdisplay improvement:

 - ht16k33: Make ht16k33_fb_fix and ht16k33_fb_var constant (Nishka Dasgupta)

----------------------------------------------------------------
Nishka Dasgupta (1):
      auxdisplay: ht16k33: Make ht16k33_fb_fix and ht16k33_fb_var constant

 drivers/auxdisplay/ht16k33.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
