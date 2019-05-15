Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A243C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BE2920843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557918752;
	bh=88gLlCXlkEflQacDbDgamQEB9cQoJE9oCERDmQ9beEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JN2WT8X8mw72lHtf9BTRcWn+8IyEDdvzfHQWcc2SOhC0euQlLJKLwqdAZGPWVnaMN
	 TXUXvbi8Nh30ouplfrsQlblPU7YKRoDIfwilJzD3yfVjdBHCKeBnFPYxOxwfhyTV+H
	 tZspNH1KortzK1pxxGTr4xLfT19lYKYMs1O+3xfU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbfEOLMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:12:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:47424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729758AbfEOLMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:12:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F17B2168B;
        Wed, 15 May 2019 11:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918742;
        bh=88gLlCXlkEflQacDbDgamQEB9cQoJE9oCERDmQ9beEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kCsGOzCOSpNO5pSNKyuZR7vwokTV3fpxgNOr9r1V4701Ryk9sILPXo9DZ7K7K1dQb
         DfZm8c9I9Qp/hp3+sad16/nOo0QFe5EZCe3HnjskwxnK0SdSZpY4QHf3kDTonbWNqn
         Cxls526xf+Dd+SEmYHSZgyHArkqyUohzqGsAAGKA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tyler Hicks <tyhicks@canonical.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.4 246/266] x86/speculation/mds: Print SMT vulnerable on MSBDS with mitigations off
Date:   Wed, 15 May 2019 12:55:53 +0200
Message-Id: <20190515090731.330285178@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090722.696531131@linuxfoundation.org>
References: <20190515090722.696531131@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1091,7 +1091,8 @@ static ssize_t mds_show_state(char *buf)
 
 	if (boot_cpu_has(X86_BUG_MSBDS_ONLY)) {
 		return sprintf(buf, "%s; SMT %s\n", mds_strings[mds_mitigation],
-			       sched_smt_active() ? "mitigated" : "disabled");
+			       (mds_mitigation == MDS_MITIGATION_OFF ? "vulnerable" :
+			        sched_smt_active() ? "mitigated" : "disabled"));
 	}
 
 	return sprintf(buf, "%s; SMT %s\n", mds_strings[mds_mitigation],


