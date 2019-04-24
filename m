Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73FDC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D77D20652
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556129517;
	bh=fVBOIT0ckStmQsqm0KVxV9Etdhtq4zIkOnneqJKZrYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2h1fzGfPqRoFWjgmVu10B5jVPIvFa1jF+Z9AbKNue2qy42Gh7SAj5f+FHoyl+91r1
	 yS2ONfhg9Fxa5a+gZavHyQNOBDLcuGjrIBWcGEQzqWEFS/H9t3l6csLciaeFNgGeyS
	 aVl8z6QezSxyucyNYNkJigj5ib+AG66DpJKnGY+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388708AbfDXSL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:11:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387856AbfDXRNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:13:21 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1ABE521903;
        Wed, 24 Apr 2019 17:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126000;
        bh=fVBOIT0ckStmQsqm0KVxV9Etdhtq4zIkOnneqJKZrYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Njcv20atEskTwWZiNYd2duZuwxo+Nfr0jd21+hx1M70qef3de/l44ivp/tGFqt8vg
         YhzbQm1mA/Pa0fFIiDyJqCwvYHWjWjvbZZ4SOxBdrHuJl6ZhkysLh+XpifuKBCcJuU
         MzoWUGGwbEvkA3Cysh0TOneKelGQRsX60BNXzS50=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 3.18 058/104] xtensa: fix return_address
Date:   Wed, 24 Apr 2019 19:09:15 +0200
Message-Id: <20190424170903.484400591@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.996641496@linuxfoundation.org>
References: <20190424170839.996641496@linuxfoundation.org>
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
@@ -107,10 +107,14 @@ static int return_address_cb(struct stac
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


