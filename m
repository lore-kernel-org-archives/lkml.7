Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F081CC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4BE521928
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568930737;
	bh=3tM0UaXpK9hyBLBvIYjqMgOquMudUYvPcuK67Ua82Do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nDvTpOXQlPNsfuUlEtGWKJrGNDWskx+pR7HsUHpTWGQ2tBi/RK6dqvPuxNGSSYutZ
	 1AyFopOafANAT/2Y/U6GL6J0GSGjGsWm/tmCuzMFfsJEPYGRmoMHJApPlzvI8pEIiv
	 WmmG0D8tnNj7OXSEIFrPsPhTnQ1wuhB7ZCMtLNSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404998AbfISWFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:05:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404976AbfISWF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:05:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05294218AF;
        Thu, 19 Sep 2019 22:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568930727;
        bh=3tM0UaXpK9hyBLBvIYjqMgOquMudUYvPcuK67Ua82Do=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ycpNUyHJ4mWpljKdYbLGmVndSFnETftPS2tCVOtS688U1ddVcnnwopsv32gbFEzIR
         QMe8hMRAoLP4zkNFzbllKTN4dsCYOkRRTP3MrM88U5L6WPwDHH9wtwAILMiNxIK8jd
         CnOJv03W5qdLqVVnlJR5do2bjDwkpgpHrzaKAl3c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH 5.3 14/21] serial: sprd: correct the wrong sequence of arguments
Date:   Fri, 20 Sep 2019 00:03:15 +0200
Message-Id: <20190919214707.904000879@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214657.842130855@linuxfoundation.org>
References: <20190919214657.842130855@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

commit 9c801e313195addaf11c16e155f50789d6ebfd19 upstream.

The sequence of arguments which was passed to handle_lsr_errors() didn't
match the parameters defined in that function, &lsr was passed to flag
and &flag was passed to lsr, this patch fixed that.

Fixes: b7396a38fb28 ("tty/serial: Add Spreadtrum sc9836-uart driver support")
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20190905074151.5268-1-zhang.lyra@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/sprd_serial.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -609,7 +609,7 @@ static inline void sprd_rx(struct uart_p
 
 		if (lsr & (SPRD_LSR_BI | SPRD_LSR_PE |
 			   SPRD_LSR_FE | SPRD_LSR_OE))
-			if (handle_lsr_errors(port, &lsr, &flag))
+			if (handle_lsr_errors(port, &flag, &lsr))
 				continue;
 		if (uart_handle_sysrq_char(port, ch))
 			continue;


