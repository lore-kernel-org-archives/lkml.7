Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB9BC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 14:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F311821835
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 14:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569765853;
	bh=6lhaPGgHzhf5iFA4NeDhhzK/tiPUcaiJONIzVETFzTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q5PU7C7cZaah0P1aIERbWA0EVQFNQ7j2SIN0/XQJUpDnP51Qcu0Qj7BT+PRglB6q3
	 AaGsgJbPZNub76Gu6TWolzfvCs9w/5Tn2/ChjX5hpi/8HQCPV7TxI8MqXD96HNkw0c
	 na+4a2R0WffBPB3UzYA/aTPsYJOxfDDebaVhYxzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbfI2OEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 10:04:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730442AbfI2OEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 10:04:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DBD22082F;
        Sun, 29 Sep 2019 14:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569765848;
        bh=6lhaPGgHzhf5iFA4NeDhhzK/tiPUcaiJONIzVETFzTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xweGs+vTv3jRqcyXMuHnJD0VtES93SIulJxeSz35ri9CHvfpP8dqt4tk4bcdd+kxd
         zPr9KEVn8gvqYiOILyKWPilvDkSft6prgaBhRC5UGjg4sy0cn5pjuM8w/8Vzb/Po20
         694FGd9kUZC+NoMpCtHWKv0YlsQXp5jY7zkTkfZ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Dennis Padiernos <depadiernos@gmail.com>
Subject: [PATCH 5.3 23/25] ALSA: hda - Apply AMD controller workaround for Raven platform
Date:   Sun, 29 Sep 2019 15:56:26 +0200
Message-Id: <20190929135017.786349926@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190929135006.127269625@linuxfoundation.org>
References: <20190929135006.127269625@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit d2c63b7dfd06788a466d5ec8a850491f084c5fc2 upstream.

It's reported that the garbled sound on HP Envy x360 13z-ag000 (Ryzen
Laptop) is fixed by the same workaround applied to other AMD chips.
Update the driver_data entry for Raven (1022:15e3) to use the newly
introduced preset, AZX_DCAPS_PRESET_AMD_SB.  Since it already contains
AZX_DCAPS_PM_RUNTIME, we can drop that bit, too.

Reported-and-tested-by: Dennis Padiernos <depadiernos@gmail.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20190920073040.31764-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/hda_intel.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2517,8 +2517,7 @@ static const struct pci_device_id azx_id
 			 AZX_DCAPS_PM_RUNTIME },
 	/* AMD Raven */
 	{ PCI_DEVICE(0x1022, 0x15e3),
-	  .driver_data = AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_ATI_SB |
-			 AZX_DCAPS_PM_RUNTIME },
+	  .driver_data = AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_AMD_SB },
 	/* ATI HDMI */
 	{ PCI_DEVICE(0x1002, 0x0002),
 	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },


