Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF19C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2346620865
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570121331;
	bh=Oa22ffIU2Jf0c7DY4ADK8jkULI0dly0qUUAy6O5XH+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qsn2uwC2a1NDSoyZtMmw71bq52I+dLOKqbQrBEDD4m00+OX+fnzaukHyJZAvGUn+O
	 9QJlEikn/6iC6Pe2uzqzB/Y1SAa+0SO9yen4CiByQe3oEv6zb43MJr1ajTbaEM5jXX
	 p7vhSm+sSQILVeRCBfEpmhrBxE+StP1lUvPjSu80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405760AbfJCQsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:48:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405749AbfJCQst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:48:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D34E2070B;
        Thu,  3 Oct 2019 16:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570121328;
        bh=Oa22ffIU2Jf0c7DY4ADK8jkULI0dly0qUUAy6O5XH+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NVQzrkbspE1UqisePO6eE60FBZRCAmtPTZ0+GzLlOWXvL7IQYzmRH32xGBZ/sda5E
         na0neLml0SnXgpqCEeTy1cAw+qZYwT9lUYcmR6skO82AY3PcpEb3t+Sh/XLwzbrQ9U
         kv2gZ7flX/5TVa1pD47jhS91hqVFy80oV5PNMEp0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.3 239/344] ALSA: firewire-tascam: check intermediate state of clock status and retry
Date:   Thu,  3 Oct 2019 17:53:24 +0200
Message-Id: <20191003154603.958712554@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154540.062170222@linuxfoundation.org>
References: <20191003154540.062170222@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

commit e1a00b5b253a4f97216b9a33199a863987075162 upstream.

2 bytes in MSB of register for clock status is zero during intermediate
state after changing status of sampling clock in models of TASCAM FireWire
series. The duration of this state differs depending on cases. During the
state, it's better to retry reading the register for current status of
the clock.

In current implementation, the intermediate state is checked only when
getting current sampling transmission frequency, then retry reading.
This care is required for the other operations to read the register.

This commit moves the codes of check and retry into helper function
commonly used for operations to read the register.

Fixes: e453df44f0d6 ("ALSA: firewire-tascam: add PCM functionality")
Cc: <stable@vger.kernel.org> # v4.4+
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Link: https://lore.kernel.org/r/20190910135152.29800-3-o-takashi@sakamocchi.jp
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/firewire/tascam/tascam-stream.c |   42 ++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 14 deletions(-)

--- a/sound/firewire/tascam/tascam-stream.c
+++ b/sound/firewire/tascam/tascam-stream.c
@@ -8,20 +8,37 @@
 #include <linux/delay.h>
 #include "tascam.h"
 
+#define CLOCK_STATUS_MASK      0xffff0000
+#define CLOCK_CONFIG_MASK      0x0000ffff
+
 #define CALLBACK_TIMEOUT 500
 
 static int get_clock(struct snd_tscm *tscm, u32 *data)
 {
+	int trial = 0;
 	__be32 reg;
 	int err;
 
-	err = snd_fw_transaction(tscm->unit, TCODE_READ_QUADLET_REQUEST,
-				 TSCM_ADDR_BASE + TSCM_OFFSET_CLOCK_STATUS,
-				 &reg, sizeof(reg), 0);
-	if (err >= 0)
+	while (trial++ < 5) {
+		err = snd_fw_transaction(tscm->unit, TCODE_READ_QUADLET_REQUEST,
+				TSCM_ADDR_BASE + TSCM_OFFSET_CLOCK_STATUS,
+				&reg, sizeof(reg), 0);
+		if (err < 0)
+			return err;
+
 		*data = be32_to_cpu(reg);
+		if (*data & CLOCK_STATUS_MASK)
+			break;
+
+		// In intermediate state after changing clock status.
+		msleep(50);
+	}
 
-	return err;
+	// Still in the intermediate state.
+	if (trial >= 5)
+		return -EAGAIN;
+
+	return 0;
 }
 
 static int set_clock(struct snd_tscm *tscm, unsigned int rate,
@@ -34,7 +51,7 @@ static int set_clock(struct snd_tscm *ts
 	err = get_clock(tscm, &data);
 	if (err < 0)
 		return err;
-	data &= 0x0000ffff;
+	data &= CLOCK_CONFIG_MASK;
 
 	if (rate > 0) {
 		data &= 0x000000ff;
@@ -79,17 +96,14 @@ static int set_clock(struct snd_tscm *ts
 
 int snd_tscm_stream_get_rate(struct snd_tscm *tscm, unsigned int *rate)
 {
-	u32 data = 0x0;
-	unsigned int trials = 0;
+	u32 data;
 	int err;
 
-	while (data == 0x0 || trials++ < 5) {
-		err = get_clock(tscm, &data);
-		if (err < 0)
-			return err;
+	err = get_clock(tscm, &data);
+	if (err < 0)
+		return err;
 
-		data = (data & 0xff000000) >> 24;
-	}
+	data = (data & 0xff000000) >> 24;
 
 	/* Check base rate. */
 	if ((data & 0x0f) == 0x01)


