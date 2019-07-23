Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE05C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 04:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3969F2238C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 04:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MR5t3N1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731403AbfGWE3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 00:29:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39577 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfGWE3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 00:29:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so18726189pgi.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 21:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=22UJjcRk/2lGT/hRSqJ5/S0+j7kZgg6IKXcxM0YiLpc=;
        b=MR5t3N1gfMiPWm1cNEY+2hpVL8X7WUEuq9PC+iLdIp3vivoR4JihR4hn2oH+B8LG8Q
         TLpw01uk07hfJU8J4mkmHusSM2HJRIZpJjQ4GpoDORuCxdpGD/CDaHqTPAw0ssi/AaXS
         gZALUDzuohgUR6Ahvc+HTgMRN9ZxkIoCKcroGELR6nGFO810uSqk6VAaRXiXmCzKsqFa
         u/j6E5vSrkjUpCgs29a1Qm2GyJuovxcP657v/Uf55j13ocmAN/dJ356qY1nlWi6w+nHe
         OUuzR0K0vJs4xvpBQqY6EhRpmvJ784/Zr8KxPiDmvOjn0BT96Jtt4AMx30eU2idiO1Lh
         QU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=22UJjcRk/2lGT/hRSqJ5/S0+j7kZgg6IKXcxM0YiLpc=;
        b=JPSGHB6wv9ZXeh5ZEvwn4/gqndYwYsLX7CuA7MuWzj5vHVvUM+zodDDDg2cpTARvSh
         VaR/hbaFXd0+QzjjlwdPrbDyzi4JOa5fMp8r2Iwqyu5oDzhIRlwNDRRcOY+8YxvH95m8
         Bpv7yyoCSWozpl55KB6pAxwOCNEIVDdmObpRhhkQsVuWFiuNjAxY0nC/7IzOZwjiBV4f
         4FozQkj3jErdoMKwgzf5uWT3GsxGXmbwsxq7zLsDTAJAGjHz8CoxdiJbVymruqkMR5Ts
         w/L3G33Z7byrrGiNuglzVEZ+tWz5Vdf8mW/HvzB63pE0qR/7V9GdzBo85p2YEoOvFaWN
         jjRg==
X-Gm-Message-State: APjAAAWr3cw4nY8h6+2623umMc09aJt9+P/sc1RCb2t7yPWFX72dqf4B
        +dVI8/7p5ObDh2Ha+7zPbPVmQQiK2nw=
X-Google-Smtp-Source: APXvYqzQOzHav8ChLR+nm5Shbhp87uosgWeoO2wTb0paGo7XmBntv7hWu6eWMMIeC9QYcngLF1adlA==
X-Received: by 2002:a63:9e54:: with SMTP id r20mr39915106pgo.64.1563856149447;
        Mon, 22 Jul 2019 21:29:09 -0700 (PDT)
Received: from localhost.localdomain ([49.205.217.198])
        by smtp.gmail.com with ESMTPSA id q69sm56424119pjb.0.2019.07.22.21.29.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 21:29:08 -0700 (PDT)
From:   Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Dennis Zhou <dennis@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: cgroups v2: issues faced attempting to setup cpu limiting
Date:   Tue, 23 Jul 2019 09:58:05 +0530
Message-Id: <20190723042803.21485-1-kaiwan.billimoria@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Am facing some issues getting CPU limiting working with cgroups v2. Pl read on
for the details; a solution is much appreciated!


Env: 5.0.0 Linux kernel on x86_64 Fedora 29

When attempting to setup CPU limiting using cgroups v2, I effectively
disabled cgroups v1 by passing

cgroup_no_v1=all

as a kernel cmdline option. That seems fine and now various controllers (cpu,
io, memory, ...) show up under /sys/fs/cgroup/unified/cgroup.controllers.

However, doing:

# mkdir /sys/fs/cgroup/unified/test1
# echo "+cpu " > /sys/fs/cgroup/unified/test1/cgroup.subtree_control
bash: echo: write error: No such file or directory
#

I understand that this is expected, as the man page on cgroups(7) mentions:

"... As at Linux 4.15, the cgroups v2 cpu controller does not support
control of realtime processes, and the controller can be enabled in the
root cgroup only if all realtime threads are in the root cgroup. (If there
are realtime processes in nonroot cgroups, then a write(2) of the string
"+cpu" to the cgroup.subtree_control file fails with the error EINVAL.
However, on some systems, systemd(1) places certain realtime processes in
nonroot cgroups in the v2 hierarchy. On such systems, these processes must
first be moved to the root cgroup before the cpu controller can be
enabled. ..."

My questions are (forgive them if too basic!): how exactly does one
'move realtime processes to the root cgroup'? What are the commands?

Next, how does one identify which processes? The ones that have sched policy
SCHED_FIFO or SCHED_RR? Would using a utility wrapper make this simpler?
(libcgroup, cgmanager, etc) - do they play well with cgroups2?

TIA!

Regards,
Kaiwan.
---
amazon author page: https://www.amazon.com/-/e/B07KNJSRJX
