Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84399C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53CDB218B8
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZmFoFiuF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731797AbfHHIAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 04:00:02 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34135 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731548AbfHHIAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 04:00:02 -0400
Received: by mail-pf1-f195.google.com with SMTP id b13so43641123pfo.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 01:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Mj0NlYSUurL6xj8Jw3i+0MeK0CDZOCR1M77+F9BwytE=;
        b=ZmFoFiuFuEhRJV21WykRlWUovgwSUqqTFjQJtAVC3DZs9ENOnjbPjAb/yiWK8PreJ8
         c2mnbTcpUBkOX5yrPYDjGZT1Atk+5/zgQaUFCvL7xOTjHJaUQ9YcfwQOu3g3oSiZW+AM
         9m5gSVyyGv6FgsMCoj8O0sMg0tUx/sRahn1yQpLFeilUzMGBBsP3NwtpnfxYKO2UEj4v
         H0MkwgSVoHQh77whMNTwaSX+OVH8ZSwQ0rCGvmMl2mIMVJTdv0caL7Dq6hTVDTkSf9Wa
         Rkq+pjCFxwGS8VABoAYUgIea2CilG2bMTvG9f0NFLJlA0sybY7IR89paSM0ySD0Qp4Yr
         vT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Mj0NlYSUurL6xj8Jw3i+0MeK0CDZOCR1M77+F9BwytE=;
        b=CcfF1YwPktD02ylf6gTKbqE/KLPNNtN7zfezMDjimBRXwlADpA752HL6tSRT3EZwU0
         0SdsClXtw40KlTRTY6VH1/OY6NoCutIw2MvfJ4nqnGhXIyB6PxdBmqFQJBnaM2Kv/uPD
         oHjvH9MuYgvZmfmOYfZp8/oAdc75Q7e2hyjStL/G7gur2Fpvme7SA6qdzRUxxI5OfGIk
         LVQrRX3i9I2Iv9cYwGdU6+UEZ5Bf2HjOHmU3WZKhICnCFctmkUdtV1R+QTGZz/teDsJG
         T6eaE1WODHwpVEXngG0vAnwVagigQcscxeWwO3V03Oy/mJUP0g7W2zgu4+T7vqXAeB3X
         LQ+w==
X-Gm-Message-State: APjAAAVqH6MxZIRZ+bH2GuG/NWL7VJz/J6+2QGw8MhlW5kyJhWUXkl8F
        YZasoUrqBXPpbMVU2QCDJoRc5uhoozs=
X-Google-Smtp-Source: APXvYqxzsjhUdbzOD9DNeF+PAk9GYhVZrZl1qUjHVEGtASrf1qnduOun6cNSSC0pt796s6zLw6HNjQ==
X-Received: by 2002:a17:90b:8e:: with SMTP id bb14mr2717479pjb.19.1565251201455;
        Thu, 08 Aug 2019 01:00:01 -0700 (PDT)
Received: from localhost.localdomain (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id t8sm107697374pfq.31.2019.08.08.00.59.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Aug 2019 01:00:01 -0700 (PDT)
From:   Vincent Chen <vincent.chen@sifive.com>
To:     paul.walmsley@sifive.com, palmer@sifive.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vincent Chen <vincent.chen@sifive.com>
Subject: [PATCH 0/2] riscv: Correct the initialized flow of FP and __fstate_clean()
Date:   Thu,  8 Aug 2019 15:58:39 +0800
Message-Id: <1565251121-28490-1-git-send-email-vincent.chen@sifive.com>
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


Vincent Chen (2):
  riscv: Correct the initialized flow of FP register
  riscv: Make __fstate_clean() can work correctly.

 arch/riscv/include/asm/switch_to.h |  8 +++++++-
 arch/riscv/kernel/process.c        | 13 +++++++++++--
 2 files changed, 18 insertions(+), 3 deletions(-)

-- 
2.7.4

