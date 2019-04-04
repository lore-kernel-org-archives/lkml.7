Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34D1C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90DC92075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369456;
	bh=9jLA0YSxUlc/+mgRq34SmclPETWQAPpErWHL4ApI4y8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FH+9ziUbXFPnek0YaoIRf5TdRQJ5TujfUa2gNeELueOCBQsV01fON2jiFMDe01feJ
	 hRIjmq4VByFMv8et8K688OXR9e+uxnKhmXaXYvBfsta65fxsOrXQDYIne+o3Sjf80i
	 e8BHDnFX1L5B8sfafAppT/OEl5DWzZctrhODT5Jw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387605AbfDDJRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:17:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388199AbfDDJRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:17:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F9262075E;
        Thu,  4 Apr 2019 09:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369451;
        bh=9jLA0YSxUlc/+mgRq34SmclPETWQAPpErWHL4ApI4y8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cLB/ypuOkzYCnSfmd6ttIIequYvsO4Wh8n7Qux4NWX1+yoV1QqEbaG/IBRFsi4HEh
         KXhWKLSN+n1xvGlVd3dFLc78YXasvZMwbpgOaRf/avte7G7yS1iHvnBP3WCiS88tQZ
         0VW43vbC+RfeyT387t7jktABPcRaJyG7PPlMIh0A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 229/246] brcmfmac: Use firmware_request_nowarn for the clm_blob
Date:   Thu,  4 Apr 2019 10:48:49 +0200
Message-Id: <20190404084627.269619402@linuxfoundation.org>
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

[ Upstream commit 4ad0be160544ffbdafb7cec39bb8e6dd0a97317a ]

The linux-firmware brcmfmac firmware files contain an embedded table with
per country allowed channels and strength info.

For recent hardware these versions of the firmware are specially build for
linux-firmware, the firmware files directly available from Cypress rely on
a separate clm_blob file for this info.

For some unknown reason Cypress refuses to provide the standard firmware
files + clm_blob files it uses elsewhere for inclusion into linux-firmware,
instead relying on these special builds with the clm_blob info embedded.
This means that the linux-firmware firmware versions often lag behind,
but I digress.

The brcmfmac driver does support the separate clm_blob file and always
tries to load this. Currently we use request_firmware for this. This means
that on any standard install, using the standard combo of linux-kernel +
linux-firmware, we will get a warning:
"Direct firmware load for ... failed with error -2"

On top of this, brcmfmac itself prints: "no clm_blob available (err=-2),
device may have limited channels available".

This commit switches to firmware_request_nowarn, fixing almost any brcmfmac
device logging the warning (it leaves the brcmfmac info message in place).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
index 1f1e95a15a17..0ce1d8174e6d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
@@ -149,7 +149,7 @@ static int brcmf_c_process_clm_blob(struct brcmf_if *ifp)
 		return err;
 	}
 
-	err = request_firmware(&clm, clm_name, bus->dev);
+	err = firmware_request_nowarn(&clm, clm_name, bus->dev);
 	if (err) {
 		brcmf_info("no clm_blob available (err=%d), device may have limited channels available\n",
 			   err);
-- 
2.19.1



