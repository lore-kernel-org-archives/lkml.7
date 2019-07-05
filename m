Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BA4C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3CE218A3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfGEJ5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 05:57:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39702 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbfGEJ5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 05:57:35 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hjKxk-0003b7-AS; Fri, 05 Jul 2019 09:57:04 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: cs4281: remove redundant assignment to variable val and remove a goto
Date:   Fri,  5 Jul 2019 10:57:04 +0100
Message-Id: <20190705095704.26050-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable val is being assigned with a value that is never
read and it is being updated later with a new value. The
assignment is redundant and can be removed.  Also remove a
goto statement and a label and replace with a break statement.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/pci/cs4281.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/pci/cs4281.c b/sound/pci/cs4281.c
index a2cce3ecda6f..04c712647853 100644
--- a/sound/pci/cs4281.c
+++ b/sound/pci/cs4281.c
@@ -694,7 +694,7 @@ static int snd_cs4281_trigger(struct snd_pcm_substream *substream, int cmd)
 
 static unsigned int snd_cs4281_rate(unsigned int rate, unsigned int *real_rate)
 {
-	unsigned int val = ~0;
+	unsigned int val;
 	
 	if (real_rate)
 		*real_rate = rate;
@@ -707,9 +707,8 @@ static unsigned int snd_cs4281_rate(unsigned int rate, unsigned int *real_rate)
 	case 44100:	return 1;
 	case 48000:	return 0;
 	default:
-		goto __variable;
+		break;
 	}
-      __variable:
 	val = 1536000 / rate;
 	if (real_rate)
 		*real_rate = 1536000 / val;
-- 
2.20.1

