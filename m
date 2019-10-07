Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605ECC4360C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 00:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2917B20862
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 00:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVksOn+h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfJGAjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 20:39:11 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38829 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfJGAjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 20:39:10 -0400
Received: by mail-qk1-f193.google.com with SMTP id u186so11084087qkc.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 17:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ethHIfH6l8qWDruvEXMFQVRVxb/jgRioUR76fNjnA40=;
        b=pVksOn+hvEDwW5Hob0DZvf59zzN5jo0aOyL8jYZPRDJ9DERpX3SJ+wfncSqWxSWftN
         93LfUDB0JHp0ELnAO4acJcAn1inzqLV3CUMj/iDy/rO1od8p/dk47E5NkLrXmw5pdbo6
         1tTQVDOsmJyAK7A+C05r7CvH/fJVGEYcbbpeZ8nfLlij9TqyXLbviFVhGGC5/Hf73fan
         eoltZVGeg3NlRk4MY2MxsK5iLf7ar/rST08gWG2N/RaOKJMcjrwktNHzua0/XQWphWD1
         pzErbwvtiLG+RORqgdPiufwqJMiQNQwaFRsBRqi+oZHiC2EJAtXXCijSQWkljs+udG33
         LTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ethHIfH6l8qWDruvEXMFQVRVxb/jgRioUR76fNjnA40=;
        b=XBccLY+ZWeclA4fLe7sJ0ivbR695Vb0MlbRFcZAbLYxYpiue0HKw74j6qFTeACDS8k
         EPQya+IQXNakl3sBkzD7mbgavZqbZarXosvKMcFxr5wcbGfHfvBwYqhuBAbuIJT8/GfW
         OVTrCAVluz/SYdVSZTkH+ckxJ6V67Jkats7BVb4W8ToX3vthbVZJi/PkEMLy3E/S3wkx
         TblkRVn3d/hTyjSKAOIP0QuAqonsi1tTNoaZzlvAR7+yU440cxiWCaopr/+d4xQYjBRV
         y2e14PfY7iCe55Bqpss/ROe1hbSdlnxekoXbRiaYdHURmnYzphwImXubDCc856cZaLuF
         BJVg==
X-Gm-Message-State: APjAAAWlwtyfLAwyMsEpyvReWMjr5SCIC3Ao82SkUzNsnGGMR0gUh/Zy
        cDhDcmgELIgLKxc1T+k46E4=
X-Google-Smtp-Source: APXvYqxvcTKkWgBHMUlmMV/+2+yr2zJkomqxQDVxOirKNUF/XyU1G6iFRK1RQ00k8sMrAmkBka/gWQ==
X-Received: by 2002:a37:883:: with SMTP id 125mr20634082qki.478.1570408749803;
        Sun, 06 Oct 2019 17:39:09 -0700 (PDT)
Received: from GBdebian.terracota.local ([177.103.155.130])
        by smtp.gmail.com with ESMTPSA id m63sm7110774qkc.72.2019.10.06.17.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 17:39:09 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org,
        payal.s.kshirsagar.98@gmail.com, himadri18.07@gmail.com,
        colin.king@canonical.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        trivial@kernel.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH] staging: rtl8712: align arguments with open parenthesis in file rtl8712_led.c
Date:   Sun,  6 Oct 2019 21:39:02 -0300
Message-Id: <20191007003902.21911-1-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleans up checks of "Alignment should match open parenthesis"

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
---
 drivers/staging/rtl8712/rtl8712_led.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/rtl8712_led.c b/drivers/staging/rtl8712/rtl8712_led.c
index db99129d3169..5901026949f2 100644
--- a/drivers/staging/rtl8712/rtl8712_led.c
+++ b/drivers/staging/rtl8712/rtl8712_led.c
@@ -75,7 +75,7 @@ static void BlinkWorkItemCallback(struct work_struct *work);
  *		Initialize an LED_871x object.
  */
 static void InitLed871x(struct _adapter *padapter, struct LED_871x *pLed,
-		 enum LED_PIN_871x	LedPin)
+			enum LED_PIN_871x	LedPin)
 {
 	pLed->padapter = padapter;
 	pLed->LedPin = LedPin;
-- 
2.20.1

