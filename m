Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0287AC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C957C20720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QA8K308l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbgAHRHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 12:07:53 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:46368 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729516AbgAHRHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 12:07:53 -0500
Received: by mail-oi1-f174.google.com with SMTP id 13so1384887oij.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 09:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=A9GrVPmNKNHW3eNzRMPYKqAUKvFyBJyDWBHuMSG+/zM=;
        b=QA8K308lbSECRq+u12lHYt0gei9CQu0ZdTmZNiW7GZBvTm/2NqY0/43XqT1p9TKsQf
         LqeEu/EemEIyVKl9rz18hLpeiZHMEENNwTmdAmCdnXEEbc82o50bNq6W1r9g8Kyg68DP
         CwCRkeRC5ly4trhTWmwIkCMvlgTjJayFLU5v2ynQQ77TbgX2ouXOuTfNAaBFx910Y6X3
         ustToSPnxyo59xevMGD5FFMAb+kMCz6r7lC26bogD1LkqW8kyD2EqVps72ytwcn7viAH
         QhD3SS5hxFAIPUb0LmnzaI1PLxHdt0fe2BeawaUfpE2quTGzKoXDHSZi0Z1fTUmKhCkA
         6UFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=A9GrVPmNKNHW3eNzRMPYKqAUKvFyBJyDWBHuMSG+/zM=;
        b=gFP1fvAce6fYP/yVuzRKLkOMMwUXFtMmCykXUCOzSDZf1ssLA6YC0yrzjTawdKtrHy
         G45XXA8O+loBtjixiJm6PHAE4AXvEv8s0KWkT88I9xAlNq/JhuzhkZgT5R+vBBWXoAkn
         0uH5cwXTLnsJ3NlDWokstHJB/+oN1HEl90bAYnmaQIGHXC5XnhfIlSD8T4JEVYharaaF
         gnxC7It+OZ3PD9DAiz3WTWtdxvpAQcHLwH5TPGTBdAn2O/cuoHXuFAxupgg894mqkyhc
         KI4ujIASH41Y0dLFB4pxwyALR4O4k2cJjBcLueS12OzXVcT9OAtglIj2qM4H+j7uO+Du
         83lg==
X-Gm-Message-State: APjAAAWMWuEiUywFxqjCxtuqjOR8hLnKXIXoT2A5AFHS3w39lhx5dO4y
        +kFVzH5pjpvYz3eeHhpkBq2FOqMX7CHX6i2KOZhjLXWqHhh4Sw==
X-Google-Smtp-Source: APXvYqyyjIWqlDZwinq/jqL8vHUa7LstVlTq9InKe3YGEo6/VT835q9nl8nK75NU/GkROsr3iUaYQLa5K58yqsr6qms=
X-Received: by 2002:a05:6808:30d:: with SMTP id i13mr3661250oie.144.1578503272178;
 Wed, 08 Jan 2020 09:07:52 -0800 (PST)
MIME-Version: 1.0
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 8 Jan 2020 09:07:41 -0800
Message-ID: <CALvZod7E9zzHwenzf7objzGKsdBmVwTgEJ0nPgs0LUFU3SN5Pw@mail.gmail.com>
Subject: [bug report] resctrl high memory comsumption
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Recently we had a bug in the system software writing the same pids to
the tasks file of resctrl group multiple times. The resctrl code
allocates "struct task_move_callback" for each such write and call
task_work_add() for that task to handle it on return to user-space
without checking if such request already exist for that particular
task. The issue arises for long sleeping tasks which has thousands for
such request queued to be handled. On our production, we notice
thousands of tasks having thousands of such requests and taking GiBs
of memory for "struct task_move_callback". I am not very familiar with
the code to judge if task_work_cancel() is the right approach or just
checking closid/rmid before doing task_work_add().

==repro==
# mkdir /sys/fs/resctrl/test
# cat /proc/slabinfo | grep kmalloc-32
kmalloc-32         57219  57288     32  124    1 : tunables  120   60
  8 : slabdata    462    462      0
# sleep 600&
[1] 17611
# for i in {1..200000}; do echo 17611 > /sys/fs/resctrl/test/tasks ; done
# cat /proc/slabinfo | grep kmalloc-32
kmalloc-32        257466 257548     32  124    1 : tunables  120   60
  8 : slabdata   2077   2077      5
# kill 17611
[1]+  Terminated              sleep 600
# cat /proc/slabinfo | grep kmalloc-32
kmalloc-32         57924  60636     32  124    1 : tunables  120   60
  8 : slabdata    470    489    385

thanks,
Shakeel
