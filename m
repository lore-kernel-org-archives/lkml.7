Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A98C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6068020843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557921581;
	bh=2G32cP8HtH00Rjv2anrTKi7M+acenD3LjABGwolUVdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Nb07bZWEUPlR65/r9ZK4i3sHhIlIqtKIQBBLUCpuYwRteQ9Q7SSmXPcFWme7C3mju
	 fhhmI4ZxYG5BtEubBPCFSXg92/qS9OpU5D0b354kKHorDskrswuY4cGcrLyfSR0tiB
	 gnG53BInPw1j4HS+6YOdGfqWEdDozF4Kzk+aptYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730712AbfEOL7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:59:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:51820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729400AbfEOLPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:15:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 157E52084F;
        Wed, 15 May 2019 11:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918920;
        bh=2G32cP8HtH00Rjv2anrTKi7M+acenD3LjABGwolUVdU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DJg/7NVhYHVVKAysf0wlGGh5476+XU5zUWFiqMw23omKjWQt/CQnAD8HFs1j2MYg/
         sFQUWnCeQlUPusrxBzhKm5ppKRIHBhK5ITWMfsQ6nr6wrOhrcJtGz4JOdHLMuGDJqD
         LnR6iCG1zUUHzv9GYQMTQRCo/iskY3/zS9/swuWY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.9 50/51] powerpc/lib: fix book3s/32 boot failure due to code patching
Date:   Wed, 15 May 2019 12:56:25 +0200
Message-Id: <20190515090629.871639485@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090616.669619870@linuxfoundation.org>
References: <20190515090616.669619870@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@c-s.fr>

commit b45ba4a51cde29b2939365ef0c07ad34c8321789 upstream.

Commit 51c3c62b58b3 ("powerpc: Avoid code patching freed init
sections") accesses 'init_mem_is_free' flag too early, before the
kernel is relocated. This provokes early boot failure (before the
console is active).

As it is not necessary to do this verification that early, this
patch moves the test into patch_instruction() instead of
__patch_instruction().

This modification also has the advantage of avoiding unnecessary
remappings.

Fixes: 51c3c62b58b3 ("powerpc: Avoid code patching freed init sections")
Cc: stable@vger.kernel.org # 4.13+
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/lib/code-patching.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -23,7 +23,7 @@ int patch_instruction(unsigned int *addr
 	int err;
 
 	/* Make sure we aren't patching a freed init section */
-	if (init_mem_is_free && init_section_contains(addr, 4)) {
+	if (*PTRRELOC(&init_mem_is_free) && init_section_contains(addr, 4)) {
 		pr_debug("Skipping init section patching addr: 0x%px\n", addr);
 		return 0;
 	}


