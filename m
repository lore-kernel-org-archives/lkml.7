Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA51C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 02:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D719320657
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 02:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732825AbfCAC6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 21:58:22 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:52162 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726088AbfCAC6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 21:58:22 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 43A03E3440FDF2E2A11F;
        Fri,  1 Mar 2019 10:58:20 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Fri, 1 Mar 2019
 10:58:11 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <joe@perches.com>,
        <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 0/2] appletalk: small cleanup and bugfix
Date:   Fri, 1 Mar 2019 10:57:55 +0800
Message-ID: <20190301025757.27592-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

v2:
- Add cover letter log

This patch series mainly fix a use-after-free bug in atalk_proc_exit.
patch 1 use remove_proc_subtree helper to simplify atalk_proc fs code,
also some other cleanup.
patch 2 add proper error cleanup path in atalk_init to fix the issue, which
based on the patch 1 because of the change of atalk_proc_exit context.

YueHaibing (2):
  appletalk: use remove_proc_subtree to simplify procfs code
  appletalk: Fix use-after-free in atalk_proc_exit

 include/linux/atalk.h            |  2 +-
 net/appletalk/atalk_proc.c       | 58 +++++++++++++---------------------------
 net/appletalk/ddp.c              | 37 ++++++++++++++++++++-----
 net/appletalk/sysctl_net_atalk.c |  5 +++-
 4 files changed, 54 insertions(+), 48 deletions(-)

-- 
2.7.0


