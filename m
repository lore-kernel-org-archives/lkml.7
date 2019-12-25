Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5F2C2D0DA
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 16:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5782072A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 16:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7dgdOh8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfLYQGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 11:06:30 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41645 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfLYQGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 11:06:30 -0500
Received: by mail-pf1-f193.google.com with SMTP id w62so12102647pfw.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Dec 2019 08:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gSfzJ6ds8IXkEBlYekF/JAP35cE9VK7DVuScN5rtr4Q=;
        b=A7dgdOh8g5N+5kh1Nip9xO4MOjiOO1NC9oH4BnLHzUEL2fsL79kLU1+F8zs4r4Esgc
         vt9uqhl0x6oOcXLODLAdn806O93r9fUjdQ7eLoLnM0oRJnVd4oCZpJuVplmXE8kwwOzP
         oOoZJ5yBr30pbzmZxmLzvIVp1gb3Bo774Tdp2gaW8BOpzFyVlDBuLwAknHlLXNN4jVSL
         b3zSNzbSXu2zneY79KuJy2JT0qkV8ph/9XFXFFyxx69pZwnh73sk2unq5yYZqMb2cbC2
         oDiGYKCmOQ4qX336e6ckeW1ZDDQTjAlWHi+8h5pwqGPHD62h1zPJe5Z4v+X9dVnznV01
         NWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=gSfzJ6ds8IXkEBlYekF/JAP35cE9VK7DVuScN5rtr4Q=;
        b=lw12EaJLrbP9eeQolItUUQseMTyts9XLDJn6FWMfZLiOifexwtfPosTzmQDER7Av8w
         FvTQ5vjurcgkfWQ3/081vim+nHaPPaaHsrIHV+n3o0KvozfRl2f17KHECaNZoyg/xt7m
         Ers3JUScvxFq/ooz6yWYU98/NxOYV55aLvpPvBscX+6XvoNUPWUwPl2P4OjIXhhCn99v
         MAFK+NRhipwIG2PRxIkFwfw7je8K1sgQcfqXtUaZpOiMRP1U507Kvmce3mUYQTOsH1nR
         snurwYgr/jytU3dKKwNzioAmoFhZECVBegdBT+xzMBdM1FiLwyAXPTAN9Mgg2YRpIKvF
         lt0A==
X-Gm-Message-State: APjAAAWwdw3El6kwGOinUeU1QFoNEmnjX2BfWpsP1xicukc7zLH17bLw
        jQBompErjOJIL9uCosarYsy3UYpc
X-Google-Smtp-Source: APXvYqyxeBrcyEJVROE3Qu5C3iF+WCirFJ1Gck5i/SgcUM2Blnu+Sf/LotuqHbPg5QD1kJmrsYrN6Q==
X-Received: by 2002:a63:2ad8:: with SMTP id q207mr43853722pgq.45.1577289989451;
        Wed, 25 Dec 2019 08:06:29 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z30sm33510680pff.131.2019.12.25.08.06.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Dec 2019 08:06:28 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Guenter Roeck <linux@roeck-us.net>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Phil Auld <pauld@redhat.com>, Waiman Long <longman@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH] powerpc/shared: Fix build problem
Date:   Wed, 25 Dec 2019 08:06:26 -0800
Message-Id: <20191225160626.968-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 656c21d6af5d ("powerpc/shared: Use static key to detect
shared processor") and 14c73bd344da ("powerpc/vcpu: Assume dedicated
processors as non-preempt"), powerpc test builds may fail with the
following build errors.

./arch/powerpc/include/asm/spinlock.h:39:1: error:
	type defaults to ‘int’ in declaration of ‘DECLARE_STATIC_KEY_FALSE’
./arch/powerpc/include/asm/spinlock.h: In function ‘vcpu_is_preempted’:
./arch/powerpc/include/asm/spinlock.h:44:7: error:
	implicit declaration of function ‘static_branch_unlikely’
./arch/powerpc/include/asm/spinlock.h:44:31: error:
	‘shared_processor’ undeclared

The offending commits use static_branch_unlikely and shared_processor
without adding the include file declaring it.

Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Phil Auld <pauld@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Juri Lelli <juri.lelli@redhat.com>
Fixes: 656c21d6af5d ("powerpc/shared: Use static key to detect shared processor")
Fixes: 14c73bd344da ("powerpc/vcpu: Assume dedicated processors as non-preempt")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/powerpc/include/asm/spinlock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index 1b55fc08f853..5ddd48616b1c 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -16,6 +16,7 @@
  * (the type definitions are in asm/spinlock_types.h)
  */
 #include <linux/irqflags.h>
+#include <linux/jump_label.h>
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
 #include <asm/hvcall.h>
-- 
2.17.1

