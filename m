Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E521DC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C8521927
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568787992;
	bh=YMHAW1um3kPGkQPFDMT9+zWRXA3Plklg/FXqtu4qDWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l98W79wNrySk7rrZg252Mu35/jWaoXW7PiOtLiLM9zXTgFVKey+7hhyIwZMg8H+oq
	 Vl8tZdhb5Fdm55T0qqKOmvhmdF36yW6FENO0f/bOS0FYs+N4iq/h9ggBQ0pKo+uecH
	 qQ5mzB8bYiG37YUyVKX/m2agheospd1e3gcldtY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbfIRG0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 02:26:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728781AbfIRG0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:26:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3A0321924;
        Wed, 18 Sep 2019 06:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568787985;
        bh=YMHAW1um3kPGkQPFDMT9+zWRXA3Plklg/FXqtu4qDWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=davbHvmnaORL06STAhsDH40K0l54gJb1KiT8Q9YOfFwlIyFhc/Hy0NnGLQndZHaJY
         FwfXZ7Rh9t54fvMBvTYJlkLeeP91oXJnGUnYBkFIS8FD9xawP4OR/dYyWZnf13n/Jr
         jFDrK3Nt8ntvlIKLhMz+ydFh+mvKAwYRrUF6hBvc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stanislaw Gruszka <sgruszka@redhat.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 5.2 40/85] mt76: mt76x0e: disable 5GHz band for MT7630E
Date:   Wed, 18 Sep 2019 08:18:58 +0200
Message-Id: <20190918061235.404229511@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190918061234.107708857@linuxfoundation.org>
References: <20190918061234.107708857@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stanislaw Gruszka <sgruszka@redhat.com>

commit 70702265a04aa0ce5a7bde77d13456209992b32f upstream.

MT7630E hardware does support 5GHz, but we do not properly configure phy
for 5GHz channels. Scanning at this band not only do not show any APs
but also can hang the firmware.

Since vendor reference driver do not support 5GHz we don't know how
properly configure 5GHz channels. So disable this band for MT7630E .

Cc: stable@vger.kernel.org
Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c
@@ -59,6 +59,11 @@ static void mt76x0_set_chip_cap(struct m
 		dev_dbg(dev->mt76.dev, "mask out 2GHz support\n");
 	}
 
+	if (is_mt7630(dev)) {
+		dev->mt76.cap.has_5ghz = false;
+		dev_dbg(dev->mt76.dev, "mask out 5GHz support\n");
+	}
+
 	if (!mt76x02_field_valid(nic_conf1 & 0xff))
 		nic_conf1 &= 0xff00;
 


