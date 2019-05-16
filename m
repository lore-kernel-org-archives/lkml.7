Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E7AC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5686C20833
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbfEPQAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 12:00:41 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43074 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727096AbfEPP6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 11:58:48 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hRImJ-0006zS-Lj; Thu, 16 May 2019 16:58:43 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hRImF-0001Se-0y; Thu, 16 May 2019 16:58:39 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Tyler Hicks" <tyhicks@canonical.com>
Date:   Thu, 16 May 2019 16:55:33 +0100
Message-ID: <lsq.1558022133.66611526@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 78/86] x86/speculation/mds: Print SMT vulnerable on
 MSBDS with mitigations off
In-Reply-To: <lsq.1558022132.52852998@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.68-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit e2c3c94788b08891dcf3dbe608f9880523ecd71b upstream.

This code is only for CPUs which are affected by MSBDS, but are *not*
affected by the other two MDS issues.

For such CPUs, enabling the mds_idle_clear mitigation is enough to
mitigate SMT.

However if user boots with 'mds=off' and still has SMT enabled, we should
not report that SMT is mitigated:

$cat /sys//devices/system/cpu/vulnerabilities/mds
Vulnerable; SMT mitigated

But rather:
Vulnerable; SMT vulnerable

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Tyler Hicks <tyhicks@canonical.com>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20190412215118.294906495@localhost.localdomain
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/cpu/bugs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1156,7 +1156,8 @@ static ssize_t mds_show_state(char *buf)
 
 	if (boot_cpu_has(X86_BUG_MSBDS_ONLY)) {
 		return sprintf(buf, "%s; SMT %s\n", mds_strings[mds_mitigation],
-			       sched_smt_active() ? "mitigated" : "disabled");
+			       (mds_mitigation == MDS_MITIGATION_OFF ? "vulnerable" :
+			        sched_smt_active() ? "mitigated" : "disabled"));
 	}
 
 	return sprintf(buf, "%s; SMT %s\n", mds_strings[mds_mitigation],

