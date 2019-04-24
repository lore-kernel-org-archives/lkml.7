Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E005DC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17F32089F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556128382;
	bh=f1eq43FuiQ2k2n+uInBQd/LGu9tuEM0gNsybuiYgH+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jSQIo7zrLtCdKDk+pwRYCj59qmXs9TDFA9HERaOmN5Y4B+s4Wwcw0okYGIJiD490b
	 aap9HNQev1s2IkoY0Ljz4xHI1nVsovwIHje3b/2ecKnN+uDDk66Sh8tv6QEGtrgI/q
	 MhMCGk1iPO+zVIm3BRqG98AokQCqeePI7h9qPzr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390771AbfDXRxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:53:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390060AbfDXR1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:27:40 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0581221909;
        Wed, 24 Apr 2019 17:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126859;
        bh=f1eq43FuiQ2k2n+uInBQd/LGu9tuEM0gNsybuiYgH+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sb8tNKJ3GHctdJNshGaFqVcr0mMnzurp3yMw6B5PxQ8NiUqijENTK4pwWVve/IYSC
         RnfO7b62a1FHbKX6vbyUkg8jlkgX+HPu9vwGCyRxyGhUh0dJE7NVIzT+Xcc2yn4iOx
         pU+0KTxy7rSq6dOqUML07ExN26iG2ZOCM9QZsu1g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vijayakumar Durai <vijayakumar.durai1@vivint.com>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.14 42/70] rt2x00: do not increment sequence number while re-transmitting
Date:   Wed, 24 Apr 2019 19:10:02 +0200
Message-Id: <20190424170913.304171827@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170906.751869122@linuxfoundation.org>
References: <20190424170906.751869122@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vijayakumar Durai <vijayakumar.durai1@vivint.com>

commit 746ba11f170603bf1eaade817553a6c2e9135bbe upstream.

Currently rt2x00 devices retransmit the management frames with
incremented sequence number if hardware is assigning the sequence.

This is HW bug fixed already for non-QOS data frames, but it should
be fixed for management frames except beacon.

Without fix retransmitted frames have wrong SN:

 AlphaNet_e8:fb:36 Vivotek_52:31:51 Authentication, SN=1648, FN=0, Flags=........C Frame is not being retransmitted 1648 1
 AlphaNet_e8:fb:36 Vivotek_52:31:51 Authentication, SN=1649, FN=0, Flags=....R...C Frame is being retransmitted 1649 1
 AlphaNet_e8:fb:36 Vivotek_52:31:51 Authentication, SN=1650, FN=0, Flags=....R...C Frame is being retransmitted 1650 1

With the fix SN stays correctly the same:

 88:6a:e3:e8:f9:a2 8c:f5:a3:88:76:87 Authentication, SN=1450, FN=0, Flags=........C
 88:6a:e3:e8:f9:a2 8c:f5:a3:88:76:87 Authentication, SN=1450, FN=0, Flags=....R...C
 88:6a:e3:e8:f9:a2 8c:f5:a3:88:76:87 Authentication, SN=1450, FN=0, Flags=....R...C

Cc: stable@vger.kernel.org
Signed-off-by: Vijayakumar Durai <vijayakumar.durai1@vivint.com>
[sgruszka: simplify code, change comments and changelog]
Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/ralink/rt2x00/rt2x00.h      |    1 -
 drivers/net/wireless/ralink/rt2x00/rt2x00mac.c   |   10 ----------
 drivers/net/wireless/ralink/rt2x00/rt2x00queue.c |   15 +++++++++------
 3 files changed, 9 insertions(+), 17 deletions(-)

--- a/drivers/net/wireless/ralink/rt2x00/rt2x00.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
@@ -672,7 +672,6 @@ enum rt2x00_state_flags {
 	CONFIG_CHANNEL_HT40,
 	CONFIG_POWERSAVING,
 	CONFIG_HT_DISABLED,
-	CONFIG_QOS_DISABLED,
 	CONFIG_MONITORING,
 
 	/*
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
@@ -670,19 +670,9 @@ void rt2x00mac_bss_info_changed(struct i
 			rt2x00dev->intf_associated--;
 
 		rt2x00leds_led_assoc(rt2x00dev, !!rt2x00dev->intf_associated);
-
-		clear_bit(CONFIG_QOS_DISABLED, &rt2x00dev->flags);
 	}
 
 	/*
-	 * Check for access point which do not support 802.11e . We have to
-	 * generate data frames sequence number in S/W for such AP, because
-	 * of H/W bug.
-	 */
-	if (changes & BSS_CHANGED_QOS && !bss_conf->qos)
-		set_bit(CONFIG_QOS_DISABLED, &rt2x00dev->flags);
-
-	/*
 	 * When the erp information has changed, we should perform
 	 * additional configuration steps. For all other changes we are done.
 	 */
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00queue.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00queue.c
@@ -200,15 +200,18 @@ static void rt2x00queue_create_tx_descri
 	if (!rt2x00_has_cap_flag(rt2x00dev, REQUIRE_SW_SEQNO)) {
 		/*
 		 * rt2800 has a H/W (or F/W) bug, device incorrectly increase
-		 * seqno on retransmited data (non-QOS) frames. To workaround
-		 * the problem let's generate seqno in software if QOS is
-		 * disabled.
+		 * seqno on retransmitted data (non-QOS) and management frames.
+		 * To workaround the problem let's generate seqno in software.
+		 * Except for beacons which are transmitted periodically by H/W
+		 * hence hardware has to assign seqno for them.
 		 */
-		if (test_bit(CONFIG_QOS_DISABLED, &rt2x00dev->flags))
-			__clear_bit(ENTRY_TXD_GENERATE_SEQ, &txdesc->flags);
-		else
+	    	if (ieee80211_is_beacon(hdr->frame_control)) {
+			__set_bit(ENTRY_TXD_GENERATE_SEQ, &txdesc->flags);
 			/* H/W will generate sequence number */
 			return;
+		}
+
+		__clear_bit(ENTRY_TXD_GENERATE_SEQ, &txdesc->flags);
 	}
 
 	/*


