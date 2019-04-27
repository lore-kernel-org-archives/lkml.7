Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D439C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC1C21530
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbfD0PcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:32:10 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60744 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726762AbfD0PPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:12 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2h-0000zC-Fn; Sat, 27 Apr 2019 16:15:07 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2h-0004OC-95; Sat, 27 Apr 2019 16:15:07 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Hui Peng" <benquike@163.com>, "Takashi Iwai" <tiwai@suse.de>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.548229562@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 008/202] ALSA: usb-audio: Fix an out-of-bound read in
 create_composite_quirks
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Hui Peng <benquike@163.com>

commit cbb2ebf70daf7f7d97d3811a2ff8e39655b8c184 upstream.

In `create_composite_quirk`, the terminating condition of for loops is
`quirk->ifnum < 0`. So any composite quirks should end with `struct
snd_usb_audio_quirk` object with ifnum < 0.

    for (quirk = quirk_comp->data; quirk->ifnum >= 0; ++quirk) {

    	.....
    }

the data field of Bower's & Wilkins PX headphones usb device device quirks
do not end with {.ifnum = -1}, wihch may result in out-of-bound read.

This Patch fix the bug by adding an ending quirk object.

Fixes: 240a8af929c7 ("ALSA: usb-audio: Add a quirck for B&W PX headphones")
Signed-off-by: Hui Peng <benquike@163.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/usb/quirks-table.h | 6 ++++++
 1 file changed, 6 insertions(+)

--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3304,6 +3304,12 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge
 					}
 				}
 			},
+			{
+				.ifnum = -1
+			},
+			{
+				.ifnum = -1
+			},
 		}
 	}
 },

