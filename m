Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7079C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5802089F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Q4JxbKZd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390567AbfIIKXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 06:23:46 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55815 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390548AbfIIKXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:23:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id g207so13144212wmg.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 03:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v1vHqtKr8cw0KtYdhkEFzC4ar+CMf7Z34S1HppPU/IU=;
        b=Q4JxbKZdEH7ikJJbSjezmyCl1O2EZRxd1Sj9Ut+gYPy58Okwm3OttXqK0uZKzD7JvP
         NDmvDYb/h4jZ3BkW50xvchvhmfH6OXoZyc8VSAH6PkX/PaKQcINbJYwmy6ErGwbY2Qn3
         Fn+OtWKkAXtTpPGQFXt62GAjO5odgq5XITsU6ghsSOAWOSP49Q4oBJZmY0xuL/53iqFW
         I+0OGhAoX60F0qo37D7WO4NjuUEghOZF5hENOnMcqEc7RZ0UlzRyl/raxJ0bKi255v1J
         qoZXhYAHTNOFwJRcpHssfnD27PnMFD1ZDWqSa0gnUnZhAm5reSObhmZ0KgPPKo9Ut0xo
         D3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v1vHqtKr8cw0KtYdhkEFzC4ar+CMf7Z34S1HppPU/IU=;
        b=PuNHvmOMKQgNc9qe42v1L0D3ukhiYu4loOQssSWGSgU1WHhwuNRjgjAVkt+0hdasXI
         5VMwb/wEh1K7iCB4RuIf8aE7SSF6q2OCyNW7dkIXSyDAUvnpyZH2uURbejPhSjZfzMsx
         M1C/AQ+l63y8lhByyv3z53ajFiTOL+RmIUScz4dkIKkmewDIWB0qqYytrEL1Zm+Kniyk
         GTusBHOFhv1ZppGThSuFub/uYmZcbDUReq4pN09Be3ndC+daq/BM41ONZ4Ewx5x5JidE
         cdskxC+EbuvSSJUeiQPHWtOsefJNYiwKhN5LatqzhSLHrES5uOAuhxUveNVIT9rQUjYh
         D6Gw==
X-Gm-Message-State: APjAAAVjmspT1fEhSbonQSpwFClQIYf1SdrvqVNvQoOaDz5ttZMqvmaI
        +rJupi9+wye9sm+145mnJ39RJ/aI5Wotfw==
X-Google-Smtp-Source: APXvYqx4fN/DN0uw+61dCgR+XviXlOSxx0lVzi+c/Vk8VC/qESo+wgcA4sINAtlrlROnJJrJ2vtAsA==
X-Received: by 2002:a05:600c:224d:: with SMTP id a13mr18044183wmm.45.1568024623543;
        Mon, 09 Sep 2019 03:23:43 -0700 (PDT)
Received: from Mindolluin.localdomain ([148.69.85.38])
        by smtp.gmail.com with ESMTPSA id d14sm1800008wrj.27.2019.09.09.03.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 03:23:42 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/9] restart_block: Prepare the ground for dumping timeout
Date:   Mon,  9 Sep 2019 11:23:31 +0100
Message-Id: <20190909102340.8592-1-dima@arista.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to address an issue in CRIU (Checkpoint Restore In Userspace)
about timed syscalls restart. It's not possible to use restart_syscall()
as the majority of applications does, as after restore the kernel doesn't
know anything about a syscall that may have been interrupted on
checkpoint. That's because the tasks are re-created from scratch and so
there isn't task_struct::restart_block set on a new task.

As a preparation, unify timeouts for different syscalls in
restart_block.

On contrary, I'm struggling with patches that introduce the new ptrace()
request API. I'll speak about difficulties of designing new ptrace
operation on Containers Microconference at Plumbers [with a hope to
find the sensible solution].

Cc: Adrian Reber <adrian@lisas.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrei Vagin <avagin@openvz.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Cyrill Gorcunov <gorcunov@openvz.org>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Pavel Emelyanov <xemul@virtuozzo.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: containers@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org

Dmitry Safonov (9):
  futex: Remove unused uaddr2 in restart_block
  restart_block: Prevent userspace set part of the block
  select: Convert __esimate_accuracy() to ktime_t
  select: Micro-optimise __estimate_accuracy()
  select: Convert select_estimate_accuracy() to take ktime_t
  select: Extract common code into do_sys_ppoll()
  select: Use ktime_t in do_sys_poll() and do_poll()
  select/restart_block: Convert poll's timeout to u64
  restart_block: Make common timeout

 fs/eventpoll.c                 |   4 +-
 fs/select.c                    | 214 ++++++++++++---------------------
 include/linux/poll.h           |   2 +-
 include/linux/restart_block.h  |  11 +-
 kernel/futex.c                 |  14 +--
 kernel/time/alarmtimer.c       |   6 +-
 kernel/time/hrtimer.c          |  14 ++-
 kernel/time/posix-cpu-timers.c |  10 +-
 kernel/time/posix-stubs.c      |   8 +-
 kernel/time/posix-timers.c     |   8 +-
 10 files changed, 115 insertions(+), 176 deletions(-)

-- 
2.23.0

