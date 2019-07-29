Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCAEC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E12621773
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564429130;
	bh=RB9hIpH/8Qdkva/l9o2yes0mx8YaAiHanj/V/Q1RVWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c4KUNWfCF4D/+W9pP5ngCmF8d+IEfoHf8xnJParM39QnipTH+PutiHsGXpbputjtj
	 jW6ISfPg+mHe+Ah7x1TQiLPOqv7w6dxI+G/1VbvRtTHA1OEpTJCz7B97tVjIZ+Pmop
	 H6vBPqGj3nL3/0IRJ9o5oHhoUQ3hzLmvXTki5EuQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388616AbfG2Tis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:38:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388889AbfG2Tij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:38:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DAAD206DD;
        Mon, 29 Jul 2019 19:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429119;
        bh=RB9hIpH/8Qdkva/l9o2yes0mx8YaAiHanj/V/Q1RVWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UjSpSEGwHMdiW6CjYnlYF+w5U2rlH9xsHYLEJfk/h/nN2TwDO55rKm7ys3O8ect6y
         Z+qdhC5ewN2Gqr7+Bbl2uAO53J2OhhRCJYGSDNLFWGwcRTS2tTy2RuqrgQ/Xgqmu6I
         +kqKgLt/wu4s1CCoRY5ARweG5EQDSKiA61S6Ij9Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hui Wang <hui.wang@canonical.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 290/293] ALSA: hda - Add a conexant codec entry to let mute led work
Date:   Mon, 29 Jul 2019 21:23:01 +0200
Message-Id: <20190729190846.459586057@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hui Wang <hui.wang@canonical.com>

commit 3f8809499bf02ef7874254c5e23fc764a47a21a0 upstream.

This conexant codec isn't in the supported codec list yet, the hda
generic driver can drive this codec well, but on a Lenovo machine
with mute/mic-mute leds, we need to apply CXT_FIXUP_THINKPAD_ACPI
to make the leds work. After adding this codec to the list, the
driver patch_conexant.c will apply THINKPAD_ACPI to this machine.

Cc: stable@vger.kernel.org
Signed-off-by: Hui Wang <hui.wang@canonical.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_conexant.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -1127,6 +1127,7 @@ static int patch_conexant_auto(struct hd
  */
 
 static const struct hda_device_id snd_hda_id_conexant[] = {
+	HDA_CODEC_ENTRY(0x14f11f86, "CX8070", patch_conexant_auto),
 	HDA_CODEC_ENTRY(0x14f12008, "CX8200", patch_conexant_auto),
 	HDA_CODEC_ENTRY(0x14f15045, "CX20549 (Venice)", patch_conexant_auto),
 	HDA_CODEC_ENTRY(0x14f15047, "CX20551 (Waikiki)", patch_conexant_auto),


