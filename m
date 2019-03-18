Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE336C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC1E62082F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtZw4YS4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfCRI5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:57:45 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35709 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfCRI5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 04:57:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id j5so10825948pfa.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 01:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xdhJJTOmLFcIyR3G22o8Q4zyTp0bAohpDv+K4rQQaFo=;
        b=OtZw4YS4WDOKxIugvIKPCAdJmHXvn0iS4oHGoqCqiPtQUtEf82jK/35uCCnUc3fWmK
         4Tf47nzan+rTOs1r98BuTft9QYSQaLkki1u3bgODMKyyCL2w0R8O7LAvH73+/awB1Cjv
         lfwetqpaOOwG8xzSku1wwRchWxOS1685yomZf/wNoYOfMfdTDspYxL/pXOQXAvYBUgWk
         sEF8B/ZB69UbP+tltNoYqnK8rS5DgpnKZOaMQeSTGEtXe1Pmd8R5sTqTCOuK2XUA5Epm
         7vjP+CWFjbL6fsIBIKHL+a3ej9Rj7gtWGss6/jg1T/U6RlAEYMCScbmhnsz1HP7AtVw0
         TcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xdhJJTOmLFcIyR3G22o8Q4zyTp0bAohpDv+K4rQQaFo=;
        b=YfK4ld9z3bHsjBq3TyU485rFknrBjMiyhz6l8/+1H7za6dnqtud/P/jgQVLzBdDVbu
         OuRVaUNj3hQ7625v14b5uBjhOGQh/gTyM+u493QhASRex/P2phUNaZGHa7SE/b3OsjhV
         dCjM+OJIxaW+DA4mrc3Zmy4fHznbLbrzkRzJLBYmdcUzgFgJY3Vm+0y2V5xMelD3X653
         p//BdrKJcFtsy6r7n9AZGYLp1abQj/+pcx+rwsm149cN6ktyXojvcANiX9tNUhsW3bej
         JQOL4A2xju6fFqlO43ium7XHLqykxhONl2QRvph+NTL4JqkPKBdcTbvq3Skjg/1D4/d2
         1n4g==
X-Gm-Message-State: APjAAAUGm3PCYIKjm1D61B3KsKytwGdqwzVCtMbz0iCZ7J0otYcBJ7wA
        tckYQPvPOLp7WbrrE8MxymE=
X-Google-Smtp-Source: APXvYqzfCWoN/IgHoX0ErHxeGi46JKheeDn2YTvvwxYyFJOLbarwYU2qO1FmBZjCYODHklYTGo7Mqw==
X-Received: by 2002:a17:902:b097:: with SMTP id p23mr18611408plr.36.1552899463784;
        Mon, 18 Mar 2019 01:57:43 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id k8sm11147024pgq.37.2019.03.18.01.57.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 01:57:43 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 00/19] locking/lockdep: Add comments and make some code
Date:   Mon, 18 Mar 2019 16:57:14 +0800
Message-Id: <20190318085733.3143-1-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

I recently looked at some system hang issues. While at it, I tried to use
and understand lockdep. These patches are made as a result. I believe they
should have helped me, so hopefully they do for others as well.

Change from v1:
- Rebased the patch series.
- Added more no-functional-change patches.
- Removed zapped locks in lock chains printing patch, which was a band-aid.
  The real problem was recently fixed by Bart.

Thanks,
Yuyang

--

Yuyang Du (19):
  locking/lockdep: Change all print_*() return type to void
  locking/lockdep: Add description and explanation in lockdep design doc
  locking/lockdep: Adjust lock usage bit character checks
  locking/lockdep: Remove useless conditional macro
  locking/lockdep: Adjust indents for function definitions
  locking/lockdep: Print the right depth for chain key colission
  locking/lockdep: Update obsolete struct field description
  locking/lockdep: Use lockdep_init_task for task initiation
    consistently
  locking/lockdep: Define INITIAL_CHAIN_KEY for chain keys to start with
  locking/lockdep: Change the range of class_idx in held_lock struct
  locking/lockdep: Remove unused argument in validate_chain()
  locking/lockdep: Update comment
  locking/lockdep: Remove unnecessary function pointer argument
  locking/lockdep: Change type of the element field in circular_queue
  locking/lockdep: Remove __cq_empty()
  locking/lockdep: Use function pointer to avoid constant checks
  locking/lockdep: Combine check_noncircular and check_redundant
  locking/lockdep: Update comments on dependency search
  locking/lockdep: Change if to else-if when checking bfs errors

 Documentation/locking/lockdep-design.txt |  89 +++--
 include/linux/lockdep.h                  |  26 +-
 init/init_task.c                         |   2 +
 kernel/fork.c                            |   3 -
 kernel/locking/lockdep.c                 | 573 +++++++++++++++++--------------
 kernel/locking/lockdep_internals.h       |   1 +
 6 files changed, 391 insertions(+), 303 deletions(-)

-- 
1.8.3.1

