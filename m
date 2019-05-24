Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D271DC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29CB121773
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Hru5M1+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390531AbfEXKf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 06:35:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33281 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389448AbfEXKf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 06:35:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id d9so9492152wrx.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 03:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=njauMCJ2o1/GsnZ2mPeYOiP+YI83chYuXOrhyQtPV2M=;
        b=Hru5M1+bFuLqBXipwVL2/tEtOL/OtEx3FfYSgOWmgjXRA6dLOeH7ftsHBfQvooSUhW
         wOktU1Vsg7mrFiljLdYvYKym6cUf2gXXkBYQQghCH0Qek2YnYyzk65DxP/TLjWfClk2z
         d8QYG7bXQwnPbdm+nWcEhHjzEhyGYCbHF+UKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=njauMCJ2o1/GsnZ2mPeYOiP+YI83chYuXOrhyQtPV2M=;
        b=Rj/BHauAMMWRNPl3XLKZ/Crsff5urySQBKxB4rDvCTA+mEL2p2ql1oruWl1a/EMNUv
         3RFm+Fr4s7Cqg4JlLxhA4R+V/PisnI6z6qV2KYxAsZzUg3iLLRAJiovz93OFIDHdQXfB
         KRzq/WfADnzi7r+I15ACk0xEIJcEe3KaUWXMrF7E6cc77bynoDwFVATZGXKVhccAzYZc
         WA7YOi3ISn6n5Q8aWqmJr1ja2LpRONCcE2tblQexunmnvJi/w3MOtr8JbdlIY17MxhsW
         ZI8P4vfXdwDTkgDW0gvoSj+EFvvVLQD9wXx8h5zo3ouovmuDuD1u5pB/H9pvav/oNcEI
         OOnA==
X-Gm-Message-State: APjAAAX8UoT2FeZtmnktFF/yFpKlIjIH8Y4wyutcu/PpWEsF8S7LO3gh
        c35ufi7CRpP7znpE5uyVMY6nUAn0/k2ojw==
X-Google-Smtp-Source: APXvYqymSOvRTe+J1h7dpzi/nvT3l56pi2Q0/g+JC6fOANr4pHoOUwoVnNfxrnU18CWAomssiDGh2g==
X-Received: by 2002:adf:f292:: with SMTP id k18mr37384267wro.321.1558694154076;
        Fri, 24 May 2019 03:35:54 -0700 (PDT)
Received: from localhost.localdomain (86.100.broadband17.iol.cz. [109.80.100.86])
        by smtp.gmail.com with ESMTPSA id n4sm2111272wrp.61.2019.05.24.03.35.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 May 2019 03:35:53 -0700 (PDT)
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jorgen Hansen <jhansen@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH 0/2] Prevent evaluation of WRITE_ONCE()
Date:   Fri, 24 May 2019 12:35:34 +0200
Message-Id: <1558694136-19226-1-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This all started when we realized that

  atomic64_t v;
  ...
  typeof(v.counter) my_val = atomic64_set(&v, VAL);

is a valid assignment on some architectures, but not on others [1]:
in particular, the assignment is valid on all architectures #define
-ing their atomic64_set() macro to WRITE_ONCE() (which is currently
evaluated).

Mark suggested to clean up all non-portable users of atomic*_set(),
and to prevent WRITE_ONCE() from being evaluated [2]; this resulted
in this first attempt/patchset based on Mark's atomics/type-cleanup
branch [3].

Cheers Andrea

[1] https://lkml.kernel.org/r/20190523083013.GA4616@andrea
[2] https://lkml.kernel.org/r/20190523141851.GA7523@lakrids.cambridge.arm.com
[3] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git atomics/type-cleanup

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jorgen Hansen <jhansen@vmware.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>

Andrea Parri (2):
  vmw_vmci: Clean up uses of atomic*_set()
  compiler: Prevent evaluation of WRITE_ONCE()

 include/linux/compiler.h      | 5 ++---
 include/linux/vmw_vmci_defs.h | 4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

-- 
2.7.4

