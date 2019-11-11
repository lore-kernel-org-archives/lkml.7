Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD03C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA4F21783
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573497239;
	bh=O8JqrFNL5fiRfUfBZHt8d/7Bp/awQ18JHCgSuhlLIGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kLsrPyoVwmRWRgC7KZaxOuNtuz0lHNhCDxtsgd6GGTjFUtIRjMpFYuat8K2slMnBO
	 ld7opOtcGbwfCGO3UiVMTmqnqjLMg9cWFaLQ2OMRPUeLmhtR69JavtFybicOPE5ATy
	 5QdszyOgdQnSjSk+6TO4nJ+hgUIjkscEgwg8BToY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfKKSd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:33:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:51382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728229AbfKKSdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:33:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 789A821783;
        Mon, 11 Nov 2019 18:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497234;
        bh=O8JqrFNL5fiRfUfBZHt8d/7Bp/awQ18JHCgSuhlLIGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2dFJP9a22FQ6OqdD+Gffc5LKriyARm+6U+Le6Sap0q2wzg9P2tI9csP2HtfVeNJdi
         BxmlzRG3GWqWKzqXnIk3FXFXBU7pa6Z8hPmaUEsahJvobEQyDoQBgwUDIyGgSkPSIt
         FmSvPPcsSfAB4u83a56MUt90P6RQ5UAeTVM8Hh4I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 11/65] ALSA: hda/ca0132 - Fix possible workqueue stall
Date:   Mon, 11 Nov 2019 19:28:11 +0100
Message-Id: <20191111181342.533517089@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181331.917659011@linuxfoundation.org>
References: <20191111181331.917659011@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 15c2b3cc09a31620914955cb2a89c277c18ee999 upstream.

The unsolicited event handler for the headphone jack on CA0132 codec
driver tries to reschedule the another delayed work with
cancel_delayed_work_sync().  It's no good idea, unfortunately,
especially after we changed the work queue to the standard global
one; this may lead to a stall because both works are using the same
global queue.

Fix it by dropping the _sync but does call cancel_delayed_work()
instead.

Fixes: 993884f6a26c ("ALSA: hda/ca0132 - Delay HP amp turnon.")
BugLink: https://bugzilla.suse.com/show_bug.cgi?id=1155836
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20191105134316.19294-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_ca0132.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -4440,7 +4440,7 @@ static void hp_callback(struct hda_codec
 	/* Delay enabling the HP amp, to let the mic-detection
 	 * state machine run.
 	 */
-	cancel_delayed_work_sync(&spec->unsol_hp_work);
+	cancel_delayed_work(&spec->unsol_hp_work);
 	schedule_delayed_work(&spec->unsol_hp_work, msecs_to_jiffies(500));
 	tbl = snd_hda_jack_tbl_get(codec, cb->nid);
 	if (tbl)


