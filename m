Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24FAC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C612081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZR0GBvuI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfCHVZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 16:25:42 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37473 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfCHVZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 16:25:42 -0500
Received: by mail-pg1-f196.google.com with SMTP id q206so15109379pgq.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 13:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j9+MHBMZ3wKobKUk7FRnddyFnv2NMsRUrYl0hUzBrNw=;
        b=ZR0GBvuIOiATShpHvYI3WFMaJWO9p7G4wn2iIIGtKRPQIRFDF4agB3AzzxAm0iWta9
         a82kZPPPbsBPcFZSUAc7jr0+zHfU2gbfutpUk+m5h9ouM3AeG/2LZA+97S8VkIqllNfu
         YLFOokZ1PmItLamI8rQIWddlZM6BGRea53ACA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j9+MHBMZ3wKobKUk7FRnddyFnv2NMsRUrYl0hUzBrNw=;
        b=fh8PlgM5BxkkT8qywmSJZub5KWAbqJvLS1DLjYsfHNBtsfyo7LF0gTaXoroim7F5t9
         xvASeJrZz+4HGyoJl3zK0jw4/LWr1nWEczQsDcmgyegDtdRq/N6Ab7DoqXwI2R0y/Z8V
         VDgw/o8f1VU5eShJEzubnmcuBBj0XPyFPH4RTV7ExVBSFzBrtEkli9mwPRf2EUXXyUIe
         b7qviecO5JVCvWfK5ZeM+0OEFSIuBjBbwfcDcVv+9HQfyGXhpb+lQKZaRy6qSM0eLeSc
         sf2Kzha7ncb2xDrUdpCfnIo3tf/tvI26dnyKyo1KGHbkVpzRNq3kRRbt/Lg6xAr582FZ
         zVZA==
X-Gm-Message-State: APjAAAW0uOzSNQwIPV+iqdVtmM3fmqrvzvZoJ9PINxl8YtftjVOieB8H
        c1v7JRoqp+qKujvtg2Ed73o8yg==
X-Google-Smtp-Source: APXvYqyrFsuPI+J/rSJr/qbj786t/px+jLZD97RqjPyY5Wg0jgAoPHArlYM5mL39NCwPKklgZ79hmA==
X-Received: by 2002:a62:70c9:: with SMTP id l192mr20670125pfc.207.1552080341451;
        Fri, 08 Mar 2019 13:25:41 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id h3sm9684639pgv.38.2019.03.08.13.25.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 13:25:40 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     groeck@chromium.org, briannorris@chromium.org, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: [PATCH] kbuild: Speed up install, modules_install and kernelrelease
Date:   Fri,  8 Mar 2019 13:25:23 -0800
Message-Id: <20190308212524.121126-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the description of the old commit 3298b690b21c ("kbuild: Add a
cache for generated variables"), calling the C compiler lots of times
during the parsing stage of the Makefile can be a little slow.  If you
happen to have a C compiler whose fork/exec time isn't optimized
(perhaps it was linked dynamically, or perhaps it's called through
several wrappers, or ...) then this can be more than a little slow, it
can be very slow.

The above slowness was addressed with the old Makefile cache, but the
cache was reverted in commit e08d6de4e532 ("kbuild: remove kbuild
cache").  That commit indicated that we expected to get the speed
gains back because "the result of compiler tests will be naturally
cached in the .config file", but as of the latest mainline there are
still lots of direct calls to the C compiler that happen in the
Makefile parsing stage.

Perhaps we could try re-introducing the Makefile cache and fix the
problems it was causing, but this patch codes up another solution that
gets some of the speed gains back, perhaps with less complexity.

Specifically I observed that by timing the parsing stage of the
Makefile by adding statements like this to the beginning and end of
the Makefile:
  ZZZ := $(shell echo "$$(date '+%T.%N'): ..." >> /tmp/timing.txt)

...that three targets were spending 3 seconds each parsing the
Makefile in my environment (building a Chrome OS kernel with clang)
when it felt like they ought to be quick.  These were: install,
modules_install and kernelrelease

I saw timings that looked like:
  09:23:08.903204451: Parsing Makefile, goals: install
  09:23:11.960515772: Done parsing Makefile, goals: install

Given that the kbuild system doesn't sync the config for any of these
options I believe it is safe to say that it can't compile any code.
Thus if we can avoid the C compiler invocation here we'll save time.

The simplest way to accomplish this is to neuter all the calls to the
compiler by stubbing them out.  After doing so (AKA applying this
change) the same timing looks like:
  09:28:04.929252271: Parsing Makefile, goals: install
  09:28:05.107468449: Done parsing Makefile, goals: install

During an incremental kernel build/install on Chrome OS we call
install once, modules_install twice (once to keep unstripped), and
kernelrelease once.  Thus this saves ~12 seconds on an incremental
kernel build/install.  With my current setup, this brings it from ~40
seconds to ~28 seconds.  Re-introducing the Makefile cache would
likely save us an extra ~3 seconds since we'd avoid the parsing in the
compile stage.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 Makefile | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Makefile b/Makefile
index f070e0d65186..5f7532d9be65 100644
--- a/Makefile
+++ b/Makefile
@@ -304,6 +304,20 @@ else
 scripts/Kbuild.include: ;
 include scripts/Kbuild.include
 
+# If we can't sync the config then we know we can't compile code.
+# Replace the slow option-testing commands with stubs to significantly
+# speed up the Makefile parsing stage of the build.
+ifeq ($(may-sync-config),0)
+	ar-option :=
+	as-option :=
+	cc-disable-warning :=
+	cc-ifversion :=
+	cc-ldoption :=
+	cc-option :=
+	cc-option-yn := n
+	ld-option :=
+endif
+
 # Read KERNELRELEASE from include/config/kernel.release (if it exists)
 KERNELRELEASE = $(shell cat include/config/kernel.release 2> /dev/null)
 KERNELVERSION = $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLEVEL),.$(SUBLEVEL)))$(EXTRAVERSION)
-- 
2.21.0.360.g471c308f928-goog

