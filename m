Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46EFC432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 19:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822F1217D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 19:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575314808;
	bh=vzC7nFUG+Iij71F4J55YJFBJ5Wz1ttGu7+TKkHK8RpQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=YpoUZfRAXPKnqD+dw6gEFeA5Gl49fW2sNvQMYkjHM1f3+lA8LpJeaXXhmr211qSJy
	 ieIvrGXaQQnlQtbi6cUx42XWzEoRX5KE3Mx87yFx/nQt9mdl0atKMWnoDKulwXg8rF
	 1xVql5UnPClv5BwzwbMeSO99H+dYEdbpHD2hJowo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbfLBT0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 14:26:47 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:46166 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbfLBT0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 14:26:47 -0500
Received: by mail-qv1-f67.google.com with SMTP id t9so317184qvh.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 11:26:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=sRC578IzxYpnWQw6x6fP98N8MlOa2CYbZCkgjfiYCog=;
        b=OU4xEpz+6oFHsp0qcnkq8VuIDLX/oFC2rU5BuXlmOTv+ZuVUZte9fp9caANExUPOWd
         GiM3zVjUSkhN0wmxodnKg3dL+pQkBmGZGctO9m/lxnJ9JPh6AlTlRbZOlJAovnoxQPId
         hg/o1Ih1ntO05Jl9ppQjm5VM2qraflAK2HMzixPg0ispbJobcXfIc0sPFHLVFpyPIIKh
         DLr2kgnfENnI2cmu/TKclK8mmi1d5IyZMTumFkgDkCfzKHID7K+naWkOtZc2S8qd54Te
         4j31+QweNeAl80Vsxp3LjseJbyUaEQOO9tb1kiUj6kOOuFz3FqcZfJXzKaGKVepEACeT
         ILgw==
X-Gm-Message-State: APjAAAXwXUicvlg2tw16hdl35d159UhHYU+Bi5a5mESZDekg1FjzXsyk
        639CENLCDUQGjxpJBob/FI0=
X-Google-Smtp-Source: APXvYqxC6MUdKhcZCNnymc7mHDpEnf3nE/+STk6uqyB6Ap66XIGy055VTTmeEjxkfiC7Iq0gIoU5fA==
X-Received: by 2002:a05:6214:5ac:: with SMTP id by12mr758100qvb.74.1575314806019;
        Mon, 02 Dec 2019 11:26:46 -0800 (PST)
Received: from dennisz-mbp ([2620:10d:c091:500::3:2086])
        by smtp.gmail.com with ESMTPSA id u24sm307708qkm.40.2019.12.02.11.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 11:26:45 -0800 (PST)
Date:   Mon, 2 Dec 2019 14:26:43 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] percpu changes for v5.5-rc1
Message-ID: <20191202192643.GA19946@dennisz-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This pull request has a change to fix percpu-refcount for RT kernels
because rcu-sched disables preemption and the refcount release callback
might acquire a spinlock.

In the works is to add memcg counting for percpu by Roman Gushchin. That
may land in either for-5.6 or for-5.7. There is also some sparse
warnings that we're sorting out now.

Thanks,
Dennis

The following changes since commit 4f5cafb5cb8471e54afdc9054d973535614f7675:

  Linux 5.4-rc3 (2019-10-13 16:37:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.5

for you to fetch changes up to ba30e27405afa0b13b79532a345977b3e58ad501:

  Revert "percpu: add __percpu to SHIFT_PERCPU_PTR" (2019-11-25 14:28:04 -0800)

----------------------------------------------------------------
Ben Dooks (1):
      percpu: add __percpu to SHIFT_PERCPU_PTR

Dennis Zhou (1):
      Revert "percpu: add __percpu to SHIFT_PERCPU_PTR"

Sebastian Andrzej Siewior (1):
      percpu-refcount: Use normal instead of RCU-sched"

 include/linux/percpu-refcount.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
index 7aef0abc194a..390031e816dc 100644
--- a/include/linux/percpu-refcount.h
+++ b/include/linux/percpu-refcount.h
@@ -186,14 +186,14 @@ static inline void percpu_ref_get_many(struct percpu_ref *ref, unsigned long nr)
 {
 	unsigned long __percpu *percpu_count;
 
-	rcu_read_lock_sched();
+	rcu_read_lock();
 
 	if (__ref_is_percpu(ref, &percpu_count))
 		this_cpu_add(*percpu_count, nr);
 	else
 		atomic_long_add(nr, &ref->count);
 
-	rcu_read_unlock_sched();
+	rcu_read_unlock();
 }
 
 /**
@@ -223,7 +223,7 @@ static inline bool percpu_ref_tryget(struct percpu_ref *ref)
 	unsigned long __percpu *percpu_count;
 	bool ret;
 
-	rcu_read_lock_sched();
+	rcu_read_lock();
 
 	if (__ref_is_percpu(ref, &percpu_count)) {
 		this_cpu_inc(*percpu_count);
@@ -232,7 +232,7 @@ static inline bool percpu_ref_tryget(struct percpu_ref *ref)
 		ret = atomic_long_inc_not_zero(&ref->count);
 	}
 
-	rcu_read_unlock_sched();
+	rcu_read_unlock();
 
 	return ret;
 }
@@ -257,7 +257,7 @@ static inline bool percpu_ref_tryget_live(struct percpu_ref *ref)
 	unsigned long __percpu *percpu_count;
 	bool ret = false;
 
-	rcu_read_lock_sched();
+	rcu_read_lock();
 
 	if (__ref_is_percpu(ref, &percpu_count)) {
 		this_cpu_inc(*percpu_count);
@@ -266,7 +266,7 @@ static inline bool percpu_ref_tryget_live(struct percpu_ref *ref)
 		ret = atomic_long_inc_not_zero(&ref->count);
 	}
 
-	rcu_read_unlock_sched();
+	rcu_read_unlock();
 
 	return ret;
 }
@@ -285,14 +285,14 @@ static inline void percpu_ref_put_many(struct percpu_ref *ref, unsigned long nr)
 {
 	unsigned long __percpu *percpu_count;
 
-	rcu_read_lock_sched();
+	rcu_read_lock();
 
 	if (__ref_is_percpu(ref, &percpu_count))
 		this_cpu_sub(*percpu_count, nr);
 	else if (unlikely(atomic_long_sub_and_test(nr, &ref->count)))
 		ref->release(ref);
 
-	rcu_read_unlock_sched();
+	rcu_read_unlock();
 }
 
 /**
