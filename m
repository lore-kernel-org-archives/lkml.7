Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DATE_IN_FUTURE_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2246C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 04:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA8A32086D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 04:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfDLEkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 00:40:42 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39582 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725788AbfDLEkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 00:40:42 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 85F2AC13FD584A7EEAF6;
        Fri, 12 Apr 2019 12:40:38 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Fri, 12 Apr 2019
 12:40:28 +0800
From:   Wang Hai <wanghai26@huawei.com>
To:     <davem@davemloft.net>, <idosch@mellanox.com>,
        <eric.dumazet@gmail.com>, <alexander.h.duyck@intel.com>,
        <tyhicks@canonical.com>, <f.fainelli@gmail.com>,
        <viro@zeniv.linux.org.uk>, <amritha.nambiar@intel.com>,
        <joe@perches.com>, <dmitry.torokhov@gmail.com>,
        <andriy.shevchenko@linux.intel.com>, <stephen@networkplumber.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wanghai26@huawei.com>
Subject: [PATCH 0/2] net-sysfs: revert wrong bugfix and re-fix
Date:   Fri, 12 Apr 2019 16:36:32 -0400
Message-ID: <20190412203634.30392-1-wanghai26@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First patch reverts the bugfix which cause another issue.
Reported by syzbot+6024817a931b2830bc93@syzkaller.appspotmail.com. 
See https://syzkaller.appspot.com/x/log.txt?x=1737671b200000 for details
Second patch improves the first(reverted) patch.
Applied these two patches. I tested, the memory leak issue
wasn't reproduced, and it didn't produce the bug which
reported by syzkaller.

Wang Hai (2):
  Revert "net-sysfs: Fix memory leak in netdev_register_kobject"
  net-sysfs: Fix memory leak in netdev_register_kobject

 net/core/net-sysfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
1.8.3.1

