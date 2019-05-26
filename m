Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F009CC46470
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 21:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C713321707
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 21:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcR3EHVi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfEZVWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 17:22:24 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46022 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfEZVWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 17:22:24 -0400
Received: by mail-lj1-f195.google.com with SMTP id r76so2156758lja.12
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 14:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vtj4XT/ZctSQODcPHrULbEup14IpWl4DXPhGkbiblZ8=;
        b=kcR3EHViTkCoCb1N2awgeF9OeRkJWwcfKpP07EdHbgyQFo8vKpDK0aRXM3GwhZPsaj
         Z0ntvNWKQGs9mtvVsyfw3I+9a7Jc2eTG4JvkKEsa2afeWbWuiQHpxAhZ4v/H1nY/eK/0
         bRq0tZqa2NrOSVYRjTyw6PdpDSymSqWnk+ZYABf64kbagoHIhSDdtxhjrwfPM+dL9dwA
         pl5BmPtTUEeag4LXamYdkIQkCOknqfDbZQJfQCKPIHkVhpIrBNVtVmOqzYfp1FZ/EkIb
         nR29zqmU2Il2oqY0oTm/4AIf4+o9BVd3tY5nUfIJPT5HawBq8EWTenEaljGBnrKD4sNB
         3Ttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vtj4XT/ZctSQODcPHrULbEup14IpWl4DXPhGkbiblZ8=;
        b=BxKoC9yoZ3W6qDBkglAGCav58WzBYloxNjI5DktGrM3SKQVm0oz6Z5juK7ullCGqxZ
         DTZaSrkJ/AYe/cqBCQun+BLasSD6tMgp/KOiKaLXRLZLmL6HfW8z31IBgGR0O7shyVeH
         j8Q+O//13leHvlvF+cjU2pSGE+MJHUlFj4RJxljXEEzupK1XzT4q0hg3Vxtn67J6KFUT
         4Y42D5yO4oMW/6pWfqfTBPlUtY451vkLl7Rd2Z+PaUeqkQt1JHQG2Dg/v77rP1Oq5kDa
         cXTIbS/5yjpyFHgRJPPFfgUh6xe6HXdhnkIjxKGBWVglnD5c/t5JjyH/kEOyaM1dfb2o
         WYjw==
X-Gm-Message-State: APjAAAWbOgXv3H/OwxdeNB9y+3Yrwf3A4VHFVoOf4ccS1TufAWPX5q1q
        PVEG4F4h/9CHaH26WtClP9qTBPGZbBw=
X-Google-Smtp-Source: APXvYqzar+sCX4oRkXtYVKukzADiEbq3x2cKytb+az/edc4sgrVA4QR/aBDDj3wxFRa5uyMImh0XsA==
X-Received: by 2002:a2e:90d1:: with SMTP id o17mr45693469ljg.187.1558905742256;
        Sun, 26 May 2019 14:22:22 -0700 (PDT)
Received: from pc636.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id y4sm1885105lje.24.2019.05.26.14.22.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 14:22:21 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Roman Gushchin <guro@fb.com>, Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 0/4] Some cleanups for the KVA/vmalloc
Date:   Sun, 26 May 2019 23:22:09 +0200
Message-Id: <20190526212213.5944-1-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch [1] removes an unused argument "node" from the __alloc_vmap_area()
function and that is it.

Patch [2] is not driven by any particular workload that fails or so,
it is just better approach to handle one specific split case.

Patch [3] some cleanups in merging path. Basically on a first step
the mergeable node is detached and there is no reason to "unlink" it.
The same concerns the second step unless it has been merged on first
one.

Patch [4] moves BUG_ON()/RB_EMPTY_NODE() checks under "unlink" logic.
After [3] merging path "unlink" only linked nodes. Therefore we can say
that removing detached object is a bug in all cases.

v1->v2:
    - update the commit message. [2] patch;
    - fix typos in comments. [2] patch;
    - do the "preload" for NUMA awareness. [2] patch;

Uladzislau Rezki (Sony) (4):
  mm/vmap: remove "node" argument
  mm/vmap: preload a CPU with one object for split purpose
  mm/vmap: get rid of one single unlink_va() when merge
  mm/vmap: move BUG_ON() check to the unlink_va()

 mm/vmalloc.c | 116 +++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 90 insertions(+), 26 deletions(-)

-- 
2.11.0

