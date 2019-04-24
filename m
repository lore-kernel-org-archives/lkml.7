Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D77C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C191D21904
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126875;
	bh=0noindewX3jxhD2G0eorpjQYAURO0ytvFyz9alrhvsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cvpo67bB9fIHqYmSrJZxYTfV/qdJ2B56Z6DQiglQoQjHORi6hloh04EtkIUue2OC/
	 eUzqyzyTXupWHZ7KbZWCq2hA+ZSbP4sYVjqN7CopMhDxPRI5JaSli42X/KUobi+jeQ
	 vhZukyoaOVe7D4EGtpKy2sKRamAJog/qxuFOqDNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390555AbfDXR1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:27:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390536AbfDXR1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:27:48 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFD9921904;
        Wed, 24 Apr 2019 17:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126867;
        bh=0noindewX3jxhD2G0eorpjQYAURO0ytvFyz9alrhvsw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=16lUHjSRe/RVGdCpv0/wA3mRLxPDYjHmhXE6MRiOKj5kwNv1HGi3/pjzbk1d/evhP
         2lb1IUbRva3zJlEKHy3JTDH0Ghv5GE/ZKiC7VXgoYqLfxipp2EQUHtnDYsK3RngGWy
         J8TdWr3uL/0H5eSUBt+oCjqNtB/Tjnz2fkTjvVIY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.14 45/70] x86/cpu/bugs: Use __initconst for const init data
Date:   Wed, 24 Apr 2019 19:10:05 +0200
Message-Id: <20190424170914.456175840@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170906.751869122@linuxfoundation.org>
References: <20190424170906.751869122@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

commit 1de7edbb59c8f1b46071f66c5c97b8a59569eb51 upstream.

Some of the recently added const tables use __initdata which causes section
attribute conflicts.

Use __initconst instead.

Fixes: fa1202ef2243 ("x86/speculation: Add command line control")
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20190330004743.29541-9-andi@firstfloor.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/bugs.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -271,7 +271,7 @@ static const struct {
 	const char			*option;
 	enum spectre_v2_user_cmd	cmd;
 	bool				secure;
-} v2_user_options[] __initdata = {
+} v2_user_options[] __initconst = {
 	{ "auto",		SPECTRE_V2_USER_CMD_AUTO,		false },
 	{ "off",		SPECTRE_V2_USER_CMD_NONE,		false },
 	{ "on",			SPECTRE_V2_USER_CMD_FORCE,		true  },
@@ -406,7 +406,7 @@ static const struct {
 	const char *option;
 	enum spectre_v2_mitigation_cmd cmd;
 	bool secure;
-} mitigation_options[] __initdata = {
+} mitigation_options[] __initconst = {
 	{ "off",		SPECTRE_V2_CMD_NONE,		  false },
 	{ "on",			SPECTRE_V2_CMD_FORCE,		  true  },
 	{ "retpoline",		SPECTRE_V2_CMD_RETPOLINE,	  false },
@@ -642,7 +642,7 @@ static const char * const ssb_strings[]
 static const struct {
 	const char *option;
 	enum ssb_mitigation_cmd cmd;
-} ssb_mitigation_options[]  __initdata = {
+} ssb_mitigation_options[]  __initconst = {
 	{ "auto",	SPEC_STORE_BYPASS_CMD_AUTO },    /* Platform decides */
 	{ "on",		SPEC_STORE_BYPASS_CMD_ON },      /* Disable Speculative Store Bypass */
 	{ "off",	SPEC_STORE_BYPASS_CMD_NONE },    /* Don't touch Speculative Store Bypass */


