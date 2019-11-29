Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35A4C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 10:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99738217BA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 10:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575022800;
	bh=uxDPX9Wv9UMxaKJ4BPCyBDMxbLwdnEATm3Jevf284nA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JoxE49xicTfADOlav7rQhv+NRQfUUNFyAhmTQ9duVfdeBWjvar59O3i3wc29QAfy5
	 BJHbS0NP9OFGVd1tTzCO7t3CKSfE9CPLJoJ/xLVivrVm6xgCuyF0utxoSgvCe0mwb5
	 134nwPqPjd2pQ3pYH2AsBO3pWTreFYANAyF1Os6A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfK2KT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 05:19:58 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33777 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbfK2KT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 05:19:57 -0500
Received: by mail-lj1-f193.google.com with SMTP id t5so31430703ljk.0;
        Fri, 29 Nov 2019 02:19:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZWtVf6zhlqG1yD0jYizMqYkj60ZxzCRmOI8BvxjssGc=;
        b=fhbxF4eHdeLhdS0M82YeyNiblyRFkdMZePAkVcLiaNr2ywkaFsS2NGxiswI1bY9pQp
         T/es6mcqh1QwgHBPoUSV69zWz//I4S2mzWH4L0b8KJs1rt3S+DEX2Tnjbj6iMz1GS4kx
         od+qEeb/A+laRVb0BpNBAmjIgF2LRr0aWANuANU9MX1OIPZ+VT6DY6POX3dX0F471nIr
         ZgvoTkjNUz9POiI53gcev0b1/I3crDrH8DweizYcFTzm4LxsFDNQanI5N/liJhh3MvX8
         r6n4S9GW+g7hF8MQk/1z+RwXKTYsKGY2ZCzrmrnlEytYqAjEbkWw91H1ppBM82oN2o1a
         2JSw==
X-Gm-Message-State: APjAAAV4vwqIjYTeFvY54qACBuu3Wdf/lnlssWoGUN5T+1ziQ6DLpzhE
        kEXJjqoXmhDiuYUVHPE6cTc=
X-Google-Smtp-Source: APXvYqw4g71C2eRvXHbOV45V30LoE6CF3v9D8rtC47pf6fKiAPEM8X2+iIFTkuBwPRMuxp4Ko7CFJw==
X-Received: by 2002:a2e:3313:: with SMTP id d19mr38124589ljc.240.1575022795263;
        Fri, 29 Nov 2019 02:19:55 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id s76sm4550400lje.53.2019.11.29.02.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 02:19:54 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@xi.terra>)
        id 1iadNU-0002Ya-AL; Fri, 29 Nov 2019 11:19:56 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        syzbot+35b1c403a14f5c89eba7@syzkaller.appspotmail.com,
        stable <stable@vger.kernel.org>, Hansjoerg Lipp <hjlipp@web.de>,
        Tilman Schmidt <tilman@imap.cc>
Subject: [PATCH 1/4] staging: gigaset: fix general protection fault on probe
Date:   Fri, 29 Nov 2019 11:17:50 +0100
Message-Id: <20191129101753.9721-2-johan@kernel.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191129101753.9721-1-johan@kernel.org>
References: <20191129101753.9721-1-johan@kernel.org>
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

