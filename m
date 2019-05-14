Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4755AC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 13:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1544220879
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 13:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfENNRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 09:17:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51110 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfENNQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 09:16:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id f204so2858055wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 06:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XOfzdfS9JDTS2x5DGGI6S8ITgh1lhmu7AKXviivuHlM=;
        b=gso/FRID7p+BCbQFGmwg9f6soFny5MCF+FRJxVG9xHrpA6xZ4WuAYtabpcsBwLf1xu
         b8pPmTBYp5bzYJAPSmBOwCFLFTazrhErp1hTe+eKKqY/7dV9JHbWrwoYh5FK/5ZBBxJa
         3WWJ5JsOcVtlXHOFkJ7Ya2GWItUHrZXihsulbMgHtZFGxZY640AJg5Gb5T+0VmlMlEpj
         vnXOQNLM9ObHKtCKKtPmXYJk2RNnSdvvUkYqWh3q/A7rMNC271U6ZoWHYCrGwZKwhISn
         lAtmJDOjMFAWQjXhkZzMc4ykMMSYJ17lNmUJ+wip5jNYNpxP/wkOlVNTHjN4tIk0jUk7
         IxAA==
X-Gm-Message-State: APjAAAVJ4TXB7TDK29zk+/RDHCyr5WbewmQwmOhwUPauvBW92dC47L7k
        CGcNEFYDnb98o8lGL9orHzpfmDgOxao3DA==
X-Google-Smtp-Source: APXvYqzjd4S45m8QdzJ48SrXeW8o3mq0TAOS+XYFjYBtZJbI+0Eb9uL/5VQgPZcML53KJaym23myJQ==
X-Received: by 2002:a1c:f310:: with SMTP id q16mr20319455wmq.102.1557839816601;
        Tue, 14 May 2019 06:16:56 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id l12sm3350136wmj.0.2019.05.14.06.16.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 06:16:55 -0700 (PDT)
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>, linux-mm@kvack.org
Subject: [PATCH RFC v2 0/4] mm/ksm: add option to automerge VMAs
Date:   Tue, 14 May 2019 15:16:50 +0200
Message-Id: <20190514131654.25463-1-oleksandr@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, KSM works only on memory that is marked by madvise(). And the
only way to get around that is to either:

  * use LD_PRELOAD; or
  * patch the kernel with something like UKSM or PKSM.

Instead, lets implement a sysfs knob, which allows marking VMAs as
mergeable. This can be used manually on some task in question or by some
small userspace helper daemon.

The knob is named "force_madvise", and it is write-only. It accepts a PID
to act on. To mark the VMAs as mergeable, use:

   # echo PID > /sys/kernel/mm/ksm/force_madvise

To unmerge all the VMAs, use the same approach, prepending the PID with
the "minus" sign:

   # echo -PID > /sys/kernel/mm/ksm/force_madvise

This patchset is based on earlier Timofey's submission [1], but it doesn't
use dedicated kthread to walk through the list of tasks/VMAs. Instead,
it is up to userspace to traverse all the tasks in /proc if needed.

The previous suggestion [2] was based on amending do_anonymous_page()
handler to implement fully automatic mode, but this approach was
incorrect due to improper locking and not desired due to excessive
complexity.

The current approach just implements minimal interface and leaves the
decision on how and when to act to userspace.

Thanks.

[1] https://lore.kernel.org/patchwork/patch/1012142/
[2] http://lkml.iu.edu/hypermail/linux/kernel/1905.1/02417.html

Oleksandr Natalenko (4):
  mm/ksm: introduce ksm_enter() helper
  mm/ksm: introduce ksm_leave() helper
  mm/ksm: introduce force_madvise knob
  mm/ksm: add force merging/unmerging documentation

 Documentation/admin-guide/mm/ksm.rst |  11 ++
 mm/ksm.c                             | 160 +++++++++++++++++++++------
 2 files changed, 137 insertions(+), 34 deletions(-)

-- 
2.21.0

