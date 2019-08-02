Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDABC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9EAF2087C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564738587;
	bh=G3LIdM7huOVEvGwJqEUqL992Y1NUwk3bmv6meesTlEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZDINyJmCE53XpMdxwAeFbPrUSwYEBEPvRVyZAqyJrmKstm/Rn92nuRJhkAG4SlS+m
	 BKpiVtMDyxIUhK4TM3Oi8jkzokFXrqgPZA1zlnBxFuFBAT4IhmPqfXWULyRpP7SjFR
	 dunZWL8I570cBuoEWMhXCl4eS/BelxjJciXdazfo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404172AbfHBJg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:36:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404186AbfHBJgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:36:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 523AF217D7;
        Fri,  2 Aug 2019 09:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564738580;
        bh=G3LIdM7huOVEvGwJqEUqL992Y1NUwk3bmv6meesTlEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H0P2/ScFRoxFw97/JZ2dK8OmSRC2wTX9eqqQ1o8tXo62kIxA+jOqLpf/yxYu9hQlH
         r3mjAuSBig35D+Ls3lGgxpDBohDse7vvM1DPRij8di0u8G3jzQstUm3BK61Yp1gOsk
         3AG9e+7bjupTxmhDP4sLTiGRfW26l3rNljeDUtuI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hui Wang <hui.wang@canonical.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 145/158] ALSA: hda - Add a conexant codec entry to let mute led work
Date:   Fri,  2 Aug 2019 11:29:26 +0200
Message-Id: <20190802092232.035930881@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092203.671944552@linuxfoundation.org>
References: <20190802092203.671944552@linuxfoundation.org>
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
@@ -1008,6 +1008,7 @@ static int patch_conexant_auto(struct hd
  */
 
 static const struct hda_device_id snd_hda_id_conexant[] = {
+	HDA_CODEC_ENTRY(0x14f11f86, "CX8070", patch_conexant_auto),
 	HDA_CODEC_ENTRY(0x14f12008, "CX8200", patch_conexant_auto),
 	HDA_CODEC_ENTRY(0x14f15045, "CX20549 (Venice)", patch_conexant_auto),
 	HDA_CODEC_ENTRY(0x14f15047, "CX20551 (Waikiki)", patch_conexant_auto),


