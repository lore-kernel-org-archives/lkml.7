Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297DCC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A1720870
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566496013;
	bh=9o44ulriWXXkwnJBjHg4oBd96Y4y2e/U4b3CT7RffeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wK+rS/bzrKIuiS1CuOBw7oDpuQ5nnmKEtQ0tzc4EZZZatdJC+m0S9J9OYEy0qzGVs
	 g842aGPaip0kMEMOgnNCh6Zb9juq2+2mx/YwNEodxf6iM1zsYiDwdQ3C3zzIGXlce2
	 ropMPT1wYNjXXT0V/BaNFWorA17l8T47mjOQNNU0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393132AbfHVRqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:46:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391439AbfHVRWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:22:43 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5C8623429;
        Thu, 22 Aug 2019 17:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494562;
        bh=9o44ulriWXXkwnJBjHg4oBd96Y4y2e/U4b3CT7RffeY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XLe81ei7JwVY2X/vdZJoyl36+H7rLiOGpW15Dh7aJoBcT2FHvvWYclGoMWBy9vA6l
         DyNibkX3U6xjiKXeJJ9YE/c3jVPVCAcSMJ2zM4YJoU4DeN06qTN4Pf9mc7OZ4XRcPT
         Q1L+d71/3p3bDvmPvHuQW7ZYryN+YLYEkGxj7M/0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guenter Roeck <linux@roeck-us.net>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 4.4 33/78] sh: kernel: hw_breakpoint: Fix missing break in switch statement
Date:   Thu, 22 Aug 2019 10:18:37 -0700
Message-Id: <20190822171833.002292107@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171832.012773482@linuxfoundation.org>
References: <20190822171832.012773482@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit 1ee1119d184bb06af921b48c3021d921bbd85bac upstream.

Add missing break statement in order to prevent the code from falling
through to case SH_BREAKPOINT_WRITE.

Fixes: 09a072947791 ("sh: hw-breakpoints: Add preliminary support for SH-4A UBC.")
Cc: stable@vger.kernel.org
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/sh/kernel/hw_breakpoint.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/sh/kernel/hw_breakpoint.c
+++ b/arch/sh/kernel/hw_breakpoint.c
@@ -160,6 +160,7 @@ int arch_bp_generic_fields(int sh_len, i
 	switch (sh_type) {
 	case SH_BREAKPOINT_READ:
 		*gen_type = HW_BREAKPOINT_R;
+		break;
 	case SH_BREAKPOINT_WRITE:
 		*gen_type = HW_BREAKPOINT_W;
 		break;


