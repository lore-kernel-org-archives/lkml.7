Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA773C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C3620866
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413929;
	bh=ZmxwNmAwB4742Iu89EpDn11440DflLFePsLiljRqvwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x+DH0sZS+Rinq6Xd1ji7XcKOhT4oEVfZSA3hMKAyLNNGQQQNd+JW05hs+RGucDDqG
	 2tH/U+PfEWNxbpdlaJ/pLMsc4tiIBYGcLC/DrjebbL+qNY82JofoJFdUG6Jj4ppk5e
	 JyegoTUK2HQ9MRaWFAi4CtfRtgMtjzrQljPEu5bc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730584AbfLCW6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:58:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:55258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730293AbfLCW6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:58:46 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 284C620866;
        Tue,  3 Dec 2019 22:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413925;
        bh=ZmxwNmAwB4742Iu89EpDn11440DflLFePsLiljRqvwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PPUAglgq84wtj6wWLrYWc1sCCBnbxg9HwEo4sWayymEA5pgzvk8IFCrCOcs78sn+n
         T68yj1QGQkFsOqw9pGVK4YO2snHKlFeQrU4cqPkEUEGmDV+EluMsrFdviOnWyyxq93
         gMSQipKmqbijkA5AbEId+DqrevLL+bFg4pJlt6Cs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4.19 298/321] mtd: rawnand: atmel: Fix spelling mistake in error message
Date:   Tue,  3 Dec 2019 23:36:04 +0100
Message-Id: <20191203223442.654000786@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

commit e39bb786816453788836c367caefd72eceea380c upstream.

Wrong copy/paste from the previous block, the error message should
refer to #size-cells instead of #address-cells.

Fixes: f88fc122cc34 ("mtd: nand: Cleanup/rework the atmel_nand driver")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/raw/atmel/nand-controller.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -1826,7 +1826,7 @@ static int atmel_nand_controller_add_nan
 
 	ret = of_property_read_u32(np, "#size-cells", &val);
 	if (ret) {
-		dev_err(dev, "missing #address-cells property\n");
+		dev_err(dev, "missing #size-cells property\n");
 		return ret;
 	}
 


