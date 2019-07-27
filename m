Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28419C7618B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 08:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E925620644
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 08:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Mis8aF0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbfG0IxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 04:53:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37608 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbfG0IxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 04:53:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so31612997wrr.4
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 01:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C25fy3k879XYQNXdbYVGXowE6lZUzsphXo8g8Goy1xE=;
        b=Mis8aF0dJwg3GRD8U5KQvZWb5bZIwbgHboDXRhZjU26kcTA/ClrKnRksgliWlzNEn7
         BTOuv2Um/ADMyc3kItzYKB3yJNJNQF8O/TqXLJPMAfpWzPQBQ8xYsr85DbUoM3Vm7CpH
         hHPur99wOENT0+z1iKi0+5z/b111Dpfy6ebxDVIIzm4iVVMlEkDrYzOSp/c2xxfSJZyi
         QdC83H5Mxr1cL9OdPMqFdKVIRl2MKn5YQPf0pUAoxrnlxdMqUyGNRM8S0TSQkM/kcg22
         T0ZZmmUf/0+WyjsRNuWJDCEzI0tB74PBkvODv+LyV2DkynQxfbzs68ZoJ6wpXqxyxl+a
         ncmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C25fy3k879XYQNXdbYVGXowE6lZUzsphXo8g8Goy1xE=;
        b=mFMkHL8J6IdsaqJWR57iISsd4z3jHRakgr/2bBHyA9wthJdo2GFx5IBXxVkyx5aBrw
         4hH56MIcS39dz/q92lxGPPKvpJfBmUC4/ariQJzUU0u0tIDUcvO7/lMCHOzZx624oYjJ
         kYCIB/bIZWeADNkkDH5N1QUD1CEzj1qiZBcv9p56zb0YJYu65HbfegXIQyAjph9b/NDg
         0ujx5fL93oLFY3KLFAdiJ+mfFmLsJr0IU7XHkgvPW0sgHzv8+xmXWFFmQC1sP5/vqbP+
         5pU2dalJfpWWRIiskeeTgronLyuo59jJwsAlNS3RaCq2h4qaRFqfx8xSXTqwDMRXIfAd
         lYbA==
X-Gm-Message-State: APjAAAXlqsZmjZBuZEyTyd+YMuh/TUUiIqwcLczMiQmpRcOqOgqdRjuZ
        dTOJ5Wzs8vNjW7HkTfB7Uhg6uq+YRLs=
X-Google-Smtp-Source: APXvYqz8as+224w+z7nKUtQaq5CBNkNWflQe4njqTi5rF7NYFN+KfiZjGAnBuJg09VHmUv7CHBAy0Q==
X-Received: by 2002:a5d:54c7:: with SMTP id x7mr77813434wrv.39.1564217597762;
        Sat, 27 Jul 2019 01:53:17 -0700 (PDT)
Received: from localhost.localdomain ([213.220.153.21])
        by smtp.gmail.com with ESMTPSA id y24sm40114584wmi.10.2019.07.27.01.53.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Jul 2019 01:53:17 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     linux-kernel@vger.kernel.org, oleg@redhat.com
Cc:     arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        joel@joelfernandes.org, tglx@linutronix.de, tj@kernel.org,
        dhowells@redhat.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, cyphar@cyphar.com,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        kernel-team@android.com, Christian Brauner <christian@brauner.io>
Subject: [PATCH v2 0/2] pidfd: waiting on processes through pidfds
Date:   Sat, 27 Jul 2019 10:51:59 +0200
Message-Id: <20190727085201.11743-1-christian@brauner.io>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey everyone,

/* v2 */
This adds the ability to wait on processes using pidfds. This is one of
the few missing pieces to make it possible to manage processes using
only pidfds.

Now major changes have occured since v1. The only thing that was changed
has been to move all find_get_pid() calls into the switch statement to
avoid checking the type argument twice as suggested by Linus.

The core patch for waitid is pleasantly small. The largest change is
caused by adding proper tests for waitid(P_PIDFD).

/* v1 */
Link: https://lore.kernel.org/lkml/20190726093934.13557-1-christian@brauner.io/

/* v0 */
Link: https://lore.kernel.org/lkml/20190724144651.28272-1-christian@brauner.io

Christian

Christian Brauner (2):
  pidfd: add P_PIDFD to waitid()
  pidfd: add pidfd_wait tests

 include/linux/pid.h                        |   4 +
 include/uapi/linux/wait.h                  |   1 +
 kernel/exit.c                              |  29 ++-
 kernel/fork.c                              |   8 +
 kernel/signal.c                            |   7 +-
 tools/testing/selftests/pidfd/pidfd.h      |  25 +++
 tools/testing/selftests/pidfd/pidfd_test.c |  14 --
 tools/testing/selftests/pidfd/pidfd_wait.c | 245 +++++++++++++++++++++
 8 files changed, 313 insertions(+), 20 deletions(-)
 create mode 100644 tools/testing/selftests/pidfd/pidfd_wait.c

-- 
2.22.0

