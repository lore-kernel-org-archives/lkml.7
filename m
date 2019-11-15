Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6445FC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A2C82077B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N9YDxlPJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfKONhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 08:37:18 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:50771 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbfKONhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 08:37:17 -0500
Received: by mail-qk1-f201.google.com with SMTP id a13so6360052qkc.17
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 05:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=G6EkFeMScJt97Zxa/Roqr4qkhmepcK8pLPvMI4jl0bE=;
        b=N9YDxlPJbBf24qBKjbmFUxwjp7HYh9Ovm2F3sroCnhW54f4ELGNBCOqk2ZiQX4Dgpy
         vmNv+jIJlJGo5typ0J71QQG814xAs4eigUB3DDbVSCl9nr3ZHSJ3yGZHReeTlnuqnMW5
         gOhV6h7VCN6ymjvH1Bz5ThBxZijXPiTx+sy+Hw39CD+TmfZblOa9QolPFOTUEigAAkuC
         /CMh8DjrEU8ykD8FXhkTiGp8EByDzvHlnJIUSYBkIztIBuNlNXE29mnqmfhER4dFr6bb
         TPqDohmWv+56Uy543hwCjVDvlbcudJl5rNp62XN2lUxzm3euJayVaClqXTmQIOqGYkTG
         +4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=G6EkFeMScJt97Zxa/Roqr4qkhmepcK8pLPvMI4jl0bE=;
        b=YOot0SpS3NM6ZmwjKnCMoPr5fIyNlMFACfy22RY126JUsZWzHVLr9Q7nlrVJLx6V8/
         +dBWhj9SXZ0wX296izYvfhRNyW46wRHwMeARXPJhNrZVqhuIDr+WWdivtRJIWsfQevPP
         oiyoZ2gnYnlKKN9z46TNBQI11n+ck24PC6GLpHbICrEFaX30ACL0I5HVQR29YdKLTe7K
         Ax0+Iv5TcsyPA+1/NNEPRAIMBrKSA+/ps7BoHr1Ev4EEbm3b/5lVcQmv7GyEcTn1RQPo
         6NwsDdkITCKoQxV323uj43fc3oTXL9cja+RpYBe6liWixo8LB0I1621+quvkbVofEebc
         zB0g==
X-Gm-Message-State: APjAAAUP3VKqe3ODW7VCHJFSCXloKb5fl+MOZmUT+AvRk6QgHa0Ay4eQ
        jWTO6/k0bcsyQZM4LXNSLvgPUWZvs0+C6k+0
X-Google-Smtp-Source: APXvYqzJ46bYPFjtSSq8kogygD+LPGa6FFnWHBGyFRx9kgGBVmWcTAg4PmkA5mIHPXfXKuLZjcGRJJ4EAOBufHLf
X-Received: by 2002:a37:98c6:: with SMTP id a189mr12586235qke.230.1573825036610;
 Fri, 15 Nov 2019 05:37:16 -0800 (PST)
Date:   Fri, 15 Nov 2019 14:37:11 +0100
Message-Id: <cover.1573824989.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v2 0/1] usb: gadget: add raw-gadget interface
From:   Andrey Konovalov <andreyknvl@google.com>
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Jonathan Corbet <corbet@lwn.net>, Felipe Balbi <balbi@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset (currently a single patch) adds a new userspace interface
for the USB Gadget subsystem called USB Raw Gadget (I don't mind changing
the name to something else if there are better ideas). This is what
currently being used to enable coverage-buided USB fuzzing with syzkaller:

https://github.com/google/syzkaller/blob/master/docs/linux/external_fuzzing_usb.md

Initially I was using GadgetFS (together with the Dummy HCD/UDC module)
to perform emulation of USB devices for fuzzing, but later switched to a
custom written interface. The incentive to implement a different interface
was to provide a somewhat raw and direct access to the USB Gadget layer
for the userspace, where every USB request is passed to the userspace to
get a response. See documentation for the list of differences between
Raw Gadget and GadgetFS.

This patchset has been pushed to the public Linux kernel Gerrit instance:

https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/2144

Changes v1 -> v2:
- Moved raw.c to legacy/.
- Changed uapi header to use __u* types.
- Switched from debugfs entry to a misc device.
- Changed raw_dev from refcount to kref.
- Moved UDC_NAME_LENGTH_MAX to uapi headers.
- Used usb_endpoint_type() and usb_endpoint_dir_in/out() functions instead
  of open coding them.
- Added "WITH Linux-syscall-note" to SPDX id in the uapi header.
- Removed pr_err() if case dev_new() fails.
- Reduced the number of debugging messages.

Andrey Konovalov (1):
  usb: gadget: add raw-gadget interface

 Documentation/usb/index.rst         |    1 +
 Documentation/usb/raw-gadget.rst    |   60 ++
 drivers/usb/gadget/legacy/Kconfig   |    8 +
 drivers/usb/gadget/legacy/Makefile  |    1 +
 drivers/usb/gadget/legacy/raw.c     | 1057 +++++++++++++++++++++++++++
 include/uapi/linux/usb/raw_gadget.h |  167 +++++
 6 files changed, 1294 insertions(+)
 create mode 100644 Documentation/usb/raw-gadget.rst
 create mode 100644 drivers/usb/gadget/legacy/raw.c
 create mode 100644 include/uapi/linux/usb/raw_gadget.h

-- 
2.24.0.432.g9d3f5f5b63-goog

