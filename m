Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932D4C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6478920820
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JYz0tgkq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394858AbfITG1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 02:27:24 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:53209 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389579AbfITG1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 02:27:24 -0400
Received: by mail-qk1-f201.google.com with SMTP id k68so6869650qkb.19
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 23:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=kndoGPsK6TO6IAqiWJAGc1exJ1qKbB/qTmt7yhIgp2A=;
        b=JYz0tgkqcjHYeFXGs5Jkl7ZHNM2Ki+xRUUbhi+Co1pWIqK2Rqoy5TkDvvpJ1jQ9eZS
         ZM93FmdRSdYmq/dqNzmeE//LcDslAmNWchBeD0VLVf5H+I/KUQevLfWnJu6s73dMnS5s
         OGUXUFXe8NM3iA4gIqi6vYO6gcWHC+zeZWytQi71ABPyMIUNz3pPkAM3FbR3OuNKybJe
         ia7FUXADvdzznFyTB3tU+qEMGiyyPfayVYvyZ2SRo9++8xPKE5dZovma8zsSJZCWWRKS
         B2/Jq0rfBSS4w1k087d0vW0FqPCn+dcwRkRwKVPoGQ3lFhU9+LK8rXGWEXLNpOhoJp5T
         aM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=kndoGPsK6TO6IAqiWJAGc1exJ1qKbB/qTmt7yhIgp2A=;
        b=GZLFM4YZ6+JuR2Rld5SwO5L1vg9l3++p/RH4IWSYLJxOmY1UcCOQEFPijDtx2OVKue
         MI9wqftXBPxHpvReRsKhH1DDbsjrCuaW26wS8xfAyaKWW9xZA0o11NifuPD8t5GQGddJ
         bk9FYKdSLasMw4SNKpszn5fJmoUzHnCOBQ0HU8GAAoG0gt2Ky98/D/wtRjWeeqit64P2
         foubJmbCnRVd0UvQRCDB0m5O5R1bvgGS2BwTmEbMwNYm6ArXd3GVwkTWkRiWsEbwvajk
         LH5Zss+que5JMKLPpB0B/G35iU/XVmRzrbnOyvmQBM60FqH4FvekmNGRlDs1mx5+ntVq
         0nCQ==
X-Gm-Message-State: APjAAAWX4qFUbvhpcMdOS5+xZlBmWo4fZ+18az9SukDzAnrsj2NADNhs
        kipzi4+A4oMyfqvvB/R60w12HmXzfuOpBg==
X-Google-Smtp-Source: APXvYqw1JYvp88OxeYK0ycIQ0fMgenrGiZsTYURvNN1tTjKkuC+71gJsg7hD8TQ7bpIVzkxB3yhufPymfAFwQg==
X-Received: by 2002:aed:22cc:: with SMTP id q12mr1653867qtc.232.1568960842694;
 Thu, 19 Sep 2019 23:27:22 -0700 (PDT)
Date:   Fri, 20 Sep 2019 15:27:11 +0900
Message-Id: <20190920062713.78503-1-suleiman@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [RFC 0/2] kvm: Use host timekeeping in guest.
From:   Suleiman Souhlal <suleiman@google.com>
To:     pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de
Cc:     john.stultz@linaro.org, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Suleiman Souhlal <suleiman@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This RFC is to try to solve the following problem:

We have some applications that are currently running in their
own namespace, that still talk to other processes on the
machine, using IPC, and expect to run on the same machine.

We want to move them into a virtual machine, for the usual
benefits of virtualization.

However, some of these programs use CLOCK_MONOTONIC and 
CLOCK_BOOTTIME timestamps, as part of their protocol, when talking
to the host.

Generally speaking, we have multiple event sources, for example
sensors, input devices, display controller vsync, etc and we would
like to rely on them in the guest for various scenarios.

As a specific example, we are trying to run some wayland clients
(in the guest) who talk to the server (in the host), and the server
gives input events based on host time. Additionally, there are also
vsync events that the clients use for timing their rendering.

Another use case we have are timestamps from IIO sensors and cameras.
There are applications that need to determine how the timestamps
relate to the current time and the only way to get current time is
clock_gettime(), which would return a value from a different time
domain than the timestamps.

In this case, it is not feasible to change these programs, due to
the number of the places we would have to change.

We spent some time thinking about this, and the best solution we
could come up with was the following:

Make the guest kernel return the same CLOCK_MONOTONIC and
CLOCK_GETTIME timestamps as the host.

To do that, I am changing kvmclock to request to the host to copy
its timekeeping parameters (mult, base, cycle_last, etc), so that
the guest timekeeper can use the same values, so that time can
be synchronized between the guest and the host.

Any suggestions or feedback would be highly appreciated.

Suleiman Souhlal (2):
  kvm: Mechanism to copy host timekeeping parameters into guest.
  x86/kvmclock: Use host timekeeping.

 arch/x86/Kconfig                     |   9 ++
 arch/x86/include/asm/kvm_host.h      |   3 +
 arch/x86/include/asm/kvmclock.h      |   2 +
 arch/x86/include/asm/pvclock-abi.h   |  27 ++++++
 arch/x86/include/uapi/asm/kvm_para.h |   1 +
 arch/x86/kernel/kvmclock.c           | 127 ++++++++++++++++++++++++++-
 arch/x86/kvm/x86.c                   | 121 +++++++++++++++++++++++++
 kernel/time/timekeeping.c            |  21 +++++
 8 files changed, 307 insertions(+), 4 deletions(-)

-- 
2.23.0.237.gc6a4ce50a0-goog

