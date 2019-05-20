Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A3DC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594AF20815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558354749;
	bh=QPkA6PZYomjL9QkDO+aj/i1Q25zp4DPXfd9KtfCtPK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yF1mL8tQmu2/0VggbAKUxJYEpaK6rzNQ86XYgSk7tIxxziGD7n46aybDDR+EJsVXZ
	 pH1jeeaSvZlWXYjCk5izYZ56bY8oOAxSJZAOZEIzACrqNVPOadl8oHrW8W2zH5difC
	 iDLBUKv2q1brYm5I9U9Kzpz5HMQgPdAyCqrez3kg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731629AbfETMTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:19:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730685AbfETMTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:19:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C483214AE;
        Mon, 20 May 2019 12:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558354740;
        bh=QPkA6PZYomjL9QkDO+aj/i1Q25zp4DPXfd9KtfCtPK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eZXtneuq5cNEMIOtUwiDoH22GTu0/NvvRymEWmKRFcMbc/uYNli89Z+PQ6LVtwNLJ
         xoQIke30HaqvfWtSWmekR8EoS6gUHJ3Bhwn2sm0KEgBLEO7YepsCGjouJBpjqO8Nz6
         Nhkd7H1p0D2wmuukD78OG9z5YRQPJz4xGwYmCPw0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wang6495@umn.edu>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 25/63] ALSA: usb-audio: Fix a memory leak bug
Date:   Mon, 20 May 2019 14:14:04 +0200
Message-Id: <20190520115233.859492728@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115231.137981521@linuxfoundation.org>
References: <20190520115231.137981521@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wang6495@umn.edu>

commit cb5173594d50c72b7bfa14113dfc5084b4d2f726 upstream.

In parse_audio_selector_unit(), the string array 'namelist' is allocated
through kmalloc_array(), and each string pointer in this array, i.e.,
'namelist[]', is allocated through kmalloc() in the following for loop.
Then, a control instance 'kctl' is created by invoking snd_ctl_new1(). If
an error occurs during the creation process, the string array 'namelist',
including all string pointers in the array 'namelist[]', should be freed,
before the error code ENOMEM is returned. However, the current code does
not free 'namelist[]', resulting in memory leaks.

To fix the above issue, free all string pointers 'namelist[]' in a loop.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/mixer.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2184,6 +2184,8 @@ static int parse_audio_selector_unit(str
 	kctl = snd_ctl_new1(&mixer_selectunit_ctl, cval);
 	if (! kctl) {
 		usb_audio_err(state->chip, "cannot malloc kcontrol\n");
+		for (i = 0; i < desc->bNrInPins; i++)
+			kfree(namelist[i]);
 		kfree(namelist);
 		kfree(cval);
 		return -ENOMEM;


