Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32BBC432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 08:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A6E218AC
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 08:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575276989;
	bh=uxDPX9Wv9UMxaKJ4BPCyBDMxbLwdnEATm3Jevf284nA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z+1Yj3vKO5u09B0yJU7ZVyCfRfCo3stnXtle/0BodlfNRJRdRk3hdrbzMXc5geGCC
	 DZj+mqSoyuB0vyE/UoBq9xHMjV2uwWksHkNSzeK9/CE/vgcOPUw+aUbVbfOAdRILT3
	 J+rhpo0D4NnS6lOx3poPDwDP6PLtSB0rj9q/gDkY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfLBI42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 03:56:28 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38141 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfLBI42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 03:56:28 -0500
Received: by mail-lf1-f68.google.com with SMTP id r14so11019859lfm.5;
        Mon, 02 Dec 2019 00:56:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZWtVf6zhlqG1yD0jYizMqYkj60ZxzCRmOI8BvxjssGc=;
        b=Knz1xZSe1iJVHq2TCSXu1yQ3poBER6h7f0gDJfdOYBz6HiofdWdcYCDCmOG9BDEOIx
         JCWAfzvjDGORqvL6k07wF8vNbW9btIvTe58vfMcR/myFOReGOysGdWkprWUTvkIGrzva
         R5PibozIcRAgDzgvcBdMwNUuilNJhiAyJAeofxEYnee3w4kC2jwOYO7hkUvrAiLnMgEL
         tKEvy6soJH52Thjn9lSgXyne0RNU/YB71h/hdNrbCcRjhQtsRqOp78SDHzE8UcXcx7xT
         Qf41pVzVwc5Y2SrUcIyAm9jDb80MOIIUDU3C6Z8U+X12A9LrmHIQD2Q6zmiVpPcv8ZvV
         MmeQ==
X-Gm-Message-State: APjAAAUUtydqan1rLFEmAyZj2XzNb6t5+wd3ZqbSdglARI5dWNswI1Kx
        +z506u4904Z9ISevWXyFcdE3K67S
X-Google-Smtp-Source: APXvYqzREhhsAsgIzm5+gICb1rmMGnTb0RIdOXajU5DczHtNjJXi1ShKoCA4u5fHEgNMs5CaTblt0w==
X-Received: by 2002:a19:7611:: with SMTP id c17mr733011lff.86.1575276985398;
        Mon, 02 Dec 2019 00:56:25 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id c27sm4403154lfh.62.2019.12.02.00.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 00:56:24 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@xi.terra>)
        id 1ibhVL-0003K0-VP; Mon, 02 Dec 2019 09:56:27 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        syzbot+35b1c403a14f5c89eba7@syzkaller.appspotmail.com,
        stable <stable@vger.kernel.org>, Hansjoerg Lipp <hjlipp@web.de>,
        Tilman Schmidt <tilman@imap.cc>
Subject: [PATCH v2 1/3] staging: gigaset: fix general protection fault on probe
Date:   Mon,  2 Dec 2019 09:56:08 +0100
Message-Id: <20191202085610.12719-2-johan@kernel.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191202085610.12719-1-johan@kernel.org>
References: <20191202085610.12719-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a general protection fault when accessing the endpoint descriptors
which could be triggered by a malicious device due to missing sanity
checks on the number of endpoints.

Reported-by: syzbot+35b1c403a14f5c89eba7@syzkaller.appspotmail.com
Fixes: 07dc1f9f2f80 ("[PATCH] isdn4linux: Siemens Gigaset drivers - M105 USB DECT adapter")
Cc: stable <stable@vger.kernel.org>     # 2.6.17
Cc: Hansjoerg Lipp <hjlipp@web.de>
Cc: Tilman Schmidt <tilman@imap.cc>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/staging/isdn/gigaset/usb-gigaset.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/staging/isdn/gigaset/usb-gigaset.c b/drivers/staging/isdn/gigaset/usb-gigaset.c
index 1b9b43659bdf..5e393e7dde45 100644
--- a/drivers/staging/isdn/gigaset/usb-gigaset.c
+++ b/drivers/staging/isdn/gigaset/usb-gigaset.c
@@ -685,6 +685,11 @@ static int gigaset_probe(struct usb_interface *interface,
 		return -ENODEV;
 	}
 
+	if (hostif->desc.bNumEndpoints < 2) {
+		dev_err(&interface->dev, "missing endpoints\n");
+		return -ENODEV;
+	}
+
 	dev_info(&udev->dev, "%s: Device matched ... !\n", __func__);
 
 	/* allocate memory for our device state and initialize it */
-- 
2.24.0

