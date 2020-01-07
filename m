Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF923C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A022080A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578432395;
	bh=w7x2HHVjQ86zAJ3fEYgFx+ap+WObzLzXfqLF4nzZdeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1h/rkn6eDL+D21r3viTfxJAWFrIOO2klIuDy2x2r/65plV7182mNJ+yuXeeCEO0q/
	 ca2oiTI0wKgbuKZdSa4/bipnsyjOxBni62+jnBd0Lm6ajnompQu8enX3VhsdO0nx5h
	 fagBcQkdsf3EL3jV2XYB1btt207HiNqdg9JGvUDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgAGU6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 15:58:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:58320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727412AbgAGU6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 15:58:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35AC0208C4;
        Tue,  7 Jan 2020 20:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578430717;
        bh=w7x2HHVjQ86zAJ3fEYgFx+ap+WObzLzXfqLF4nzZdeM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wcGNlMzS0u8yEpYy6L2hefdMGY2iYSU/FIU4p2DEx5sKi8pNGOjNI5D4LhPeFEFtb
         ixYvHdowjdEnDhvl8e3sG23hqLDw1tzrhIcbV8kh6N5xmmhDsOEjuHK9Qhlue38+kH
         G4boimqms4ZQ7LeH9riEdlJpemUJd/QWmw/g+n58=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.4 067/191] ALSA: usb-audio: fix set_format altsetting sanity check
Date:   Tue,  7 Jan 2020 21:53:07 +0100
Message-Id: <20200107205336.576580613@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205332.984228665@linuxfoundation.org>
References: <20200107205332.984228665@linuxfoundation.org>
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
@@ -506,9 +506,9 @@ static int set_format(struct snd_usb_sub
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


