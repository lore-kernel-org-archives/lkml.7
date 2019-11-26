Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A17EC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 15:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D8C120659
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 15:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mR/SHrJk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbfKZPjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 10:39:03 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41945 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfKZPjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 10:39:03 -0500
Received: by mail-wr1-f66.google.com with SMTP id b18so22993450wrj.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 07:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=8M4WeC77001HU9K3OuWdzr0/6Ckzu4Btb0vCvwuuEEY=;
        b=mR/SHrJkmHMPldRrAFgSYdjriCZZSc3YubJJ1LswCfp0Y+Kf3xBxhJ3bciSEUx8FvS
         6Vt7kxcIVbIChKir64Sng8ZkuDHQRuYOQm8VAtFL9xCUJZtwJ9eiRpLADhHnKotmCmuN
         jtcvirGL0a9jYH/SXLcR5VbSRlYVl3aVPDk89efOOWey5JZaeH0x7AExfRzb0xohhaO3
         YeY44+9g5VM3BsZJ2PcBt1Km0o7k6iZcZeiOpsVxw5P3NnK/HqK5I2mOI6wczkhe3/It
         Eook/YZC4159YCPY9jkOkyc8gE+pQqca+Fp3tQBhyey+RK8cOPv3ehhzqkRTACtLLet4
         R0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=8M4WeC77001HU9K3OuWdzr0/6Ckzu4Btb0vCvwuuEEY=;
        b=Lc/CNjhqtXEe4ZuhPxi5T+uYAO89glj31F0w3RHlQvrN/6Z8IShcNo0dn2AdFu4oaN
         5uGk6txyYLtmCTLdgHZy8G+bUdog7faBJI0zyOdIxiceGQa6Qw5/lo5U41u0PTKvOl0W
         8dEcQH2d+ET8FCAyIIgxKw/HGN2dbnRwzVOfU9FUjNsa8HCi8KaNkh7CSBJtavcyPW97
         L9nIsqUuDoT6SL14eVX6ZqP6Tr/zDO7XUxzPDM7ESbHhWrXPpwHnRDkRMpk/okAFRbOR
         n+BPUZ/X3C0pRSEbn9I+BI/sDgMFONJUkNGzi/dI+WmTxRUGjl622sroMYYRoVRqafbO
         OhJg==
X-Gm-Message-State: APjAAAVTPaX5153MxLybWRtuA23PpfjXwm0HwxWW+QFu6Bxw8Ws4raUq
        5boIBut1Qm0wBJRmlw37rBx1PuaQ02RYGw==
X-Google-Smtp-Source: APXvYqyZPMwPDWs0EFOTxZYrE5LTKn4ic1vtelHq6ZdCIrDANfaJtO1aEY9UUVS019Zne+tAylesNg==
X-Received: by 2002:adf:9786:: with SMTP id s6mr39056324wrb.188.1574782740652;
        Tue, 26 Nov 2019 07:39:00 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id 60sm14791602wrn.86.2019.11.26.07.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 07:38:59 -0800 (PST)
Date:   Tue, 26 Nov 2019 15:38:58 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [GIT PULL] kgdb changes v5.5-rc1
Message-ID: <20191126153858.bclidzxinfjrtkl6@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit da0c9ea146cbe92b832f1b0f694840ea8eb33cce:

  Linux 5.4-rc2 (2019-10-06 14:27:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-5.5-rc1

for you to fetch changes up to c58ff643763c78bef12874ee39995c9f7f987bc2:

  kdb: Tweak escape handling for vi users (2019-10-28 12:08:29 +0000)

----------------------------------------------------------------
kgdb patches for 5.5-rc1

The major change here is the work from Douglas Anderson that
reworks the way kdb stack traces are handled on SMP systems.
The effect is to allow all CPUs to issue their stack trace which
reduced the need for architecture specific code to support stack
tracing.

Also included are general of clean ups from Doug and myself:

 * Remove some unused variables or arguments.
 * Tidy up the kdb escape handling code and fix a couple of odd
   corner cases.
 - Better ignore escape characters that do not form part of an
   escape sequence. This mostly benefits vi users since they are most
   likely to press escape as a nervous habit but it won't harm anyone
   else.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

----------------------------------------------------------------
Daniel Thompson (6):
      kdb: Avoid array subscript warnings on non-SMP builds
      kdb: Tidy up code to handle escape sequences
      kdb: Simplify code to fetch characters from console
      kdb: Remove special case logic from kdb_read()
      kdb: Improve handling of characters from different input sources
      kdb: Tweak escape handling for vi users

Douglas Anderson (4):
      kgdb: Remove unused DCPU_SSTEP definition
      kdb: Remove unused "argcount" param from kdb_bt1(); make btaprompt bool
      kdb: Fix "btc <cpu>" crash if the CPU didn't round up
      kdb: Fix stack crawling on 'running' CPUs that aren't the master

 kernel/debug/debug_core.c      |  34 ++++++
 kernel/debug/debug_core.h      |   3 +-
 kernel/debug/kdb/kdb_bt.c      | 116 +++++++++++----------
 kernel/debug/kdb/kdb_io.c      | 231 ++++++++++++++++++++---------------------
 kernel/debug/kdb/kdb_private.h |   1 +
 5 files changed, 208 insertions(+), 177 deletions(-)
