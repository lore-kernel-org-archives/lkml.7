Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F992C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 19:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F0BC2190F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 19:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732540AbfJITOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 15:14:45 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:45961 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731801AbfJITLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:11:15 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MeknF-1hiOma24ph-00ao3W; Wed, 09 Oct 2019 21:11:13 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-bluetooth@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Subject: [PATCH v6 19/43] compat_ioctl: remove HCIUART handling
Date:   Wed,  9 Oct 2019 21:10:19 +0200
Message-Id: <20191009191044.308087-19-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191009190853.245077-1-arnd@arndb.de>
References: <20191009190853.245077-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8aOTXX6TdEpU5/KgUIDONK80ND60yvXM5iK1bsPvn2pkU6Qv7sB
 n/GqURBo1FAIM5bXKDZazKJNmUMRNOCbXlFqat9iQsMxjMHEOb1c/aeZJIVOlrfV238DfTO
 kwvpU5H7UvxKocPekysrSHac5yjk8q0H/UkP0dhbsP+jMXmAwlylYAfz23ozNqL1nlUZ8Rq
 zPi3DjTuBjmifhy+Ncn7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SrUTzCjBBoI=:BECAHyoNcZAW+KdZHIWkUJ
 2C39Q9P1Dd/xKvUP3Jsq0hr/FmPw46oP2wGHfrYJ5XzoQXHHWNsuNccN/bjT2E2c5x2Xn8M/X
 ezAZPafZ5IlFnRsaWK0OWDO2MG0NUeO7R0Qn/fvx85MFFy5nJ9ULFM7kxwz+e/nEAVyd0NKZw
 0PExVtFaIkubIXtjIhsrUxQNMZQxK/0xPS77hkL/ILy+TyZYeY+bnKpOGh1nqABGHvvVJutLd
 yj+lEdtRdp0dBodYoww7V0xXEwSxXwGaOUE6gJoTHtbEI4qxmRN0OYNdr/CPUUk/hLa54rCJR
 WivIwdUieHhhtM1PeTxsLbCEMQTDUHlSHlXKVVzNXeiUE94lS25xNUi/2xZDLbNc8zpnq/C5f
 PE/g7EYT9egMa6u+IkveEtFUyM3dvHHOC2tnDOHo60UpWU4W4XKb/VwAMd6WJcQmfDNKeuQyo
 HMJxG9gc0lkg+kA7r8CV6Sr3b359LYoMTvEk5r8dGOKx9XWYYjsTVswgHoVg8RRI3m5FYW9ek
 DJAfXEMHu7+EMGbXQQBf535jz/VAgZI2js1TauHADNOwzkeCeviTqMPf3r+/TsN+blUMrr0tO
 lDI6A+InPPdbUcXvJ9/D6hZSQXKtFYOwWOcFxMWGrKh/ANvTTqU54/J/8nd7KfBE2EZ5rNrT5
 FJ125P6CJWssSCQTPj1Lw0UD/BsqqKRXb5Ebq9K0naUWJE+mNrwjJphtkHRDWXQazxtKILNAU
 bUN4s0FH3ujrGTB8/Wmjsclu8gOABaDqkM4zrQcjDdEr7n0LpOSJtKntIiRnnyHmYP39KTnxP
 bGprJkQ9uUQ6Q/pwoOAXUTqyy+QQCNDKof9cM+olwAYI4B2PEsFcYUzdFJYaqaAyQ1XHxfbxd
 0gOha65Em5TnZKzkHHGQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of commit f0193d3ea73b ("change semantics of ldisc ->compat_ioctl()"),
all hciuart ioctl commands are handled correctly in the driver, and we
never need to go through the table here.

Cc: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 9302157d1471..758b8b934b70 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -353,13 +353,6 @@ static int ppp_scompress(struct file *file, unsigned int cmd,
 	return do_ioctl(file, PPPIOCSCOMPRESS, (unsigned long) odata);
 }
 
-/* Bluetooth ioctls */
-#define HCIUARTSETPROTO		_IOW('U', 200, int)
-#define HCIUARTGETPROTO		_IOR('U', 201, int)
-#define HCIUARTGETDEVICE	_IOR('U', 202, int)
-#define HCIUARTSETFLAGS		_IOW('U', 203, int)
-#define HCIUARTGETFLAGS		_IOR('U', 204, int)
-
 /*
  * simple reversible transform to make our table more evenly
  * distributed after sorting.
@@ -642,12 +635,6 @@ COMPATIBLE_IOCTL(RNDGETPOOL)
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

