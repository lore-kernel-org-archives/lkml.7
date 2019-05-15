Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBBDC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D263A2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557918213;
	bh=XEGPRHuNE2A8sY3W/4NEaf9kpIV/TijLU3XKaV9gsHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vARGTorzkIhtuTdYgjVxUaH7VljhEzboCIUWfoKFkmly+Xa3a1+orYD5A+JmBeHJa
	 D5wWJCo5AlG+RK+b/dykoocH2hAFM7VqmIjAz0s1XCDxsgDD1gpGLhXeu5faIw1X+F
	 iuISRjAMdB8+xa1BtoQ0IHOoN5KiK6LMysr3Rfvo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbfEOLDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:03:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:60972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728177AbfEOLD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:03:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D1A72084F;
        Wed, 15 May 2019 11:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918205;
        bh=XEGPRHuNE2A8sY3W/4NEaf9kpIV/TijLU3XKaV9gsHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dXU+yH7wgIjl7GKuLqALWmlj+CLXfDZgf5gXDYHHvE50qnyJ5lj8CSIkVA4j3wllE
         kDPtOl3PsuM2BugRKtG0pCj7cd1lHq/rXrXsP0O0opAU3z4LF6hy3ZeV4wJvB2wv9r
         tN7iOv1D9PFl5dWe4t9XW0yeA49OQhDq+P25vbek=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Diana Craciun <diana.craciun@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.4 045/266] powerpc/64: Disable the speculation barrier from the command line
Date:   Wed, 15 May 2019 12:52:32 +0200
Message-Id: <20190515090723.996463811@linuxfoundation.org>
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

From: Diana Craciun <diana.craciun@nxp.com>

commit cf175dc315f90185128fb061dc05b6fbb211aa2f upstream.

The speculation barrier can be disabled from the command line
with the parameter: "nospectre_v1".

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/security.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -17,6 +17,7 @@
 unsigned long powerpc_security_features __read_mostly = SEC_FTR_DEFAULT;
 
 bool barrier_nospec_enabled;
+static bool no_nospec;
 
 static void enable_barrier_nospec(bool enable)
 {
@@ -43,9 +44,18 @@ void setup_barrier_nospec(void)
 	enable = security_ftr_enabled(SEC_FTR_FAVOUR_SECURITY) &&
 		 security_ftr_enabled(SEC_FTR_BNDS_CHK_SPEC_BAR);
 
-	enable_barrier_nospec(enable);
+	if (!no_nospec)
+		enable_barrier_nospec(enable);
 }
 
+static int __init handle_nospectre_v1(char *p)
+{
+	no_nospec = true;
+
+	return 0;
+}
+early_param("nospectre_v1", handle_nospectre_v1);
+
 #ifdef CONFIG_DEBUG_FS
 static int barrier_nospec_set(void *data, u64 val)
 {


