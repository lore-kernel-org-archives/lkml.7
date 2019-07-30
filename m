Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD27C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 20:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00DFD20659
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 20:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfG3UBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 16:01:50 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:53131 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfG3UBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 16:01:50 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MYNW8-1hokhs3crS-00VLjo; Tue, 30 Jul 2019 22:01:46 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v5 20/29] compat_ioctl: remove HCIUART handling
Date:   Tue, 30 Jul 2019 22:01:25 +0200
Message-Id: <20190730200145.1081541-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190730192552.4014288-1-arnd@arndb.de>
References: <20190730192552.4014288-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:noHB01zjETkbsqArpq8t35RXjwvYROuKxnK7CTrTSdVMP/m6xIA
 Bg6Y8fOZDoSMksrI/4s5Y65kcjgyeCRuqHwupI/dW8LyVCXDqegBf8PvswAgWNsRC87YYii
 QNWYIwgnUzezFv6mLd9ZS3tWXosJS2wgX3+8rGrTAdfvm4ShmeLdDO4X85++sXTeEAv5AEt
 vFnaf8hLe7XHH4XDb3k1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:80bHOsZlkj8=:vWtIK+qyk1I0xKHajkNfGR
 Fgy6NWqO1IxhILt0eRVd999Fa5T0+ny7p1/janZSqpGwxW3hniU1yvf7fgtnAAvK9EqcZB2el
 Z7vQM3ZH0eAN20ebceBIA2c/2EeDiGPCpYTL+RN1QGaHFAG+wPp2rgc+wrgLrfYPiRLE45IQR
 L61ICWAqJ/jziTWMrQKbJFCoxX8nVbi+5p6U0FdzzCH+hJD5GuQX+YF3Xikn4WwhENzvUmq3c
 IP+wJjCpYA2T7sLRrb/ikY1QhucNg1Dy3j+EP91LQfWg2hP0EKk5Wrk4Tuyr9iU4OKY/FmKHN
 N8AiBxBXLTlt2mah3erwmIl/Ghir8Uh8Oxn6hPpI+77ReGswB6b9SEkMMMwnL9rUtT21WF4q2
 ry1raKZ0iMdJSluRevlacVy0vUCdQ07J6GT1u6bMtjcXagtdM55JNgrhJsYXP5ZHPUITZo4EO
 oEoAukOK2OUbsVMLEFktYYZpfWbhFGjTFhWicL0orAKo8J7yZRL6CPbGv29qt7eK6Y6su+7bc
 5G8Ee5+PqxUP7L/8Q8ZkgHA6uEDqiJvenOJAsZhQFpwx5r1TqmGynk0qqj+ehIjc366lWO3go
 idf+U+I3HzZs013zdSPMqHFBm8uB+1V4oCDzffXnIz96b2MLZe6SJGp+X1rcktRVzSisOBT++
 MaiUcCCVfJxRvsTqZdPMVpvXzH+Z03Vv9A0E8TLYsTYkclVK8jNV6t2y5V1AP5a0cGkyxwzvp
 /ua8DfFpBeazw/Y7E6fsbRp1Ukyr19i5YpcuEQ==
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

