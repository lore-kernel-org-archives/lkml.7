Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E09EC341C8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A1C24689
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfLMUxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 15:53:50 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:43623 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfLMUxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 15:53:50 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MtPzy-1hrbs61fsU-00uu3R; Fri, 13 Dec 2019 21:53:44 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 09/24] quota: avoid time_t in v1_disk_dqblk definition
Date:   Fri, 13 Dec 2019 21:52:14 +0100
Message-Id: <20191213205221.3787308-6-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191213204936.3643476-1-arnd@arndb.de>
References: <20191213204936.3643476-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JA7cpk/zrzgly8p4eMkgobmlMJH0BMfBiwOJE0Fs7DHb5ktCnCi
 4ESYtf31/8tN6P0cPzC0yFn0laxJc/QFQXw5yqhqeqf3hw+o2aPYCSrC4uyq80+26JiYCSk
 f9UCvx2M1LKkwJ0iBS7og9top0ULb6NFXd4WfS6ObMnEuC8Cqstc2AzAtAYJEyVJG72cw0a
 nk/+WMbJdV84YlXKRlXTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DY+jB6jkCoE=:LPR123PfwdTfbPBsMalpyh
 XsMoebsMEG+HS54UZhHzOguZ4kpUBUtJVW/uhMldV9SSQXHLyMyAwrFB23cEB62cU+g0PgZU1
 yapEPpJfZbWtRzGP4uoB2dz6fdQf/hKB4Sp26WQ7pURg3j8VmUBMZfzbQ7FbImq2iwjMttdnx
 J0HUvbCf209VXVwRQdc1gtlTh7PA4GEfwPBXtKL84dvdxMHibA+hHIlTXk5NLKhI/ilPV6+rk
 KxPxW3UNxXKiimGzrnJluGgckq4j066VjdBFz4kxhA8AHcfi+ohvELwI/dH+tpHNID3/8TyGM
 vQQMlOOdzYsP0vXX2+P2CsysMO/wbFozYDN9M5MDmw6801gisn7euKl4g/tphNdTnHn4DO9El
 ac2+E/4WlNnt0N0t6kyF9Xh3T0aACkbzuMk3+mRReT/x2lAWs+3qeIuY1me0NH1V05wvX5377
 ax2JoShYAdF2XbMMGdswrfoGcvXqSImhNds79AEjAALgvIGtRZwThwFdoCb1hNVvM1CKxmeO5
 moZrMHZoYAEfcus7YSYUHSuVgy6V16trfaV7T7ZGKhRV04QFpa1Sin2SvnG95AMhnBioTV5kS
 CSnpuerWLyEo/T2nyhowzzvZ5D41g4PUSf1JlC1mCYtMp+bCJetXIRJKoiqELcA5K0wdZSD2H
 UIwb75m/MiplnjAn5/izcCtucP5xpSrOAvEq7bO9JKm6pHd3gwxmd22JNOVTS7dl1SeAE3E99
 Uq/qmtkiz19j/nLnE3egxx9+W5ePQTWxJv5I/YGYIPBmT3tXt0/pCDO1qALjUwLh1S7mWODvL
 I/gRizkAwzzjscnH4KO48JzNtFfSHsN1HN/t10WpGV2MjHVzect+1gQ6I9e+KGhjTxO93FNkZ
 WqwSNDnrg0Ee0trcW40w==
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

