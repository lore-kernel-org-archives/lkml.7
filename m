Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15844C2D0C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 00:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD332467B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 00:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbfLQAxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 19:53:06 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35554 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727205AbfLQAvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 19:51:45 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1ih15O-0003PR-5c; Tue, 17 Dec 2019 00:51:38 +0000
Received: from ben by deadeye with local (Exim 4.93-RC7)
        (envelope-from <ben@decadent.org.uk>)
        id 1ih15L-0005fo-Dv; Tue, 17 Dec 2019 00:51:35 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Henry Lin" <henryl@nvidia.com>, "Takashi Iwai" <tiwai@suse.de>
Date:   Tue, 17 Dec 2019 00:47:43 +0000
Message-ID: <lsq.1576543535.324896323@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 129/136] ALSA: usb-audio: not submit urb for stopped
 endpoint
In-Reply-To: <lsq.1576543534.33060804@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.80-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Henry Lin <henryl@nvidia.com>

commit 528699317dd6dc722dccc11b68800cf945109390 upstream.

While output urb's snd_complete_urb() is executing, calling
prepare_outbound_urb() may cause endpoint stopped before
prepare_outbound_urb() returns and result in next urb submitted
to stopped endpoint. usb-audio driver cannot re-use it afterwards as
the urb is still hold by usb stack.

This change checks EP_FLAG_RUNNING flag after prepare_outbound_urb() again
to let snd_complete_urb() know the endpoint already stopped and does not
submit next urb. Below kind of error will be fixed:

[  213.153103] usb 1-2: timeout: still 1 active urbs on EP #1
[  213.164121] usb 1-2: cannot submit urb 0, error -16: unknown error

Signed-off-by: Henry Lin <henryl@nvidia.com>
Link: https://lore.kernel.org/r/20191113021420.13377-1-henryl@nvidia.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/usb/endpoint.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -377,6 +377,9 @@ static void snd_complete_urb(struct urb
 		}
 
 		prepare_outbound_urb(ep, ctx);
+		/* can be stopped during prepare callback */
+		if (unlikely(!test_bit(EP_FLAG_RUNNING, &ep->flags)))
+			goto exit_clear;
 	} else {
 		retire_inbound_urb(ep, ctx);
 		/* can be stopped during retire callback */

