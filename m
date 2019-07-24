Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CA4C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 05:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F87218DA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 05:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbfGXFr3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 01:47:29 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25380 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725894AbfGXFr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 01:47:28 -0400
X-Greylist: delayed 905 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Jul 2019 01:47:28 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1563946340; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=EF9MQ/cO+0RD6Nq+6ZqurtZ48ymDiQlH8Kcji2rH1ew1ZilRd+L4fTXajqZJ7Cj5wDIbHVVmbdUgymZ/0elY02V3kiv8Y5aXk67bv5Uy7/0yoip2lDqK8RFGBwmejVhb+9YgIW4mMkDGkTunL4loj2IlWcy2TLgpRc/mpfdKS3A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1563946340; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=ZGrJP8lsLyeOcZGzg9BM6QAFRxy0WJmO2A+QOuacb4g=; 
        b=faYCzjEKT+OlaKKv4YbbfxKcg/LSIlMhnUdKlOE6Ovyaxyg687tGuZ4403gVWtI3YJWfh2EGVNIrQEbnIVqx/OsXsU8gfXL7kBtxr6hswthcWbs4hWqYDyrUA8b4KRC+qwDtwEg98BsWUBvHQ0zToL6NI/8ESbhEis+DGcSZdf0=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=zoho.com.cn;
        spf=pass  smtp.mailfrom=cgxu519@zoho.com.cn;
        dmarc=pass header.from=<cgxu519@zoho.com.cn> header.from=<cgxu519@zoho.com.cn>
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1563946339474558.2818888374384; Wed, 24 Jul 2019 13:32:19 +0800 (CST)
From:   Chengguang Xu <cgxu519@zoho.com.cn>
To:     jack@suse.com
Cc:     linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@zoho.com.cn>
Message-ID: <20190724053216.19392-1-cgxu519@zoho.com.cn>
Subject: [PATCH] quota: fix condition for resetting time limit in do_set_dqblk()
Date:   Wed, 24 Jul 2019 13:32:16 +0800
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We reset time limit when current usage is smaller
or equal to soft limit in other place, so follow
this rule in do_set_dqblk().

Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>
---
 fs/quota/dquot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index be9c471cdbc8..6e826b454082 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2731,7 +2731,7 @@ static int do_set_dqblk(struct dquot *dquot, struct qc_dqblk *di)
 
 	if (check_blim) {
 		if (!dm->dqb_bsoftlimit ||
-		    dm->dqb_curspace + dm->dqb_rsvspace < dm->dqb_bsoftlimit) {
+		    dm->dqb_curspace + dm->dqb_rsvspace <= dm->dqb_bsoftlimit) {
 			dm->dqb_btime = 0;
 			clear_bit(DQ_BLKS_B, &dquot->dq_flags);
 		} else if (!(di->d_fieldmask & QC_SPC_TIMER))
@@ -2740,7 +2740,7 @@ static int do_set_dqblk(struct dquot *dquot, struct qc_dqblk *di)
 	}
 	if (check_ilim) {
 		if (!dm->dqb_isoftlimit ||
-		    dm->dqb_curinodes < dm->dqb_isoftlimit) {
+		    dm->dqb_curinodes <= dm->dqb_isoftlimit) {
 			dm->dqb_itime = 0;
 			clear_bit(DQ_INODES_B, &dquot->dq_flags);
 		} else if (!(di->d_fieldmask & QC_INO_TIMER))
-- 
2.20.1



