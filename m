Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21138C4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE2820693
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567947213;
	bh=2IMqh2I9r0/tQn3n3KrKnfXUTdJBdIYC20ZWkmNy9+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RzExBXD1lpltydIXw0a5qxvcTHarXiiLDc8LqeSC/NMPl9JOfkRRtwTWqzTm90MyH
	 emo/lITr/HMvJdrEQiFL1KS6f8hbaXKcKglfVVZAEDEeqmuAQ7ylv7xPvUss8gnvnj
	 eut1gwqtEcZ4dHGOuhqeLh71b4owRAQg+9Z+iymI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387668AbfIHMxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:53:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387617AbfIHMx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:53:26 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BABB2190F;
        Sun,  8 Sep 2019 12:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567947206;
        bh=2IMqh2I9r0/tQn3n3KrKnfXUTdJBdIYC20ZWkmNy9+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KhVci2Vk6j+R76eKhDgmT6QNwKcnLd76v8sbH06rlTxXsPP/hF8Its7+qfQ0D7EQP
         ZvEV8QfBX/z2rfGvdQAadjjp7gXcucQMAUPRA2UWxfTdAxXFwcjYj7hEJ22x8GSrwV
         vpvhkLu58ULOHp12MucdeFyiSn3hmUzFeUzbfpBg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wenwen@cs.uga.edu>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 51/94] liquidio: add cleanup in octeon_setup_iq()
Date:   Sun,  8 Sep 2019 13:41:47 +0100
Message-Id: <20190908121151.899401924@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121150.420989666@linuxfoundation.org>
References: <20190908121150.420989666@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 6f967f8b1be7001b31c46429f2ee7d275af2190f ]

If oct->fn_list.enable_io_queues() fails, no cleanup is executed, leading
to memory/resource leaks. To fix this issue, invoke
octeon_delete_instr_queue() before returning from the function.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cavium/liquidio/request_manager.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/request_manager.c b/drivers/net/ethernet/cavium/liquidio/request_manager.c
index fcf20a8f92d94..6a823710987da 100644
--- a/drivers/net/ethernet/cavium/liquidio/request_manager.c
+++ b/drivers/net/ethernet/cavium/liquidio/request_manager.c
@@ -239,8 +239,10 @@ int octeon_setup_iq(struct octeon_device *oct,
 	}
 
 	oct->num_iqs++;
-	if (oct->fn_list.enable_io_queues(oct))
+	if (oct->fn_list.enable_io_queues(oct)) {
+		octeon_delete_instr_queue(oct, iq_no);
 		return 1;
+	}
 
 	return 0;
 }
-- 
2.20.1



