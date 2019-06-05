Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B460C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55EC02086A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="fq+IAMsS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfFENaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 09:30:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37147 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbfFENaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 09:30:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id v14so1818327wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 06:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lMvdl6nBbuZIhohZk4JDzoO+gQ8DLgRypV8C5pDMxkg=;
        b=fq+IAMsSH0vIGZsqJGp440VM8znjVMeRHNNEIA8Klf8lPG97ikOFb1FD9o36dCdjGr
         YD8l32FsNwKKBWVe8PdHCPaAsIUpvrPzn+JEAiDRK3pQZxjHBbPjscKqoYKNu1wkdRHK
         6IjGzym7nRxdIzATquNWI1s7nbNbwnsP/8+sufxtWhvTWdhvG7wfdzPRBOlWxU0OsvIr
         oQuZAe9GShR6ntM5NIXdXoFwfGb05ThW/xyotHeelIXxaOqLiw11cZmJR02HGINOr2lT
         N1XqHlVGnyspC4qFFZerNY5CglVOQFsulYVoL+TJslvVZXC2cELy/njzwx+kZ3Cpb8/3
         OGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lMvdl6nBbuZIhohZk4JDzoO+gQ8DLgRypV8C5pDMxkg=;
        b=oJJ1hyFv69pAwA1c4Ihr1cNBytB5ZlZcpofToVlS+dIAKNU5LcWV0XRXKnayhD5k+1
         m4X+kqMfGwjU1rMxU5HFumr8sAitCGZyhEniWgFrheC0oetpwKS939Fm5BUE36mugj3m
         8J2qtXmGxt2kHv8PLF8byG/Gso/N0lv0RvkFcZImg9/5zvvSVhzUsoxVVvdXVnJ/Gb3R
         UJMYfWg62idOLtQIv+P/7myrtBmaCiONei2yzmGRDbSZBtZi3V9DTV9tYaV8uIhY3Kks
         vXv80ltN/Z/5NakLfffmjxGqoyqqBuYEkduigTCBFjP9J2XYdaBaqzX22wUYnJdR3w97
         h68g==
X-Gm-Message-State: APjAAAV1CCQu+DkwZEayeypKWQdLwFDtLOFh3ofIJVjkcskFUpTudbXL
        AfqxWTgfgtFcUnRB0Na3ttckrmQ0Je4tbw==
X-Google-Smtp-Source: APXvYqxEKVMAEorXJa5XP/Oiye0IE8d4xOUuMoR1Pi+49KK152RCbMImJDqmRK+VywGsmWzUdxHUqg==
X-Received: by 2002:adf:ee0b:: with SMTP id y11mr11998457wrn.241.1559741420446;
        Wed, 05 Jun 2019 06:30:20 -0700 (PDT)
Received: from localhost.localdomain ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id c17sm16503892wrv.82.2019.06.05.06.30.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 05 Jun 2019 06:30:19 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Cc:     arnd@arndb.de, Christian Brauner <christian@brauner.io>
Subject: [GIT PULL] pidfd fixes for v5.2-rc4
Date:   Wed,  5 Jun 2019 15:29:37 +0200
Message-Id: <20190605132937.29438-1-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is a pull request containing three hopefully uncontroversial fixes:

The following changes since commit f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a:

  Linux 5.2-rc3 (2019-06-02 13:55:33 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/pidfd-fixes-v5.2-rc4

for you to fetch changes up to 1fcd0eb356ad56c4e405f06e31dd9fde2109d5ab:

  tests: fix pidfd-test compilation (2019-06-05 15:06:32 +0200)

The tag contains two small patches to the pidfd samples and test binaries
respectively. They were lacking appropriate ifdefines for
__NR_pidfd_send_signal and could hence lead to compilation errors when
__NR_pidfd_send_signal was not defined.
This was spotted on mips independently by Guenter Roeck (who was kind
enough to send a fix for the samples binary) and Arnd who spotted it in
linux-next.
Apart from these two patches, there's also a patch to update the comments
for the pidfd_send_signal() syscall which were slightly wrong/inconsistenly
worded.

Please consider pulling these changes from the signed pidfd-fixes-v5.2-rc4 tag.

Thanks!
Christian

----------------------------------------------------------------
pidfd fixes for v5.2-rc4

----------------------------------------------------------------
Christian Brauner (2):
      signal: improve comments
      tests: fix pidfd-test compilation

Guenter Roeck (1):
      samples: fix pidfd-metadata compilation

 kernel/signal.c                            | 11 +++++------
 samples/pidfd/pidfd-metadata.c             |  4 ++++
 tools/testing/selftests/pidfd/pidfd_test.c |  4 ++++
 3 files changed, 13 insertions(+), 6 deletions(-)
