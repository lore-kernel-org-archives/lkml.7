Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249F9C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE42422314
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578004481;
	bh=BJfAgA/szN1AYgs2fr/TD2yZN9lPFjDUIRPYNSfyyGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zyc1hGOMjbGS8CgHVTAKh8rArqkpLrmGw33ZCwm/L6Pd+QvTw3m1qQev04doJNNeP
	 vQpwi8YjP/VWnRzkaPF5EtmlDu2ptuLjevMA6GD1Zd5DaRHbSKf9dUUov8esH7SKF5
	 G86wl//4SLS9mlIgiVXSYOeCZzx8GjD5ztqdF5AE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbgABWej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:34:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:43454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730247AbgABWei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:34:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86606222C3;
        Thu,  2 Jan 2020 22:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004478;
        bh=BJfAgA/szN1AYgs2fr/TD2yZN9lPFjDUIRPYNSfyyGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cjRWJMOKCzwu7Q8p4WWTNWV7F5uAsJr30Dsqt9QLdG1oG+Tu4I47cKR6/hfMZLGgZ
         T5B+yz6E5gUe7yByVslFkQtPVTRljr2LXYoVhmykDky8dW2eyAbb22xhlqurSyMDrp
         HcnwVCQQjHMZ4XROxNsqJFfJ2l7ctDMyY7I1not0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 003/137] ALSA: hda/ca0132 - Keep power on during processing DSP response
Date:   Thu,  2 Jan 2020 23:06:16 +0100
Message-Id: <20200102220547.060516972@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220546.618583146@linuxfoundation.org>
References: <20200102220546.618583146@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 377bc0cfabce0244632dada19060839ced4e6949 upstream.

We need to keep power on while processing the DSP response via unsol
event.  Each snd_hda_codec_read() call does the power management, so
it should work normally, but still it's safer to keep the power up for
the whole function.

Fixes: a73d511c4867 ("ALSA: hda/ca0132: Add unsol handler for DSP and jack detection")
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20191213085111.22855-2-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_ca0132.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -4424,12 +4424,14 @@ static void ca0132_process_dsp_response(
 	struct ca0132_spec *spec = codec->spec;
 
 	codec_dbg(codec, "ca0132_process_dsp_response\n");
+	snd_hda_power_up_pm(codec);
 	if (spec->wait_scp) {
 		if (dspio_get_response_data(codec) >= 0)
 			spec->wait_scp = 0;
 	}
 
 	dspio_clear_response_queue(codec);
+	snd_hda_power_down_pm(codec);
 }
 
 static void hp_callback(struct hda_codec *codec, struct hda_jack_callback *cb)


