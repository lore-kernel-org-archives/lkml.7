Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77B7C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 14:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B940E21906
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 14:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569765720;
	bh=8mUkfEiTqKmgwVqD+qnKg2d6guLUvZJrqrSYKLHENp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RaBPXsbWcc6f1FqGDwKFecPKWzwE0NJZrTsgzi0sFcRAYDPSQKdxDILSZMw+2FAhl
	 630DItYj3WjZE2zPB5vCH+x5JUPderJVSKX5Ck/hacsouPgMNRZxqeJiojCkPrJeFI
	 yF4f2sl6yxjDA1mNxw+aU+NaAkzKUMXCH4DtCemY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbfI2OB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 10:01:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:44330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730109AbfI2OBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 10:01:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30F9021835;
        Sun, 29 Sep 2019 14:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569765715;
        bh=8mUkfEiTqKmgwVqD+qnKg2d6guLUvZJrqrSYKLHENp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aJXDOu4NWNxS5rPu5jWgUARhVuKh4IpLvJb2SV5JkdRrqQheIdSWoeu/b8pCEqwwk
         Z0UGlk5QE2hUQK3S1fe+mw4xcajL2aRVqUYNP3pnkte/vTPxq/AcLKhF62erLs23aM
         nvgGeruBSAqibTmg4LLk3PFyBZ0gF82o6w66iwbA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jussi Laako <jussi@sonarnerd.net>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.2 24/45] ALSA: usb-audio: Add DSD support for EVGA NU Audio
Date:   Sun, 29 Sep 2019 15:55:52 +0200
Message-Id: <20190929135031.156149038@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190929135024.387033930@linuxfoundation.org>
References: <20190929135024.387033930@linuxfoundation.org>
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


