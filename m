Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E6CC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF4C20651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555356148;
	bh=lV/5N/A/xAKHQrs+2JzZ2IFh2g1IBhWls9baD+cI1ts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yfux79areMQS2x9RuPbvLnhGK1FuSvTZFsv/l/9xvkah/VtdS4d3PYBBTmWKpZ0uk
	 wNgEjx/6UfUxdkAxEGqFUQFrQgPBZ2B3RPVp/Yjuv7w7nbHntH+KNDXzHGkZXdJyix
	 qsTrLnl6XVBcabDdZDN3hNvt3APqZmWuDaPRddNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbfDOTIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:08:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:43626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730419AbfDOTIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:08:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2FF420880;
        Mon, 15 Apr 2019 19:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355297;
        bh=lV/5N/A/xAKHQrs+2JzZ2IFh2g1IBhWls9baD+cI1ts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xwQc0Oe3OVaCruwuBn1lXAOd78klimX1LDecXFmL+zLkB8kpC9bw2hR8biShfm0cz
         5pY2RmYWCkbEl0v2kX2oMRw3wy8ltseIW7BFaCU+rTBOAFMQXiYsuAHn8ySI/1zRwe
         fjWRu+VXw68YWJG6IJy5+3/1/k2G2MW7t1KCz3z0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 4.19 085/101] xtensa: fix return_address
Date:   Mon, 15 Apr 2019 20:59:23 +0200
Message-Id: <20190415183744.896787544@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
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
@@ -253,10 +253,14 @@ static int return_address_cb(struct stac
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


