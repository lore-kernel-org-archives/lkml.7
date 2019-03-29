Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8427C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6719218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ey3fTuZv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730426AbfC2WIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 18:08:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33877 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730117AbfC2WIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 18:08:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id v12so1846981pgq.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 15:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vxqwInnRJGr6vMSgKpAmw+4XgnduKAVVmZbUW3pVXSs=;
        b=Ey3fTuZvde5avtjaMbyvcxDzLhlzYr0ZzVkz0cnDIX59adv3UiwZ3H5WezCXFLohCs
         pwsI2vxgsBWe7RANhGXrNwKWBvNfhtj41d34WeTx8ePlx4g5dvHSdC2dl1R2UVMoB1XN
         cC7yDBFNtzILym3RQWd7GWcSGTOAFZh1X0gQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vxqwInnRJGr6vMSgKpAmw+4XgnduKAVVmZbUW3pVXSs=;
        b=ihkS5dcnptheENGrhruBRcuG7Q/WuLNsbetgub2VpoEbAJpmZGcbX82hmCP8FEqOli
         7NqAE86csOlx7KXM5zfwqK76YKqE4bQTZ3cyU4NDICUbw/zgk2dY4Ne2Pc46rbXWwCo1
         3eCJPh6sY3A945c0R76VcIRAA+8ydPjU0PjcrsmItDwC6Ly8WXGAF+Kuq2hPOGMk+REJ
         nz1U51XI3PdURpXiNLfFhXIW3M5baicC/4n1SHcaRTBXXnmlWzOslh2dp4Zlz+wUq5G+
         xa4DzRXIH0mMUQTxsjlhVGVwTeXAL/sl9QUEatcfeQlAXmNwZ0OuL5p/YT/WwVfKTbbq
         UMQQ==
X-Gm-Message-State: APjAAAWCXTpmhg7rA0q3hS7x+zVp6zqQmlGVJo4o920mevBM6jW03Oqa
        81tMKqrktg/tVAWLHZRDRdY1mr5O7ET6qQ==
X-Google-Smtp-Source: APXvYqxZhAP4EGS8qk7LEz5QgcUXfJ8+GegllJEg9hZaJOkXk3HqoQQ2lLXRuUKoXBmSbOEQs9Ta8g==
X-Received: by 2002:a62:ee13:: with SMTP id e19mr49368634pfi.224.1553897326174;
        Fri, 29 Mar 2019 15:08:46 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b7sm8925514pfj.67.2019.03.29.15.08.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 15:08:45 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Douglas Anderson <dianders@chromium.org>,
        Nikolay Borisov <n.borisov.lkml@gmail.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jackie Liu <liuyun01@kylinos.cn>
Subject: [PATCH v2 0/5] gdb script for kconfig and timer list
Date:   Fri, 29 Mar 2019 15:08:39 -0700
Message-Id: <20190329220844.38234-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a handful of changes to the kernel's gdb scripts to do some more
debugging with kgdb. The first patch allows the vmlinux to be reloaded
from where it was specified on the command line so that this set of
scripts can be used from anywhere. The second patch adds a script to
dump the config.gz to a file on the host debugging machine. The third
patch adds some rb tree utilities and the last patch uses those rb tree
walking utilities to dump out the contents of /proc/timer_list from a
system under debug.

Andrew picked these patches up into -mm. I'm resending for full review
instead of just sending the diff.

Changes from v1:
 * Fixed config dumping script off-by-one error on builtin config size
 * Silenced pep8 style warnings and errors
 * Added a new patch at the end to fix existing warnings
 * Fixed some TODOs in timerlist printing
  * cpumask printing
  * jiffies printing uses jiffies_64 now to avoid conversion problems

Cc: Douglas Anderson <dianders@chromium.org>
Cc: Nikolay Borisov <n.borisov.lkml@gmail.com>
Cc: Kieran Bingham <kbingham@kernel.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Jackie Liu <liuyun01@kylinos.cn> 

Stephen Boyd (5):
  scripts/gdb: Find vmlinux where it was before
  scripts/gdb: Add kernel config dumping command
  scripts/gdb: Add rb tree iterating utilities
  scripts/gdb: Add a timer list command
  scripts/gdb: Silence pep8 checks

 scripts/gdb/linux/config.py       |  44 ++++++
 scripts/gdb/linux/constants.py.in |  13 ++
 scripts/gdb/linux/cpus.py         |   1 +
 scripts/gdb/linux/lists.py        |   1 +
 scripts/gdb/linux/proc.py         |  10 +-
 scripts/gdb/linux/rbtree.py       | 177 ++++++++++++++++++++++++
 scripts/gdb/linux/symbols.py      |   6 +-
 scripts/gdb/linux/tasks.py        |   2 +
 scripts/gdb/linux/timerlist.py    | 219 ++++++++++++++++++++++++++++++
 scripts/gdb/linux/utils.py        |   7 +-
 scripts/gdb/vmlinux-gdb.py        |   3 +
 11 files changed, 477 insertions(+), 6 deletions(-)
 create mode 100644 scripts/gdb/linux/config.py
 create mode 100644 scripts/gdb/linux/rbtree.py
 create mode 100644 scripts/gdb/linux/timerlist.py


base-commit: 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b
-- 
Sent by a computer through tubes

