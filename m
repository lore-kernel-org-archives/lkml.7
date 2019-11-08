Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FA6FC6197
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE5820869
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731945AbfKHVKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 16:10:38 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:40383 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbfKHVKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:10:37 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MvJwN-1hbuBO0HpZ-00rIaY; Fri, 08 Nov 2019 22:10:35 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH 06/23] y2038: vdso: nds32: open-code timespec_add_ns()
Date:   Fri,  8 Nov 2019 22:07:26 +0100
Message-Id: <20191108210824.1534248-6-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191108210236.1296047-1-arnd@arndb.de>
References: <20191108210236.1296047-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YuJmh0hdaoXKPB496OqQwH5zF3mK0xLxqrenBpCosELtgojDeG6
 0ydOvFj7+DITM/cL850c75HGzUSrstupuG0x40X8tVSgqOJJEzjQoFnTixpW6lIarskuNf3
 8p9iwlohOgg5Ic09T3K1Xsm5JNORDInkJ0iuOX2hm3SuHbgw32nVkc0sU5iORDrl13FAf2d
 NDuF1g3kxV+9ZuX/vNNUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W7ipudwxVNs=:i23o+CyoqGzloOAK6blQ7L
 H0nBM6ZEN0Zz8/3kx0MorJxywha7JE8NNOPLmX8OSej99FDv/kuAjpwHE6gav7zf1A+dTf97J
 gPPxe+E4J34Moz4o9ROc+e1l68aXTat3nwheFhTxO3jDCEJlbICgpoB95HVxxeDDC7L0bYt3I
 aVknHQ3wLXIJUnQN0Zk+J9TQyqpq2GHFlj+WA5/PQbsE8ZFqCvF87mzNZjoImu7viL4itYUPn
 xVYVEo79PeD4ZrN0iTzdZ3D3TU+PzDSM4YEAcekYxv8OPsG6ua2LBAg/QBAxCll1kJA4CRMv7
 6SPdy4TF0ym+xNZ+1uPxXAlyXJJ0dwHsfeffms8Z3HWZC+521wLxBYhTj0qErNqxNUXoxwKiZ
 J0gZec1g3FfSuw/+eUkyjFW/awCWr3rKLhP+FTBqQLhGf2Pf5j1+b+xJM+mNMbgE+j3rf47pX
 xwPgZFdphFgoUpmjLSWDmvUzheodPhJi9mS9JuLp90v33vGzT33E8VwE+SplX5rp8JOLQQ1YG
 UWrFZ2vpTi3vLFKP52pnKVODkYiTYr4lavfLqfXFzL/4iqSwxL1cV3LwFRB9xNyQcCUeHdd3o
 TNZ02u6yXaC475jY/OpDb8KcBx1NQvUUZ9FzoOinV1AgR92jJsBvNqm3VIbyHg50NbTUgwXd4
 +/OEgMRJMwURcdcMenvbgLm12/UGdJrQEoifs1mU2M5IldNTtrPmv4NrYV87pj4Ft5ItgyRs5
 XNUTzZwxVGmif6tUMojrweawqqLfcRdW5h/witqeF0KQdoSbpRLN1wXvOh85s5T3Bt9flDh3P
 xwx3dSKCVt117fCza5IlcVAfqreCo6kVwaFVVfY4huHvhnbf9ydVEHZpRevXylWyEXIpsJ5mz
 tdlbq72Zg/YV+Dtf8ZFA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nds32 vdso is now the last user of the deprecated timespec_add_ns().

Change it to an open-coded version like the one it already uses in
do_realtime(). What we should really do though is to use the
generic vdso implementation that is now used in x86. arm and mips.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/nds32/kernel/vdso/gettimeofday.c | 33 ++++++++++++---------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/arch/nds32/kernel/vdso/gettimeofday.c b/arch/nds32/kernel/vdso/gettimeofday.c
index 687abc7145f5..9ec03cf0ec54 100644
--- a/arch/nds32/kernel/vdso/gettimeofday.c
+++ b/arch/nds32/kernel/vdso/gettimeofday.c
@@ -81,22 +81,20 @@ static notrace int do_realtime_coarse(struct __kernel_old_timespec *ts,
 static notrace int do_monotonic_coarse(struct __kernel_old_timespec *ts,
 				       struct vdso_data *vdata)
 {
-	struct timespec tomono;
 	u32 seq;
+	u64 ns;
 
 	do {
 		seq = vdso_read_begin(vdata);
 
-		ts->tv_sec = vdata->xtime_coarse_sec;
-		ts->tv_nsec = vdata->xtime_coarse_nsec;
-
-		tomono.tv_sec = vdata->wtm_clock_sec;
-		tomono.tv_nsec = vdata->wtm_clock_nsec;
+		ts->tv_sec = vdata->xtime_coarse_sec + vdata->wtm_clock_sec;
+		ns = vdata->xtime_coarse_nsec + vdata->wtm_clock_nsec;
 
 	} while (vdso_read_retry(vdata, seq));
 
-	ts->tv_sec += tomono.tv_sec;
-	timespec_add_ns(ts, tomono.tv_nsec);
+	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
+	ts->tv_nsec = ns;
+
 	return 0;
 }
 
@@ -135,26 +133,25 @@ static notrace int do_realtime(struct __kernel_old_timespec *ts, struct vdso_dat
 
 static notrace int do_monotonic(struct __kernel_old_timespec *ts, struct vdso_data *vdata)
 {
-	struct timespec tomono;
-	u64 nsecs;
+	u64 ns;
 	u32 seq;
 
 	do {
 		seq = vdso_read_begin(vdata);
 
 		ts->tv_sec = vdata->xtime_clock_sec;
-		nsecs = vdata->xtime_clock_nsec;
-		nsecs += vgetsns(vdata);
-		nsecs >>= vdata->cs_shift;
+		ns = vdata->xtime_clock_nsec;
+		ns += vgetsns(vdata);
+		ns >>= vdata->cs_shift;
 
-		tomono.tv_sec = vdata->wtm_clock_sec;
-		tomono.tv_nsec = vdata->wtm_clock_nsec;
+		ts->tv_sec += vdata->wtm_clock_sec;
+		ns += vdata->wtm_clock_nsec;
 
 	} while (vdso_read_retry(vdata, seq));
 
-	ts->tv_sec += tomono.tv_sec;
-	ts->tv_nsec = 0;
-	timespec_add_ns(ts, nsecs + tomono.tv_nsec);
+	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
+	ts->tv_nsec = ns;
+
 	return 0;
 }
 
-- 
2.20.0

