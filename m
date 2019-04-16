Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251BAC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC7B920880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730768AbfDPUbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:31:52 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:43555 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730325AbfDPUbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 16:31:52 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N2mS2-1grMbt2AaS-0134ab; Tue, 16 Apr 2019 22:31:45 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Yafang Shao <laoar.shao@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net] socket: fix compat SO_RCVTIMEO_NEW/SO_SNDTIMEO_NEW
Date:   Tue, 16 Apr 2019 22:31:14 +0200
Message-Id: <20190416203143.408835-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Gr+wKH+d/ofnFqh9hLhzKvW3GV6jgcB8Gk07iFcnWJLu7KZp6KQ
 T0DZ2ua5K4qyTidoFk2vc5V09AexvVg9OsVbQ5ZddpsrKi4T71xjHf/0pU/stJGwMTSVPLO
 DDg8OI/horOdut6seP63iljYhZwtKseZDwtf2NaSQyBSWYVzzm9mK4WqKKnTIuW3OFSPyGv
 awUJYR+6iO/0EO2KvXcoA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8nIufYNRBU0=:gBihqo+8yzCf1wLnfqevyu
 ERX87mA2zQfsckvPNyRxkKNeKO/i8jG8mqtbtBPO9fiyRCf7X1lehH9KQUCfdzhXIUya/P0bK
 ATPrPzj8NbNdEnB7Vz/MFIE0eJTuLNFz2g0BLlWe9UhGU226x13xT0sw2jRjZsOnCeB9nv+fj
 feMMPSHbBWkKWpYUNw+5DfK7h/r8Dax3RKY+zdvvBrkpFZl6ujT++zrgzeKdHHAsaZoWthYz4
 dwhUkfxo+TJY+SZ/tMHR18IvB/gbhtx7c1ngxbNA3Jishnghs0aiqxLT9P4xpsjJCMMhnT+MJ
 Hjk54o6PhkJ6I+COIzp4wjpNLprdcMDRdeUMeyoJLs47i/hiLkaxonG6FtD6rGCHL6tKmaVSZ
 JKBJJ4UFABFgz0Yoozju9+fZ05lQxWXZMiW3FX9bx+rVQLTp3RRw+T04Pg3I8YlenfsK92hoC
 lg2XOb6RuRlq7Iw9YUzYD8BN6mutmknLeNcrjNhJxZ2AmrmfmpElSZCL0706BZjrPBIup8xMx
 Y5M697YAkKQs3d/nWRui7VXb4uwbUkWWs4/adHSP07igGSLHYA2oQ4hKBD/ssNGMAQz0cTbVu
 rWNxZnveX7F1ho0d8CqvodhZvq77cNRrYY8nQ9Y32OyejouQDYgIwci2lomay/niUsdU6rMcl
 zL05yptiDxxd6JHAPUXWc/dPdiVBTE2CKRH+YUkeIs3Vj0OolE923AdbOy97JoFg8iMmNr4g2
 n0scb2LnGNwkLXcAuxQ3ENQCFM3cTRY1zUfVgQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like the new socket options only work correctly
for native execution, but in case of compat mode fall back
to the old behavior as we ignore the 'old_timeval' flag.

Rework so we treat SO_RCVTIMEO_NEW/SO_SNDTIMEO_NEW the
same way in compat and native 32-bit mode.

Cc: Deepa Dinamani <deepa.kernel@gmail.com>
Fixes: a9beb86ae6e5 ("sock: Add SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---

 net/core/sock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index dc7c31d66200..1e418c0b3b73 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -348,7 +348,7 @@ static int sock_get_timeout(long timeo, void *optval, bool old_timeval)
 		tv.tv_usec = ((timeo % HZ) * USEC_PER_SEC) / HZ;
 	}
 
-	if (in_compat_syscall() && !COMPAT_USE_64BIT_TIME) {
+	if (old_timeval && in_compat_syscall() && !COMPAT_USE_64BIT_TIME) {
 		struct old_timeval32 tv32 = { tv.tv_sec, tv.tv_usec };
 		*(struct old_timeval32 *)optval = tv32;
 		return sizeof(tv32);
@@ -372,7 +372,7 @@ static int sock_set_timeout(long *timeo_p, char __user *optval, int optlen, bool
 {
 	struct __kernel_sock_timeval tv;
 
-	if (in_compat_syscall() && !COMPAT_USE_64BIT_TIME) {
+	if (old_timeval && in_compat_syscall() && !COMPAT_USE_64BIT_TIME) {
 		struct old_timeval32 tv32;
 
 		if (optlen < sizeof(tv32))
-- 
2.20.0

