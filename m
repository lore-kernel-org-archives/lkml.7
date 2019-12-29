Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7081AC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 382CA207FD
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577641385;
	bh=0u7SZL13F09GLn1Mw2FPqrx4fwckpHR5PEXNZEThXX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dC3VClTjMxDGVVu0dbWJFtZ2KmrQOeeY9qmsQUuxmDPKb3DiKMRkkgSp05dkz28uI
	 2K7wquPx9KdmBmKjSK1lL8kXD1fOO5pHFyDd1BHtd+AvuI6vUImu2SnMW35MOcEKad
	 U2UJTDC18fD23x/MfAwJPyrz2WLmbqt3uwAkVLvc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbfL2RnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:43:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:49862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730398AbfL2RnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:43:00 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 691AF207FD;
        Sun, 29 Dec 2019 17:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641379;
        bh=0u7SZL13F09GLn1Mw2FPqrx4fwckpHR5PEXNZEThXX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wpq4mR7/AWluKuG4Q34UaNP0gifvIJUQcvo7KJ0DYuT/98Lm29uuEShxe8Jarcl5M
         LlVaQ0ZhRll+0rjSIDbDKyhpdBP+vRC3bDLbY6tgCnxn63IWx4hwAtiCaucS/2lnMR
         ynPO02JnD3dHyYLlntLZnz8ch+JUjSgEr20jgpWI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.4 041/434] ALSA: hda/ca0132 - Avoid endless loop
Date:   Sun, 29 Dec 2019 18:21:34 +0100
Message-Id: <20191229172704.764257566@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit cb04fc3b6b076f67d228a0b7d096c69ad486c09c upstream.

Introduce a timeout to dspio_clear_response_queue() so that it won't
be caught in an endless loop even if the hardware doesn't respond
properly.

Fixes: a73d511c4867 ("ALSA: hda/ca0132: Add unsol handler for DSP and jack detection")
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20191213085111.22855-3-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_ca0132.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1809,13 +1809,14 @@ struct scp_msg {
 
 static void dspio_clear_response_queue(struct hda_codec *codec)
 {
+	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
 	unsigned int dummy = 0;
-	int status = -1;
+	int status;
 
 	/* clear all from the response queue */
 	do {
 		status = dspio_read(codec, &dummy);
-	} while (status == 0);
+	} while (status == 0 && time_before(jiffies, timeout));
 }
 
 static int dspio_get_response_data(struct hda_codec *codec)


