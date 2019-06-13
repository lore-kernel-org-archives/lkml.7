Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834BBC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B912147A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560443036;
	bh=3OEXiAs75ff7vu4u0tXJhZvD+5HKzFh2qQAAOpwAB7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZtSGpPVy7f/3ldZ211bELad3j8szxuC0sDX1p7U6z779JYE8u983eKHjE/5Ilp9gr
	 k9bMOiPAnDvfeuDhmH2ivVEQDJt12OaPj325xowPv+ycWuRBgq4cTDk0KN9fP84cIH
	 3P4sZFmDIVTc3F3b0PK3F/jpa2lPvTRzMKCP33cs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403980AbfFMQXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:23:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731008AbfFMIh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:37:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8020820851;
        Thu, 13 Jun 2019 08:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415049;
        bh=3OEXiAs75ff7vu4u0tXJhZvD+5HKzFh2qQAAOpwAB7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EkjR69eKLOUNCXs5dikj9hioB+RV2x00rIoz2aY8Jn6cCYvM8j93zgSzk1iH8WCuY
         uXVLGQJVyEWaFcH0zqjiaDGejHekWKm25p1+nIuJzXHiSkvjrX35Ed608YZA9kDDoI
         1vE7wbNkC93DzJwEnUV34ezBIRPJMuDOfEgpK6b0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liwei Song <liwei.song@windriver.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 41/81] ALSA: hda - Register irq handler after the chip initialization
Date:   Thu, 13 Jun 2019 10:33:24 +0200
Message-Id: <20190613075652.365131244@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075649.074682929@linuxfoundation.org>
References: <20190613075649.074682929@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit f495222e28275222ab6fd93813bd3d462e16d340 ]

Currently the IRQ handler in HD-audio controller driver is registered
before the chip initialization.  That is, we have some window opened
between the azx_acquire_irq() call and the CORB/RIRB setup.  If an
interrupt is triggered in this small window, the IRQ handler may
access to the uninitialized RIRB buffer, which leads to a NULL
dereference Oops.

This is usually no big problem since most of Intel chips do register
the IRQ via MSI, and we've already fixed the order of the IRQ
enablement and the CORB/RIRB setup in the former commit b61749a89f82
("sound: enable interrupt after dma buffer initialization"), hence the
IRQ won't be triggered in that room.  However, some platforms use a
shared IRQ, and this may allow the IRQ trigger by another source.

Another possibility is the kdump environment: a stale interrupt might
be present in there, the IRQ handler can be falsely triggered as well.

For covering this small race, let's move the azx_acquire_irq() call
after hda_intel_init_chip() call.  Although this is a bit radical
change, it can cover more widely than checking the CORB/RIRB setup
locally in the callee side.

Reported-by: Liwei Song <liwei.song@windriver.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_intel.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index afa591cf840a..65fb1e7edb9c 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1839,9 +1839,6 @@ static int azx_first_init(struct azx *chip)
 			chip->msi = 0;
 	}
 
-	if (azx_acquire_irq(chip, 0) < 0)
-		return -EBUSY;
-
 	pci_set_master(pci);
 	synchronize_irq(bus->irq);
 
@@ -1956,6 +1953,9 @@ static int azx_first_init(struct azx *chip)
 		return -ENODEV;
 	}
 
+	if (azx_acquire_irq(chip, 0) < 0)
+		return -EBUSY;
+
 	strcpy(card->driver, "HDA-Intel");
 	strlcpy(card->shortname, driver_short_names[chip->driver_type],
 		sizeof(card->shortname));
-- 
2.20.1



