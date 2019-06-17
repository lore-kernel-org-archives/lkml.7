Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB0FC31E5C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A102063F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560806918;
	bh=8XSvJ2TFsgwWkkcGwIZ6kDllatsH/sIS52RzuLD3X50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pYIi72E+6b9XmqonNaABkuNhXDkHo/7KxwrdTaxhlIMF8qnK8ADDZRApO0pfH1jzE
	 HuZPt1PPFDHJMjA4e/0z4QRMerzE5ehSf3EYS2prP6RjHPCIeGgu7BoXvacgq4KpEB
	 tTpdax7UByCEys4rpnaNdsfKPN8gUCUUZLC6noxs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbfFQV2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:28:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728930AbfFQV2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:28:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5F782070B;
        Mon, 17 Jun 2019 21:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560806911;
        bh=8XSvJ2TFsgwWkkcGwIZ6kDllatsH/sIS52RzuLD3X50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gBMlIVmJkuaKk/K4X1BiRb+lYbWQF3vBrThwfk9cO7FZjvHYAUdlN2KFlu67AkMfv
         S8zKde/A+T103RPWncwFMYwBBzlPYS1ej7J41Qb3qrlEKkLdeKH+2cxJHpUuOwhBT5
         FaN5ZK+gybwP6cltKLUMcWTIXFAf2RJsrYXuwj1I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 05/53] ALSA: oxfw: allow PCM capture for Stanton SCS.1m
Date:   Mon, 17 Jun 2019 23:09:48 +0200
Message-Id: <20190617210746.182179497@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617210745.104187490@linuxfoundation.org>
References: <20190617210745.104187490@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

commit d8fa87c368f5b4096c4746894fdcc195da285df1 upstream.

Stanton SCS.1m can transfer isochronous packet with Multi Bit Linear
Audio data channels, therefore it allows software to capture PCM
substream. However, ALSA oxfw driver doesn't.

This commit changes the driver to add one PCM substream for capture
direction.

Fixes: de5126cc3c0b ("ALSA: oxfw: add stream format quirk for SCS.1 models")
Cc: <stable@vger.kernel.org> # v4.5+
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/firewire/oxfw/oxfw.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -176,9 +176,6 @@ static int detect_quirks(struct snd_oxfw
 		oxfw->midi_input_ports = 0;
 		oxfw->midi_output_ports = 0;
 
-		/* Output stream exists but no data channels are useful. */
-		oxfw->has_output = false;
-
 		return snd_oxfw_scs1x_add(oxfw);
 	}
 


