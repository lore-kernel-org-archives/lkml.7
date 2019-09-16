Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0C7C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 11:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D9192067D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 11:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568634076;
	bh=ItIEi264BmnPHmxlri53zlCN6O9JWYJQ90U5gpYQpic=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=rACw9+PJBPRnYOjkRyUqD/vK4uy3YpxJobvEvRLgLDS0NnkLJhNlQz+Tk2XKtFmXg
	 6zw1L2TK7mrEJwqcTpFnoUw4/K55b67dwD+WJ3Z1vR061Fk8tYrASCY010HkBBhigO
	 H5NKJaXN0gb48hFD8PpFKTNI/yFzWcH8lY8xgCaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732099AbfIPLlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 07:41:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33476 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfIPLlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 07:41:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id b9so4920374wrs.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 04:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7Os/u0VdItyExV9ZxI/ioj3/7STwp91iuWfVjfmjBEo=;
        b=eCK9ZVVsGFi35pIdsP+P4AM0/4YMdYXVhkGvEBmIHrioAGL1N5SnoOTmERIoTogKWI
         IjQxdR+LStmWKYZbLfLvGkBPLSiGIOUE+zzQB+sGCoIPH/SDn05TMqS+01kUBD10SKzW
         SXtjDW4viRFD+csBw6zEqGpRJXa6abtaPoIVRIaFW81O/+vlyyZq6R3gnaG614eKh11H
         YEbD5UxkU2mPUOlx/eLw4nHVOTw4v0hl1kxbo5AVgt70G9YFVisubT0zotATU924tknB
         30uE7xJAgl98V6c3VInHwRgVNOz03wso4mA+kaOa1TbMLxmrqbVN0DiIETtwflxj2ikc
         u99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=7Os/u0VdItyExV9ZxI/ioj3/7STwp91iuWfVjfmjBEo=;
        b=B3Acrl2u6tuY1mYJERHDJHJklDXc8LGOvIX5gnVOI0JlEXdhnRhrYoyWaiIn1gDoxp
         JT4b2YiRqtOS5MqFNlWEDQC5/h+C/U4EY+bU6n5lZv5ykjA8S6/NB71lggmET9UeX+yV
         2Oo1/BN6Uiztw+ML5l8etCwZe21DPos7pYfCC+/qsyTuSDcwtnVEkuP6eVjtiYA/ieeA
         abzYvSHWjdmwEZ9s1n58FzAbuBPETlfeAJdzHWE7DO55flSagrDLoPHbD15RsAHtFm1h
         36z2vLgQ8HqBJTIx84mMYtW1YuKWKnMB3ZOQUf0EQ8vUbnkRVnJiZBYWqYFRtRHqveTg
         zXgw==
X-Gm-Message-State: APjAAAVfPlryOgFSNza9LJasoCVFChIp8fjLJLSim+fU0kNk+CF39CzW
        NXANf8KBsYtVqzVCM1LPd3jhHvdu
X-Google-Smtp-Source: APXvYqwGRtQFeRVc7vFcAShgepBSr7tloe2fkzchqmnLZsf02/6C7wk31nKULcuox7N7jFB6r+pXMQ==
X-Received: by 2002:adf:f00b:: with SMTP id j11mr8571430wro.298.1568634072744;
        Mon, 16 Sep 2019 04:41:12 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id q25sm13770415wmq.27.2019.09.16.04.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 04:41:12 -0700 (PDT)
Date:   Mon, 16 Sep 2019 13:41:10 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] locking changes for v5.4
Message-ID: <20190916114110.GA128086@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest locking-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-for-linus

   # HEAD: e57d143091f1c0b1a98140a4d2e63e113afb62c0 mutex: Fix up mutex_waiter usage

This cycle's changes were:

 - Improve rwsem scalability
 - Add uninitialized rwsem debugging check
 - Reduce lockdep's stacktrace memory usage and add diagnostics
 - Misc cleanups, code consolidation and constification

 Thanks,

	Ingo

------------------>
Bart Van Assche (4):
      locking/lockdep: Make it clear that what lock_class::key points at is not modified
      stacktrace: Constify 'entries' arguments
      locking/lockdep: Reduce space occupied by stack traces
      locking/lockdep: Report more stack trace statistics

Davidlohr Bueso (1):
      locking/rwsem: Check for operations on an uninitialized rwsem

Mukesh Ojha (2):
      locking/mutex: Make __mutex_owner static to mutex.c
      locking/mutex: Use mutex flags macro instead of hard code

Peter Zijlstra (2):
      locking/qspinlock,x86: Clarify virt_spin_lock_key
      mutex: Fix up mutex_waiter usage

Waiman Long (1):
      locking/rwsem: Make handoff writer optimistically spin on owner


 arch/x86/include/asm/qspinlock.h   |  15 ++++
 include/linux/lockdep.h            |  11 +--
 include/linux/mutex.h              |  25 +-----
 include/linux/rwsem.h              |  10 +++
 include/linux/stacktrace.h         |   4 +-
 kernel/locking/lockdep.c           | 159 ++++++++++++++++++++++++++++---------
 kernel/locking/lockdep_internals.h |   9 ++-
 kernel/locking/lockdep_proc.c      |   8 +-
 kernel/locking/mutex.c             |  26 ++++++
 kernel/locking/rwsem.c             |  54 ++++++++++---
 kernel/stacktrace.c                |   4 +-
 11 files changed, 241 insertions(+), 84 deletions(-)
