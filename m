Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE39C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99052084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554141350;
	bh=O4PCFXKEVmdqFN002EiJoRoFMVsV60/A78YAC8tx51s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wIAbGRYHqXJl14gtnraIX55H4PRGPpjxTnFeln9hhAr93tDT83q9phEu/n6I6wMp1
	 jC359zFvgrH+kEl9XyD2tPsenHI2Kuc2gGhAhPKLFhm0wl1bsG21o34LVd8PjQMuAU
	 YNy4jDz8+zxd1oLwu0BAjfKZYGmH75ChH6wnm50E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732242AbfDARzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:55:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731747AbfDARWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:22:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DC3B21473;
        Mon,  1 Apr 2019 17:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139353;
        bh=O4PCFXKEVmdqFN002EiJoRoFMVsV60/A78YAC8tx51s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mUqJBVCIR9A5mC+pqVrTDgJDz9Xnn16m/83QIa2PCJogL+3C+X1GUGbxUhM2p+NqY
         PKhftmd28THSIHAtTULKsYvjPhh3SYedgtRh2f4NaOsn8L6WH7Wod7uENTBbk/flpB
         Dv0B9ZIlleM40WM8KXvdveQpvdV8QyLnURtRS1Fs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Diana Craciun <diana.craciun@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 052/107] powerpc/fsl: Update Spectre v2 reporting
Date:   Mon,  1 Apr 2019 19:02:07 +0200
Message-Id: <20190401170050.514042017@linuxfoundation.org>
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

commit dfa88658fb0583abb92e062c7a9cd5a5b94f2a46 upstream.

Report branch predictor state flush as a mitigation for
Spectre variant 2.

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/security.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -212,8 +212,11 @@ ssize_t cpu_show_spectre_v2(struct devic
 
 		if (count_cache_flush_type == COUNT_CACHE_FLUSH_HW)
 			seq_buf_printf(&s, "(hardware accelerated)");
-	} else
+	} else if (btb_flush_enabled) {
+		seq_buf_printf(&s, "Mitigation: Branch predictor state flush");
+	} else {
 		seq_buf_printf(&s, "Vulnerable");
+	}
 
 	seq_buf_printf(&s, "\n");
 


