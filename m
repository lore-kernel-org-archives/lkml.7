Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18167C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3CA20657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557921729;
	bh=cL5268vptadB2RdyHUUKibQtVUrEzLU0AwJACEzkAvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1pGXb2V+YP5q1i/5Zrg8m/RQbwIQw5LJ8IN4iOnVWWfXFMZWQiJeyxvcSP0Qvipl0
	 y0qDa8hBjXoWa860w1xTwDq9LJwD9W35rF9jlRXD5SMyFbPoPWvhFBWPk96eB7v8DX
	 4rPuPua/RFk+jS8r7j4LlGK132WA7YpJJ1qJwhm4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbfEOMCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:02:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729967AbfEOLN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:13:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BE2521473;
        Wed, 15 May 2019 11:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918809;
        bh=cL5268vptadB2RdyHUUKibQtVUrEzLU0AwJACEzkAvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F4zmQ29kuagr3EzUuuOU6NXvu5dZX1w63gJFZNhFPaYNNqmyV0J3cyfAZMYKScOXZ
         7OXRO83M3wGXIzLeY1MTDto+LWLIlyXpOjdY8iUH2Wqw5VFAugrVJbFP75DPrUoHie
         tZiNdNZxK1QcglwA4pvmV9ZOz06GGooaa0V50qKo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.4 249/266] x86/speculation/mds: Add mitigations= support for MDS
Date:   Wed, 15 May 2019 12:55:56 +0200
Message-Id: <20190515090731.438392012@linuxfoundation.org>
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

From: Josh Poimboeuf <jpoimboe@redhat.com>

commit 5c14068f87d04adc73ba3f41c2a303d3c3d1fa12 upstream.

Add MDS to the new 'mitigations=' cmdline option.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[bwh: Backported to 4.4:
 - Drop the auto,nosmt option, which we can't support
 - Adjust filenames, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/kernel-parameters.txt |    1 +
 arch/x86/kernel/cpu/bugs.c          |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2187,6 +2187,7 @@ bytes respectively. Such letter suffixes
 					       nospectre_v2 [X86]
 					       spectre_v2_user=off [X86]
 					       spec_store_bypass_disable=off [X86]
+					       mds=off [X86]
 
 			auto (default)
 				Mitigate all CPU vulnerabilities, but leave SMT
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -221,7 +221,7 @@ static const char * const mds_strings[]
 
 static void __init mds_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_MDS)) {
+	if (!boot_cpu_has_bug(X86_BUG_MDS) || cpu_mitigations_off()) {
 		mds_mitigation = MDS_MITIGATION_OFF;
 		return;
 	}


