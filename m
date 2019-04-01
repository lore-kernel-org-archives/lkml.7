Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C2AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE7EB20856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139297;
	bh=tY7sqEMlLCJ8w/FlBmzQ62/E5s9E9b0eiJJWH89mtmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nsr/cc6ShKo3E3ZGtUs3yuoC1rFL6sfZUNSYP1Mz2rPIiwVnjqgbUGNE9F+ETmIB1
	 8svlO/MEePOXX9y7TuKkgtoG65qqg8nlVZZaZDC/M23j85Z91bEn50lIQBmh8R0MDZ
	 D72P8Sj50oaoqH/0MjTk5qExst69McS2w7rFUD80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731841AbfDARVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:21:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731427AbfDARVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:21:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F1DB20856;
        Mon,  1 Apr 2019 17:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139292;
        bh=tY7sqEMlLCJ8w/FlBmzQ62/E5s9E9b0eiJJWH89mtmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r6QacYPvTkmVamBi7K+XrAcgxF5J7Vv/CpdXFiMHrVEI6LqhkQnRXwi7q2qoIVgVu
         LPB/GsB4OHZ0rif+j9xxKqPyV1ZxpSqac2y/rJcJjLysqN81me0mFh+8Goo6jac4E8
         17+uCVoEzzvDomSZrAGwzLH0qw8b6Fb5s02fxDzs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Diana Craciun <diana.craciun@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 032/107] powerpc/64: Make stf barrier PPC_BOOK3S_64 specific.
Date:   Mon,  1 Apr 2019 19:01:47 +0200
Message-Id: <20190401170048.631506382@linuxfoundation.org>
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

commit 6453b532f2c8856a80381e6b9a1f5ea2f12294df upstream.

NXP Book3E platforms are not vulnerable to speculative store
bypass, so make the mitigations PPC_BOOK3S_64 specific.

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/security.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -176,6 +176,7 @@ ssize_t cpu_show_spectre_v2(struct devic
 	return s.len;
 }
 
+#ifdef CONFIG_PPC_BOOK3S_64
 /*
  * Store-forwarding barrier support.
  */
@@ -323,3 +324,4 @@ static __init int stf_barrier_debugfs_in
 }
 device_initcall(stf_barrier_debugfs_init);
 #endif /* CONFIG_DEBUG_FS */
+#endif /* CONFIG_PPC_BOOK3S_64 */


