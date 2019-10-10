Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB5BECE58C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 01:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F1D2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 01:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="Uwr1cF66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732531AbfJJBHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 21:07:08 -0400
Received: from mx1.ucr.edu ([138.23.248.2]:14915 "EHLO mx1.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731155AbfJJBHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 21:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570669628; x=1602205628;
  h=from:to:cc:subject:date:message-id;
  bh=iscobZV2+WcD7Caf8EIX+cf3/3kJSCh16Yd5Sl8L2gA=;
  b=Uwr1cF66EydT2pYbzR5y+0h9ZXI96PwxQEeNwPOg1VJw+PHzs4+jAxwc
   2Mk+LDXZHsjUSEeI8sGc2/mNmyrleAHD1dSTDa5wkmnlJZWPU3KdeVX3L
   IByg6rQa7iUc2Ric3LQH+GUIkaZirz0eGi9ZOZ0h4SLZEdLFfuv4mGb8h
   8p0tNiBnNFNKQEPRIUGqxo2A+iPx2XKZPp9PTroNgOA+zhpZ7WkgoRrz1
   K48JgKISING0TkzF8glvdtLWUnLRdHtu/wOkq8rFckqIA6JvrJYP4vdEI
   aM3ph7kgqUF52/q+YG1ul1XEjAiX1BCbiL8d+KP9KrQmZ/8GvTDtUMfOU
   g==;
IronPort-SDR: hyeMzlOX1tVYpAsnXar9LYlLN1/Kpah9Q3vYeJTETUha9Mu1OQ0ntI9zMBgemfZL8i/rX+hJrX
 NMVrfm5BE47Mu6d6KIhR/jLefxSDbs2h2/14skNnr7K4pYOyPaAdRWW4oTQ/X9xY150izKYy4K
 on5YvgT4OBIVGC+DEWcgoKJ8Epiw7+QR+KPGOOxdAFfyzZtb6eOTHalLzO4hrYtCCcL44wAF4F
 I9P/Gp8Ff1OBlUQI4IHQIcPq+4MgvX/rFzbIfnia+D4jKUhtbQJbq4oii6Dc5UX+fgl/pFKIVM
 tJA=
IronPort-PHdr: =?us-ascii?q?9a23=3Air8HcBXrp9uCNIQoTYGhmwHVSZDV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbBWOt8tkgFKBZ4jH8fUM07OQ7/m7HzJaqsrd+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi4oAnLt8Qan4RuJ6k+xx?=
 =?us-ascii?q?DUvnZGZuNayH9yK1mOhRj8/MCw/JBi8yRUpf0s8tNLXLv5caolU7FWFSwqPG?=
 =?us-ascii?q?8p6sLlsxnDVhaP6WAHUmoKiBpIAhPK4w/8U5zsryb1rOt92C2dPc3rUbA5XC?=
 =?us-ascii?q?mp4ql3RBP0jioMKiU0+3/LhMNukK1boQqhpx1hzI7SfIGVL+d1cqfEcd8HWW?=
 =?us-ascii?q?ZNQsNdWipEAoO9dIsPFOsBPeBXr4LguVUAtAa1BQetBOzxzj9Hm2L90ak03u?=
 =?us-ascii?q?g9FA3L2gsvEs4AvXjIsdn5LbseXf2ox6XM0DnOb/Za1DHg44bKbx8hu+mBU7?=
 =?us-ascii?q?Juf8TMx0chFATLg06MpYD5JT6Zyv4Av3SH4+dmSOmhi3QnqwZ0ojW3xMgsi4?=
 =?us-ascii?q?jIhoIIylDD6C50x4Y0JNy4SEFhYN6oDIdcui+BOotrXswiWXtktzgnxb0boJ?=
 =?us-ascii?q?O2ejUBxpc/xxPHdfCLb4yF7gjgWeuROzt0mm9pdK6lixqs7USs1vXwWtS13V?=
 =?us-ascii?q?tOtCZJjNfBu3AX2xDN68WLUPlw80in1D2SzQ7c8PtELloxlafDLp4hxaM/mY?=
 =?us-ascii?q?QLvETYGy/2hF32jKiLdkU44uSo6/roYrHhppKEMo97kAD+MqA3lsynD+Q0Lx?=
 =?us-ascii?q?ECX2aF9eigyLHv50L5QLJNjv05lqnWrorWKtgcpq68GwNV04Aj5AijDzq+zt?=
 =?us-ascii?q?gUgX0KIEhGdR+HlYTlJUzCLOziAfuhn1igjC9nx/XcMb3gBpXNIGLDkLDkfb?=
 =?us-ascii?q?tl609dyQozwspe555IFr0MLun+WlLtu9zCFBM2LRG7w/v/BNVnyoweQX6PAr?=
 =?us-ascii?q?OeMK7KtV+I5+QvI/SDZYMMuzbyNeIl5/jwgn89glIdY6ap0oUNaHyiHfRpPV?=
 =?us-ascii?q?+ZYXzyjdcFC2sKuRA+TOO5wHOYVjsGVnegX787rmUqGoKvDN+bHaiwi6bH0S?=
 =?us-ascii?q?umSM4FLltaA0yBRC+7P76PXO0BPWfPf8I=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EmFAB0g55dgMjSVdFmhiBMEI0lhVp?=
 =?us-ascii?q?QAQEBBospGHGFeoowAQgBAQEMAQEtAgEBhECCUiM4EwIDCQEBBQEBAQEBBQQ?=
 =?us-ascii?q?BAQIQAQEJDQkIJ4VCgjopgzULFhVSgRUBBQE1IjmCRwGCUiWkaYEDPIwlM4h?=
 =?us-ascii?q?kAQkNgUgJAQiBIoc1hFmBEIEHgRGDUIQNg1mCSgSBOQEBAY14hzeWVwEGAoI?=
 =?us-ascii?q?QFIF4kxUnhDyJP4tEAadjAgoHBg8jgUaBe00lgWwKgURQEBSQNSEzgQiNP4J?=
 =?us-ascii?q?UAQ?=
X-IPAS-Result: =?us-ascii?q?A2EmFAB0g55dgMjSVdFmhiBMEI0lhVpQAQEBBospGHGFe?=
 =?us-ascii?q?oowAQgBAQEMAQEtAgEBhECCUiM4EwIDCQEBBQEBAQEBBQQBAQIQAQEJDQkIJ?=
 =?us-ascii?q?4VCgjopgzULFhVSgRUBBQE1IjmCRwGCUiWkaYEDPIwlM4hkAQkNgUgJAQiBI?=
 =?us-ascii?q?oc1hFmBEIEHgRGDUIQNg1mCSgSBOQEBAY14hzeWVwEGAoIQFIF4kxUnhDyJP?=
 =?us-ascii?q?4tEAadjAgoHBg8jgUaBe00lgWwKgURQEBSQNSEzgQiNP4JUAQ?=
X-IronPort-AV: E=Sophos;i="5.67,278,1566889200"; 
   d="scan'208";a="13400259"
Received: from mail-pf1-f200.google.com ([209.85.210.200])
  by smtp1.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Oct 2019 18:07:08 -0700
Received: by mail-pf1-f200.google.com with SMTP id b204so3388324pfb.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 18:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8OVQEqDnZT/hGCFmchJ+P83mxDX43MTb/ldo4fn9QXY=;
        b=CHt8kbMQGlgCtNv5mI7CaEfNJywH0jsS5acMDV5IJXESKYSvk62S3WtOr0Zz9BORoU
         d4n0OcWFXxNMTS+cyXj5luONLUg3ovGHoe0NxO1WagvN0YCMvYdTJfXAQisYLX/ba7OS
         WtZNboY3wj2tesaxhe0gsv3wgfxXvgm7VL1Cm3LaI+1NnUrW2jpUr10X7FznU9tyAkmd
         ARVqmhfX2EkqEMNQ4g32yr/Z4ICaUUWnAYh+TAG7vFQRoxZC20cjMKY7aFzNBsiFWDD4
         bvUMCsHPVFz60+wT3xLUTS7S4X5+Ipyr6YnLJt6CRKzDoTg5n65AGFnZe5xX7gReVZbR
         X7VQ==
X-Gm-Message-State: APjAAAUQsFxrnkVX9w9sv4VA5jaWS7/3Vnx1fAk5BoQYOAT4ZbqhcI3+
        UU/f1UTBiBS/ait0UyYooZ86yQfhHcU9nqiDpuo45wicGgm/cgJUGRZJirbJlxKxNuraogI8rBg
        ppscQr2MDXjqxTz17QDFkNCp4EQ==
X-Received: by 2002:a63:ba05:: with SMTP id k5mr7205848pgf.195.1570669626512;
        Wed, 09 Oct 2019 18:07:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxephfitnQqNF8zyyZTwZ/TQoyiKyjLrb0voeLkdonCTGpgIUWEkD91QseazSP+HMn31UmIDw==
X-Received: by 2002:a63:ba05:: with SMTP id k5mr7205822pgf.195.1570669626191;
        Wed, 09 Oct 2019 18:07:06 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id k65sm6346906pga.94.2019.10.09.18.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 18:07:05 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     Yizhuo <yzhai003@ucr.edu>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ChenGang <cg.chen@huawei.com>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jia Guo <guojia12@huawei.com>, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ocfs2:fix potential Null Ptr Dereference
Date:   Wed,  9 Oct 2019 18:07:50 -0700
Message-Id: <20191010010752.25941-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside function o2hb_region_blocks_store(), to_o2hb_region()
could return NULL but there's no check before its dereference,
which is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 fs/ocfs2/cluster/heartbeat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index a368350d4c27..93f2b540f245 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -1628,7 +1628,7 @@ static ssize_t o2hb_region_blocks_store(struct config_item *item,
 	unsigned long tmp;
 	char *p = (char *)page;
 
-	if (reg->hr_bdev)
+	if (!reg || reg->hr_bdev)
 		return -EINVAL;
 
 	tmp = simple_strtoul(p, &p, 0);
-- 
2.17.1

