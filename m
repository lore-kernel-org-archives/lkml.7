Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AF8C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E814920843
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SHwQE8pQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfHNIX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 04:23:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45846 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725265AbfHNIX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 04:23:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id w26so7874190pfq.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 01:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=rEnxligpiNBOZsMLUa2pNExp9uwlDBDh1X2nlxPgNEQ=;
        b=SHwQE8pQnfcqX2bqOvsQmD1HbXJdaoQyGKVRNZ6z+tUsJ4fLN8rXLNYxl+X0JlDsyK
         2kMaM/lMOc2xXiA/h9VnxbKLHQ2gWvjkoQ/Hxq3aTj9keLxc7+nlkxayPp6+KCRkxkBV
         MlTYkxHIXaoI/9rjFnQHyzaYAy3jiCv7KvwDgUCj5+yKqIHaMbr6PdF1YDF7xj18NIvR
         D76atVZQ8oLil0d+Z50nclSbSAebyq+kJHGoPCcS0jalYGtQ9gss3k2lavJdFFPo4cQE
         7zq2rpa2XGm7daqS70jw/TtoSV8CU6RV9FqTFHNOH/NtOczod4yYn7r6cju4xr0gbMeq
         6ujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rEnxligpiNBOZsMLUa2pNExp9uwlDBDh1X2nlxPgNEQ=;
        b=J/pLQzW9eVFoWRikV1aSMjub7uT/S/iN1duMRLT9bboZRPnJ3pwAzq7K1Rj4IOCn76
         +SsINlLT8UtHEib2royrGKrWTyYyWpiAG5KqoA3PTZGExmHC3wvQdzej6Xksw7aQVumI
         Uv+tERJLcWFitTYnp3rYOTdxGG4vz3I/KvRG0MDt9TSRYAB0x5ZHNDogH5dmZtGPRNb6
         GFsg2kHrJV0jfwdzHxasd+d2dw6f8GhvdXbMpEAfikblrVOhVdna3IclkQERSsodSkaa
         7fwX9O/YE+aqW9OV+LAnz+xg3pVQATWKiOBIBC7QpPz8ypXCzE4RUDfNi3pFtK/bsiTK
         n9Pw==
X-Gm-Message-State: APjAAAVnb/Q5jGiQcjXL13+0bWFRz1fIUlRLkKqk0w/C7UPStyFrV7d/
        c1JPZN4m2rpb/igFTkC/YePxgg==
X-Google-Smtp-Source: APXvYqz10BPXPgKiDc0RpVCnD3PYHGcpBN5kEMkQijEKA/0/TENqixTu5pwCdRQNUi28WT68mgnxxg==
X-Received: by 2002:a63:2c8:: with SMTP id 191mr37355432pgc.139.1565771037551;
        Wed, 14 Aug 2019 01:23:57 -0700 (PDT)
Received: from localhost.localdomain (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id f205sm12359152pfa.161.2019.08.14.01.23.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Aug 2019 01:23:56 -0700 (PDT)
From:   Vincent Chen <vincent.chen@sifive.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vincent Chen <vincent.chen@sifive.com>
Subject: [PATCH v2 0/2] riscv: Correct the initialized flow of FP and __fstate_clean()
Date:   Wed, 14 Aug 2019 16:23:51 +0800
Message-Id: <1565771033-1831-1-git-send-email-vincent.chen@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following two reasons cause FP registers are sometimes not
initialized before starting the user program.
1. Currently, the FP context is initialized in flush_thread() function
   and we expect these initial values to be restored to FP register when
   doing FP context switch. However, the FP context switch only occurs in
   switch_to function. Hence, if this process does not be scheduled out
   and scheduled in before entering the user space, the FP registers
   have no chance to initialize.
2. In flush_thread(), the state of reg->sstatus.FS inherits from the
   parent. Hence, the state of reg->sstatus.FS may be dirty. If this
   process is scheduled out during flush_thread() and initializing the
   FP register, the fstate_save() in switch_to will corrupt the FP context
   which has been initialized until flush_thread().
In addition, the __fstate_clean() function cannot correctly set the state
of sstatus.FS to SR_FS_CLEAN. These problems will be solved in this patch
set.

Changes since v1:
- Remove unneeded braces
- Remove unneeded ifdef condition
- Make the correction for __fstate_clean() be a RC fix

Vincent Chen (2):
  riscv: Correct the initialized flow of FP register
  riscv: Make __fstate_clean() work correctly.

 arch/riscv/include/asm/switch_to.h |  8 +++++++-
 arch/riscv/kernel/process.c        | 11 +++++++++--
 2 files changed, 16 insertions(+), 3 deletions(-)

-- 
2.7.4
