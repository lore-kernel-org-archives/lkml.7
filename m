Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448A6C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1524B208C4
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578431240;
	bh=VctaP92xKyakZMANjrVFe+tcl8tJdI7QuXUjX3uaBjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bk0f6KXyqY02YGrG04wIf2ZP5l12zOf8jS2JeDJ6tIG5I+KsxebDwG439VTCq6E2g
	 vGRnNnSinH9auMYvCxQMRDr6xtfPfcBeBT7MxUT7kBlVxHqqvUfoGYZ0f2xo2OdM1o
	 /0cMxobODZZxspzFCcyI6tvHaSDlvbWAFv3NPBRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbgAGVHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:07:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:57596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729359AbgAGVHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:07:14 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C8982087F;
        Tue,  7 Jan 2020 21:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431233;
        bh=VctaP92xKyakZMANjrVFe+tcl8tJdI7QuXUjX3uaBjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iEk+H5h2Nt6wxve6k6FggOTWTArvd7r2UA1e8ubXjyGeJh+P7M1GzT8vbPr0Dk+gn
         0ouujWRiwZfB84oroabx0JCW//iBYJuDNtsZtLl8brzcms2xcFEKN6tiK/k8BbTrxX
         mgOlNWXa/sy4z+CRHxN6W9adnW5i/VICTTLtHiP8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 043/115] ALSA: usb-audio: fix set_format altsetting sanity check
Date:   Tue,  7 Jan 2020 21:54:13 +0100
Message-Id: <20200107205301.964001719@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205240.283674026@linuxfoundation.org>
References: <20200107205240.283674026@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 0141254b0a74b37aa7eb13d42a56adba84d51c73 upstream.

Make sure to check the return value of usb_altnum_to_altsetting() to
avoid dereferencing a NULL pointer when the requested alternate settings
is missing.

The format altsetting number may come from a quirk table and there does
not seem to be any other validation of it (the corresponding index is
checked however).

Fixes: b099b9693d23 ("ALSA: usb-audio: Avoid superfluous usb_set_interface() calls")
Cc: stable <stable@vger.kernel.org>     # 4.18
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20191220093134.1248-1-johan@kernel.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/pcm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -513,9 +513,9 @@ static int set_format(struct snd_usb_sub
 	if (WARN_ON(!iface))
 		return -EINVAL;
 	alts = usb_altnum_to_altsetting(iface, fmt->altsetting);
-	altsd = get_iface_desc(alts);
-	if (WARN_ON(altsd->bAlternateSetting != fmt->altsetting))
+	if (WARN_ON(!alts))
 		return -EINVAL;
+	altsd = get_iface_desc(alts);
 
 	if (fmt == subs->cur_audiofmt)
 		return 0;


