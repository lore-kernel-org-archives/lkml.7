Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A218EC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 16:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D675205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 16:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oGY5MW1s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfENQOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 12:14:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44636 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfENQOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 12:14:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id c5so19853579wrs.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 09:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=6iJMYy4sqQvG8/L5zVG7RUMxlxIeAwm6rLRsh9c58Rk=;
        b=oGY5MW1s8WOMhVHUEzAKD1G3yLhZ03DAkcHEnloudE08qktZ5a5VWwVUUD9M6bndLP
         ZBIwM6kcpshrIV0LRcbDobhsLQ2Q0cJDXr9ND+/EZduZ0EmBdYG3Z+uqp+lZVQwG5xrZ
         7V47A8+JZbz8QyWBEvlwWM7WyQxDbAKTcDrwEGI3lSBJnTsG3FVVFytpdEcZ6kwK0Dry
         pVFxapkULIhkud6vVm70Y+I8pvhtrgc552G0Nwfzts3UhBS52LkX7w5dJHLpWi3MqMmJ
         4yPTi82ws9MTWFvwYgwK+dj04m/JhGU1Z/+/xsobLnSQyR4T/XQCiPHCQgGqeDC3MFYR
         Aekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=6iJMYy4sqQvG8/L5zVG7RUMxlxIeAwm6rLRsh9c58Rk=;
        b=ERrrzLEBQenF01bGKTBNeV5d3T8T3fihVJzLeO5yqPYerohvuMf0Gd9FkDlE/mtsQM
         qw3a+785n0WK9c2hesZYO0J9qGPogI6jCf77w+PvDLabS7eQX221bzlyHfcra+D3rF/7
         iz7al+enjG6vtb/VxyGGziAX4INTyh8PfgLQGWkCn55CMRDahiqbCineGtY202YGMSgW
         1bgkHnvROCB9NC6e04jPzDuyp+/s4JblV5zG78scNciYi4hoMtY6wiYWtyNVyUFBZqVl
         iuL5LChvIa3+ghfSFFmSJcmKnMzOV9nIFlsoBo7A1i4ZPZjk9ZjfPFvrEaQgS4f8hQ1M
         6Kow==
X-Gm-Message-State: APjAAAWzJ4Ay8zEBnilP1PuYFCBXFxltMW2T5/t0F2NOu4q1N2T9CZ4F
        plUTg98d7Xneuz47UpsGj826xg==
X-Google-Smtp-Source: APXvYqyX/Cz5AASuzTWwtqOKJ6zFPYY/1UrmNJcv1NKds9CbNs4QE1spPtIu38hDWXeE+/ZDwm7JPA==
X-Received: by 2002:a5d:6cae:: with SMTP id a14mr7548926wra.214.1557850477196;
        Tue, 14 May 2019 09:14:37 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id j131sm5723599wmb.9.2019.05.14.09.14.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 09:14:36 -0700 (PDT)
Date:   Tue, 14 May 2019 17:14:34 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org,
        Wenlin Kang <wenlin.kang@windriver.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Douglas Anderson <dianders@chromium.org>,
        Young Xiao <YangX92@hotmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [GIT PULL] kgdb changes v5.2-rc1
Message-ID: <20190514161434.4sdb4p5huqdlm7xp@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit dc4060a5dc2557e6b5aa813bf5b73677299d62d2:

  Linux 5.1-rc5 (2019-04-14 15:17:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-5.2-rc1

for you to fetch changes up to ca976bfb3154c7bc67c4651ecd144fdf67ccaee7:

  kdb: Fix bound check compiler warning (2019-05-14 13:44:24 +0100)

----------------------------------------------------------------
kgdb patches for 5.2-rc1

Mostly clean ups but there are also a couple of out-of-bounds accesses
(including a potential write to the byte before a static buffer).

The main changes are:

 * Fixes those out-of-bounds access (empty string to configure
   test module could write the byte before a buffer, high cpu counts
   could read outside of per-cpu structures).

 * Improvements to string handling problems picked up by new compiler
   warnings and other static checks. Most are fixing benign issues that
   can't be tickled without code changes but still reduce the wtf factor
   a little.

 * Tidy up the terminal output.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

----------------------------------------------------------------
Dan Carpenter (1):
      kdb: do a sanity check on the cpu in kdb_per_cpu()

Douglas Anderson (1):
      kdb: Get rid of broken attempt to print CCVERSION in kdb summary

Gustavo A. R. Silva (3):
      gdbstub: mark expected switch fall-throughs
      gdbstub: Replace strcpy() by strscpy()
      kdb: kdb_support: replace strcpy() by strscpy()

Wenlin Kang (1):
      kdb: Fix bound check compiler warning

Young Xiao (1):
      misc: kgdbts: fix out-of-bounds access in function param_set_kgdbts_var

 drivers/misc/kgdbts.c          | 4 ++--
 kernel/debug/gdbstub.c         | 9 +++++----
 kernel/debug/kdb/Makefile      | 1 -
 kernel/debug/kdb/kdb_io.c      | 2 +-
 kernel/debug/kdb/kdb_main.c    | 3 +--
 kernel/debug/kdb/kdb_support.c | 2 +-
 6 files changed, 10 insertions(+), 11 deletions(-)
