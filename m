Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FB1C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC7320684
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575412660;
	bh=klQsIEaLdkvQn9mXHsL/19l5ID92BD8wx7KpDUk+fkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KLsgAh++gmRkcD4RAYVRyxQkFzqll6xifqYkzg7Vbj3477BQ7y+gXBlwXAC2caWHd
	 k3eb+D33Trm4Mx3hbuhsU2EzDeALdywuEcdrNSs8hU5ZTDxnf8QueZSdOMHJeshFni
	 fXLPoAIAUanucvp0nf5TNVKa3Kiqh5GA0DhsAjZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfLCWhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:37:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:45952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727722AbfLCWhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:37:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0C0B2073C;
        Tue,  3 Dec 2019 22:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575412656;
        bh=klQsIEaLdkvQn9mXHsL/19l5ID92BD8wx7KpDUk+fkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KWVMQ9fbZ2HoZvK4+WzTM2G+XC2R/H8QZrPFENjvQc8/TiZUsSROeGwY4o3k5eNPj
         NCKAdaQ973ig1MNV5vuEs20IeDUA7vGmgQJplTz6rLhpTfw7sN2C0FNfMmtC4dwNeP
         ac+phyoTcESEhgMgPdk0ImyTjg7iulTiUXWDuIWc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mathias Kresin <dev@kresin.me>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 5.4 06/46] usb: dwc2: use a longer core rest timeout in dwc2_core_reset()
Date:   Tue,  3 Dec 2019 23:35:26 +0100
Message-Id: <20191203212716.752250752@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203212705.175425505@linuxfoundation.org>
References: <20191203212705.175425505@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathias Kresin <dev@kresin.me>

commit 6689f0f4bb14e50917ba42eb9b41c25e0184970c upstream.

Testing on different generations of Lantiq MIPS SoC based boards, showed
that it takes up to 1500 us until the core reset bit is cleared.

The driver from the vendor SDK (ifxhcd) uses a 1 second timeout. Use the
same timeout to fix wrong hang detections and make the driver work for
Lantiq MIPS SoCs.

At least till kernel 4.14 the hanging reset only caused a warning but
the driver was probed successful. With kernel 4.19 errors out with
EBUSY.

Cc: linux-stable <stable@vger.kernel.org> # 4.19+
Signed-off-by: Mathias Kresin <dev@kresin.me>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc2/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/dwc2/core.c
+++ b/drivers/usb/dwc2/core.c
@@ -524,7 +524,7 @@ int dwc2_core_reset(struct dwc2_hsotg *h
 	greset |= GRSTCTL_CSFTRST;
 	dwc2_writel(hsotg, greset, GRSTCTL);
 
-	if (dwc2_hsotg_wait_bit_clear(hsotg, GRSTCTL, GRSTCTL_CSFTRST, 50)) {
+	if (dwc2_hsotg_wait_bit_clear(hsotg, GRSTCTL, GRSTCTL_CSFTRST, 10000)) {
 		dev_warn(hsotg->dev, "%s: HANG! Soft Reset timeout GRSTCTL GRSTCTL_CSFTRST\n",
 			 __func__);
 		return -EBUSY;


