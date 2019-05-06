Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1265DC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D71522087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557153239;
	bh=c7+759KtWeqIy6/qDK5HB8WPLHOClRZMOyll85UC/p8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dd9YdJ0au7IEaulzc94emt4POoH3sP5iV5J/n2pYUEQdU2/LzKE4eZ/tg1ODKLfPJ
	 3tVoRohjBP2ZcK038NV0WI4CipffuuKVmxdPxwndVcXWYa5CMMisc214oNudd+8XbB
	 c7cwJ8x36ZBdX+YpWCxyPsn9REkaSbHvKfOKD4vw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfEFOd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:33:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbfEFOd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:33:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31BA9204EC;
        Mon,  6 May 2019 14:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153235;
        bh=c7+759KtWeqIy6/qDK5HB8WPLHOClRZMOyll85UC/p8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ium4B5zycQlTC8hN6DCnsB+cglMB7a9ghNBZ+NG/ayuUA5jvoIyFrBRdtszm+W2im
         z4nw99eyQ3P8w5HoNFyNdj8aFhVfuPtLcBkAd+1FekA7lIP2qa5rcisHRn3P+nMLId
         A+9CDLDEGtJlkga6H70lVTRzROLgsr4hZHG5d4wU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.0 013/122] ALSA: hda/realtek - Apply the fixup for ASUS Q325UAR
Date:   Mon,  6 May 2019 16:31:11 +0200
Message-Id: <20190506143055.913264975@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143054.670334917@linuxfoundation.org>
References: <20190506143054.670334917@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 3887c26c0e24d50a4d0ce20cf4726737cee1a2fd upstream.

Some ASUS models like Q325UAR with ALC295 codec requires the same
fixup that has been applied to ALC294 codec.  Just copy the entry with
the pin matching to cover ALC295 too.

BugLink: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1784485
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7545,6 +7545,10 @@ static const struct snd_hda_pin_quirk al
 		{0x12, 0x90a60130},
 		{0x17, 0x90170110},
 		{0x21, 0x04211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1043, "ASUS", ALC294_FIXUP_ASUS_SPK,
+		{0x12, 0x90a60130},
+		{0x17, 0x90170110},
+		{0x21, 0x03211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
 		{0x14, 0x90170110},
 		{0x21, 0x04211020}),


