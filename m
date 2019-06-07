Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF1BC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0C12133D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559922202;
	bh=/OXER1Ejj6On/IPyGWXD/d4+RU7b36OA0PhjKQsOZ3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rQ7c0XXDGNw6i8y37rCjWnA+9xzKsT0+W5L8BTU4Mybmx8sKjt2My1kWT2m6+1goo
	 vjJpoKB2paiq82ti/j3p6Wyf+tqqq182rYu6O0cRlGjjRsZ2bjf8tyZp/Ba6/HN1yW
	 losiJcFCcIxF7OSs9TJGY2imqYN/+5vvMSheiH9k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730846AbfFGPnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:43:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:54414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730828AbfFGPnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:43:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C5502133D;
        Fri,  7 Jun 2019 15:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559922198;
        bh=/OXER1Ejj6On/IPyGWXD/d4+RU7b36OA0PhjKQsOZ3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IFj44j642rKHBCy1aqWbvJG7FcIglOMJ01B1ANSVXTBlPxfIxf/wREZBkFc3zZ2uc
         gxhLmKbgEp/QfK1hk7DjlzwtWV1uasjRXQU08R/4FrWpg1j0eQm2dz7cSmVbTOkT74
         eBoDM4XFbq3PGl0G2H53d/UWkZUvA19jf/dYTwAo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 45/69] ALSA: hda/realtek - Set default power save node to 0
Date:   Fri,  7 Jun 2019 17:39:26 +0200
Message-Id: <20190607153853.952274138@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607153848.271562617@linuxfoundation.org>
References: <20190607153848.271562617@linuxfoundation.org>
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
@@ -7078,7 +7078,7 @@ static int patch_alc269(struct hda_codec
 
 	spec = codec->spec;
 	spec->gen.shared_mic_vref_pin = 0x18;
-	codec->power_save_node = 1;
+	codec->power_save_node = 0;
 
 #ifdef CONFIG_PM
 	codec->patch_ops.suspend = alc269_suspend;


