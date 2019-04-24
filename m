Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4286AC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0312721904
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126556;
	bh=d4CCv43Dn69lwbQqBcdVooznbfqNl55zkL9QJn2sUvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uYA4+Tdbqt6tnBB4qqSzNjt4FwCUWXeXj9zH161bmFeA5m2ftKS5ELw7EKr5IrMrh
	 +COL6Zr01tklcrvqnxDNlipzpFY4U+CZk1w1sxL1OdgeQHiJ5Zh1GZG9onII58e6A+
	 HeLlJEnAg4ipxI5PeBydD11VxBDituXDypTHJwMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389595AbfDXRWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:22:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:48134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388929AbfDXRWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:22:32 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB48821904;
        Wed, 24 Apr 2019 17:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126552;
        bh=d4CCv43Dn69lwbQqBcdVooznbfqNl55zkL9QJn2sUvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bd9ci7g/spmKDAomMFhpom7ovWNB8mpIsr+GzFaEoOemq0OlQLR9COGaUldpjxZKy
         QnRArq+ApDOhGSZ2ity/vPauGMpTx2i0aPrjrtLVTI4VdH3e0kIkiNhpjbhmWaImZ7
         STEouWSjRl3ta472ZtAlwBQ8k5ERpWDPnB8/H89M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 102/168] ALSA: sb8: add a check for request_region
Date:   Wed, 24 Apr 2019 19:09:06 +0200
Message-Id: <20190424170929.671852037@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit dcd0feac9bab901d5739de51b3f69840851f8919 ]

In case request_region fails, the fix returns an error code to
avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/isa/sb/sb8.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/isa/sb/sb8.c b/sound/isa/sb/sb8.c
index b8e2391c33ff..0c7fe1418447 100644
--- a/sound/isa/sb/sb8.c
+++ b/sound/isa/sb/sb8.c
@@ -111,6 +111,10 @@ static int snd_sb8_probe(struct device *pdev, unsigned int dev)
 
 	/* block the 0x388 port to avoid PnP conflicts */
 	acard->fm_res = request_region(0x388, 4, "SoundBlaster FM");
+	if (!acard->fm_res) {
+		err = -EBUSY;
+		goto _err;
+	}
 
 	if (port[dev] != SNDRV_AUTO_PORT) {
 		if ((err = snd_sbdsp_create(card, port[dev], irq[dev],
-- 
2.19.1



