Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D913C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B2C20578
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557428168;
	bh=WSRye4QuqhDnD0KzcvLyhshoPeuDaJR9wrkaZyoDOMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gkQJtUbyycMcttOyGSwLOUz7l5efB/ht/mKxZG8zTBLJo6zmgY9FCWME0QVYgEWS3
	 Fyet1wku8wWH6YcQ8yy1ljw1nfjrbWvCyVuTjRH62Id/dT8ZCBXwM0OjAz1vz3Y/jk
	 SJvhO2uC0LktTfutEFXkHO3JnQwW/0erL9BsmoHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbfEISzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:55:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729198AbfEISzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:55:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECB47204FD;
        Thu,  9 May 2019 18:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557428115;
        bh=WSRye4QuqhDnD0KzcvLyhshoPeuDaJR9wrkaZyoDOMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o+DjTKgOJ+OxL9eKvzy7o4M/kA6kBdEYT6JYakj45OZZCb7EVGVwvVW+XNm/vccMq
         QCrHPH2U7o7plbzwRodFIPYyP+iG8UUHC45WKglZUTaHbfBugDftfqA+0eqoV9dTS8
         LpWcfrnDql+CgRENouQHyJCsyxqP3bHSjIhF6UKI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thinh Nguyen <thinhn@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 5.1 08/30] usb: dwc3: Fix default lpm_nyet_threshold value
Date:   Thu,  9 May 2019 20:42:40 +0200
Message-Id: <20190509181252.423027909@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181250.417203112@linuxfoundation.org>
References: <20190509181250.417203112@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

commit 8d791929b2fbdf7734c1596d808e55cb457f4562 upstream.

The max possible value for DCTL.LPM_NYET_THRES is 15 and not 255. Change
the default value to 15.

Cc: stable@vger.kernel.org
Fixes: 80caf7d21adc ("usb: dwc3: add lpm erratum support")
Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc3/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1218,7 +1218,7 @@ static void dwc3_get_properties(struct d
 	u8			tx_max_burst_prd;
 
 	/* default to highest possible threshold */
-	lpm_nyet_threshold = 0xff;
+	lpm_nyet_threshold = 0xf;
 
 	/* default to -3.5dB de-emphasis */
 	tx_de_emphasis = 1;


