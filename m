Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24462C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD2821019
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558354759;
	bh=vlQhOCKTDbcoG8HJYqOyejbiYpKBr5+dhUL0IWXIMtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LvPT7ZtHmoqDtRMHXKRqcoKMMYF7OvgX41DylVHSf4cwY8ofpanm4B7miHUD43fS8
	 43yDB4wPrT879DUKoVClJ3KU2wB3WsigRkKSR8C3y+lGGMDJ+Dz7c3BKK6xUGquO1u
	 cPVT+6y2M9g2J9AhSOHUXXIdp+yESc6OGdcB2lqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731563AbfETMTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:19:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731278AbfETMTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:19:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 303A0208C3;
        Mon, 20 May 2019 12:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558354748;
        bh=vlQhOCKTDbcoG8HJYqOyejbiYpKBr5+dhUL0IWXIMtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SbYrtS0T5Ac+Gq1y3phQXghH7IlwE0G71h6PKdIYUKS5pvr7aNG+WO5wq2wjv8d+H
         B0Hz7Q/F0j5GW5/YYsygdw0vm8Ql1uPCv4b0GKj/PDYMUuTVCOuCImEybdCxBvWz5Q
         NqJIotWYV+ro9n4zsDdBhSZd8AkOPQ9RyuN6TZQQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 28/63] ALSA: hda/realtek - EAPD turn on later
Date:   Mon, 20 May 2019 14:14:07 +0200
Message-Id: <20190520115234.241055771@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115231.137981521@linuxfoundation.org>
References: <20190520115231.137981521@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kailang Yang <kailang@realtek.com>

commit 607ca3bd220f4022e6f5356026b19dafc363863a upstream.

Let EAPD turn on after set pin output.

[ NOTE: This change is supposed to reduce the possible click noises at
  (runtime) PM resume.  The functionality should be same (i.e. the
  verbs are executed correctly) no matter which order is, so this
  should be safe to apply for all codecs -- tiwai ]

Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -781,11 +781,10 @@ static int alc_init(struct hda_codec *co
 	if (spec->init_hook)
 		spec->init_hook(codec);
 
+	snd_hda_gen_init(codec);
 	alc_fix_pll(codec);
 	alc_auto_init_amp(codec, spec->init_amp);
 
-	snd_hda_gen_init(codec);
-
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_INIT);
 
 	return 0;


