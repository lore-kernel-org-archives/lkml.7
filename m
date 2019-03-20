Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89512C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB9E2184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="K3LH26Fe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfCTFEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 01:04:37 -0400
Received: from mout.gmx.net ([212.227.15.15]:43631 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfCTFEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 01:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553058270;
        bh=xruUcvG4yIeCnExf//yw6gdXzUs1SE8L8KieehIYV6k=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=K3LH26FeeOxFhNUYeQkQlNyLknc1ha99v8qiOAnw0fYfHTN5ixxyFMpMbZhXEKSM8
         YshPfoToW8lpAEDgVr4OFeTY6qUQcpy448/dmPzOJnetM/hjSxgLVKvbKoBXpTPBrH
         qI8PERP1eSEdNup744L8EoWB5EwFwbznR8evOVMY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([218.18.229.179]) by mail.gmx.com
 (mrgmx001 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0LjIit-1gai142L5L-00dURX; Wed, 20 Mar 2019 06:04:30 +0100
From:   Chengguang Xu <cgxu519@gmx.com>
To:     jack@suse.com
Cc:     linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH] quota: code cleanup for __dquot_alloc_space()
Date:   Wed, 20 Mar 2019 13:03:59 +0800
Message-Id: <20190320050400.20616-1-cgxu519@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C/F4Hzqc887H3eqo7Q5rjmkorGOU6VSWfYxlf/hhSJj8/Q/lS+S
 4pO9VchJqd3abFq8TnhCz1DUGLuCFC1eug5uUxid7iGKnW/1JGJOU6GrZwgvSjd7UMXnFWk
 dHKA+7W2fywmvcyQowmDabBn/uJMi83WtR4aO8hXcKGAEnwjp0uHjHrP2s+/axADTFrE+ZZ
 1KA4arw5xSLaZ75hcri1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y6muu/x6/h4=:tSYjcxVeYIJKKGM4KDq8D8
 UfYFppMpuTjdg5FKWADwg4W4unhNZ1JGV4/gzsDf/6ORkueuHzASlkcVxHIGY0pTqT8zOESh1
 qvLs4n2jlwxc5Mn8hpg973JPflXG/vf0ylWObPD2vJFQKtOvkken2zAD0hf3M30dvLXvcL3ej
 F2AjPgmB4maUC3vb/Ae4mEXrsBPKcaQVoJS0ADQCao8HwIcuzPIuqo425knxtaFMoRGSNkWhh
 NBWjOy1SAa4e26Y2j1UKYAlYQmKswNQyJOxCS8WxvbM3gLE6xlLuL8y3FAYCe5MEEWVSa/DvC
 Cq33773jiiBfGfAbYWFYVeyuclhNolmLtb7tzSP7Irf/5pL6dN5ZfTbKVppUs4wP3nufPR6nW
 /9UvPZwc1OmwRjLj9QZYvrVmmLBOv0Xoe58dLUqdvbOG1G9sRa5eaORmIhTf2g2b+cf0CNdJd
 G6N0B0HeusCkc0Yrq0LWk0U1P3YRhE5MTbHZRymcoKiYdgvLiTLXHk0PNSjXjyB0DGhGxui1o
 x15JluTyDwqXNPGVUL8ts/8pavTWJRNHvYwHCYOmZtpMg2I/VSj9kPVveXYQUZAdbH4BeVPXq
 kU+icfDDukKpdCHOXJQr7+nj01FhTdxMi05miBwm1uCZBRAG1SRBFzlZss0D+AJ3YSgglsv/6
 ME13/CfUSGOhwPb81EQ1AorUQoBLCcqoN8kAcykY+mZxtlOaIPHErHtEEoJtPKUR+hiLCzUhU
 BiduxjBzxVB/J83Yo5FvPhdGxl9c2MdIg8UdCU0PS7LTVIjVVdt83lp1gzq02feXwdztCC5Ux
 xlzL6xTDYER6aCfXy8aGo7qkVqxLsGTjKJlzQcfxCANW/I/X14NtvnEBJrJuQiy0aXZzY1n09
 3nPlsHpXLg4QP2Hb16Bp5oMigzLb8HecYy41VO4YfvRuRibZxBUkinoDoExG+G
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace (flags & DQUOT_SPACE_RESERVE) with
variable reserve.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
=2D--
 fs/quota/dquot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index fc20e06c56ba..00de508f9d2e 100644
=2D-- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1663,7 +1663,7 @@ int __dquot_alloc_space(struct inode *inode, qsize_t=
 number, int flags)
 	for (cnt =3D 0; cnt < MAXQUOTAS; cnt++) {
 		if (!dquots[cnt])
 			continue;
-		if (flags & DQUOT_SPACE_RESERVE) {
+		if (reserve) {
 			ret =3D dquot_add_space(dquots[cnt], 0, number, flags,
 					      &warn[cnt]);
 		} else {
@@ -1676,7 +1676,7 @@ int __dquot_alloc_space(struct inode *inode, qsize_t=
 number, int flags)
 				if (!dquots[cnt])
 					continue;
 				spin_lock(&dquots[cnt]->dq_dqb_lock);
-				if (flags & DQUOT_SPACE_RESERVE) {
+				if (reserve) {
 					dquots[cnt]->dq_dqb.dqb_rsvspace -=3D
 									number;
 				} else {
=2D-
2.20.1

