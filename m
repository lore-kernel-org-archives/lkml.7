Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B18FC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F088A2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557918737;
	bh=raMUrnqaIQbYt5v0mwOlRvH5vlYwvORIdiVZAI4jgjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p3q4H44ZT1Ydufqfdfn0J4jZsIsrU0gdcFPUAnTT2Lx2cjGFXp8IdgR1JLm+N8FKA
	 dYXMNG+r0pZmtVh0E6Sp3KsDKp8QngIEjyc00aG6Eel8WP2EyLyTs0Svb0UeDpy9XR
	 yJF7Uw3EPkmE9y5TwksoeDtxiJZJ8NaQEV1Yzfas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbfEOLMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:12:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729732AbfEOLMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:12:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD70B2168B;
        Wed, 15 May 2019 11:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918732;
        bh=raMUrnqaIQbYt5v0mwOlRvH5vlYwvORIdiVZAI4jgjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lZRRxYZCzzs7x7Q5gQ+//wRRfijXZwiPxlerdjrdhLyM7PJZeww92vLdaCnbi3eBi
         ng5oITlMhg+Hj/YV54w2VQe6UmWHJUHo9AuPdxbvwh0q5WUwSEFkc/OC5TBoQwiOWD
         ZXFGWXQ5spMZ3Th0TMIOvM/jeuXtZaoq6F2nh6ZU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tyler Hicks <tyhicks@canonical.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.4 243/266] x86/speculation: Move arch_smt_update() call to after mitigation decisions
Date:   Wed, 15 May 2019 12:55:50 +0200
Message-Id: <20190515090731.225475037@linuxfoundation.org>
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

commit 7c3658b20194a5b3209a143f63bc9c643c6a3ae2 upstream.

arch_smt_update() now has a dependency on both Spectre v2 and MDS
mitigations.  Move its initial call to after all the mitigation decisions
have been made.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Tyler Hicks <tyhicks@canonical.com>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -100,6 +100,8 @@ void __init check_bugs(void)
 
 	mds_select_mitigation();
 
+	arch_smt_update();
+
 #ifdef CONFIG_X86_32
 	/*
 	 * Check whether we are able to run this kernel safely on SMP.
@@ -611,9 +613,6 @@ specv2_set_mode:
 
 	/* Set up IBPB and STIBP depending on the general spectre V2 command */
 	spectre_v2_user_select_mitigation(cmd);
-
-	/* Enable STIBP if appropriate */
-	arch_smt_update();
 }
 
 static void update_stibp_msr(void * __unused)


