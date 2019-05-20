Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAFEC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC20721479
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558355408;
	bh=N9QFeO4yQVMQCWzkv0CVm3igV/vAF6zg1t8BEEZGIbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oJRVnC9HyY03GS3B6eghjsYNwkQPbs+/TtCPABAEHDJa8oZhI483xdu6TZfZU+uKL
	 zR+5xaXbV4okKwH8Y0F4RiGMwBhs+0bT9KNwneW2IhpfKyECRYW/zCleMnY9SqVs17
	 RmIyPNLvKddTbmJ6AsZLDbo++guQEYPen2AOxODc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390031AbfETMaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:30:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390019AbfETMaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:30:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96FDD20645;
        Mon, 20 May 2019 12:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558355402;
        bh=N9QFeO4yQVMQCWzkv0CVm3igV/vAF6zg1t8BEEZGIbY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UTYN4nPTb3+TFBbaPSImEcS2aed5ThrLf2/uU/EKJU5ow83PFZrq+fia7916yXczw
         MU2Ew7UCDsLK37W9T/awlSJ5iBPR2tbJ5GVhSnlGmoinNsWtj/BHDaMtm6RajtuWyF
         MRez9lFPlWZDR1Do1BBwJplPY02vCkR1Q7noaQQU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ofir Drang <ofir.drang@arm.com>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.0 064/123] crypto: ccree - HOST_POWER_DOWN_EN should be the last CC access during suspend
Date:   Mon, 20 May 2019 14:14:04 +0200
Message-Id: <20190520115249.067751301@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115245.439864225@linuxfoundation.org>
References: <20190520115245.439864225@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Drang <ofir.drang@arm.com>

commit 3499efbeed39d114873267683b9e776bcb34b058 upstream.

During power management suspend the driver need to prepare the device
for the power down operation and as a last indication write to the
HOST_POWER_DOWN_EN register which signals to the hardware that
The ccree is ready for power down.

Signed-off-by: Ofir Drang <ofir.drang@arm.com>
Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: stable@vger.kernel.org # v4.19+
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/ccree/cc_pm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/crypto/ccree/cc_pm.c
+++ b/drivers/crypto/ccree/cc_pm.c
@@ -25,13 +25,13 @@ int cc_pm_suspend(struct device *dev)
 	int rc;
 
 	dev_dbg(dev, "set HOST_POWER_DOWN_EN\n");
-	cc_iowrite(drvdata, CC_REG(HOST_POWER_DOWN_EN), POWER_DOWN_ENABLE);
 	rc = cc_suspend_req_queue(drvdata);
 	if (rc) {
 		dev_err(dev, "cc_suspend_req_queue (%x)\n", rc);
 		return rc;
 	}
 	fini_cc_regs(drvdata);
+	cc_iowrite(drvdata, CC_REG(HOST_POWER_DOWN_EN), POWER_DOWN_ENABLE);
 	cc_clk_off(drvdata);
 	return 0;
 }


