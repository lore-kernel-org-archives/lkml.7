Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A23FC6196
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A04E214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732914AbfKHVPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 16:15:33 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:33779 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732101AbfKHVPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:15:32 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N3bCH-1hlI2n3QdX-010fBS; Fri, 08 Nov 2019 22:15:26 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH 14/23] y2038: make ns_to_compat_timeval use __kernel_old_timeval
Date:   Fri,  8 Nov 2019 22:12:13 +0100
Message-Id: <20191108211323.1806194-5-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191108210236.1296047-1-arnd@arndb.de>
References: <20191108210236.1296047-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Pfme16M9JKU/1lQYMjSUnUlUlunFko9yGD1/qMR1+QbuE78z4pf
 ZHI88gH+wz2J6OBPQID1DtDxbizptVLZT1jhAxDXEzsVfN7ghgDqvT96Hx+hRxj+0iznIqt
 /PVpStGxYFsdM5EoOazNF0V9hzc3ECTCD9sJDscIIwFm3LzbpdHtOT9CepwMwhnnRp1dkgh
 bgsEBYh4LC7QcFloIaBXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BXLkiyXx/ek=:6ux6MXiobQDoYSdUr8teJu
 Qdu+4y/M2l60Hz+zNN940bfImgo3biC7NDpp6eKqPDDRzYbC71KWA7Hofa/py/3EpjDnbZTVL
 hyl8IuisupTzJvHQ9dtiFcGhn7gNrAduwMr24dNU/3NYUpiqpaiFN2oamfbtvbXkQstLty5ev
 DVKLexf7lAzU24EiE9thHI8iU54ku+p4C2kHt0ocPp9mHDm/zCvb34TrqLDnC8cCcbsVZ/NbF
 lVyLegS3fhlsHkVaAUUuYjFsGpg0hl9MfmfdcGh4QtJ1q0SlOwFny8quFBhuy9anyyiLd7Tyy
 1RP/STEVAqsEXCOr9O0frVj38AbbWYAJ6ynQ002lStuq1uq03mzUq4faqi8nm7lRB2LYj8975
 3qPOLAL2Gk/kh3ZulEQNHXtaGefQ9j09PYYI9rENTnMIAsLn5IjymW4cR73UBWw7sdtWDpaP/
 hg47QQSK8cXXbl/jKBPiPCy3TpgOo7T1L9DAALv71cYgRk2mUhR9sc0On1enZS5IcJwKpwM4f
 aXGKhyE5IUPWFeEKn72L3yQs83CdLkqF2pG9gOxbGP7gdYKk032Nme0eKNZKue4Xi3Lzt76J5
 8pUhtsrOmdPBrXgi1EjrQ1T+Qy431V6ptjBBYO9iAgxK+epkMXJaOdlHUsrNkksM7g/qQyDIK
 Xrcil36hElxlcsPhlGe2PP1vWGDp0FKgWVMI6jo3eciulj4QUes7ERrPc81OkzB/fpWzXIxOn
 WveEHEHcg2Q+e+gGmHwxeVHyM6h4SaOLX4KBA9AxaZ1TU0tHIjL1CZeW7P6c8Jez3+o7w78A/
 81zzirRiIYllZL+9/ABM92Za7yx/GU5Ywl5mpUSpDbRjlkPNcpQmX7To9iWb0A+L+6hwrWSzM
 KCrNO2bIVQpTWZ2nGtHw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This gets us one step closer to removing 'struct timeval' from the
kernel. We still keep __kernel_old_timeval for interfaces that we cannot
fix otherwise, and ns_to_compat_timeval() is provably safe for interfaces
that are legitimate users of __kernel_old_timeval on native kernels,
so this is an obvious change.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/compat.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index 16dafd9f4b86..3735a22bfbc0 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -937,10 +937,10 @@ static inline bool in_compat_syscall(void) { return is_compat_task(); }
  */
 static inline struct old_timeval32 ns_to_old_timeval32(s64 nsec)
 {
-	struct timeval tv;
+	struct __kernel_old_timeval tv;
 	struct old_timeval32 ctv;
 
-	tv = ns_to_timeval(nsec);
+	tv = ns_to_kernel_old_timeval(nsec);
 	ctv.tv_sec = tv.tv_sec;
 	ctv.tv_usec = tv.tv_usec;
 
-- 
2.20.0

