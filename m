Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC5DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E6242075D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YilAR6sN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbfCYSpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:45:25 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40913 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730209AbfCYSpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:45:24 -0400
Received: by mail-pl1-f193.google.com with SMTP id b11so364226plr.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 11:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GEjHZZyN9UV8cr9/1AsfCdSj4T5lyWTft2bZ9OIolto=;
        b=YilAR6sNYUraBChWS+HN63XE1mB10GN3H7whUIsKw2aMrn/CGfOiVY3T6gv1jP+8R8
         VTag/hQ647QeIUba3yo8/VbXC0fCB8ZVAgPk3WdQ/+6v2IqeeP20P4O3xjpICCjtNxe1
         +/47dHcLPpEeDA6IjMRbouCqbF1au10TOxxyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GEjHZZyN9UV8cr9/1AsfCdSj4T5lyWTft2bZ9OIolto=;
        b=QMunM2HMN1LNvDx8N1tlr9C0OrscYNuumpQwLGfYJb6Pqm0jTRtbI1gCjrbCOc2FCB
         JSZhkTJ2NS8tfljlfC1sSIt3wIiUSbncaOug5b5GFnYYnevS4ExO+X0U8FJUQM5TkPhb
         737QgBeoDgbSgGB+BegCeFAYeBLJaajHZVWizZk9t+/QuLFHb+/S816uHkLpvIsvYLve
         L+sh1jrjbvRd1UGxGghHJEktGxuulY2AROQgjgPLaaCEV2V2CriAczsZN7b+ckpBi9Wq
         zdlF5e3AskrE5h/O9rmhzvyWHis5kgcT8N1V6NOfmAVW/AbKzleK4xbKTxSIf5GlB6qL
         c8Hw==
X-Gm-Message-State: APjAAAVzZu+Gux1ABhQC4So/ToWCVt7NWPdpVup2OgOpXBcsYE8Y6Pt+
        56wXZS8WD+z76O9OIEt4qImjgw==
X-Google-Smtp-Source: APXvYqwLudEWkB3WnCmnVNEZVvQXuWelXdKVPknFjex1SFkSO6/xJOHVQdLCJJeuqDNyrIVdH0FbEg==
X-Received: by 2002:a17:902:70cc:: with SMTP id l12mr8312236plt.10.1553539524256;
        Mon, 25 Mar 2019 11:45:24 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id h3sm27505108pfb.31.2019.03.25.11.45.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 11:45:23 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Douglas Anderson <dianders@chromium.org>,
        Nikolay Borisov <n.borisov.lkml@gmail.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jackie Liu <liuyun01@kylinos.cn>
Subject: [PATCH 0/4] gdb script for kconfig and timer list
Date:   Mon, 25 Mar 2019 11:45:18 -0700
Message-Id: <20190325184522.260535-1-swboyd@chromium.org>
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

I'm guessing that Andrew will pick these patches up. I don't know who
maintains these gdb scripts but it looks like Andrew has been doing the
lifting recently.

Cc: Douglas Anderson <dianders@chromium.org>
Cc: Nikolay Borisov <n.borisov.lkml@gmail.com>
Cc: Kieran Bingham <kbingham@kernel.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Jackie Liu <liuyun01@kylinos.cn> 

Stephen Boyd (4):
  scripts/gdb: Find vmlinux where it was before
  scripts/gdb: Add kernel config dumping command
  scripts/gdb: Add rb tree iterating utilities
  scripts/gdb: Add a timer list command

 scripts/gdb/linux/config.py       |  48 ++++++++
 scripts/gdb/linux/constants.py.in |   8 ++
 scripts/gdb/linux/rbtree.py       | 169 ++++++++++++++++++++++++++
 scripts/gdb/linux/symbols.py      |   6 +-
 scripts/gdb/linux/timerlist.py    | 194 ++++++++++++++++++++++++++++++
 scripts/gdb/vmlinux-gdb.py        |   3 +
 6 files changed, 427 insertions(+), 1 deletion(-)
 create mode 100644 scripts/gdb/linux/config.py
 create mode 100644 scripts/gdb/linux/rbtree.py
 create mode 100644 scripts/gdb/linux/timerlist.py


base-commit: 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b
-- 
Sent by a computer through tubes

