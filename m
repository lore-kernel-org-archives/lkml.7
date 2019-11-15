Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836B5C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 06:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C180207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 06:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573798930;
	bh=k/QTvKQ7CL52EtvqmQq+zWJX9EG7E24ynNVmGRIe72w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UUuPHmN7dW4YyIdjuqhTOJ+JtjU76OopWnChF0YIHy7rbrtdBZaluik75onXi7QqN
	 C5mcbj+WS2Y7lh2wEIBo9euhHRJTNiHJ/ASgcHK8EvrQURZkFPiVfZl2ZDiKDYG0bU
	 v8q0S/xSuIU1fdkn2H7JOIeFt2PwvPseKHxjdGJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfKOGWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 01:22:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:51156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727550AbfKOGWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 01:22:01 -0500
Received: from localhost (unknown [104.132.150.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B61B42073C;
        Fri, 15 Nov 2019 06:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573798921;
        bh=k/QTvKQ7CL52EtvqmQq+zWJX9EG7E24ynNVmGRIe72w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=18afwdj6kFztacoBFVH1y2nmRLO0hNRKuV3QCoDHV2X73wfs2GZqILybfR74Pso/S
         ec94AV5WCHpWYEjxZPu2F2YWqaMR8Z1kmkrUGXfpr6P2cJqawE9ZgYjSopt59we1F+
         itISkSwKR4tQFtOa5HqpBIcmUqWJKc4YCqcSNtoU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.9 12/31] x86/tsx: Add "auto" option to the tsx= cmdline parameter
Date:   Fri, 15 Nov 2019 14:20:41 +0800
Message-Id: <20191115062014.685532405@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191115062009.813108457@linuxfoundation.org>
References: <20191115062009.813108457@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

commit 7531a3596e3272d1f6841e0d601a614555dc6b65 upstream.

Platforms which are not affected by X86_BUG_TAA may want the TSX feature
enabled. Add "auto" option to the TSX cmdline parameter. When tsx=auto
disable TSX when X86_BUG_TAA is present, otherwise enable TSX.

More details on X86_BUG_TAA can be found here:
https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/tsx_async_abort.html

 [ bp: Extend the arg buffer to accommodate "auto\0". ]

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
[bwh: Backported to 4.9: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/kernel-parameters.txt |    3 +++
 arch/x86/kernel/cpu/tsx.c           |    7 ++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -4537,6 +4537,9 @@ bytes respectively. Such letter suffixes
 				update. This new MSR allows for the reliable
 				deactivation of the TSX functionality.)
 
+			auto	- Disable TSX if X86_BUG_TAA is present,
+				  otherwise enable TSX on the system.
+
 			Not specifying this option is equivalent to tsx=off.
 
 			See Documentation/hw-vuln/tsx_async_abort.rst
--- a/arch/x86/kernel/cpu/tsx.c
+++ b/arch/x86/kernel/cpu/tsx.c
@@ -75,7 +75,7 @@ static bool __init tsx_ctrl_is_supported
 
 void __init tsx_init(void)
 {
-	char arg[4] = {};
+	char arg[5] = {};
 	int ret;
 
 	if (!tsx_ctrl_is_supported())
@@ -87,6 +87,11 @@ void __init tsx_init(void)
 			tsx_ctrl_state = TSX_CTRL_ENABLE;
 		} else if (!strcmp(arg, "off")) {
 			tsx_ctrl_state = TSX_CTRL_DISABLE;
+		} else if (!strcmp(arg, "auto")) {
+			if (boot_cpu_has_bug(X86_BUG_TAA))
+				tsx_ctrl_state = TSX_CTRL_DISABLE;
+			else
+				tsx_ctrl_state = TSX_CTRL_ENABLE;
 		} else {
 			tsx_ctrl_state = TSX_CTRL_DISABLE;
 			pr_err("tsx: invalid option, defaulting to off\n");


