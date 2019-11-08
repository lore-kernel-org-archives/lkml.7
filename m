Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1A3FC6197
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D7A2215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388386AbfKHVhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 16:37:54 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:44267 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388098AbfKHVhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:37:53 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Ml6Zo-1i3mCK0AMm-00lWcq; Fri, 08 Nov 2019 22:36:40 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, Jan Kara <jack@suse.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 11/16] quota: avoid time_t in v1_disk_dqblk definition
Date:   Fri,  8 Nov 2019 22:32:49 +0100
Message-Id: <20191108213257.3097633-12-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191108213257.3097633-1-arnd@arndb.de>
References: <20191108213257.3097633-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:r4+HDTKLF8JwWwZoVSG61m2TMwB5tZHUr07N5j4f9snFYXaTdcY
 8FRUSe43cL00EtG2dk4U1k+hXkV64fPxg7EX4hmJZQNw/AyESlLPHpAg25GkrUqXhPGl9Lx
 8YRcLHUZLOSwT20wpqodE+JInhJy7d2FFkcfHTVzHy8N5ypap4xeBuCESRRynBQgUvk5uvs
 nmwdUOajEqKDJ2kcXErsA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:smWTcQrNlag=:uceC1aGHaQdFcGEu4mCRW8
 IycRt3ysNIHQT9iNFSsAykKZJ1rvSzRVIec34YMmY2Q9Pt7HHRjxq72igB5ec/1Sx4cAcSV+F
 d7GMy2eAogNO3pEbWvgpZN2+J9C6XW53mlBhFobTyozqIVZbBJe5qwl1Ox3CRCPGjQD7utCvd
 fgBZnXEXE4/0nHRebGtVKyx/zO5RGk3LPRyodlQ765n7wjCEz7UZe5AuRLLi1GdF6yI3JJIEd
 v6I2XYkK2SXQo1+vQ2AS68rUMDjJF+AFyx7SZn51NQIk+pwg7/0uf929uYZHmWSVs35/6wm+Z
 MkSjpbm/rFl6ZXwOIUOw/FXsZ+ARRtv/uV2bmBEFQvNXYYKPknMdDdtSj+KgusKRxVsTs9F/3
 gS1nk408LbTXOTk4a06htk6k7py7No6/csoOfK+ze5KocKp1MqQKUM8DheQm5DFVNfip5dF5I
 wZPQFkBD+te3Vv4Zc4VBNgeht9YyKqwneuRtYcFASSoGXkOCA0qwc5iTnEt14yynLkQFAMQEW
 txC3StDzJZBhfkyANjR4Jcl+IOEkEbhmJg1vWyGh64PffHxZ4V6R8vHh9W75QuPj/qXCqBH4D
 9iozyL+1PLUi4m/gcpH8mAVJI+U2TXPvCCIykQiebBvN8oGx9B0Fj8WKr2BCSJJtGiMOmQfhg
 T/rB/hvlwqZlFe0vMnpDbSdb3cE0vAGj24u4rL6At5JDEvwck+qTU2N0zQzV2J8aPt5nOKVH2
 ODZGHba3cEBb3FVrF/WKHrkDRUgd5isoiM0jRKBebve6rXhKVQInUy6A5J3AagYkUCdauqeK7
 FQhtJvvV8hgtVOXFiuIoDEvVXNliECSauDatoMv6mTutAAfIv+jK1voP2I0TDbOqLVr7B1ZFG
 oZ4A1HVS+oWARNansHPA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The time_t type is part of the user interface and not always the
same, with the move to 64-bit timestamps and the difference between
architectures.

Make the quota format definition independent of this type and use
a basic type of the same length. Make it unsigned in the process
to keep the v1 format working until year 2106 instead of 2038
on 32-bit architectures.

Hopefully, everybody has already moved to a newer format long
ago (v2 was introduced with linux-2.4), but it's hard to be sure.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/quota/quotaio_v1.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/quota/quotaio_v1.h b/fs/quota/quotaio_v1.h
index bd11e2c08119..31dca9a89176 100644
--- a/fs/quota/quotaio_v1.h
+++ b/fs/quota/quotaio_v1.h
@@ -25,8 +25,10 @@ struct v1_disk_dqblk {
 	__u32 dqb_ihardlimit;	/* absolute limit on allocated inodes */
 	__u32 dqb_isoftlimit;	/* preferred inode limit */
 	__u32 dqb_curinodes;	/* current # allocated inodes */
-	time_t dqb_btime;	/* time limit for excessive disk use */
-	time_t dqb_itime;	/* time limit for excessive inode use */
+
+	/* below fields differ in length on 32-bit vs 64-bit architectures */
+	unsigned long dqb_btime; /* time limit for excessive disk use */
+	unsigned long dqb_itime; /* time limit for excessive inode use */
 };
 
 #define v1_dqoff(UID)      ((loff_t)((UID) * sizeof (struct v1_disk_dqblk)))
-- 
2.20.0

