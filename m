Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698F5C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F282067D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564740100;
	bh=usO32lga3/Anl6L+2SlDM4azY5A8nQ7+o79TH4GpfE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xP6SJawc9qmHiU8tqfwVB/tjdGdsu85KmuDSRw8B3Vq4p3LKaohSG6e0iBY49kMgP
	 fh84eELLvtJo2E4f3KbnOmmbYutyXPKxQJCozFaS+TvymkuNntHNBiWl2DxW7R1NBa
	 cxTxBkxMoiO0WZn7TuQGAy7pz7KJ0SXwhsBvOBYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406745AbfHBKBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 06:01:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:47280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405169AbfHBJoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:44:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31D422086A;
        Fri,  2 Aug 2019 09:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564739044;
        bh=usO32lga3/Anl6L+2SlDM4azY5A8nQ7+o79TH4GpfE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r0UpXsngGOZmJZ8JhBGTQcv5SrdM2wMBZ7u4crVumS8bT3UmV/PjWAAqmAlNhUIyF
         UPUZDzrckhefKHGZojySj4bqAGvx78A87zbZVsArxB5Y+qQ+k7UJprM2Fgn+qVOQ3u
         4NqS3p5OnAQ9ick1tJBdCX4h1y7fOgk6fTsXLU6M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hui Wang <hui.wang@canonical.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 091/223] ALSA: hda/realtek: apply ALC891 headset fixup to one Dell machine
Date:   Fri,  2 Aug 2019 11:35:16 +0200
Message-Id: <20190802092245.010878786@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092238.692035242@linuxfoundation.org>
References: <20190802092238.692035242@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hui Wang <hui.wang@canonical.com>

commit 4b4e0e32e4b09274dbc9d173016c1a026f44608c upstream.

Without this patch, the headset-mic and headphone-mic don't work.

Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7272,6 +7272,11 @@ static const struct snd_hda_pin_quirk al
 		{0x18, 0x01a19030},
 		{0x1a, 0x01813040},
 		{0x21, 0x01014020}),
+	SND_HDA_PIN_QUIRK(0x10ec0867, 0x1028, "Dell", ALC891_FIXUP_DELL_MIC_NO_PRESENCE,
+		{0x16, 0x01813030},
+		{0x17, 0x02211010},
+		{0x18, 0x01a19040},
+		{0x21, 0x01014020}),
 	SND_HDA_PIN_QUIRK(0x10ec0662, 0x1028, "Dell", ALC662_FIXUP_DELL_MIC_NO_PRESENCE,
 		{0x14, 0x01014010},
 		{0x18, 0x01a19020},


