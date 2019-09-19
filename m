Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACB6C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9686021928
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568932246;
	bh=gP1KFasB8WO5aIgzqJHmO5K+ABZ0LA7tXlnu06A8+bI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tW1csifo70BAECV6vUdfzxqT0Cu5lmYvk1BSDLsrvQXD6dxZmVfhZlG7+Ama/y1l6
	 CRvdjGsbnU19RGLy8KJWKuJtNR6LHqVUdm2EJmNqucF/ywjuKuuYuMnhAbOKp5lzln
	 SIeQY8RDvbrDrAntHFnT1RMDESlHZ1sf82da4Ncs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404444AbfISWPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:15:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:55626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406169AbfISWPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:15:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A560A21907;
        Thu, 19 Sep 2019 22:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931340;
        bh=gP1KFasB8WO5aIgzqJHmO5K+ABZ0LA7tXlnu06A8+bI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2PwmJeWeCcU2XYEVJtA+fATfQipHHwMI0ism35n5/9rTg5taFj66Yo2QFycZXTQQP
         Nkm/T4+H9Wilg9MelIXF1Cxrv3EDhn8o3sWeZUK2yJMxx9KTd/bS27fh3eykN87fmc
         YxC/MwsSWQL+DKcXklMg8iyMLpG8tSxb9lGcPPnk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH 4.14 11/59] serial: sprd: correct the wrong sequence of arguments
Date:   Fri, 20 Sep 2019 00:03:26 +0200
Message-Id: <20190919214758.710259373@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214755.852282682@linuxfoundation.org>
References: <20190919214755.852282682@linuxfoundation.org>
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
@@ -240,7 +240,7 @@ static inline void sprd_rx(struct uart_p
 
 		if (lsr & (SPRD_LSR_BI | SPRD_LSR_PE |
 			SPRD_LSR_FE | SPRD_LSR_OE))
-			if (handle_lsr_errors(port, &lsr, &flag))
+			if (handle_lsr_errors(port, &flag, &lsr))
 				continue;
 		if (uart_handle_sysrq_char(port, ch))
 			continue;


