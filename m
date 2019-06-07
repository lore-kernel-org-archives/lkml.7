Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D29BC468BD
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D253E20657
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559922516;
	bh=RZ1AvFzI4GQ8mOZ69NkGtWsCd1txB7QpKcOCG6wxQeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MSMNjS3eUnriUFi/JmaIJ4UdfK/Aw5nF/BcgkBroo4swSgjaXVziOML2jbOjlPCLc
	 8SXXFX/h1UTRkWg2LOh8OSK4P8ewVLJo+uqR2S94jPVTmhUMaATmd0+9rDPzKZrQDB
	 FPbRkYWxT6RiuL7JnsA8nM3s7ufUI6+V8QxVcBkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731814AbfFGPsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:48:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:33894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731796AbfFGPsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:48:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 429F120657;
        Fri,  7 Jun 2019 15:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559922511;
        bh=RZ1AvFzI4GQ8mOZ69NkGtWsCd1txB7QpKcOCG6wxQeA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kXRKPMNPQCzgOj36erbTOlNz1Ekv+TFtsYKvS7G1F1KcphlY/fTcNPnlFfB4rJya+
         yoh2kv7GxLjZWSaS3Cad3DFD1QxTB6DScW1Dy/zyeAwb6r0u+MM80I4DIQG+0jnley
         tk/vDwA4XOZ/QvkcIJIq2eoddMbgSeZ9zrCC5lbU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.1 40/85] ALSA: hda/realtek - Set default power save node to 0
Date:   Fri,  7 Jun 2019 17:39:25 +0200
Message-Id: <20190607153854.168089398@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607153849.101321647@linuxfoundation.org>
References: <20190607153849.101321647@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kailang Yang <kailang@realtek.com>

commit 317d9313925cd8388304286c0d3c8dda7f060a2d upstream.

I measured power consumption between power_save_node=1 and power_save_node=0.
It's almost the same.
Codec will enter to runtime suspend and suspend.
That pin also will enter to D3. Don't need to enter to D3 by single pin.
So, Disable power_save_node as default. It will avoid more issues.
Windows Driver also has not this option at runtime PM.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7654,7 +7654,7 @@ static int patch_alc269(struct hda_codec
 
 	spec = codec->spec;
 	spec->gen.shared_mic_vref_pin = 0x18;
-	codec->power_save_node = 1;
+	codec->power_save_node = 0;
 
 #ifdef CONFIG_PM
 	codec->patch_ops.suspend = alc269_suspend;


