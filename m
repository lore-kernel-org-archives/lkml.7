Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC344C17445
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A19214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573497812;
	bh=wvUzQEadWN/VgQ5ZZU2lNYzDF824oKCzfHjNlPBhoqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ktpe9zQf8kHnPcRF9cR8D3mKgw7NjaA3Y/D9Hb9SzOlzYrQYfHqWKeH5LWdAZKGcj
	 ZV6k163s/A5ZmVgxRqxqHV5vgS2UfiWlCwGQBsbTTqBKY3v0taExTj5CSYsLl5d9W+
	 XfvLwoUfzqT4dx7LdMNksTx/4Xph3Ksu4vNcrWDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbfKKSnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:43:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:34796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729082AbfKKSn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:43:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56B49214E0;
        Mon, 11 Nov 2019 18:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497807;
        bh=wvUzQEadWN/VgQ5ZZU2lNYzDF824oKCzfHjNlPBhoqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JRkrNxg/fOLxpYJYVr7jrpP0E1fvsvQAdxnYVV+g5Au+BKV57MJBHIo/8aT7HmIgj
         9fAtK0f+lHCzOHGuuRKktVni93RbPXHfBxuu+f/5FPJKMR1JeC2XHA3ErUWtWKFGf0
         NI82tN6rm0A6qtBTQN13P8X70iFdMKqhL4rOIYrw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 063/125] ALSA: usb-audio: remove some dead code
Date:   Mon, 11 Nov 2019 19:28:22 +0100
Message-Id: <20191111181448.702698852@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181438.945353076@linuxfoundation.org>
References: <20191111181438.945353076@linuxfoundation.org>
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
@@ -2670,7 +2670,6 @@ static int parse_audio_selector_unit(str
 		usb_audio_err(state->chip, "cannot malloc kcontrol\n");
 		err = -ENOMEM;
 		goto error_name;
-		return -ENOMEM;
 	}
 	kctl->private_value = (unsigned long)namelist;
 	kctl->private_free = usb_mixer_selector_elem_free;


