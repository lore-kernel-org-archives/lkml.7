Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD7BC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A6C22527
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wOmXzfFa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbfLLSWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 13:22:54 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:45495 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730168AbfLLSWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 13:22:54 -0500
Received: by mail-qk1-f202.google.com with SMTP id 143so1936570qkg.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 10:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=rEnziU9nLlHlYc/tf137lSRc7sdTqh5wg35Mf+C3wB0=;
        b=wOmXzfFazrugxZCYf410kz6njqqI2ZayPQ3Zp1rCCJAl61eXIHZJMLIXKd7ipcL41R
         Sm+Wcca2Q6JqgT++kdbvjzbjYq0FYVW/lmi7QB7yJwkVuo4MV424+x+d7yCwKx0ttep0
         Lptl32SFvhXt0TyRQZlvv9SqXlyRFpCG1TsG3O7/iQ2t4vkLUnHSfRpXrHshDh35/gFo
         c/KEVVI0neOaMUy1YUeklfjbepAMeO7ukOv7HLZ0ISIwDFMKd/GAqrrKh7r8JeBNqa+r
         SbafHPrcaqVH22AN6GG+pQawROsiZA4u3mp/RCCP/9BjFwd9lIMMNNZaOz5x++hHZB3m
         2fSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=rEnziU9nLlHlYc/tf137lSRc7sdTqh5wg35Mf+C3wB0=;
        b=V0PrT5Kny29qS9tFGgbbs49uPEIC7j53NB2ob7LbrrX3jGj2LpwrbfHCmfcxChelwn
         hVWACmyA8mJb4DBApR3I7XKcG5EA9LrPTqO1qWf9fRkOUfe3OijbdLFQQtKwhYcI/Zuu
         44zur+bzQC8yoa7unPdyUUbNek/PSm1fHLQXStYHoJQ7mh2rk4hY3JXoKqM+JeQv3wEz
         Y+8x1IOY6TuNMqIpTEPdzbVTk7OCcG4BopvE05yVMdV/EcPs1ZAGAz+rLGgJXqZjwb2O
         ggbyvIwuFlTsEDxk0wq9n5ThIGeHRySo6C1nhAobMzdrbjD42/qIjWQbk+qPQ9V9mgDO
         mZzQ==
X-Gm-Message-State: APjAAAUvMya4mr0WT/qGFOsJP7gD01x9WlQf9SsKYFdQeum8Glqrq2Ll
        3+ixjdA4S8IaGoRVqqZoEEICSXyA
X-Google-Smtp-Source: APXvYqzcW/ZghkfJqEYc4rFEK2YkEyqYYEYYl+bxHBfcPF4MTg+EIi+2m6XM7rKZ/g0d94tGM2bioMma
X-Received: by 2002:ac8:5308:: with SMTP id t8mr8677688qtn.51.1576174973189;
 Thu, 12 Dec 2019 10:22:53 -0800 (PST)
Date:   Thu, 12 Dec 2019 13:22:36 -0500
Message-Id: <20191212182238.46535-1-brho@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v5 0/2] kvm: Use huge pages for DAX-backed files
From:   Barret Rhoden <brho@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jason.zeng@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset allows KVM to map huge pages for DAX-backed files.

v4 -> v5:
v4: https://lore.kernel.org/lkml/20191211213207.215936-1-brho@google.com/
- Rebased onto kvm/queue
- Removed the switch statement and fixed PUD_SIZE; just use
  dev_pagemap_mapping_shift() > PAGE_SHIFT
- Added explanation of parameter changes to patch 1's commit message

v3 -> v4:
v3: https://lore.kernel.org/lkml/20190404202345.133553-1-brho@google.com/
- Rebased onto linus/master

v2 -> v3:
v2: https://lore.kernel.org/lkml/20181114215155.259978-1-brho@google.com/
- Updated Acks/Reviewed-by
- Rebased onto linux-next

v1 -> v2:
https://lore.kernel.org/lkml/20181109203921.178363-1-brho@google.com/
- Updated Acks/Reviewed-by
- Minor touchups
- Added patch to remove redundant PageReserved() check
- Rebased onto linux-next

RFC/discussion thread:
https://lore.kernel.org/lkml/20181029210716.212159-1-brho@google.com/

Barret Rhoden (2):
  mm: make dev_pagemap_mapping_shift() externally visible
  kvm: Use huge pages for DAX-backed files

 arch/x86/kvm/mmu/mmu.c | 31 +++++++++++++++++++++++++++----
 include/linux/mm.h     |  3 +++
 mm/memory-failure.c    | 38 +++-----------------------------------
 mm/util.c              | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 67 insertions(+), 39 deletions(-)

-- 
2.24.0.525.g8f36a354ae-goog

