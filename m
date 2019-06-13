Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437B3C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1206F20665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560441766;
	bh=40DTW3A9ULQJV05YKLriCav7N/Bx4LGVmFcy1t1S5P0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iZPsNkAQ7b/P77t1/EAk4TRwmsKH7VyL0nmoJ2YfEZobA+oX8XGDgNjvGxR1u3Lb6
	 ZlebOgjgihkYS+o9nxUXzrUifYf7FgBR1Uif/pPuo55u0I4edTQVf+YFB8F+ldKugj
	 GKud9byTlkxQjs2vRuPDk/LnwL2FaQHpEErv8cdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731584AbfFMQCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:02:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:35914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731403AbfFMIrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:47:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08719206BA;
        Thu, 13 Jun 2019 08:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415666;
        bh=40DTW3A9ULQJV05YKLriCav7N/Bx4LGVmFcy1t1S5P0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OUZg0mAVC6BE4Z1cgV19lT4ixH1rh18232pQD7Uv7imPpPFoz3/VBPlnKZ8XrkGTl
         F+ml7gqv9kWh+oXwWFegW8GCCTUA5vbphx1tr7ITb58tguHpzhK3NR7CxpLYlcZ5EN
         4g8MnMMc1TRitYT36bNHknVYZrzhqugcVSoqJH0c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 083/155] nvmem: core: fix read buffer in place
Date:   Thu, 13 Jun 2019 10:33:15 +0200
Message-Id: <20190613075657.713095622@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075652.691765927@linuxfoundation.org>
References: <20190613075652.691765927@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 2fe518fecb3a4727393be286db9804cd82ee2d91 ]

When the bit_offset in the cell is zero, the pointer to the msb will
not be properly initialized (ie, will still be pointing to the first
byte in the buffer).

This being the case, if there are bits to clear in the msb, those will
be left untouched while the mask will incorrectly clear bit positions
on the first byte.

This commit also makes sure that any byte unused in the cell is
cleared.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvmem/core.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index f24008b66826..53dc37574b5d 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1166,7 +1166,7 @@ EXPORT_SYMBOL_GPL(nvmem_cell_put);
 static void nvmem_shift_read_buffer_in_place(struct nvmem_cell *cell, void *buf)
 {
 	u8 *p, *b;
-	int i, bit_offset = cell->bit_offset;
+	int i, extra, bit_offset = cell->bit_offset;
 
 	p = b = buf;
 	if (bit_offset) {
@@ -1181,11 +1181,16 @@ static void nvmem_shift_read_buffer_in_place(struct nvmem_cell *cell, void *buf)
 			p = b;
 			*b++ >>= bit_offset;
 		}
-
-		/* result fits in less bytes */
-		if (cell->bytes != DIV_ROUND_UP(cell->nbits, BITS_PER_BYTE))
-			*p-- = 0;
+	} else {
+		/* point to the msb */
+		p += cell->bytes - 1;
 	}
+
+	/* result fits in less bytes */
+	extra = cell->bytes - DIV_ROUND_UP(cell->nbits, BITS_PER_BYTE);
+	while (--extra >= 0)
+		*p-- = 0;
+
 	/* clear msb bits if any leftover in the last byte */
 	*p &= GENMASK((cell->nbits%BITS_PER_BYTE) - 1, 0);
 }
-- 
2.20.1



