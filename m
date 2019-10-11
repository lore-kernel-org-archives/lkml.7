Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782ADECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 11:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED81214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 11:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="J1tLsBFL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbfJKLUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 07:20:21 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:52816 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbfJKLUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 07:20:19 -0400
Received: by mail-wm1-f43.google.com with SMTP id r19so10023332wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 04:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8FUzCXKMgFlRWZSYjz6SB7CgHl35Q9I/1MXzksfCd2M=;
        b=J1tLsBFLJvqruEsBrGtzikhkMUsPFoBu7PTBR9Aor74VABITwmub6lm3lbGj3o6hx3
         sLXUnyjEw24VLTbWji8uSjR5LHxpXOd/P1faFWwu2D/2WrWzz6JLq0S/0qmjwVxhiQjK
         pKYBxuMjn8WMrCSRHLYpgXACm5gtmDyhgeyIiJ0HFVUIW0r1QiwBNstk2qoYE7jT+t7q
         +gf9D5EqFxmUmHjeYSraRQUiwB3DcGwBLqp3qwA/MNbtKyW1eb7UtElm+bkJ/rHGRZMv
         ybwGRQXkjvmpDbfd0owHx9/S5TgKYvkLtA9zl9m/l+rPJysN9JudIHF4ZS/KhodEJl+b
         Ix6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8FUzCXKMgFlRWZSYjz6SB7CgHl35Q9I/1MXzksfCd2M=;
        b=cdYvnW3bqpUoaFl0Yz253Ad/sDtuP433s+9RLcK9ZUg4Bn9UQKaOIFE7JjdPuKMa9q
         03QZEXvatJuqfetue6oJJVhFPOUm/TSlkeDYLcVdKFIg51qp53IAYJJHiTLklPHUAW+q
         iAonRzvbmrkOB/e8lli50LkPPhHd7lYVGWHIZ5YduQPt4aPx+E29Ufc/E3/qBhiQKvD2
         EM402JnD6Tj5bP9m23fCgRpPwxgX2PdBlPO8FYl+t3UC8fHd51AEmalAek5HU/ZZyPsC
         UoUuSBssr83tDqzOzkyZsMBbtsnTfo2/XzWNDjIux4KGIgWpS/vR44WLxSV9SyGCRIUq
         daSQ==
X-Gm-Message-State: APjAAAVdaj011y3VVzX1ejgPWthz/aIrN8/PL5ncFIkrvwlbQGDX4qQN
        p6WSP+66U59hnXkyFIMSChi+beakLz4=
X-Google-Smtp-Source: APXvYqwk+ygknJKIqirZvNsgW6OwfjyDNvKxMAOqWXDIZyFUBV8VLnoRDN0jpl/9Ehcp1VF9EMYkcA==
X-Received: by 2002:a05:600c:2481:: with SMTP id 1mr2690748wms.98.1570792816248;
        Fri, 11 Oct 2019 04:20:16 -0700 (PDT)
Received: from linux.fritz.box (p200300D99705BE00E22045ECB41D901D.dip0.t-ipconnect.de. [2003:d9:9705:be00:e220:45ec:b41d:901d])
        by smtp.googlemail.com with ESMTPSA id 63sm12781226wri.25.2019.10.11.04.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 04:20:15 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Cc:     1vier1@web.de, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 0/3] Clarify/standardize memory barriers for ipc
Date:   Fri, 11 Oct 2019 13:20:04 +0200
Message-Id: <20191011112009.2365-1-manfred@colorfullife.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Partially based on the findings from Waiman Long:

a) The memory barriers in ipc are not properly documented, and at least
for some architectures insufficient:
Reading the xyz->status is only a control barrier, thus
smp_acquire__after_ctrl_dep() was missing in mqueue.c and msg.c
sem.c contained a full smp_mb(), which is not required.

Patch 1: Document that wake_q_add() contains a barrier.

b) wake_q_add() provides a memory barrier, ipc/mqueue.c relies on this.
Move the documentation to wake_q_add(), instead writing it in ipc/mqueue.c

Patch 2-4: Update the ipc code, especially add missing
           smp_mb__after_ctrl_dep().

c) [optional]
Clarify that smp_mb__{before,after}_atomic() are compatible with all
RMW atomic operations, not just the operations that do not return a value.

Patch 5: Documentation for smp_mb__{before,after}_atomic().

From my point of view, patch 1 is a prerequisite for patches 2-4:
If the barrier is not part of the documented API, then ipc should not rely
on it, i.e. then I would propose to replace the WRITE_ONCE with
smp_store_release().

Open issues:
- More testing. I did some tests, but doubt that the tests would be
  sufficient to show issues with regards to incorrect memory barriers.

- Should I add a "Fixes:" or "Cc:stable"? The only issues that I see are
  the missing smp_mb__after_ctrl_dep(), and WRITE_ONCE() vs.
  "ptr = NULL".

What do you think?

--
	Manfred
