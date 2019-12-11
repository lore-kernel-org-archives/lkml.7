Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DEFC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E60A222C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="uDTaHM1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfLKT5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 14:57:49 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:38603 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfLKT5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 14:57:48 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 25D5823D06;
        Wed, 11 Dec 2019 20:57:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1576094266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pBddhS/axkFN9xuqKepHUAlLgUVkbXFMjGqDKWGgil4=;
        b=uDTaHM1c9Ge3fnx1CI4glGrwNO0zT16r1zuGcPycseCp6epInYYjxCHRXEw0rx4+dWjhmb
        QoZWj7bixM/w1MFHQSwubuSVNQugDU8ABKWc9PzRK8aEtHT7jHzTpo6rEYQH/BiWKILdLe
        TXMxac5IfMeBY411/OZvoR/pUXLE29A=
From:   Michael Walle <michael@walle.cc>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] spi: nxp-fspi: Ensure width is respected in spi-mem operations
Date:   Wed, 11 Dec 2019 20:57:30 +0100
Message-Id: <20191211195730.26794-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 25D5823D06
X-Spamd-Result: default: False [6.40 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCPT_COUNT_FIVE(0.00)[6];
         DKIM_SIGNED(0.00)[];
         MID_CONTAINS_FROM(1.00)[];
         NEURAL_HAM(-0.00)[-0.680];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:31334, ipnet:2a02:810c::/31, country:DE];
         FREEMAIL_CC(0.00)[gmail.com,nxp.com,kernel.org,walle.cc];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of a core helper to ensure the desired width is respected
when calling spi-mem operators.

Otherwise only the SPI controller will be matched with the flash chip,
which might lead to wrong widths. Also consider the width specified by
the user in the device tree.

Fixes: a5356aef6a90 ("spi: spi-mem: Add driver for NXP FlexSPI controller")
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/spi/spi-nxp-fspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index c36bb1bb464e..8c5084a3a617 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -439,7 +439,7 @@ static bool nxp_fspi_supports_op(struct spi_mem *mem,
 	    op->data.nbytes > f->devtype_data->txfifo)
 		return false;
 
-	return true;
+	return spi_mem_default_supports_op(mem, op);
 }
 
 /* Instead of busy looping invoke readl_poll_timeout functionality. */
-- 
2.20.1

