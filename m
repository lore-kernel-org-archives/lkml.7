Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C6FC2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5241820674
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482924;
	bh=dg2MU6IFSs3G0S+mmM3T6HFFRjpfRxxzHPcgk4BIABU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R3h0cQpiAENqui3jqlStfpyRPvZIa1D3LB4+wjEF+iwUdCcBxvX0n1AcLjAbr7Mw4
	 lFPEPI+ZsrOrpSwSR3MSOMX9YL+bpp8KGoEArhrc7kjFwYw62x7ZEaIPdI0ssva9cL
	 BG30H6itS/PluXyxJhYgQiD4eUkrc7qu9ogCg+qs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730952AbfLDSIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:08:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:60524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730915AbfLDSIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:08:31 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 214AB20833;
        Wed,  4 Dec 2019 18:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482910;
        bh=dg2MU6IFSs3G0S+mmM3T6HFFRjpfRxxzHPcgk4BIABU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nBOEO4MqImdn1SdqV+FBxj1DIlh++wQJbXBPpI1dFLJ1blyeaKPe209VvZJZfcyY1
         dap+v0YWfXgMbPPTVH05ESCs342hQki+kM+hmYGdOVDjDuVPVsnno9yKn/Rm2yGn1e
         l05GWPHUT8j5yogT33j6kWeUe04ne/WOtkiePjrc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4.14 182/209] mtd: rawnand: atmel: Fix spelling mistake in error message
Date:   Wed,  4 Dec 2019 18:56:34 +0100
Message-Id: <20191204175336.018549369@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175321.609072813@linuxfoundation.org>
References: <20191204175321.609072813@linuxfoundation.org>
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
 drivers/mtd/nand/atmel/nand-controller.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mtd/nand/atmel/nand-controller.c
+++ b/drivers/mtd/nand/atmel/nand-controller.c
@@ -1888,7 +1888,7 @@ static int atmel_nand_controller_add_nan
 
 	ret = of_property_read_u32(np, "#size-cells", &val);
 	if (ret) {
-		dev_err(dev, "missing #address-cells property\n");
+		dev_err(dev, "missing #size-cells property\n");
 		return ret;
 	}
 


