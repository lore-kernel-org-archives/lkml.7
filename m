Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FF9C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B206B2087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="nKku9kvZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbfD2Rpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 13:45:53 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:49968 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbfD2Rpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:45:52 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 1AEFDC79
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 17:45:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KgCm7PNxANOp for <linux-kernel@vger.kernel.org>;
        Mon, 29 Apr 2019 12:45:50 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id E7ADDAD5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 12:45:50 -0500 (CDT)
Received: by mail-io1-f72.google.com with SMTP id h10so9409391iob.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 10:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=uxPM7sWsj1FXWn2sHkMbQQ4Yr44ikQVSiMn4hllkK/A=;
        b=nKku9kvZYmb1cYpv1cXx+XLn4k2eH8QvwQNMaWpn0oyrUSy4lyBM6oz0WcZPjwVSOr
         0voqfz71u9Br9NWWJeR0sN1uRTRevnHljOHXj/yW2nO45QsEedoVnx0IgfjvUEUHHPka
         PIlI7jXIrZNpJ83x7NcJUWhYz5EfD3/Qv7TWwFaEyfp5fCtnXY3KRdkx7j67jX3Biifw
         KUIXO3V6dcD5tv5xvT/7WF2KARhdZuqJZdrxxt3V2YNY5QPwwiZCaawwP2gUDOZ5B8eJ
         N49eq3dErIAtrXnCQ5yWs85zQ1rPQhHZQwro+ICPGo4USj0oC1nVnbmkZmD4SCf1bVd/
         2epw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uxPM7sWsj1FXWn2sHkMbQQ4Yr44ikQVSiMn4hllkK/A=;
        b=OGJ64C4H2CFMcMGW3Dk5eZfY/1J/5rcVg9ORV29wgtummq7wKfKE72brENHYMm8xbO
         abtVZ+wadPHU9T65eysej5dtwXP8vPSzs7zX7vBwzTrCLdJ6LgZiMQmnVzZ007WP/m13
         xYCN0kWCshhSEykqUFAysFeK6Uiqb/flFe8N2sEureMqidgXD8LkguvhuANRpVIRU3CU
         TWz66LF0NahohK0FzfVk6U5Ejmh8l5qhT1Rio/jR7oo5HcpzY77qUAAhJmSit1xpjqyZ
         Ygv/T54OkqfGyZO77W0wxDyzFiJeZcXCeIyxvB7ZgaOHjNdcEnJsj+34H/zkVsOn8Tma
         MP0A==
X-Gm-Message-State: APjAAAX5PDE1QBaTOhzOXNm5lPgdMn+ZZ0HE6VaEybraV636vZDgOxfY
        zfdwYBqANY+PEpZfRcT9JvfTMibMjOZBuUHsKScxMMxEMoIUrHg3+XU+8MpJTZXshs+1pLg/SUB
        qTW0RgjuiOyuOrN6fxntUBQpyrN1N
X-Received: by 2002:a5e:dc44:: with SMTP id s4mr19244565iop.9.1556559950647;
        Mon, 29 Apr 2019 10:45:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy5iCLTVrOmTeqizKMaoQ1oFJNs0FGOPNBW6H+Zer8OUXBmxy+2CAoDckD1tifSqHXZdw2Rtw==
X-Received: by 2002:a5e:dc44:: with SMTP id s4mr19244548iop.9.1556559950417;
        Mon, 29 Apr 2019 10:45:50 -0700 (PDT)
Received: from cs-u-cslp16.dtc.umn.edu (cs-u-cslp16.cs.umn.edu. [128.101.106.40])
        by smtp.gmail.com with ESMTPSA id n184sm90194itc.28.2019.04.29.10.45.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Apr 2019 10:45:49 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kees Cook <keescook@chromium.org>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] ALSA: usx2y: fix a double free bug
Date:   Mon, 29 Apr 2019 12:45:40 -0500
Message-Id: <1556559941-26684-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In usX2Y_In04_init(), a new urb is firstly created through usb_alloc_urb()
and saved to 'usX2Y->In04urb'. Then, a buffer is allocated through
kmalloc() and saved to 'usX2Y->In04Buf'. If the allocation of the buffer
fails, the error code ENOMEM is returned after usb_free_urb(), which frees
the created urb. However, the urb is actually freed at card->private_free
callback, i.e., snd_usX2Y_card_private_free(). So the free operation here
leads to a double free bug.

To fix the above issue, simply remove usb_free_urb().

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 sound/usb/usx2y/usbusx2y.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/usb/usx2y/usbusx2y.c b/sound/usb/usx2y/usbusx2y.c
index da4a5a5..1f0b0100 100644
--- a/sound/usb/usx2y/usbusx2y.c
+++ b/sound/usb/usx2y/usbusx2y.c
@@ -293,10 +293,8 @@ int usX2Y_In04_init(struct usX2Ydev *usX2Y)
 	if (! (usX2Y->In04urb = usb_alloc_urb(0, GFP_KERNEL)))
 		return -ENOMEM;
 
-	if (! (usX2Y->In04Buf = kmalloc(21, GFP_KERNEL))) {
-		usb_free_urb(usX2Y->In04urb);
+	if (! (usX2Y->In04Buf = kmalloc(21, GFP_KERNEL)))
 		return -ENOMEM;
-	}
 	 
 	init_waitqueue_head(&usX2Y->In04WaitQueue);
 	usb_fill_int_urb(usX2Y->In04urb, usX2Y->dev, usb_rcvintpipe(usX2Y->dev, 0x4),
-- 
2.7.4

