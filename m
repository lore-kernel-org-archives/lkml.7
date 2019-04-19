Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EED3C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5308420645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="DMUVGKa6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbfDSTFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:05:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42949 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729145AbfDSTDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:03:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3JFGAdE319982
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 19 Apr 2019 08:16:10 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3JFGAdE319982
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555686970;
        bh=Ff1ERkD9UsDlx1ku8vQ0nd7O5hDrsGU3a7YfGR3g24I=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=DMUVGKa69nA2RanmRojCvyhCQcnOzSeAlZN8BqekV/SnGTMbPQmk7ACUW51y1Zr7i
         jzhdFnnlzZgdoG/ejkBtLvrZDUZQh3B4YFNqUyRywmDCM0gvYX52U8Q0+dVE4ivAjp
         0dDScYzKYGZo1gEY96dYAYyCa8saCgyo6DdezbIi6DEVM+7rQBP1uIKbEucOFRV91/
         7h6B4//jtpYT6GF872XIz1LKl4Tr5PpIw8J/Z4J0Uw2+dL1q3hMp7TSx0w63n+c7bB
         Mv92Ls3KeZdHzghrujXItzbnPDeV/HrWrg7tbpCEluIGxPakRg0Ztw6BQVRTo0MG2X
         FjKFJMrbaNIYg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3JFG8RB319975;
        Fri, 19 Apr 2019 08:16:08 -0700
Date:   Fri, 19 Apr 2019 08:16:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-1de7edbb59c8f1b46071f66c5c97b8a59569eb51@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, ak@linux.intel.com
Reply-To: ak@linux.intel.com, hpa@zytor.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <20190330004743.29541-9-andi@firstfloor.org>
References: <20190330004743.29541-9-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/cpu/bugs: Use __initconst for 'const' init
 data
Git-Commit-ID: 1de7edbb59c8f1b46071f66c5c97b8a59569eb51
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1de7edbb59c8f1b46071f66c5c97b8a59569eb51
Gitweb:     https://git.kernel.org/tip/1de7edbb59c8f1b46071f66c5c97b8a59569eb51
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Fri, 29 Mar 2019 17:47:43 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 19 Apr 2019 17:11:39 +0200

x86/cpu/bugs: Use __initconst for 'const' init data

Some of the recently added const tables use __initdata which causes section
attribute conflicts.

Use __initconst instead.

Fixes: fa1202ef2243 ("x86/speculation: Add command line control")
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20190330004743.29541-9-andi@firstfloor.org

---
 arch/x86/kernel/cpu/bugs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 2da82eff0eb4..b91b3bfa5cfb 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -275,7 +275,7 @@ static const struct {
 	const char			*option;
 	enum spectre_v2_user_cmd	cmd;
 	bool				secure;
-} v2_user_options[] __initdata = {
+} v2_user_options[] __initconst = {
 	{ "auto",		SPECTRE_V2_USER_CMD_AUTO,		false },
 	{ "off",		SPECTRE_V2_USER_CMD_NONE,		false },
 	{ "on",			SPECTRE_V2_USER_CMD_FORCE,		true  },
@@ -419,7 +419,7 @@ static const struct {
 	const char *option;
 	enum spectre_v2_mitigation_cmd cmd;
 	bool secure;
-} mitigation_options[] __initdata = {
+} mitigation_options[] __initconst = {
 	{ "off",		SPECTRE_V2_CMD_NONE,		  false },
 	{ "on",			SPECTRE_V2_CMD_FORCE,		  true  },
 	{ "retpoline",		SPECTRE_V2_CMD_RETPOLINE,	  false },
@@ -658,7 +658,7 @@ static const char * const ssb_strings[] = {
 static const struct {
 	const char *option;
 	enum ssb_mitigation_cmd cmd;
-} ssb_mitigation_options[]  __initdata = {
+} ssb_mitigation_options[]  __initconst = {
 	{ "auto",	SPEC_STORE_BYPASS_CMD_AUTO },    /* Platform decides */
 	{ "on",		SPEC_STORE_BYPASS_CMD_ON },      /* Disable Speculative Store Bypass */
 	{ "off",	SPEC_STORE_BYPASS_CMD_NONE },    /* Don't touch Speculative Store Bypass */
