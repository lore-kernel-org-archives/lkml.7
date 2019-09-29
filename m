Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A661C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 14:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E7652082F
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 14:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569765842;
	bh=8mUkfEiTqKmgwVqD+qnKg2d6guLUvZJrqrSYKLHENp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HATewflC+9zPFwJXrejfZua9CJGqvHXZtJ9o1ucS8rG6tCJr7u8444MOoI6z3FzYD
	 GuPra0S6y3wmZA3jpOP87mQxpBdXhEOi1NczEf6WjzdwJCDENTCaFhbE8C7YNhPYmQ
	 kkSD9+Ulciw9h7l1zJzzu5uWmijuR+RtpzANlKJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbfI2OEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 10:04:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730414AbfI2OD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 10:03:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEFC92086A;
        Sun, 29 Sep 2019 14:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569765836;
        bh=8mUkfEiTqKmgwVqD+qnKg2d6guLUvZJrqrSYKLHENp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SXwAWPf5rZo/sNiSArO0DZydVtShxWV284O7z7oRiDiGGnzEcqWv5dOn9gx3gnmVx
         mk9Y89WuucTwRS1aP59sm3t3g+2KaYZC0BM68SmoD0xdX8ZIAkLYvO/VrEdf7lN7cd
         f5bNKpZeMS/kt0bHKM5WjgqfDX0JULLOmbuvT3Ck=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jussi Laako <jussi@sonarnerd.net>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.3 20/25] ALSA: usb-audio: Add DSD support for EVGA NU Audio
Date:   Sun, 29 Sep 2019 15:56:23 +0200
Message-Id: <20190929135016.791758521@linuxfoundation.org>
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

From: Jussi Laako <jussi@sonarnerd.net>

commit f41f900568d9ffd896cc941db7021eb14bd55910 upstream.

EVGA NU Audio is actually a USB audio device on a PCIexpress card,
with it's own USB controller. It supports both PCM and DSD.

Signed-off-by: Jussi Laako <jussi@sonarnerd.net>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20190924071143.30911-1-jussi@sonarnerd.net
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/quirks.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1655,6 +1655,7 @@ u64 snd_usb_interface_dsd_format_quirks(
 	case 0x152a:  /* Thesycon devices */
 	case 0x25ce:  /* Mytek devices */
 	case 0x2ab6:  /* T+A devices */
+	case 0x3842:  /* EVGA */
 	case 0xc502:  /* HiBy devices */
 		if (fp->dsd_raw)
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;


