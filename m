Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EE4C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127BC20685
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556128983;
	bh=o8WU5jJq6idQa815QjFa58x4Kc0UhZGgcns4woUtyNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gsHQtPtOZaDiL4MRD/0LPSU5iBqB/K2YPuffi76FputpfXUHuP9mMrfreEYfpeQRH
	 Z427iiC4M6AxiCBM9p50R1pQYz5vb6ruNL9I/DUlEVk+FUWNe3CLQXKbPo3+By1vln
	 V4/YHpQtktXSqEanzDpMJsNEqFOpcE0v5i2/zskc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390140AbfDXSDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:03:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389231AbfDXRUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:20:48 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E37AD2190C;
        Wed, 24 Apr 2019 17:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126448;
        bh=o8WU5jJq6idQa815QjFa58x4Kc0UhZGgcns4woUtyNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YR7sYGEBflw6tE7SU1w9bAOsl9KOqyZUezvni/jk8dh19jDFdZY2U8A4zvsrsIGDi
         SRuQSw9HtRKWjGWgr8dKCWqSzMJeVHxcyrvZlKpKkyJjwp0RSocT46Bg7c8n2ljZbY
         WrNPpSPNPozH4htN5RssJxa2uN2sFw2UR0Hmpz8I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 4.4 096/168] xtensa: fix return_address
Date:   Wed, 24 Apr 2019 19:09:00 +0200
Message-Id: <20190424170929.379361144@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Filippov <jcmvbkbc@gmail.com>

commit ada770b1e74a77fff2d5f539bf6c42c25f4784db upstream.

return_address returns the address that is one level higher in the call
stack than requested in its argument, because level 0 corresponds to its
caller's return address. Use requested level as the number of stack
frames to skip.

This fixes the address reported by might_sleep and friends.

Cc: stable@vger.kernel.org
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/xtensa/kernel/stacktrace.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/arch/xtensa/kernel/stacktrace.c
+++ b/arch/xtensa/kernel/stacktrace.c
@@ -272,10 +272,14 @@ static int return_address_cb(struct stac
 	return 1;
 }
 
+/*
+ * level == 0 is for the return address from the caller of this function,
+ * not from this function itself.
+ */
 unsigned long return_address(unsigned level)
 {
 	struct return_addr_data r = {
-		.skip = level + 1,
+		.skip = level,
 	};
 	walk_stackframe(stack_pointer(NULL), return_address_cb, &r);
 	return r.addr;


