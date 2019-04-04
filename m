Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D837C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A6A206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554371399;
	bh=7udGr7CkuOqZ/ZkMTAMyEcn+KtSzPuocwrswRQADpss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N8L6ZeOXyNbxeIuyEIAiV2n1xQDwrGExQ1Kh8eqCkY8tI7BiRYiOSr9om0bGFs51O
	 QDYGo5kQyXRxi2zrGIzwGGuPUa3U4aweGQyAOZ+c64PUk+xJAZKpEuhYH31bzKf9ML
	 VfHA1MExmSPozK0/Srd17h8Pa61ogbKyEjEpZwBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbfDDJt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:49:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729969AbfDDI4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:56:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EBCA20652;
        Thu,  4 Apr 2019 08:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368163;
        bh=7udGr7CkuOqZ/ZkMTAMyEcn+KtSzPuocwrswRQADpss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aX+EOH1zvnKkEzOaoONfL1SAwEdtf7fBQMd9EnttYp/ldHcLR4uH1oH1gd9yvhHrY
         4ZcGPPijAVBC0nNAWgPQ2oqiABES5czEx1V8qWouchFHKUYMt/i2ETUaQK+xUEWrCF
         Dc9e1nQbF6TG91gazxWqoa4eZNp4+qAJpfnDkNoA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 044/121] serial: 8250_pxa: honor the port number from devicetree
Date:   Thu,  4 Apr 2019 10:47:12 +0200
Message-Id: <20190404084547.659936574@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084545.245659903@linuxfoundation.org>
References: <20190404084545.245659903@linuxfoundation.org>
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



