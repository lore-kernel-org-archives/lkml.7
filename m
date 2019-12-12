Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E35C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B118222527
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vrj3NH1S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbfLLRPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 12:15:48 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:45343 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730019AbfLLRPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 12:15:48 -0500
Received: by mail-qk1-f202.google.com with SMTP id 143so1811491qkg.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 09:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=v2c9ZfhsjHl5yHeRsOkptCzwopqKyi8H+GjnL6ViNEI=;
        b=vrj3NH1ShlxM4YyYe0HqMM/dwIJ/fbhT+APeMTYtYoOG+CRXgaspmBasE4ErJdIIKi
         jKDBAG0QKul7viwQpYW6XAA0Zjs/OwBkQtBf1K05wZYbMMI0opQwGyzT+YsfLr3OMqla
         lDjR73vpeODB04Fr5k9u1dyE32YCXQ30LDRoDe1gHq4pwTdmfL8rUSdCJbvdFP3l45dg
         SR5r6aA/6DzNNbzAod12aErBMfwYaNEoTYiQcLyDBmiLButXvXObMUCU5tGqskbDvrJ2
         qfdxvJXSBSxcvZeWKiOarc8KAVx2GSe2x7sH+SPYxcSWpwQcQCSL3928o15KVRmxBP0Q
         KJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=v2c9ZfhsjHl5yHeRsOkptCzwopqKyi8H+GjnL6ViNEI=;
        b=EXWdK/OMc03htZm7sPwnZXwqeqUkFRdBhRj0FdZFU76urb7B9F85ew6hT+k1DHBKNZ
         t0cyPb64U7gGLxm0UCzJHBoGWQhHvb1TNsQoinRK+voyEll8n1/obJ4dbQUMtYOuxOVS
         7LX1UHy4zrITjPgoMU+2UYnKxRDf9XZ6+d2+e0tiWdXEC2o5RPLmgsKNSLCEb/mjGRnq
         pqREMEVKqK+OEdj7deRstXIePaqtiHELijf4oVo6r8mbQcrSBYEfuZf7FTbytkh+VHx+
         xMafxzO/8LvOm4kCpgsnfJgHmCAQ4ho5TH8Tb3D4qCXS9yYcZcxvxUr91t762GbVGe0R
         QABw==
X-Gm-Message-State: APjAAAWwZSuMDHfnFfSvPnOc0wKxhem9Rcb1kwX42tVMwzolJdb+9OcT
        +QA4m6dfGoGVgMgtvwleLsg5xWHEvnmNxH6J
X-Google-Smtp-Source: APXvYqzGw/ZgJf+JgIA+hGU/h4Uovf7mUvA8SaZcjm27w1n/jWOAvB9sAKZXyMLIHaH8dKOK3BumvDPhvQx5uZWo
X-Received: by 2002:ac8:6f2d:: with SMTP id i13mr4821925qtv.133.1576170946867;
 Thu, 12 Dec 2019 09:15:46 -0800 (PST)
Date:   Thu, 12 Dec 2019 18:15:37 +0100
Message-Id: <cover.1576170740.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH RFC 0/2] kcov: collect coverage from usbhid interrupts
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset extends kcov to allow collecting coverage from interrupts
and then uses the new functionality to collect coverage from usbhid code.

What I'm not sure yet about this change is if we actually want to
selectively annotate some parts of the USB stack that are executed in
interrupt context, or maybe we can do this with some common approach.

For example patch #2 in this patchset annotates all functions that are
passed as completion callbacks to usb_fill_*() in drivers/hid/usbhid.
Maybe instead we could redefine usb_fill_*() in a way that would handle
all such cases without manual annotations.

Any suggestions are welcome.

This has allowed to find at least one new HID bug [1], which was recently
fixed by Alan [2].

[1] https://syzkaller.appspot.com/bug?extid=09ef48aa58261464b621
[2] https://patchwork.kernel.org/patch/11283319/

This patchset has been pushed to the public Linux kernel Gerrit instance:

https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/2225

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Andrey Konovalov (2):
  kcov: collect coverage from interrupts
  HID: usbhid: kcov: add annotations for coverage collection

 Documentation/dev-tools/kcov.rst   |  16 +--
 drivers/hid/usbhid/hid-core.c      |  25 +++-
 drivers/hid/usbhid/usbkbd.c        |  15 ++-
 drivers/hid/usbhid/usbmouse.c      |   7 +-
 drivers/usb/gadget/udc/dummy_hcd.c |   1 +
 include/linux/sched.h              |   3 +
 kernel/kcov.c                      | 196 +++++++++++++++++++----------
 lib/Kconfig.debug                  |   9 ++
 8 files changed, 192 insertions(+), 80 deletions(-)

-- 
2.24.1.735.g03f4e72817-goog

