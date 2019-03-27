Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D880EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC2C205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553712746;
	bh=5yGH/Q26LhnQytYmAEbqCdRpOlRTb8zRY2OxZRys0PY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ecMyL1k1ZSGC//1OokOFK/0MZFoSvsGNuhxn9ZhE2G/TJMf0pdcckuuIshY3fRsS7
	 UJpZlVIL0COiloCMdqhYQ88qVOvy1A9Sx0CZQnsU9Svq8Xxqu7Fy/OStuSvA08r5HR
	 Zd2/U+VXqwxpbyRDeUh4y+2jIcG3F3/DuWpeN+EA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390881AbfC0SwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:52:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390041AbfC0SRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:17:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 498982082F;
        Wed, 27 Mar 2019 18:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710665;
        bh=5yGH/Q26LhnQytYmAEbqCdRpOlRTb8zRY2OxZRys0PY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y+GmBskfXEYx6N7WEVsIOBI1Zqm5hZkGAxoe5fZ95npdIe2LOY8aDzFH80/w7sCU/
         fQaLQyibmCP5vLrGTbQjeOfNcJHjEVGhQUUb/Lry+1/90I+78BkT/XKrWbqrG9G6zZ
         cMvfulSzlPiY/4q9Lvkul02QVoiQaMgWntOKAhoI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lubomir Rintel <lkundrak@v3.sk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 040/123] serial: 8250_pxa: honor the port number from devicetree
Date:   Wed, 27 Mar 2019 14:15:04 -0400
Message-Id: <20190327181628.15899-40-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181628.15899-1-sashal@kernel.org>
References: <20190327181628.15899-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lubomir Rintel <lkundrak@v3.sk>

[ Upstream commit fe9ed6d2483fda55465f32924fb15bce0fac3fac ]

Like the other OF-enabled drivers, use the port number from the firmware if
the devicetree specifies an alias:

  aliases {
      ...
      serial2 = &uart2; /* Should be ttyS2 */
  }

This is how the deprecated pxa.c driver behaved, switching to 8250_pxa
messes up the numbering.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_pxa.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pxa.c b/drivers/tty/serial/8250/8250_pxa.c
index 4d68731af534..de1372ba24b1 100644
--- a/drivers/tty/serial/8250/8250_pxa.c
+++ b/drivers/tty/serial/8250/8250_pxa.c
@@ -118,6 +118,10 @@ static int serial_pxa_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = of_alias_get_id(pdev->dev.of_node, "serial");
+	if (ret >= 0)
+		uart.port.line = ret;
+
 	uart.port.type = PORT_XSCALE;
 	uart.port.iotype = UPIO_MEM32;
 	uart.port.mapbase = mmres->start;
-- 
2.19.1

