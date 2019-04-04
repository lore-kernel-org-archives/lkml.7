Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A630C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6B0205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370508;
	bh=1b6XqWC6eXD8aicezeUNaB2us//gmAIg4pzhMlVJ2N8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HvMX8HScYx3mdejH+Hd+iss9XTQpEMrwDz/rrEfBcY/4XGJsVfJ9vyqZ2YBjVDtHc
	 NPqK28evZTMFRAfRF/iGpBAprhyXJFZ5Xq3DJPuEhxlpNYWQp0mdVJesEXGYAf3tGz
	 9RFHXz+bnW1Y4mP7fimvqHMKla65qj1w+kzaLkq4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732645AbfDDJfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:35:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732358AbfDDJGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:06:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 047CA218FF;
        Thu,  4 Apr 2019 09:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368800;
        bh=1b6XqWC6eXD8aicezeUNaB2us//gmAIg4pzhMlVJ2N8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2OxpsvSS+C9SAEbBOul/IgtEnnRjJWtRPW6mk1ENbrxEh4cdDh3BgdWVCGtByvITk
         VRaaNHBtmxCPvMLK1hEYA9h+cm+J8B/nVCzUNohUafmRrhCQ++fdGlkKNK6vXJd6Tz
         Cp5yUPhiRE0ecszbqYjSlQJZ1wDJBbkhs7QJWY68=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 175/187] brcmfmac: Use firmware_request_nowarn for the clm_blob
Date:   Thu,  4 Apr 2019 10:48:32 +0200
Message-Id: <20190404084611.350544499@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index cd3651069d0c..27893af63ebc 100644
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



