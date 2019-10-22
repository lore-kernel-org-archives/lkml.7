Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D175BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A181120B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bwG8FsZz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389408AbfJVQqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 12:46:40 -0400
Received: from mail-wr1-f73.google.com ([209.85.221.73]:35210 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388730AbfJVQqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:46:39 -0400
Received: by mail-wr1-f73.google.com with SMTP id 7so9498008wrl.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 09:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=FxzIQyDunHtVBZCVK6ttUg3oB9s0DEBjz5E3R+aCqJU=;
        b=bwG8FsZzFAPaLXF+EeN/hUCP9Ctc2PqOreWk2uXXPC1rx7igFgoYTwQmMPUoum8kN2
         BCDHyY+9Y3k4GDqLnxZX4DJeS4dHVZz2+0dRswv3cdpUzr/TwgGbwwFH8QyCXUgUjuhZ
         Nks82aX0zUMLehsuEDOPYo2bHPgtiRFXEe4h7LU+Z1NBLKnIwZRQ2yBDEq33H4IQb/8R
         eNidmD5c9kaZE2RILTyQvcpk2qanv245jpGAsz/TPPZSFFwDGPHmUQKp1M3LWnrLJXq7
         NuTimyO/udpVPVqtAL1NOviEG57gds0FKsZoYgaXz6fcekzuyx53kphtB0HI5IqkuVvQ
         aoDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=FxzIQyDunHtVBZCVK6ttUg3oB9s0DEBjz5E3R+aCqJU=;
        b=FjzOMmUSofsu7RKCpODofj8eizbSSfoaq7ZzouDTQoYqszHZQbTyyGoODV7rnvjx0c
         YuNLOrwqwXyWHUiCMEs1qsN3Y23e47pBZGWyEK18UzNP/lFdF69wb5QXCyowHUWb8x38
         5fwB67CaDlpl92EmIj5Rt1pv4zmCwbTHMX7kjp2xqWttEK/bEFHZYFBej3GXeeI16Wfx
         /O49Uz1OaMPso+Der4LS6h04epRvEsNkNrv29CKtliGMwGSFlZnWRxYHWrVrQQwY5tZU
         GCq5XU6rx0zHWyGCc/v4q4hnFY3lqx6NMBoDGbhhjabD/XpM1yY5RAuwuFucbzIsEfRp
         uubQ==
X-Gm-Message-State: APjAAAXpdbwNgW6OvVA48fq0uaQZ3CU1U70nAlh8dBFevhRth7FLFglp
        g2XsPvtVHe0x7YNEpkBL2Pm1Y9xtfKJc3znZ
X-Google-Smtp-Source: APXvYqzw4xdCDUIijFFJk3ia1kfm+QpMoPGMUaeGlY+KJBFhy0thno5gFZaPKu1JXCicdUguQwe6wX+B/HIHHpRY
X-Received: by 2002:a5d:4644:: with SMTP id j4mr944846wrs.355.1571762797288;
 Tue, 22 Oct 2019 09:46:37 -0700 (PDT)
Date:   Tue, 22 Oct 2019 18:46:30 +0200
Message-Id: <cover.1571762488.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH 0/3] kcov: collect coverage from usb and vhost
From:   Andrey Konovalov <andreyknvl@google.com>
To:     linux-usb@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Windsor <dwindsor@gmail.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset extends kcov to allow collecting coverage from the USB
subsystem and vhost workers. See the first patch description for details
about the kcov extension. The other two patches apply this kcov extension
to USB and vhost.

These patches have been used to enable coverage-guided USB fuzzing with
syzkaller for the last few years, see the details here:

https://github.com/google/syzkaller/blob/master/docs/linux/external_fuzzing_usb.md

This patchset has been pushed to the public Linux kernel Gerrit instance:

https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/1524

Changes from RFC v1:
- Remove unnecessary #ifdef's from drivers/vhost/vhost.c.
- Reset t->kcov when area allocation fails in kcov_remote_start().
- Use struct_size to calculate array size in kcov_ioctl().
- Add a limit on area_size in kcov_remote_arg.
- Added kcov_disable() helper.
- Changed encoding of kcov remote handle ids, see the documentation.
- Added a comment reference for kcov_sequence task_struct field.
- Change common_handle type to u32.
- Add checks for handle validity into kcov_ioctl_locked() and
    kcov_remote_start().
- Updated documentation to reflect the changes.

Andrey Konovalov (3):
  kcov: remote coverage support
  usb, kcov: collect coverage from hub_event
  vhost, kcov: collect coverage from vhost_worker

 Documentation/dev-tools/kcov.rst | 120 ++++++++
 drivers/usb/core/hub.c           |   5 +
 drivers/vhost/vhost.c            |   6 +
 drivers/vhost/vhost.h            |   1 +
 include/linux/kcov.h             |   6 +
 include/linux/sched.h            |   6 +
 include/uapi/linux/kcov.h        |  20 ++
 kernel/kcov.c                    | 464 ++++++++++++++++++++++++++++---
 8 files changed, 593 insertions(+), 35 deletions(-)

-- 
2.23.0.866.gb869b98d4c-goog

