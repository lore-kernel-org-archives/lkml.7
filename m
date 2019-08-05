Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0ACC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E0620880
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="hGv9CDgT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbfHER7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 13:59:38 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45064 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbfHER7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 13:59:37 -0400
Received: by mail-pl1-f196.google.com with SMTP id y8so36780030plr.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 10:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ud8kaTYnOTLsJDKCOZKHErxyavHvXjt//haLV/7Osr0=;
        b=hGv9CDgTazwbClR18fPbNFhTKGeCpdG7RyYZ0RgTJwkDw2aXb20quOE6DK9Eht6Z7z
         2MofnoF7J4WkV1cYD08hq/4gFHLbNc5XqtgO+cXa9HIL6zH5+G6dcDy46jNhO7QohcBB
         KqlzL7A3QAjCFunqxat85FVs4BDNh8lb7lCvGlqIFTjgA9iiGf67aABNq4oWuQXDcf75
         C/RWme/+HRNYZOySvQLeFJ6j4o8EitJf03vvmqVPdku+9AHjBJTgJ9j45Du7RlPmP6s1
         6xpMQqA9OexXzEbbjrT3gFx1ylDOAk3kRJO/qr894VSkZ0uVau7xs9NhaVJ2P4hmPw8Z
         kJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ud8kaTYnOTLsJDKCOZKHErxyavHvXjt//haLV/7Osr0=;
        b=gmPqRL4wD610r/GFwudgbZInw/RonEXBV/yYxaprgduYgtfZp6NQ7coADhZ73yJz+O
         MyQQSfg7wL+a5h5YWOTUf1DYg1VRLT+hiTvijxjN6SJw/XxYKcm9DqSRhZDdQAAsR/wg
         +eXRPSFD9LUhl79uWIR6kUABQ0ar6z7nAbMG77ZzGhkcQxdq+R7clz+BvIkta56IdMBd
         E8SCyYEmA316aqeolb5AkhjJeYvNHm4DEQrXMXyDx4EjCpQ0L1b0HWYToYBI2hM/+Xz9
         EbJbTJVyGog9hSUs6kBc72NGcReJVgulfSfdzUvpB1JoGRWIRfHwh1ntA4lAavH2P6+E
         xJ4g==
X-Gm-Message-State: APjAAAUOTadCF3ggcmOW4lK944C0aqgxyIN8wfidDTrbwTJbRsWLhajp
        LfvgS5Yxg1KNR/CBz96eyyY=
X-Google-Smtp-Source: APXvYqwZeYBRnbQ/QlTDw+8YaaB6BBCMQBBMQNRLF+ujIAQ9yn9fFzWGqTAFqhE6Jd8wptS+jiashQ==
X-Received: by 2002:a17:902:7894:: with SMTP id q20mr140347877pll.339.1565027976621;
        Mon, 05 Aug 2019 10:59:36 -0700 (PDT)
Received: from trong0.mtv.corp.google.com ([2620:15c:211:0:469:982a:29da:f29b])
        by smtp.gmail.com with ESMTPSA id f19sm124403670pfk.180.2019.08.05.10.59.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 10:59:36 -0700 (PDT)
From:   Tri Vo <trong@android.com>
To:     rjw@rjwysocki.net, gregkh@linuxfoundation.org,
        viresh.kumar@linaro.org
Cc:     rafael@kernel.org, hridya@google.com, sspatil@google.com,
        kaleshsingh@google.com, ravisadineni@chromium.org,
        swboyd@chromium.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, kernel-team@android.com,
        Tri Vo <trong@android.com>
Subject: [PATCH v7 0/3] PM / wakeup: show wakeup sources stats in sysfs
Date:   Mon,  5 Aug 2019 10:58:45 -0700
Message-Id: <20190805175848.163558-1-trong@android.com>
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

 Documentation/ABI/testing/sysfs-class-wakeup |  76 +++++++++
 drivers/acpi/device_pm.c                     |   3 +-
 drivers/base/power/Makefile                  |   2 +-
 drivers/base/power/power.h                   |   9 ++
 drivers/base/power/wakeup.c                  |  59 ++++---
 drivers/base/power/wakeup_stats.c            | 161 +++++++++++++++++++
 fs/eventpoll.c                               |   4 +-
 include/linux/pm_wakeup.h                    |  21 +--
 kernel/power/autosleep.c                     |   2 +-
 kernel/power/wakelock.c                      |  32 ++--
 kernel/time/alarmtimer.c                     |   2 +-
 11 files changed, 316 insertions(+), 55 deletions(-)
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

--
2.22.0.770.g0f2c4a37fd-goog

