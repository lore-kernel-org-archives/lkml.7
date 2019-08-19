Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB7BC3A5A1
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 22:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233E02070B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 22:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Lgsaurir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbfHSWmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 18:42:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46957 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbfHSWmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 18:42:00 -0400
Received: by mail-pl1-f194.google.com with SMTP id c2so1653211plz.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 15:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=reYP0h0U7AmT0WrP1r9OhGz/zHx/dWGpS47L5kEvrB4=;
        b=Lgsaurir0+vXieqGBAsFYErA1pf8znPOLAnScMKvk2AKkO7TJFak9PsJqvMDrFYtcP
         XGBPaDwHhYNow7DPU9chuTbZ7MUjMHjOGDyQNb86MD5mA7rkwL7fTIMFVVg68jb6O72y
         w11XrBEslBdoL64VF6i3H/RXt8wkLZnZUvcfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=reYP0h0U7AmT0WrP1r9OhGz/zHx/dWGpS47L5kEvrB4=;
        b=N6IWOAhye2xsc6tNsbe4fKih0vhpA2wHXddYQs8XPXAsAZz3L5JDLfi7KDb/+DBQiL
         6xLCs2xpgvXxhb5l3n+JYeAVVLKbGQ38peOTOgnOTI5dUCRAR7fRMuqMNs6MaE3epanH
         dyX6mztRNL7dAUCcGSwJoIpTkjjpg97F0sGzOf7SjebkM7mykW1NBAFEb5WdBx4JOih+
         ihQv/U30+3peGdgCPkUN9D4rXok5hQ7KDkFw6+eBTNkcDdDBWP7Vkvvc4Vbg85OCjvP+
         eApONMLLCFyo2RN74kRA7/Lp3+MxSB8veAz+N/wEit72W+GF6NExlpjMQ4Md2C8nbhyG
         GKrA==
X-Gm-Message-State: APjAAAUBYIbppuvsmWoooMh/J14nm4m0rowCRe1RAQWwfayzhf4hcFhL
        1rYI0iW/TU8P7l7V+lGYHWgv9N6TQX33Zw==
X-Google-Smtp-Source: APXvYqx15lSE+3yIW/SMck4E32gHXzRXUQD/plAankqzSR89Skg+JyZqnpnElq8HYfy3LIJYu6L8hg==
X-Received: by 2002:a17:902:aa03:: with SMTP id be3mr25071415plb.240.1566254520200;
        Mon, 19 Aug 2019 15:42:00 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id e9sm16841593pge.39.2019.08.19.15.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 15:41:59 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Qian Cai <cai@lca.pw>, Tri Vo <trong@android.com>
Subject: [PATCH v4 0/2] PM / wakeup: Fix wakeup class wrecakge in -next
Date:   Mon, 19 Aug 2019 15:41:56 -0700
Message-Id: <20190819224158.62954-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending the patch series to pick up the tags and fix the subject
on patch #2. I didn't drop the "Fixes" tags even though they're
just in -next and the patches have been dropped in the latest version.
Please update them in the future so we know what commit they're fixing
if the commits change in the pm tree.

Changes from v3:
 * Picked up reviewed-by tags from Tri Vo
 * Fixed Cc tag on patch 2
 * Fixed subject on patch 2 to speak about proper symbols

Changes from v2:
 * Fix logic for not adding the wakeup class from dpm_sysfs_add()
 * Compile tested on !CONFIG_PM_SLEEP

Cc: Qian Cai <cai@lca.pw>
Cc: Tri Vo <trong@android.com>

Stephen Boyd (2):
  PM / wakeup: Register wakeup class kobj after device is added
  PM / wakeup: Unexport wakeup_source_sysfs_{add,remove}()

 drivers/base/power/power.h        |  9 +++++++++
 drivers/base/power/sysfs.c        |  6 ++++++
 drivers/base/power/wakeup.c       | 10 ++++++----
 drivers/base/power/wakeup_stats.c | 15 +++++++++++++--
 4 files changed, 34 insertions(+), 6 deletions(-)


base-commit: 0c3d3d648b3ed72b920a89bc4fd125e9b7aa5f23
-- 
Sent by a computer through tubes

