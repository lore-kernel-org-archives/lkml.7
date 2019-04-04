Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C90FC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7EA2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370183;
	bh=fk/ewNo0bcmDcA/TR1FEC+GO/PeKstfoouvQKMN6Uhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ly7pDMiXHQc8UeRrJC1bZqLNcqy5MFUbU3VyTcPFek7qManQdqYnDMxC42iWt0/dS
	 t9rFeE4EJRlsEjH2RHlGfsHGeEtY7/zo/Oe06meN2tve9eaiZNML1t6NaINhZjFKl1
	 iMw+S68tXDSOXkgYSKNDzIxvi3UV+stW20MlvrOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733229AbfDDJ3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:29:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732814AbfDDJKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:10:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A730F20693;
        Thu,  4 Apr 2019 09:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369042;
        bh=fk/ewNo0bcmDcA/TR1FEC+GO/PeKstfoouvQKMN6Uhg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HY8q7xU2+oSAovUmEhJdLDA/UvGsDhtsBuMFFfaL1bvntlkDGdiXBHoP7nUVJpg1V
         09M7qr2wLe9O0AkBv/GI0eYYQUvsyrwdYp471DePb9sxA7tribDbZju07Z0r/Jv6ZL
         fPqwGLBNwbN9EFR2n2PvrFc2Fm1A3ERfmL1dYjE4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 076/246] serial: 8250_pxa: honor the port number from devicetree
Date:   Thu,  4 Apr 2019 10:46:16 +0200
Message-Id: <20190404084621.795624667@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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
index b9bcbe20a2be..c47188860e32 100644
--- a/drivers/tty/serial/8250/8250_pxa.c
+++ b/drivers/tty/serial/8250/8250_pxa.c
@@ -113,6 +113,10 @@ static int serial_pxa_probe(struct platform_device *pdev)
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



