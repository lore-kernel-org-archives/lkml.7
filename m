Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA7DC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 06:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867FF20644
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 06:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfG2Gww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 02:52:52 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3192 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725934AbfG2Gwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 02:52:44 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EE91586908F054A1E362;
        Mon, 29 Jul 2019 14:52:19 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 29 Jul
 2019 14:52:13 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 00/22] staging: erofs: updates according to erofs-outofstaging v4
Date:   Mon, 29 Jul 2019 14:51:37 +0800
Message-ID: <20190729065159.62378-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset includes all meaningful modifications till now according
to erofs-outofstaging v4:
https://lore.kernel.org/linux-fsdevel/20190725095658.155779-1-gaoxiang25@huawei.com/

Some empty lines which were add or delete are not included in this
patchset, I will send erofs-outofstaging v5 later in order to keep
main code bit-for-bit identical with this staging patchset.

Thanks,
Gao Xiang

Gao Xiang (22):
  staging: erofs: update source file headers
  staging: erofs: rename source files for better understanding
  staging: erofs: fix dummy functions erofs_{get,list}xattr
  staging: erofs: keep up erofs_fs.h with erofs-outofstaging patchset
  staging: erofs: sunset erofs_workstn_{lock,unlock}
  staging: erofs: clean up internal.h
  staging: erofs: remove redundant #include "internal.h"
  staging: erofs: kill CONFIG_EROFS_FS_IO_MAX_RETRIES
  staging: erofs: clean up shrinker stuffs
  staging: erofs: kill sbi->dev_name
  staging: erofs: kill all failure handling in fill_super()
  staging: erofs: refine erofs_allocpage()
  staging: erofs: kill CONFIG_EROFS_FS_USE_VM_MAP_RAM
  staging: erofs: tidy up zpvec.h
  staging: erofs: remove redundant braces in inode.c
  staging: erofs: tidy up decompression frontend
  staging: erofs: remove clusterbits in sbi
  staging: erofs: turn cache strategies into mount options
  staging: erofs: tidy up utils.c
  staging: erofs: tidy up internal.h
  staging: erofs: update super.c
  staging: erofs: update Kconfig

 .../erofs/Documentation/filesystems/erofs.txt |   10 +
 drivers/staging/erofs/Kconfig                 |  111 +-
 drivers/staging/erofs/Makefile                |    4 +-
 drivers/staging/erofs/compress.h              |    2 +-
 drivers/staging/erofs/data.c                  |    8 +-
 drivers/staging/erofs/decompressor.c          |   44 +-
 drivers/staging/erofs/dir.c                   |    6 +-
 drivers/staging/erofs/erofs_fs.h              |   47 +-
 .../erofs/include/trace/events/erofs.h        |    2 +-
 drivers/staging/erofs/inode.c                 |   24 +-
 drivers/staging/erofs/internal.h              |  244 +--
 drivers/staging/erofs/namei.c                 |    7 +-
 drivers/staging/erofs/super.c                 |  268 ++-
 .../erofs/{include/linux => }/tagptr.h        |   12 +-
 drivers/staging/erofs/unzip_vle.c             | 1591 -----------------
 drivers/staging/erofs/utils.c                 |  112 +-
 drivers/staging/erofs/xattr.c                 |    6 +-
 drivers/staging/erofs/xattr.h                 |   22 +-
 drivers/staging/erofs/zdata.c                 | 1408 +++++++++++++++
 .../staging/erofs/{unzip_vle.h => zdata.h}    |  119 +-
 drivers/staging/erofs/zmap.c                  |    5 +-
 .../erofs/{unzip_pagevec.h => zpvec.h}        |   41 +-
 22 files changed, 1853 insertions(+), 2240 deletions(-)
 rename drivers/staging/erofs/{include/linux => }/tagptr.h (94%)
 delete mode 100644 drivers/staging/erofs/unzip_vle.c
 create mode 100644 drivers/staging/erofs/zdata.c
 rename drivers/staging/erofs/{unzip_vle.h => zdata.h} (56%)
 rename drivers/staging/erofs/{unzip_pagevec.h => zpvec.h} (78%)

-- 
2.17.1

