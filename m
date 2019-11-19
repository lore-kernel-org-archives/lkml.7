Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BBCC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A48F208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141132;
	bh=r/YU+KvIf+z6ar+xyhrZTY2mGiQKU1TxAIcyDr3xEyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M/J/URtqcNCf7+cP9q60ustv/Nb81nH41AjBRyFR575bBEl/VU71HV33SXy1In9fw
	 xx9kJ/Kd4XNrWlxj06/ZUtk8PMsG0gHGFmZOo9B2M0fekCbU49+LLoCKS7reY+GUYA
	 yjIrDyKodCboEQgy2nTmK1NcT3cPTSZ9V/UDB640=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbfKSFZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:25:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:42946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727716AbfKSFZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:25:29 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 312D921783;
        Tue, 19 Nov 2019 05:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141127;
        bh=r/YU+KvIf+z6ar+xyhrZTY2mGiQKU1TxAIcyDr3xEyM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LyXSPXDb2TfGwlSoyYbbw+yuVNm9XzjllHlqAtdYknY+f1q475kKMpayP5srDyWNU
         NuIOM3Vs++d8KxurUVCQkyQqKj/0Dyb3HwiThZbmXcOfggBgZe+kmj+604n4yLKWYA
         AY5y3Ea2lcky/tf4bJ5wikvz/aYKEwS9ugXjRdeM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 013/422] ALSA: usb-audio: Fix incorrect size check for processing/extension units
Date:   Tue, 19 Nov 2019 06:13:30 +0100
Message-Id: <20191119051401.022454405@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 976a68f06b2ea49e2ab67a5f84919a8b105db8be upstream.

The recently introduced unit descriptor validation had some bug for
processing and extension units, it counts a bControlSize byte twice so
it expected a bigger size than it should have been.  This seems
resulting in a probe error on a few devices.

Fix the calculation for proper checks of PU and EU.

Fixes: 57f8770620e9 ("ALSA: usb-audio: More validations of descriptor units")
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20191114165613.7422-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/validate.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/sound/usb/validate.c
+++ b/sound/usb/validate.c
@@ -81,9 +81,9 @@ static bool validate_processing_unit(con
 	switch (v->protocol) {
 	case UAC_VERSION_1:
 	default:
-		/* bNrChannels, wChannelConfig, iChannelNames, bControlSize */
-		len += 1 + 2 + 1 + 1;
-		if (d->bLength < len) /* bControlSize */
+		/* bNrChannels, wChannelConfig, iChannelNames */
+		len += 1 + 2 + 1;
+		if (d->bLength < len + 1) /* bControlSize */
 			return false;
 		m = hdr[len];
 		len += 1 + m + 1; /* bControlSize, bmControls, iProcessing */


