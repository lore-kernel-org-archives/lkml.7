Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2872BC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 04:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 018162083B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 04:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfHNEId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 00:08:33 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4684 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725320AbfHNEId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 00:08:33 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 454CF1D7FAA01BD20600;
        Wed, 14 Aug 2019 12:08:28 +0800 (CST)
Received: from localhost.localdomain (10.175.124.28) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 14 Aug
 2019 12:08:18 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-fsdevel@vger.kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 2/2] staging: erofs: differentiate unsupported on-disk format
Date:   Wed, 14 Aug 2019 12:25:25 +0800
Message-ID: <20190814042525.4925-2-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190814042525.4925-1-gaoxiang25@huawei.com>
References: <20190814042525.4925-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some specific fields, use ENOTSUPP instead of EIO
for values which look sane but aren't supported right now.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/inode.c | 4 ++--
 drivers/staging/erofs/zmap.c  | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
index 461fd4213ce7..1088cd154efa 100644
--- a/drivers/staging/erofs/inode.c
+++ b/drivers/staging/erofs/inode.c
@@ -24,7 +24,7 @@ static int read_inode(struct inode *inode, void *data)
 		errln("unsupported data mapping %u of nid %llu",
 		      vi->datamode, vi->nid);
 		DBG_BUGON(1);
-		return -EIO;
+		return -ENOTSUPP;
 	}
 
 	if (__inode_version(advise) == EROFS_INODE_LAYOUT_V2) {
@@ -95,7 +95,7 @@ static int read_inode(struct inode *inode, void *data)
 		errln("unsupported on-disk inode version %u of nid %llu",
 		      __inode_version(advise), vi->nid);
 		DBG_BUGON(1);
-		return -EIO;
+		return -ENOTSUPP;
 	}
 
 	if (!nblks)
diff --git a/drivers/staging/erofs/zmap.c b/drivers/staging/erofs/zmap.c
index 16b3625604f4..f955d0752792 100644
--- a/drivers/staging/erofs/zmap.c
+++ b/drivers/staging/erofs/zmap.c
@@ -178,7 +178,7 @@ static int vle_legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 		break;
 	default:
 		DBG_BUGON(1);
-		return -EIO;
+		return -ENOTSUPP;
 	}
 	m->type = type;
 	return 0;
@@ -362,7 +362,7 @@ static int vle_extent_lookback(struct z_erofs_maprecorder *m,
 		errln("unknown type %u at lcn %lu of nid %llu",
 		      m->type, lcn, vi->nid);
 		DBG_BUGON(1);
-		return -EIO;
+		return -ENOTSUPP;
 	}
 	return 0;
 }
@@ -436,7 +436,7 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 	default:
 		errln("unknown type %u at offset %llu of nid %llu",
 		      m.type, ofs, vi->nid);
-		err = -EIO;
+		err = -ENOTSUPP;
 		goto unmap_out;
 	}
 
-- 
2.17.2

