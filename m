Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF5FC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99142133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558641024;
	bh=SurAlSJuIgXS5zvEQC7YB5+ieM+xlVu36sEG7hdHYBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JtOukynXGAyCHK3F8ifQBrr2GAt6yFBRhI26Piio/V5StSR0iM9zugbJIc61xsFIW
	 ivlzQGoT1625jQrFA+oUuM7S0x9T2mJ98xeeM+r9ZSwgr5P7IpIpOIA9/ojGgAENM8
	 k1FidKb8a2ZhCbO9mJ5nGnP8sErLbSOWkEdLqw/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388200AbfEWTuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:50:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:43222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387615AbfEWTJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:09:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D4922187F;
        Thu, 23 May 2019 19:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558638597;
        bh=SurAlSJuIgXS5zvEQC7YB5+ieM+xlVu36sEG7hdHYBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fyO9cCSyjpoyYpvrnb+qnIWfU6mZK4r7RAIyYbdUWVqPQ7u3wmvZKFqXmkw3bWCd8
         SdjM7xmu8LBtZBhsxJd1agLK3PnO4DyhGQFw0B3Q4RhQFbrS9QYWLM29cGr8gD/Cye
         cZWinj42GWre4NR0j8W5BOMtfpoMW6z9UQ2AORWc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yifeng Li <tomli@tomli.me>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 4.9 31/53] fbdev: sm712fb: fix VRAM detection, dont set SR70/71/74/75
Date:   Thu, 23 May 2019 21:05:55 +0200
Message-Id: <20190523181715.787822144@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181710.981455400@linuxfoundation.org>
References: <20190523181710.981455400@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yifeng Li <tomli@tomli.me>

commit dcf9070595e100942c539e229dde4770aaeaa4e9 upstream.

On a Thinkpad s30 (Pentium III / i440MX, Lynx3DM), the amount of Video
RAM is not detected correctly by the xf86-video-siliconmotion driver.
This is because sm712fb overwrites the GPR71 Scratch Pad Register, which
is set by BIOS on x86 and used to indicate amount of VRAM.

Other Scratch Pad Registers, including GPR70/74/75, don't have the same
side-effect, but overwriting to them is still questionable, as they are
not related to modesetting.

Stop writing to SR70/71/74/75 (a.k.a GPR70/71/74/75).

Signed-off-by: Yifeng Li <tomli@tomli.me>
Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>
Cc: <stable@vger.kernel.org>  # v4.4+
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/fbdev/sm712fb.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -1145,7 +1145,9 @@ static void sm7xx_set_timing(struct smtc
 		/* init SEQ register SR30 - SR75 */
 		for (i = 0; i < SIZE_SR30_SR75; i++)
 			if ((i + 0x30) != 0x30 && (i + 0x30) != 0x62 &&
-			    (i + 0x30) != 0x6a && (i + 0x30) != 0x6b)
+			    (i + 0x30) != 0x6a && (i + 0x30) != 0x6b &&
+			    (i + 0x30) != 0x70 && (i + 0x30) != 0x71 &&
+			    (i + 0x30) != 0x74 && (i + 0x30) != 0x75)
 				smtc_seqw(i + 0x30,
 					  vgamode[j].init_sr30_sr75[i]);
 


