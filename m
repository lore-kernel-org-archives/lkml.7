Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4337CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A0BE218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553120926;
	bh=uHWKfCWiUUduQl+hHvcHKYmzz5TwhBowk9B8ncc6fn8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=UnwJsjxIoDLG1agOmi19nWKXK2SS5ZH4sy6DBpLMnpEy6D0OhGqWyKKDM96cyQgjW
	 M3JB5O0awmWUUoMTaC8bHMUtS/yk7pyG502BCK6z8/SA6GvApXrH6N8BKzusKZ90IS
	 kqIkAOBHmjIAyZN2GKW0ftunkgRl+e4rfCg58Uio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfCTW2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 18:28:44 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:44679 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbfCTW2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 18:28:44 -0400
Received: by mail-yw1-f68.google.com with SMTP id c4so3315515ywa.11;
        Wed, 20 Mar 2019 15:28:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dLQbQLb+LbBg3EhbjazMgrlxpCtWNa1jT7fqdBlxHDI=;
        b=PIU1W786gGBdSihC6oNyGT5Atvhr2uKXXa6ebd6tyEQFffMOSxGFvq/M3nN+FM0X7K
         2u/MV1gi8M/N5JdsmqWRr1q1/iC7irvS6vAyqws734tZyZNtHAISQFg2CRmMxislicsu
         rpti39rsFXD7BtL/YGrz3EQPmF6iSMiO8k4KOAifL8lxHH7hehMZKBgacJfIv/t/WOMU
         6oRHwu08b2IC2L8qMrADGll2ybDVOWjxUpGA5axuow3roJtJg60gD+C3Gf8wJRT8d2Rr
         yTYfLHCMIiJnsouThGo+dOLx2bjfsdQXIbEWWeJppm2zJbNQzn6nVMmQMXK05es2Du/a
         YHpA==
X-Gm-Message-State: APjAAAUsr8F50FkJgaHel3ec+ezgBpoHTKxO5YekHH2jdXtJkvKVFz8F
        NgyXyBTf8aQNZneVaqCWLds=
X-Google-Smtp-Source: APXvYqxMOGiDKdeYU9yFNJbhABVHoRIp8mFO4uHfsWaFPECYjaxm4OrH4E3cVV5S+wL2CK0ugNkeDg==
X-Received: by 2002:a81:8807:: with SMTP id y7mr459608ywf.265.1553120923407;
        Wed, 20 Mar 2019 15:28:43 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id g1sm1051945ywf.0.2019.03.20.15.28.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 15:28:41 -0700 (PDT)
Received: by 42.do-not-panic.com (sSMTP sendmail emulation); Wed, 20 Mar 2019 22:28:39 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     akpm@linux-foundation.org, keescook@chromium.org
Cc:     sandeen@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 0/6] sysctl: add pending proc_do_large_bitmap fix
Date:   Wed, 20 Mar 2019 22:28:25 +0000
Message-Id: <20190320222831.8243-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, Kees,

Eric sent a fix out for proc_do_large_bitmap() last month for when
using a large input buffer. After patch review a test case for the issue
was built and submitted. I noticed there were a few issues with the
tests, but instead of just asking Eric to address them I've taken
care of them and ammended the commit where necessary. There's a
few issues he reported which I also address and fix in this series.

Since we *do* expect users of these scripts to also use them on older
kernels, I've also addressed not breaking calling the script for them,
and gives us an easy way to easily extend our tests cases for future
kernels as well.

Before anyone considers these for stable as minor fixes, I'd recommend
we also address the discrepancy on the read side of things: modify the
test script to use diff against the target file instead of using the
temp file.

Eric Sandeen (2):
  test_sysctl: add proc_do_large_bitmap() test case
  sysctl: Fix proc_do_large_bitmap for large input buffers

Luis Chamberlain (4):
  test_sysctl: remove superfluous test_reqs()
  test_sysctl: load module before testing for it
  test_sysctl: ignore diff output on verify_diff_w()
  test_sysctl: allow graceful use on older kernels

 kernel/sysctl.c                          |  30 ++++-
 lib/test_sysctl.c                        |  18 ++-
 tools/testing/selftests/sysctl/sysctl.sh | 161 +++++++++++++++++++----
 3 files changed, 178 insertions(+), 31 deletions(-)

-- 
2.18.0

