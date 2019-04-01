Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FD0C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C90DA21473
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139358;
	bh=8yEbENt3HIro9qgBd2wrVTaeMUAHRLsCxkQRUBzE2lI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pW//6VNF5NsCDOlWq6vwsxbhoye8VguhWP5wdDq9T7o5J6CTRUXJZKcj+3aX0KMuc
	 SDC/iRBKLeH+NpG1qpuW4jTX70F4oq5fHfFH0eoBuG9g0yuLrjVdek3vtuRobnbUas
	 vQPCKr0+ESoW0QBrvJwMUoVC3Hvu+prFcmL1n1jM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732003AbfDARWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:22:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731336AbfDARWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:22:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABE8A21903;
        Mon,  1 Apr 2019 17:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139351;
        bh=8yEbENt3HIro9qgBd2wrVTaeMUAHRLsCxkQRUBzE2lI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1N9I32E0BwLkkxca5kFAz2dJOXU34KMkYVD/gAEbpZne3zI0nJjb6IAfG4srlcIqB
         Yd7XP67FPfFj+rPDhbYBki4LKBq8bFZlum1mK7Aga8eRkJaRXFtpWVT1oCgdjYt7uF
         ez+y4+AYsoNxO0OmHkXmpwrr4MkCpG0ixwUYnxN8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Diana Craciun <diana.craciun@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 051/107] powerpc/fsl: Enable runtime patching if nospectre_v2 boot arg is used
Date:   Mon,  1 Apr 2019 19:02:06 +0200
Message-Id: <20190401170050.436223136@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170045.246405031@linuxfoundation.org>
References: <20190401170045.246405031@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Diana Craciun <diana.craciun@nxp.com>

commit 3bc8ea8603ae4c1e09aca8de229ad38b8091fcb3 upstream.

If the user choses not to use the mitigations, replace
the code sequence with nops.

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/setup-common.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -938,6 +938,7 @@ void __init setup_arch(char **cmdline_p)
 		ppc_md.setup_arch();
 
 	setup_barrier_nospec();
+	setup_spectre_v2();
 
 	paging_init();
 


