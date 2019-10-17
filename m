Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BEFECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A5520820
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="txWXUG/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394490AbfJQRoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 13:44:21 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:37854 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbfJQRoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 13:44:20 -0400
Received: by mail-vk1-f202.google.com with SMTP id q187so1242054vkq.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 10:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=AepTsz+A74jxm03gyi80tnEG5pdCAiVEmB2VKmmYbAA=;
        b=txWXUG/bKJH+xYvRuY3lNWGbs0Fu/K7TeNieEqEzkwCbQ951DttsTLGCzkXdVPy3KY
         Km2w/kOt807GP8B2mwZNT/1sE4XCnhEOgDKdD2r4LCXjfxdltkSQyRv4CGCTq1VoGRr2
         91CJUZ7DeaO+yiJF+glAdddLlpQJvF72+eqedoBsFNo0bVaZHL++3E9pDK/04d2YWGe+
         np7G/lXqW7cVF7AenbULxn1+Hg8fqiLGg2q6O/L99nPop1TMN0R0LzXBRRMq6hiBGMPQ
         t+QwWnw5oWFay2e0WWPMTYmTGfrtu7hXElVim/VjermRHIFXL96frNDlAwKVbaRGZzxv
         pUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=AepTsz+A74jxm03gyi80tnEG5pdCAiVEmB2VKmmYbAA=;
        b=a4Di353a4fbVV77MWisk5RYZYyRGR85/UBJx/qRKPd6tTZAzWgWTOndsep01iFg2Pt
         ll7UOxjgkHt+bI7BDrPAOVtBw9m8uFWM3MVBT/jCo9e7YUMeY4+5Pb1PqQOE/rgh3emI
         u2HPjr/F6vCXsa9LQDm8Uqt8m+CEcBoGWV9WfpUsGWMun0pQxKTw1cXzK9n8LPeBiul6
         HVBP2YRP3w2CD0tivdcp7aDWYowhrAIirFW8BoVtkR6QsaDAiy7liXZh/IGSMOOu8g8Y
         FMDjbUotEWWOYoaM066rJScZkxH00IcMRMQ180okWmLuIolB7OU9+bdsVefQDHt5LjQ3
         XLWA==
X-Gm-Message-State: APjAAAVM/YwcuWYu7k/ekjZmjaUiJaci3k+hLxXAEOYsskkdWYRqOiNJ
        k5RD/5zQv2y62hLKdN03wyH3Ev2YRERkUTcZ
X-Google-Smtp-Source: APXvYqw6C55wAy116NWvppt7eDZT+fCR1ORnXW7Efx/dADnmZz5XHGPkhTIDMeFVShexmVeAGLoCcWUsVfibJxkz
X-Received: by 2002:a9f:200a:: with SMTP id 10mr2884411uam.42.1571334259331;
 Thu, 17 Oct 2019 10:44:19 -0700 (PDT)
Date:   Thu, 17 Oct 2019 19:44:12 +0200
Message-Id: <cover.1571333592.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH RFC 0/3] kcov: collect coverage from usb and vhost
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

Andrey Konovalov (3):
  kcov: remote coverage support
  usb, kcov: collect coverage from hub_event
  vhost, kcov: collect coverage from vhost_worker

 Documentation/dev-tools/kcov.rst |  99 +++++++
 drivers/usb/core/hub.c           |   4 +
 drivers/vhost/vhost.c            |  15 ++
 drivers/vhost/vhost.h            |   3 +
 include/linux/kcov.h             |  10 +
 include/linux/sched.h            |   6 +
 include/uapi/linux/kcov.h        |  18 ++
 kernel/kcov.c                    | 434 ++++++++++++++++++++++++++++---
 8 files changed, 554 insertions(+), 35 deletions(-)

-- 
2.23.0.866.gb869b98d4c-goog

