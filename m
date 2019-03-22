Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D892EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF1572183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfCVPsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:48:53 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:47103 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbfCVPsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:48:52 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MEFrX-1hEp4Q01fp-00AE6h; Fri, 22 Mar 2019 16:48:43 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     stable@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Waiman Long <longman@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BACKPORT 4.4.y 20/25] Hang/soft lockup in d_invalidate with simultaneous calls
Date:   Fri, 22 Mar 2019 16:44:11 +0100
Message-Id: <20190322154425.3852517-21-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190322154425.3852517-1-arnd@arndb.de>
References: <20190322154425.3852517-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:d0xlr2K8dEQfJy6mi20uQzl6SrNBL/1a9vz7njWi1W20fXOfw8f
 GUHCunn54toqlYpKmZF+xbWn2Rb9zfUlYnlvnOB6DM75R1rrzn49oKK/1le/DiOhxaG68zZ
 qvZOJYAKt4IEkGuvLhENosiVKKpcdULM6Io5PU6pI9Pgeqsdrp1BNMYlb9xlAWy/sXB9cQN
 bs/inoqlhqiJHdsk1qCPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Yq39bHp/YZE=:q+MAwvTwnQSOcoeRAF3q98
 PsCIkmtdtFzFVcYkMwg76R7g9q4iuuug4uyDc8N3DTb2T3aPQM9lIsqnJV6DUqjsndCtR5YIT
 s+PxkL7nYvGQz1e4rgK59SZhrp5z33buPElBD45WbcTKcHM0FbAQSHdpQH202QlQpnONMivfi
 nr0vmG5hXFPQWsF5iy5h5/waGxiSM6Fxh9s+Xq4Q5RLeXrPrw5MVtaD0qD1/OU7R8mF4eDYdC
 ySxb+U8dQINIudpPLnbKLtNRuC1lGmVwubX30YxG/zgL0XJhDnve/XWcQfsj9Cqp6tmvEIzKP
 6u4n7S28KBir1yAg85+mOE113RuQByb1ecNPO01S4DqOmXpkx3sgAd7whrYD0ubqwLStuG0P9
 jKpeZHfr3oM3XBhQLinp26vKLhea+jhStVF/cwLtFXU+XCBIJFLLdZp2RgtNcRdXxb5jlAFs3
 JjXsN2gjmG5tXnAXDrmHnXlpixnCCCiSov5F15Hitb7dr+IU816dSUo0+jLev4sgxv2Z5OPcv
 PRB5VLoPAmkizgHDU+hOk62M1X66Kc9HF3gucww1Rm5VdhtnwpBpP4W/yvExKulmiDgpL7FKP
 tR2zNFYpY48USqkhOsFeqa0FRnyftBNqJ/pyIRBgrqqgc95pvYJkssj2/Zguj2tfghaqlZys+
 9WSl7XZBUOrkFulcuYKNO1VegmmSPXQZR7g/DHByq5jSgDKBBe8z2PepYZ17ukoNnMWFxww47
 +Ug19tpB1N+oQn7AIZn6JbNDH2hYRrb0rh9mlQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@ZenIV.linux.org.uk>

It's not hard to trigger a bunch of d_invalidate() on the same
dentry in parallel.  They end up fighting each other - any
dentry picked for removal by one will be skipped by the rest
and we'll go for the next iteration through the entire
subtree, even if everything is being skipped.  Morevoer, we
immediately go back to scanning the subtree.  The only thing
we really need is to dissolve all mounts in the subtree and
as soon as we've nothing left to do, we can just unhash the
dentry and bugger off.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
(cherry picked from commit 81be24d263dbeddaba35827036d6f6787a59c2c3)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/dcache.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 9ffe60702299..cb554e406545 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1510,7 +1510,7 @@ static void check_and_drop(void *_data)
 {
 	struct detach_data *data = _data;
 
-	if (!data->mountpoint && !data->select.found)
+	if (!data->mountpoint && list_empty(&data->select.dispose))
 		__d_drop(data->select.start);
 }
 
@@ -1552,17 +1552,15 @@ void d_invalidate(struct dentry *dentry)
 
 		d_walk(dentry, &data, detach_and_collect, check_and_drop);
 
-		if (data.select.found)
+		if (!list_empty(&data.select.dispose))
 			shrink_dentry_list(&data.select.dispose);
+		else if (!data.mountpoint)
+			return;
 
 		if (data.mountpoint) {
 			detach_mounts(data.mountpoint);
 			dput(data.mountpoint);
 		}
-
-		if (!data.mountpoint && !data.select.found)
-			break;
-
 		cond_resched();
 	}
 }
-- 
2.20.0

