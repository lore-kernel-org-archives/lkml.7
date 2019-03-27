Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92E5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1D220657
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553711726;
	bh=2XKyr4/lr1f1ZymUApGsdWfFphGfv7gMe2COxmPa2Lg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rc80P/NOC+yz8Uz6G4TEnpZZ1qRlXNbDujhKNf0Atl6D8R54fA4hRg3b4pjJ+Wmnq
	 p1LYaMdwEViuenrOBJtoIAvfWo7NN8DcAqcqYPJ19Y3opuibwrpVCbZN+z6ROZkZul
	 isGmHsbgolR/o+VxenIHDl+1t9zm0bPjh0KcvXNQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404191AbfC0SfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:35:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:43268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391570AbfC0SYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:24:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B7F22070B;
        Wed, 27 Mar 2019 18:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553711062;
        bh=2XKyr4/lr1f1ZymUApGsdWfFphGfv7gMe2COxmPa2Lg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=giwa0hhnkdhKuNdpRsOWJxB/G8T4fe1JytJFh517vrQd4A48o6nmLC3GxgZ9gMUOe
         lq+LfvSOPkeh0CiAiqm0jrhfcaQs25Z1jwnIEgySRXUvUDxcPGNEmSC8nQEuMC2AR+
         DNHz+w5i34VT4Xccrjd+OtCqgIWKaJd2bA6mBm+0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michal Kazior <michal@plume.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-leds@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 35/63] leds: lp55xx: fix null deref on firmware load failure
Date:   Wed, 27 Mar 2019 14:22:55 -0400
Message-Id: <20190327182323.18577-35-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327182323.18577-1-sashal@kernel.org>
References: <20190327182323.18577-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Kazior <michal@plume.com>

[ Upstream commit 5ddb0869bfc1bca6cfc592c74c64a026f936638c ]

I've stumbled upon a kernel crash and the logs
pointed me towards the lp5562 driver:

> <4>[306013.841294] lp5562 0-0030: Direct firmware load for lp5562 failed with error -2
> <4>[306013.894990] lp5562 0-0030: Falling back to user helper
> ...
> <3>[306073.924886] lp5562 0-0030: firmware request failed
> <1>[306073.939456] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> <4>[306074.251011] PC is at _raw_spin_lock+0x1c/0x58
> <4>[306074.255539] LR is at release_firmware+0x6c/0x138
> ...

After taking a look I noticed firmware_release()
could be called with either NULL or a dangling
pointer.

Fixes: 10c06d178df11 ("leds-lp55xx: support firmware interface")
Signed-off-by: Michal Kazior <michal@plume.com>
Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/leds-lp55xx-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/leds-lp55xx-common.c b/drivers/leds/leds-lp55xx-common.c
index 59b76833f0d3..fd077c176a62 100644
--- a/drivers/leds/leds-lp55xx-common.c
+++ b/drivers/leds/leds-lp55xx-common.c
@@ -200,7 +200,7 @@ static void lp55xx_firmware_loaded(const struct firmware *fw, void *context)
 
 	if (!fw) {
 		dev_err(dev, "firmware request failed\n");
-		goto out;
+		return;
 	}
 
 	/* handling firmware data is chip dependent */
@@ -213,9 +213,9 @@ static void lp55xx_firmware_loaded(const struct firmware *fw, void *context)
 
 	mutex_unlock(&chip->lock);
 
-out:
 	/* firmware should be released for other channel use */
 	release_firmware(chip->fw);
+	chip->fw = NULL;
 }
 
 static int lp55xx_request_firmware(struct lp55xx_chip *chip)
-- 
2.19.1

