Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9383FC46460
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 07:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5E0217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 07:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfEJHV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 03:21:29 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37010 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbfEJHV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 03:21:28 -0400
Received: by mail-qk1-f195.google.com with SMTP id c1so1749589qkk.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 00:21:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qkp3uN3JmIP+V4STFBMw4M1itzMyk7qqDLAq1F6TTQI=;
        b=GjkLfSJVj2Ed4Dth/vTbrupIdXHvfVxVbpZsi+q6L2SQP0bd/fR4RkKnU7bYDUQLHL
         tYK+nwMHpCVEKVGcceqizz11yWTfW7DF2LgxylD8NoocJ6oDZQBuO1mIP5lRYeVgT6Fk
         jyNluntZ+PPzKYS57wszdjggejYD6RmlGDe0B2mlzsqCzGQf4BHS7sO+yndRjMp8MgKt
         avLes4GhWwQ4W4lw//9hkuLm3YIv5c+lpTFDsdk1z+BTWFPgleqCDKRA8jFRbMOD+xtH
         r8seWpVOTmB2h6CGyWvH+zDZCgo+pWnG/lZbDnqJi319bzZihhPI3sUfVxWFMlMlxv0y
         pGXw==
X-Gm-Message-State: APjAAAUfpQG83saWBVa37vPBW+pDqKavIvHHiWI0Ia9fHkOeSiG09qyD
        IznFLpfvZjqmRVh63U9ZS/cVH9aeqBT1ZA==
X-Google-Smtp-Source: APXvYqxQmGrUW/No6yN8KlnGJEV4Aj+h/RJzKqJ9tg+pnXf3scxoRahou77rSE4Udu+LioHkCbnimQ==
X-Received: by 2002:a37:a216:: with SMTP id l22mr7397641qke.282.1557472887500;
        Fri, 10 May 2019 00:21:27 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id t57sm521405qtt.7.2019.05.10.00.21.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 00:21:26 -0700 (PDT)
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>, linux-mm@kvack.org
Subject: [PATCH RFC 0/4] mm/ksm: add option to automerge VMAs
Date:   Fri, 10 May 2019 09:21:21 +0200
Message-Id: <20190510072125.18059-1-oleksandr@redhat.com>
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

Instead, lets implement a so-called "always" mode, which allows marking
VMAs as mergeable on do_anonymous_page() call automatically.

The submission introduces a new sysctl knob as well as kernel cmdline option
to control which mode to use. The default mode is to maintain old
(madvise-based) behaviour.

Due to security concerns, this submission also introduces VM_UNMERGEABLE
vmaflag for apps to explicitly opt out of automerging. Because of adding
a new vmaflag, the whole work is available for 64-bit architectures only.

This patchset is based on earlier Timofey's submission [1], but it doesn't
use dedicated kthread to walk through the list of tasks/VMAs.

For my laptop it saves up to 300 MiB of RAM for usual workflow (browser,
terminal, player, chats etc). Timofey's submission also mentions
containerised workload that benefits from automerging too.

Open questions:

  * once "always" mode is activated, should re-scan of all VMAs be
    triggered to find eligible ones for automerging?

Thanks.

[1] https://lore.kernel.org/patchwork/patch/1012142/

Oleksandr Natalenko (4):
  mm/ksm: introduce ksm_enter() helper
  mm/ksm: introduce VM_UNMERGEABLE
  mm/ksm: allow anonymous memory automerging
  mm/ksm: add automerging documentation

 .../admin-guide/kernel-parameters.txt         |   7 +
 Documentation/admin-guide/mm/ksm.rst          |   7 +
 fs/proc/task_mmu.c                            |   3 +
 include/linux/ksm.h                           |   5 +
 include/linux/mm.h                            |   6 +
 include/trace/events/mmflags.h                |   7 +
 mm/ksm.c                                      | 142 ++++++++++++++----
 mm/memory.c                                   |   6 +
 8 files changed, 157 insertions(+), 26 deletions(-)

-- 
2.21.0

