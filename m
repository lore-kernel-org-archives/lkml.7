Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A4BC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912FD20679
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TP+7I1u8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbfKHS1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 13:27:02 -0500
Received: from mail-vs1-f73.google.com ([209.85.217.73]:50961 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbfKHS1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:27:02 -0500
Received: by mail-vs1-f73.google.com with SMTP id z1so744567vsq.17
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 10:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=InCRmCaYMSJuejWdhbWZ80dHI+Ie599QAOMGzNVa8w0=;
        b=TP+7I1u88l92JkOCamU28Y5ZsK5+tbfj3eufSxGmmqP49N30NQLzAHdNGZ66T3MoPr
         RA/ZnHYToLy6UXCbTnIypGk1BGHP0XmqM+n8G7XL4DwXXFYSdZmYOJqeDkVKENYdmeG9
         AlR7d2DJ6GkwZfljvLkYTJH+AdsPWtr3jJ4BJ+W1/eu95Rvi/av/ntF9C1Jxjg+spfpZ
         LSUOLmspBQpXt+PYu69w3xGGs1kwiy5bYkqPlYFjG/nDl8Q2JeqRW9Necr+SLpsBrnOl
         WLxHgTI7ib54OB3WEJGhxxMF1EdzBMIrCBk+sYoS3YsSM7XqA1Lc7mHYPs7sDeClhCZu
         irPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=InCRmCaYMSJuejWdhbWZ80dHI+Ie599QAOMGzNVa8w0=;
        b=ObRvgiPEiu4aOJs4uOWcYtKu28+0Mhb+g7SmO3nTCoCloXJ59I8w5076e7k3FBH1Cd
         WsTmJEQwNr347lXRmJmzWcu6p8hWlXinALsU+9sgFD/n3v9yTNHXhHNXfDkf5RP5bWyg
         OEFIkSPLpf+jKhGNggoj763Y1dGfIqCYC0k70AnKwJQUTlr4hSrTLRmbASlYsFb4/H5t
         wBE0kUFUnHEAoqLYgVgV5eXkNnjI6qBXS7CyQkEl3Kipzgm5Yjtl/LnOkUFKlGf/8OIh
         2KsJ40KfYmGFlGJWW6NBcT3Dwn7BU1YnmTlTjxeAzD66APwoZlk0VPEpqQGsSxwkXMIK
         r1iw==
X-Gm-Message-State: APjAAAWMtlPwc690NtlHGpzQLVsXxEyyIShT4o9t+Cbp6MPRTsEs2CTj
        xGC1RnWweeDJJa8T98Odl44hsuWWTRMGhtQr
X-Google-Smtp-Source: APXvYqwq/EaWvDgTgw8EdmOJsazZTyA+tDGqijyvay3+yMvNeIB6nn8yXTHkAs9AyBx78GY1k5XNrKAqfUW/cUwV
X-Received: by 2002:a05:6102:835:: with SMTP id k21mr8718518vsb.11.1573237621016;
 Fri, 08 Nov 2019 10:27:01 -0800 (PST)
Date:   Fri,  8 Nov 2019 19:26:54 +0100
Message-Id: <cover.1573236684.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH 0/1] usb: gadget: add raw-gadget interface
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

Andrey Konovalov (1):
  usb: gadget: add raw-gadget interface

 Documentation/usb/index.rst         |    1 +
 Documentation/usb/raw-gadget.rst    |   60 ++
 drivers/usb/gadget/Kconfig          |    9 +
 drivers/usb/gadget/Makefile         |    2 +
 drivers/usb/gadget/raw.c            | 1150 +++++++++++++++++++++++++++
 include/uapi/linux/usb/raw_gadget.h |  164 ++++
 6 files changed, 1386 insertions(+)
 create mode 100644 Documentation/usb/raw-gadget.rst
 create mode 100644 drivers/usb/gadget/raw.c
 create mode 100644 include/uapi/linux/usb/raw_gadget.h

-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

