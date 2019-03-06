Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E664AC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 13:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C158120684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 13:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbfCFNAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 08:00:51 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5211 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728376AbfCFNAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 08:00:49 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8F381EC53B43D5B3129E;
        Wed,  6 Mar 2019 21:00:46 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.408.0; Wed, 6 Mar 2019 21:00:36 +0800
From:   Hongbo Yao <yaohongbo@huawei.com>
To:     <tglx@linutronix.de>, <edumazet@google.com>,
        <linux-kernel@vger.kernel.org>, <yaohongbo@huawei.com>
Subject: [RFC PATCH 0/2] add ktime_sub_safe() to avoid undefined behaviour
Date:   Wed, 6 Mar 2019 21:13:24 +0800
Message-ID: <20190306131326.10275-1-yaohongbo@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I ran Syzkaller testsuite, I got some UBSAN warnings with
ktime_sub().

Instead of putting overflow checks into each place, add a function
which does the sanity checking and convert all affected callers to use
it.

Hongbo Yao (2):
  ktime: add ktime_sub_safe() to avoid undefined behaviour
  hrtimer: Prevent overflow for relative refrences

 include/linux/ktime.h |  8 ++++++++
 kernel/time/hrtimer.c | 21 +++++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

-- 
2.20.1

