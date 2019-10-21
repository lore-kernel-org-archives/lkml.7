Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2C7CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054362089C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbfJUKHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 06:07:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34189 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfJUKHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:07:31 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iMUaq-0006Yb-JY; Mon, 21 Oct 2019 12:07:16 +0200
Date:   Mon, 21 Oct 2019 12:07:15 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andreas Schwab <schwab@linux-m68k.org>
cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH] lib/vdso: Make clock_getres() POSIX compliant again
In-Reply-To: <87eez7glre.fsf@igel.home>
Message-ID: <alpine.DEB.2.21.1910211202260.1904@nanos.tec.linutronix.de>
References: <0fc22a08-31d9-e4d1-557e-bf5b482a9a20__6444.28012180782$1571503753$gmane$org@c-s.fr> <87v9skcznp.fsf@igel.home> <ed65e4c6-2fe0-2f5c-f667-5a81b19eb073@c-s.fr> <87tv83zqt1.fsf@hase.home> <b64c367b-d1e5-bf26-d452-145c0be6e30a@c-s.fr>
 <alpine.DEB.2.21.1910201243580.2090@nanos.tec.linutronix.de> <875zkjipra.fsf@igel.home> <alpine.DEB.2.21.1910201731070.2090@nanos.tec.linutronix.de> <87r237h01a.fsf@igel.home> <alpine.DEB.2.21.1910202145160.2090@nanos.tec.linutronix.de>
 <87eez7glre.fsf@igel.home>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent commit removed the NULL pointer check from the clock_getres()
implementation causing a test case to fault.

POSIX requires an explicit NULL pointer check for clock_getres() aside of
the validity check of the clock_id argument for obscure reasons.

Add it back for both 32bit and 64bit.

Note, this is only a partial revert of the offending commit which does not
bring back the broken fallback invocation in the the 32bit compat
implementations of clock_getres() and clock_gettime().

Fixes: a9446a906f52 ("lib/vdso/32: Remove inconsistent NULL pointer checks")
Reported-by: Andreas Schwab <schwab@linux-m68k.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
---
 lib/vdso/gettimeofday.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -214,9 +214,10 @@ int __cvdso_clock_getres_common(clockid_
 		return -1;
 	}
 
-	res->tv_sec = 0;
-	res->tv_nsec = ns;
-
+	if (likely(res)) {
+		res->tv_sec = 0;
+		res->tv_nsec = ns;
+	}
 	return 0;
 }
 
@@ -245,7 +246,7 @@ static __maybe_unused int
 		ret = clock_getres_fallback(clock, &ts);
 #endif
 
-	if (likely(!ret)) {
+	if (likely(!ret && res)) {
 		res->tv_sec = ts.tv_sec;
 		res->tv_nsec = ts.tv_nsec;
 	}
