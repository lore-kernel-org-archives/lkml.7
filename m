Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9C7C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F154320674
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573498331;
	bh=73lA5gtCBnMbzfubTkEqfkVRumQ7E0fSm5ObyuTBBgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y2mhv3XFDLtOuklt88H6NkUm2OjoL3eO1Isd+ZZM1dp3q8m7k/dht5lh55zOzpLYa
	 A3TgCTBvAs6WsJSQWoKY8C0HY4Z4wYrjAimiKlmJuOKd4o4GMqsDI6AleMuk7aem89
	 VWkMlFmPmTJtcnO5fclWV15rAb/+Z8DiJvrxPaCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbfKKSwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:52:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:46418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729013AbfKKSwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:52:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5794721655;
        Mon, 11 Nov 2019 18:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573498326;
        bh=73lA5gtCBnMbzfubTkEqfkVRumQ7E0fSm5ObyuTBBgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rcTOo7252KGlEpfPj8H2kZUzmpFLXPS/GVKEsNtY3rzJov5khsitkOKv8fwWsci6U
         T+p6zMuPVvkETYF6j+/4ESHsTVPXCvPI9vY5qAtle3CnH4XuUJgAJFNMB9cAcjMvwf
         FSDUScOztECKETgVCtBLLBDJwYf7MbSdkkmEPJOo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.3 088/193] ALSA: usb-audio: remove some dead code
Date:   Mon, 11 Nov 2019 19:27:50 +0100
Message-Id: <20191111181507.642908795@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181459.850623879@linuxfoundation.org>
References: <20191111181459.850623879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit b39e077fcb283dd96dd251a3abeba585402c61fe upstream.

We recently cleaned up the error handling in commit 52c3e317a857 ("ALSA:
usb-audio: Unify the release of usb_mixer_elem_info objects") but
accidentally left this stray return.

Fixes: 52c3e317a857 ("ALSA: usb-audio: Unify the release of usb_mixer_elem_info objects")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/mixer.c |    1 -
 1 file changed, 1 deletion(-)

--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2651,7 +2651,6 @@ static int parse_audio_selector_unit(str
 		usb_audio_err(state->chip, "cannot malloc kcontrol\n");
 		err = -ENOMEM;
 		goto error_name;
-		return -ENOMEM;
 	}
 	kctl->private_value = (unsigned long)namelist;
 	kctl->private_free = usb_mixer_selector_elem_free;


