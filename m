Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D37C31E40
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 01:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4647621743
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 01:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="LLvPBe19"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbfHGBtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 21:49:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39619 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfHGBtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 21:49:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so42560988pgi.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 18:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HJ3esN1ahDfJjJR96PwcK66MyhHcH/NFW9YKUR9reys=;
        b=LLvPBe19SlIAKDxSydDNUKqZo39qYY7Zz0vT6YLucgwG+eoxjBfX+EKClzNpe3dKwE
         4LF0GUohOhBGJrcAaYR/kKUv/9oEFSGR3skjgiVvxDmAQgLNZKlLgRGJRe/iwZLijHJl
         qT+JKc2MATdQBg04Zo3UldAUBqfYoS2QJBUO5w7slCaF0sQ+Xdn+EIE848oNeEXt+bv3
         nRmP+4+d97EAvfvCNPTTPdwZ5A4X1yIMOkD+KtSYF9zBNp13/tLSqhSZRraiX5FNpewo
         0nN8F1hAUrAwegEPNiyAFzmht0Ti8ObhdYMQxfS3MGueMltWqTuFdad/ySORLXyaCPe0
         wiEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HJ3esN1ahDfJjJR96PwcK66MyhHcH/NFW9YKUR9reys=;
        b=K/d8OCqT0YJLeMtxdktd970494Xva3TXFZTcuitZgYjRDu6HM3iglNraAQe2wfNUaU
         xV32ooxdHSgfyQEWusd2xKI+OupOPWpds0HELAM+ndOrLRVCctST6aRQl0g+2hrR527L
         lmEgtz4/qPRvtuMxDRLQ2I1UEvG8blX1pDfKUl0Kzh97u2wRKsLlse8/E/2kS+8jpnlA
         9ycPp2q5LVkK276g6XUCY1qJASwxJkNsglFV2gzWf5Y9VDHaZahy+DunV3suAFVAxsUy
         5RKqxGKVVi6oEczJzFWcVQv9vG6lIJj//oxWTdCeGyrGkvWb1hIHbhiZf2YMjR/5bemF
         B2Vg==
X-Gm-Message-State: APjAAAUrNJ7JAYZXMAN+2aTK2L3aaPwj3rIbOhLAyg/JMVIHrEw4f1su
        C5Eur039v+AUQNEcz/P+K1QujA==
X-Google-Smtp-Source: APXvYqwJ2vVO50mw2/ZIMUTOHrmqILOhGYNKOygNOKtBD8NdIMY0sirHAWCpVwGH8KQdH1oLAGh1Pw==
X-Received: by 2002:a62:8c81:: with SMTP id m123mr6738728pfd.240.1565142549655;
        Tue, 06 Aug 2019 18:49:09 -0700 (PDT)
Received: from trong0.mtv.corp.google.com ([2620:15c:211:0:469:982a:29da:f29b])
        by smtp.gmail.com with ESMTPSA id q1sm104159076pfg.84.2019.08.06.18.49.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 18:49:09 -0700 (PDT)
From:   Tri Vo <trong@android.com>
To:     rjw@rjwysocki.net, gregkh@linuxfoundation.org,
        viresh.kumar@linaro.org
Cc:     rafael@kernel.org, hridya@google.com, sspatil@google.com,
        kaleshsingh@google.com, ravisadineni@chromium.org,
        swboyd@chromium.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, kernel-team@android.com,
        Tri Vo <trong@android.com>
Subject: [PATCH v8 0/3] PM / wakeup: Show wakeup sources stats in sysfs
Date:   Tue,  6 Aug 2019 18:48:43 -0700
Message-Id: <20190807014846.143949-1-trong@android.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace can use wakeup_sources debugfs node to plot history of suspend
blocking wakeup sources over device's boot cycle. This information can
then be used (1) for power-specific bug reporting and (2) towards
attributing battery consumption to specific processes over a period of
time.

However, debugfs doesn't have stable ABI. For this reason, create a
'struct device' to expose wakeup sources statistics in sysfs under
/sys/class/wakeup/wakeup<ID>/*.

Patch 1 and 2 do some cleanup to simplify our changes to how wakeup sources are
created. Patch 3 implements wakeup sources stats in sysfs.

Tri Vo (3):
  PM / wakeup: Drop wakeup_source_init(), wakeup_source_prepare()
  PM / wakeup: Use wakeup_source_register() in wakelock.c
  PM / wakeup: Show wakeup sources stats in sysfs

 Documentation/ABI/testing/sysfs-class-wakeup |  76 +++++++
 drivers/acpi/device_pm.c                     |   3 +-
 drivers/base/power/Makefile                  |   2 +-
 drivers/base/power/power.h                   |   9 +
 drivers/base/power/wakeup.c                  |  59 +++---
 drivers/base/power/wakeup_stats.c            | 203 +++++++++++++++++++
 fs/eventpoll.c                               |   4 +-
 include/linux/pm_wakeup.h                    |  21 +-
 kernel/power/autosleep.c                     |   2 +-
 kernel/power/wakelock.c                      |  32 +--
 kernel/time/alarmtimer.c                     |   2 +-
 11 files changed, 358 insertions(+), 55 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-wakeup
 create mode 100644 drivers/base/power/wakeup_stats.c

v2:
- Updated Documentation/ABI/, as per Greg.
- Removed locks in attribute functions, as per Greg.
- Lifetimes of struct wakelock and struck wakeup_source are now different due to
  the latter embedding a refcounted kobject. Changed it so that struct wakelock
  only has a pointer to struct wakeup_source, instead of embedding it.
- Added CONFIG_PM_SLEEP_STATS that enables/disables wakeup source statistics in
  sysfs.

v3:
Changes by Greg:
- Reworked code to use 'struct device' instead of raw kobjects.
- Updated documentation file.
- Only link wakeup_stats.o when CONFIG_PM_SLEEP_STATS is enabled.
Changes by Tri:
- Reverted changes to kernel/power/wakelock.c. 'struct device' hides kobject
  operations. So no need to handle lifetimes in wakelock.c

v4:
- Added 'Co-developed-by:' and 'Tested-by:' fields to commit message.
- Moved new documentation to a separate file
  Documentation/ABI/testing/sysfs-class-wakeup, as per Greg.
- Fixed copyright header in drivers/base/power/wakeup_stats.c, as per Greg.

v5:
- Removed CONFIG_PM_SLEEP_STATS
- Used PTR_ERR_OR_ZERO instead of if(IS_ERR(...)) + PTR_ERR, reported by
  kbuild test robot <lkp@intel.com>
- Stephen reported that a call to device_init_wakeup() and writing 'enabled' to
  that device's power/wakeup file results in multiple wakeup source being
  allocated for that device.  Changed device_wakeup_enable() to check if device
  wakeup was previously enabled.
Changes by Stephen:
- Changed stats location from /sys/class/wakeup/<name>/* to
  /sys/class/wakeup/wakeup<ID>/*, where ID is an IDA-allocated integer. This
  avoids name collisions in /sys/class/wakeup/ directory.
- Added a "name" attribute to wakeup sources, and updated documentation.
- Device registering the wakeup source is now the parent of the wakeup source.
  Updated wakeup_source_register()'s signature and its callers accordingly.

v6:
- Changed stats location to /sys/class/wakeup/ws<ID>/*
- Replaced ida_simple_get()/ida_simple_remove() with ida_alloc()/ida_free() as
  the former is deprecated.
- Reverted changes to device_init_wakeup(). Rafael is preparing a patch to deal
  with extra wakeup source allocation in a separate patch.

v7:
- Removed wakeup_source_init(), wakeup_source_prepare().
- Removed duplicate wakeup source creation code from  kernel/power/wakelock.
- Moved ID allocation to wakeup source object creation time.
- Changed stats location back to /sys/class/wakeup/wakeup<ID>/*
- Remove wakeup source device's "power" attributes.

v8:
- Updated commit message on patch 1 to indicate change of behavior of
  wakeup_source_create(), as per Stephen.
- Included headers for used symbols, as per Stephen.
- Added a function to create wakeup source devices to use
  device_set_pm_not_required() to skip power management for such devices, as per
  Stephen.

--
2.22.0.770.g0f2c4a37fd-goog

