Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94252C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6684C216FD
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557918767;
	bh=QXI3nrZ26GPuYgikXChVsPWBbXrsAubn0NqfcnrEJaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ON30pwtOjObO6xASc76JIr0eCyhvQ3BFomwBa9OeHri2EofBVNjK57J4wM6QG+QAY
	 ox0o2kpfFlWkw03rP3vd9jmqp5mkXLo5J/ZHckzP8TGHXEJD/4ebtdganlrvPkkQbp
	 Z4BfgtrtKCLQZ3S+78bwCWTX02eXv8w11pNbNt0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbfEOLMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:12:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729840AbfEOLMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:12:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98DA021783;
        Wed, 15 May 2019 11:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918760;
        bh=QXI3nrZ26GPuYgikXChVsPWBbXrsAubn0NqfcnrEJaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j8Bsk8ukx6oNHrzCITQOmSvQydINT/rKTccPqti3Bvd6ddJ7ViGnP7En58QW/khjz
         D0Tz8czPpNWO0+7oTrX2MLqHpYgzcO+F2hK9gZkc9O8JS7nFupT3gQTGvCuBy9PC48
         3DCUIXiQ2Br2h+P/PzYKXxmI0FvRKIHiYuii/LWw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.4 214/266] x86/speculation: Unify conditional spectre v2 print functions
Date:   Wed, 15 May 2019 12:55:21 +0200
Message-Id: <20190515090730.216368988@linuxfoundation.org>
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

From: Thomas Gleixner <tglx@linutronix.de>

commit 495d470e9828500e0155027f230449ac5e29c025 upstream.

There is no point in having two functions and a conditional at the call
site.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Casey Schaufler <casey.schaufler@intel.com>
Cc: Asit Mallick <asit.k.mallick@intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Jon Masters <jcm@redhat.com>
Cc: Waiman Long <longman9394@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Dave Stewart <david.c.stewart@intel.com>
Cc: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/20181125185004.986890749@linutronix.de
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |   17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -249,15 +249,9 @@ static const struct {
 	{ "auto",		SPECTRE_V2_CMD_AUTO,		  false },
 };
 
-static void __init spec2_print_if_insecure(const char *reason)
+static void __init spec_v2_print_cond(const char *reason, bool secure)
 {
-	if (boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
-		pr_info("%s selected on command line.\n", reason);
-}
-
-static void __init spec2_print_if_secure(const char *reason)
-{
-	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
+	if (boot_cpu_has_bug(X86_BUG_SPECTRE_V2) != secure)
 		pr_info("%s selected on command line.\n", reason);
 }
 
@@ -305,11 +299,8 @@ static enum spectre_v2_mitigation_cmd __
 		return SPECTRE_V2_CMD_AUTO;
 	}
 
-	if (mitigation_options[i].secure)
-		spec2_print_if_secure(mitigation_options[i].option);
-	else
-		spec2_print_if_insecure(mitigation_options[i].option);
-
+	spec_v2_print_cond(mitigation_options[i].option,
+			   mitigation_options[i].secure);
 	return cmd;
 }
 


