Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09C7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C7D204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552902273;
	bh=mXTMfz7QTPqqjiriOS4It/OE672eltL+GcReWsim98o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L5mXMpzbiDuAvvD7tJkh4j/+kUJk+QhnmLCE02j5Az/KDxASmtyXsT+DO0hvQVr8H
	 ATwPmu12Nm2hcizAg2nIDBtvoN9U+T7erAwaOQMI58u8Qp8qQgLl1LkWu3N0hDXDN1
	 eXWNlKACv4SWfnBnk0zWyVRG37bOgPQVDib2ua3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbfCRJoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:44:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:38238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727891AbfCRJay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:30:54 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACC892087C;
        Mon, 18 Mar 2019 09:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901453;
        bh=mXTMfz7QTPqqjiriOS4It/OE672eltL+GcReWsim98o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bOTKRT06R2j3wknEuGCUxFXGfzZ6dBHrZP2njS4pNPx+R08KAF18TFCPUcs6NP1F0
         6Fb3vMH7b/jU1YZwiE6AWc/LrFatKaz2Sxe05YqUF1U0m4npWbbZRDcjz5aueIkmxZ
         DJnqDhMNbJ+RWQJ6YEHxH1B5lQ3RmYmhVXar2Nsg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Jones <tonyj@suse.com>,
        "DSouza, Nelson" <nelson.dsouza@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, eranian@google.com,
        jolsa@redhat.com, stable@kernel.org
Subject: [PATCH 4.20 48/52] perf/x86/intel: Fix memory corruption
Date:   Mon, 18 Mar 2019 10:25:35 +0100
Message-Id: <20190318083849.440027392@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318083843.398913295@linuxfoundation.org>
References: <20190318083843.398913295@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit ede271b059463731cbd6dffe55ffd70d7dbe8392 upstream.

Through:

  validate_event()
    x86_pmu.get_event_constraints(.idx=-1)
      tfa_get_event_constraints()
        dyn_constraint()

cpuc->constraint_list[-1] is used, which is an obvious out-of-bound access.

In this case, simply skip the TFA constraint code, there is no event
constraint with just PMC3, therefore the code will never result in the
empty set.

Fixes: 400816f60c54 ("perf/x86/intel: Implement support for TSX Force Abort")
Reported-by: Tony Jones <tonyj@suse.com>
Reported-by: "DSouza, Nelson" <nelson.dsouza@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tony Jones <tonyj@suse.com>
Tested-by: "DSouza, Nelson" <nelson.dsouza@intel.com>
Cc: eranian@google.com
Cc: jolsa@redhat.com
Cc: stable@kernel.org
Link: https://lkml.kernel.org/r/20190314130705.441549378@infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/events/intel/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3398,7 +3398,7 @@ tfa_get_event_constraints(struct cpu_hw_
 	/*
 	 * Without TFA we must not use PMC3.
 	 */
-	if (!allow_tsx_force_abort && test_bit(3, c->idxmsk)) {
+	if (!allow_tsx_force_abort && test_bit(3, c->idxmsk) && idx >= 0) {
 		c = dyn_constraint(cpuc, c, idx);
 		c->idxmsk64 &= ~(1ULL << 3);
 		c->weight--;


