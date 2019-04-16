Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC8FC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F5D20663
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730553AbfDPU2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:28:05 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:43067 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbfDPU2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 16:28:00 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MQMmF-1hU1KW3QCP-00MLi9; Tue, 16 Apr 2019 22:27:57 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 18/26] compat_ioctl: remove HCIUART handling
Date:   Tue, 16 Apr 2019 22:25:39 +0200
Message-Id: <20190416202701.127745-7-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190416202701.127745-1-arnd@arndb.de>
References: <20190416202013.4034148-1-arnd@arndb.de>
 <20190416202701.127745-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:boivb7CwWV0bFt89B3RR2qvpQAzVzaYo05QGrOe2sRKMw5YXRh+
 8CsmlPybzsy/eW9KAAiDzwhfYIM4HNFLpbh4N/+N2BA1+Zmn2H8St3DS74fdn5dRpHQ/pZq
 W6oIyOeiJg7JxbitmkzvTKcIsfkpxggJXuxON1B9RAXe4/sm3LSnyW5ucY37Ut2VXf/6VFS
 5WjtViPx9Xh6FcXRzWzWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bz5QFlz3xZQ=:0fUVQCoXsV0wy15sX8jem0
 q2xNLR6CxZs/1XZVLUAopx/3ENqMHGO3mpivFDaxh0UQtpG5hAcyImhizAunChsOucZQb6Zjj
 vdVkTiSA1QDpe4tedYBQc9Y/w7dUWlBC6rP6t0Aa8SahOvmn8Grkvsrcg/6NfFaIflhoeFWwn
 uDWFTb2+ap3xbGGfqgHePVJoXWza50zV0x84IymbuWvHZ1WoI188xfbfz8Dk0QLH2qzsAMcMP
 g4N9VrQgcJX01mTKSCvHQC9WafwN/AbUJCeAkV9ccDefVauPuvC5VliJ3iBuIzfzELWjYJGi0
 v2eNMsO1HH+Bdta/aN4tAknfgJ7lfAidT0QafxG9cyaJImkaEPAgUE3Al1WyHGjXRQKQtDnjn
 PG0ESwnyYcl2E+mDDQd9m3xN3lQSC1kNzVUuAvryhcHaGmWlR9F/numCYU6AgzKL6su0wDk2Q
 wc3d0+55PyNAC65B+VepIvC2FaKMMaEbySq6S49hIkXHMNF5L+UcRRfrGXjU2kr8ztqONxvbY
 Oezt/yVHPcAMCasp9xf47Y6dqPOcpcSpRChosAU1WUq092fagK0LRergm9f3ot4M1IkVTOEg0
 /zmT3sYsJo2Kgox0XpUpl9fRYxdde89hYNHyRhX9SsL/CDM0Ii8dDD4Mcy3xJeBaznE5P7stu
 FgrAj+RSuxWSHEnmzzEoQIe1wuKovz4spaw2scKY7RL+15lpYQl/Y2oLw8Da36kMbsY+c00Ih
 Rq1fRQmoJTa1oEqPNX9xSqvQkgpgSUaDR6tPyQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of commit f0193d3ea73b ("change semantics of ldisc ->compat_ioctl()"),
all hciuart ioctl commands are handled correctly in the driver, and we
never need to go through the table here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 9024cae05eda..9e96b8b63578 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -273,13 +273,6 @@ static int sg_grt_trans(struct file *file,
 
 #endif /* CONFIG_BLOCK */
 
-/* Bluetooth ioctls */
-#define HCIUARTSETPROTO		_IOW('U', 200, int)
-#define HCIUARTGETPROTO		_IOR('U', 201, int)
-#define HCIUARTGETDEVICE	_IOR('U', 202, int)
-#define HCIUARTSETFLAGS		_IOW('U', 203, int)
-#define HCIUARTGETFLAGS		_IOR('U', 204, int)
-
 /* on ia32 l_start is on a 32-bit boundary */
 #if defined(CONFIG_IA64) || defined(CONFIG_X86_64)
 struct space_resv_32 {
@@ -583,12 +576,6 @@ COMPATIBLE_IOCTL(RNDGETPOOL)
 COMPATIBLE_IOCTL(RNDADDENTROPY)
 COMPATIBLE_IOCTL(RNDZAPENTCNT)
 COMPATIBLE_IOCTL(RNDCLEARPOOL)
-/* Bluetooth */
-COMPATIBLE_IOCTL(HCIUARTSETPROTO)
-COMPATIBLE_IOCTL(HCIUARTGETPROTO)
-COMPATIBLE_IOCTL(HCIUARTGETDEVICE)
-COMPATIBLE_IOCTL(HCIUARTSETFLAGS)
-COMPATIBLE_IOCTL(HCIUARTGETFLAGS)
 /* Misc. */
 COMPATIBLE_IOCTL(PCIIOC_CONTROLLER)
 COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_IO)
-- 
2.20.0

