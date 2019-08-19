Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEA6C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B53C20989
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfHSKfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 06:35:19 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55472 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726477AbfHSKfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 06:35:18 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 51609BA7CB78A0572AFD;
        Mon, 19 Aug 2019 18:35:12 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 19 Aug
 2019 18:35:03 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-fsdevel@vger.kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 0/6] staging: erofs: first stage of corrupted compressed images
Date:   Mon, 19 Aug 2019 18:34:20 +0800
Message-ID: <20190819103426.87579-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819080218.GA42231@138>
References: <20190819080218.GA42231@138>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have fuzzed EROFS for about a day and observed the following
issues due to corrupted compression images by my first fuzzer
(It seems ok for uncompressed images for now). Now it can survive
for 10+ minutes on my PC (Let me send out what I'm done and
I will dig it more deeply...)

All the fixes are trivial.

Note that those have dependency on EFSCORRUPTED, so for-next
is needed and I will manually backport them by hand due to
many cleanup patches...

Thanks,
Gao Xiang

Gao Xiang (6):
  staging: erofs: some compressed cluster should be submitted for
    corrupted images
  staging: erofs: cannot set EROFS_V_Z_INITED_BIT if fill_inode_lazy
    fails
  staging: erofs: add two missing erofs_workgroup_put for corrupted
    images
  staging: erofs: avoid loop in submit chains
  staging: erofs: detect potential multiref due to corrupted images
  staging: erofs: avoid endless loop of invalid lookback distance 0

 drivers/staging/erofs/zdata.c | 46 ++++++++++++++++++++++++++---------
 drivers/staging/erofs/zmap.c  |  9 +++++--
 2 files changed, 42 insertions(+), 13 deletions(-)

-- 
2.17.1

