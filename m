Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5ACC76186
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCBE52053B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563419787;
	bh=a2ZzkgIy1k148nrv6bB08nt0fT5odGbwESvXpwqPESM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wCBnJFejvrH/NSlUiCBA6yyPpZqOqlw4KD8XiBbhcXqMkFpuOWGJQchWWilH8DgLs
	 E0AL42tv25AiGNfM0BaYDWcqh0EJXTt0SEN/rB0H4sSps/0Rcnu1iP2Ny7MmvwYSeS
	 tpV41t51by7bcDPDMeIRPla8mewPBr/ATWT7C81U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391062AbfGRDPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:15:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391927AbfGRDPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:15:03 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC03F2173E;
        Thu, 18 Jul 2019 03:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419703;
        bh=a2ZzkgIy1k148nrv6bB08nt0fT5odGbwESvXpwqPESM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N+shnu9rxp0AdP5XlGfmMLfwCDLM1XTJgU+aPC+c8+mqCOiXogdA+qcPciGfwIcyg
         zLQUzBZEyFzKMmV64y5RjGtvDIgk/kgUi8QRm2LoI+OevdGGq76CGtY5QmpT3EeC0k
         cr+dreWzs9gYaXA0zzbF19szuk9O+kxcZXZLX0r0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 32/40] ppp: mppe: Add softdep to arc4
Date:   Thu, 18 Jul 2019 12:02:28 +0900
Message-Id: <20190718030049.843650648@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030039.676518610@linuxfoundation.org>
References: <20190718030039.676518610@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit aad1dcc4f011ea409850e040363dff1e59aa4175 ]

The arc4 crypto is mandatory at ppp_mppe probe time, so let's put a
softdep line, so that the corresponding module gets prepared
gracefully.  Without this, a simple inclusion to initrd via dracut
failed due to the missing dependency, for example.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ppp/ppp_mppe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ppp/ppp_mppe.c b/drivers/net/ppp/ppp_mppe.c
index 05005c660d4d..6376edd89ceb 100644
--- a/drivers/net/ppp/ppp_mppe.c
+++ b/drivers/net/ppp/ppp_mppe.c
@@ -62,6 +62,7 @@ MODULE_AUTHOR("Frank Cusack <fcusack@fcusack.com>");
 MODULE_DESCRIPTION("Point-to-Point Protocol Microsoft Point-to-Point Encryption support");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_ALIAS("ppp-compress-" __stringify(CI_MPPE));
+MODULE_SOFTDEP("pre: arc4");
 MODULE_VERSION("1.0.2");
 
 static unsigned int
-- 
2.20.1



