Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D624DC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9049220659
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Jn2Ju1Oy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfG3TFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 15:05:21 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37398 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfG3TFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:05:20 -0400
Received: by mail-io1-f67.google.com with SMTP id q22so10881965iog.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 12:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6xq/drbshr7a6ifjtYXwzYh1cR/KYTlMyeuT0GJwIMM=;
        b=Jn2Ju1OyCU4v3AwDIMIhnSfQ48UQ0LS1KkC0gtnizRnNZWSeyV5s4Nf0Ky369vRpKX
         GF6ocMu5DVvo0ekyNbjGN/SkGuRVSpQRPXvuZko0FjDkKAsBy+SuKIHfZ9ki+6ESh5nc
         UXugwJst9bQu+sOjh7lH28F9oRuyLt4EAHA/13MdbbEklrMhImWQ9a/83H6GXT1fZLxS
         wjU+0IOUEaj6SQYQ5nq8uSYZcOClAvj3w/CRLJx72gVDo+9P0506O/jP9IH+RIbV6Gq1
         OctrFFIiSQOvnp//0PSJd+yAMhBzmTGOanKxRaN8VZsV+0MwBMPFLGx1Bs1NTkryameJ
         Vt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6xq/drbshr7a6ifjtYXwzYh1cR/KYTlMyeuT0GJwIMM=;
        b=dv5lrKP55JZae3SNJSKE8ch9htN3sl49FVUJPDXtiLGfctr/niLtBsBLhT1uAYswvL
         NtT5lNSzTEy2rtpr/QXi8DrLRRAPfQhmbk0z6rOzuesC1OHSrQILPv/8ZI7TzcBaoGQe
         YlRzOkUEnJRbehTnISUQJG+rZRHhYVe7E4tliZ7fYKz7Wi7r7tJg2cOMQakF5SQu5SVH
         HgxCCqamDn6TsSe64L1At+NQsZq1MH2rW6zx8CX9ALj9gmAbmhFY/d9viB+2IZGqLMHw
         gv9BGyZxWI6gnDfbrYbYLv/8dWMHcvQGl2m7Y9fdNhgpnIufFIqxbfalP+2c4TN6ka3/
         rZJg==
X-Gm-Message-State: APjAAAW6Jx0LpLEjdLgmY1k5hA6bzopLuDHVoGFNKTB1Chn+YyRKll0l
        bIvVKCc7buBdnTsOwAXe8kc=
X-Google-Smtp-Source: APXvYqyvuWOyR2W7I2nrEK10CGI9a3aZxb8KfC+9CBldTIUE2Xzx0/dWC1/oy7Y0psalynn5RzfJ5g==
X-Received: by 2002:a02:90c8:: with SMTP id c8mr26552924jag.22.1564513519975;
        Tue, 30 Jul 2019 12:05:19 -0700 (PDT)
Received: from localhost.localdomain ([162.223.5.124])
        by smtp.gmail.com with ESMTPSA id a7sm52783730iok.19.2019.07.30.12.05.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 12:05:19 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, oleg@redhat.com,
        joel@joelfernandes.org
Subject: [GIT PULL] pidfd fixes
Date:   Tue, 30 Jul 2019 21:04:37 +0200
Message-Id: <20190730190437.19004-1-christian@brauner.io>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This makes setting the exit_state in exit_notify() consistent after fixing
the pidfd polling race pre-rc1. Related to the race fix, this adds a
WARN_ON() to do_notify_pidfd() to catch any future exit_state races.
Last, this removes an obsolete comment from the pidfd tests.

The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:

  Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-20190730

for you to fetch changes up to 30b692d3b390c6fe78a5064be0c4bbd44a41be59:

  exit: make setting exit_state consistent (2019-07-30 19:57:14 +0200)

Please consider pulling from the signed for-linus-20190730 tag.

Thanks!
Christian

----------------------------------------------------------------
for-linus-20190730

----------------------------------------------------------------
Christian Brauner (2):
      pidfd: remove obsolete comments from test
      exit: make setting exit_state consistent

Joel Fernandes (Google) (1):
      pidfd: Add warning if exit_state is 0 during notification

 kernel/exit.c                              | 5 +++--
 kernel/signal.c                            | 1 +
 tools/testing/selftests/pidfd/pidfd_test.c | 6 +-----
 3 files changed, 5 insertions(+), 7 deletions(-)
