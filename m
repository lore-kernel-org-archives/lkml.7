Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EF6C48BD9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 16:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48DB220659
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 16:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfF0Q7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 12:59:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59668 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbfF0Q7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 12:59:00 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hgXjZ-000846-Sc; Thu, 27 Jun 2019 16:58:53 +0000
From:   Colin King <colin.king@canonical.com>
To:     Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, xen-devel@lists.xenproject.org,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: xen-front: fix unintention integer overflow on left shifts
Date:   Thu, 27 Jun 2019 17:58:53 +0100
Message-Id: <20190627165853.21864-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Shifting the integer value 1 is evaluated using 32-bit
arithmetic and then used in an expression that expects a 64-bit
value, so there is potentially an integer overflow. Fix this
by using the BIT_ULL macro to perform the shift.

Addresses-Coverity: ("Unintentional integer overflow")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/xen/xen_snd_front_alsa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/xen/xen_snd_front_alsa.c b/sound/xen/xen_snd_front_alsa.c
index b14ab512c2ce..e01631959ed8 100644
--- a/sound/xen/xen_snd_front_alsa.c
+++ b/sound/xen/xen_snd_front_alsa.c
@@ -196,7 +196,7 @@ static u64 to_sndif_formats_mask(u64 alsa_formats)
 	mask = 0;
 	for (i = 0; i < ARRAY_SIZE(ALSA_SNDIF_FORMATS); i++)
 		if (pcm_format_to_bits(ALSA_SNDIF_FORMATS[i].alsa) & alsa_formats)
-			mask |= 1 << ALSA_SNDIF_FORMATS[i].sndif;
+			mask |= BIT_ULL(ALSA_SNDIF_FORMATS[i].sndif);
 
 	return mask;
 }
@@ -208,7 +208,7 @@ static u64 to_alsa_formats_mask(u64 sndif_formats)
 
 	mask = 0;
 	for (i = 0; i < ARRAY_SIZE(ALSA_SNDIF_FORMATS); i++)
-		if (1 << ALSA_SNDIF_FORMATS[i].sndif & sndif_formats)
+		if (BIT_ULL(ALSA_SNDIF_FORMATS[i].sndif) & sndif_formats)
 			mask |= pcm_format_to_bits(ALSA_SNDIF_FORMATS[i].alsa);
 
 	return mask;
-- 
2.20.1

