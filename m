Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0F8C4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 02:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781AE2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 02:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ox6x7+78"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbfI3CmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 22:42:05 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42981 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728755AbfI3CmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 22:42:05 -0400
Received: by mail-io1-f67.google.com with SMTP id n197so34128349iod.9;
        Sun, 29 Sep 2019 19:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=T3DOkj/b43Ad7U2iMhu7YlXk6yi1/vVYB43MKzW696Q=;
        b=ox6x7+78ah0fGD2D6DWr7GwQ8hOT4WAm/8p+Gdr2nSDmoNQB0VIzHadX3BskPMq7MZ
         QAHeD8MbTDRo8vUkebft19RV4pmrJqpIJWXO9vGWyIDWBYAazhd5TXDqDYTi7IWhKiQt
         /acMTBNVC6tttuWaTTPgGGjEP1EHpgFpMQRE7XsP9Y+I6XPKCOI0EWhF4WnswlfF8b6D
         DOUVy1vHRxxiNcMqxchCh6DHDR0RPbjYtw/1Of0/54pEYtCrwsrjbv8mDHc/shxt7N1Q
         3+/KStziKNZ3eGr3Sn6teNXpMUX7hKiT/GACxCcQnW/AQPx0gLrGFAOsx0K8h7vQSTpW
         fc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T3DOkj/b43Ad7U2iMhu7YlXk6yi1/vVYB43MKzW696Q=;
        b=jCk7kJ0DzaZYilYlx0cFNFvHOqEKSsgbL8cAry+uH2H01d6AKeQoPUKloK4054ktu5
         CJd7+g6Ey9dfq3WqWuTtjC4yrfcgtNRmCGvoYEqFbVlJQRyGhBCrkFCCp37F5JhqKVgT
         iOkMznptlQT63akbOZ8ZQCdzf3reuaebT0d6cgz5sv8fa5kIwjpnkuVapU14LO1rfAvO
         IdM5iEfHecWmMDbI4GPGk+w/SQ57foZ6fvsx5UN0fdu9H9mguIJ74BYnXNiFux+dUW5p
         u0/65WYKLgo9/lbeNf3JSUafrPNfJaoHNoyPxALX3eMREysJLhFa4zY4joiPETlpVFra
         3TRg==
X-Gm-Message-State: APjAAAVgZP13nMKf0TUAbXdVsngOKvxsxMSOdN7oo38TxEOrP8LAd83v
        pzljueh1ifB5Rqhvm9+3Lfo=
X-Google-Smtp-Source: APXvYqx9cHyQeiLxjY2CRe35d+auWhnvAdAotiIBYwi7gKehJ5OXoJ6+HDxi/DsEC48VxHVpJGwDOg==
X-Received: by 2002:a6b:148a:: with SMTP id 132mr19112959iou.55.1569811324369;
        Sun, 29 Sep 2019 19:42:04 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id k7sm5197565iob.80.2019.09.29.19.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 19:42:03 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc3: pci: prevent memory leak in dwc3_pci_probe
Date:   Sun, 29 Sep 2019 21:41:45 -0500
Message-Id: <20190930024147.25243-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In dwc3_pci_probe a call to platform_device_alloc allocates a device
which is correctly put in case of error except one case: when the call to
platform_device_add_properties fails it directly returns instead of
going to error handling. This commit replaces return with the goto.

Fixes: 1a7b12f69a94 ("usb: dwc3: pci: Supply device properties via driver data")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/usb/dwc3/dwc3-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 5e8e18222f92..023f0357efd7 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -258,7 +258,7 @@ static int dwc3_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
 
 	ret = platform_device_add_properties(dwc->dwc3, p);
 	if (ret < 0)
-		return ret;
+		goto err;
 
 	ret = dwc3_pci_quirks(dwc);
 	if (ret)
-- 
2.17.1

