Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA08DC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2735206BF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557922035;
	bh=cf7yNtQYY2P7CkktRSIz5I8LQTIlsj7/HHIWF8pulDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v9j1jXVV/onU7K7rep4IqTp5iZ1av2luxkews64D8lb56uMy5wSQpREIz+6gPUtaE
	 62SFs44FW29K9QriYn2Q+0gEbHTbAhcfM5d935+tNzw9uu58C3nRPKwxbkZieeqSJK
	 zpI9M7IUiaEmRUQ7qSzxd+L2bWcdJ4auFNCaiGzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbfEOMHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:07:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728652AbfEOLJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:09:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEDF420862;
        Wed, 15 May 2019 11:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918574;
        bh=cf7yNtQYY2P7CkktRSIz5I8LQTIlsj7/HHIWF8pulDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eb8Bwso7FrARgbY2LQVEOVx7pMA1XAEW8v+13TA4knmfqQym0uzxQo0tXxTYdq2VH
         Jg6ikwjZZlmVwyMr1CxSRHdC5oPj9NipQrTIDKWsP1Q22ZRr4fwCQrn0maXik9BDAX
         nIuPyobiwXt35NFDBuwlRq4jHaJPRGWDdQm9XrEs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.4 184/266] x86/cpufeatures: Hide AMD-specific speculation flags
Date:   Wed, 15 May 2019 12:54:51 +0200
Message-Id: <20190515090729.154695368@linuxfoundation.org>
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

From: Ben Hutchings <ben@decadent.org.uk>

Hide the AMD_{IBRS,IBPB,STIBP} flag from /proc/cpuinfo.  This was done
upstream as part of commit e7c587da1252 "x86/speculation: Use
synthetic bits for IBRS/IBPB/STIBP".  That commit has already been
backported but this part was omitted.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/cpufeatures.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -265,9 +265,9 @@
 
 /* AMD-defined CPU features, CPUID level 0x80000008 (ebx), word 13 */
 #define X86_FEATURE_CLZERO	(13*32+0) /* CLZERO instruction */
-#define X86_FEATURE_AMD_IBPB	(13*32+12) /* Indirect Branch Prediction Barrier */
-#define X86_FEATURE_AMD_IBRS	(13*32+14) /* Indirect Branch Restricted Speculation */
-#define X86_FEATURE_AMD_STIBP	(13*32+15) /* Single Thread Indirect Branch Predictors */
+#define X86_FEATURE_AMD_IBPB	(13*32+12) /* "" Indirect Branch Prediction Barrier */
+#define X86_FEATURE_AMD_IBRS	(13*32+14) /* "" Indirect Branch Restricted Speculation */
+#define X86_FEATURE_AMD_STIBP	(13*32+15) /* "" Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_VIRT_SSBD	(13*32+25) /* Virtualized Speculative Store Bypass Disable */
 
 /* Thermal and Power Management Leaf, CPUID level 0x00000006 (eax), word 14 */


