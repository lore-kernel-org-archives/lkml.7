Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F645C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1CD2081B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViRTZkFl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfCISbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 13:31:20 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39936 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfCISbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 13:31:18 -0500
Received: by mail-qk1-f193.google.com with SMTP id h28so501420qkk.7
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2019 10:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IMAu91qSbO5pqsc2P0qgKzuEr0mwPpr6Sw3sn896eEg=;
        b=ViRTZkFlmFNHmki6m/ZqZOwNDRChh6LQxCrzkLGsgD8d6PcmgLA8c03T2prqYzxSqb
         6cgWJi/JVleOECNC/tR+pAiOsBD/Puu4mAx2Kv8BnVteQzUTyVmvSnGOYR6HOgxn9hoJ
         y6Qso9XN6bo0fz24IswqhhYWa0A+4wLUz4BhtL5NgvFchannDGjmIgLZ1hutbOmzisSr
         ojqxNH9OzJ8G/3D57B6TJ4F1Tbrx0PH9Mlw/Y+lah37MErinIkm0khUI4apTARbYmkXS
         jBjbKDc8fUzkGwOqy77aXXKaHe2X5md0mdcB9l+KwuafkUGjqwsNb7vDuNQz75cpRklz
         sFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IMAu91qSbO5pqsc2P0qgKzuEr0mwPpr6Sw3sn896eEg=;
        b=lKBdg1ySqkNp6snqwJXRfCmHIS4H+olCL64AQybIbgR5gBt++FUJDw41Bmc8UpNRYd
         gUk0ZS57oGDNtcpHogaXGf1wV0XDAD3kD6S9fAJkQ6SMIC02ZCmmLd5ghOiFBlrJdlTI
         QZP4F3VqfqsWram3IBzayZaKW981BDQXi4mTvun51/wOiTXX31yBtm8XZJAIMfBoeoNM
         ia6AYBn+c14Dj2f9jXehTRumU5qPYh5kfBOiRGAqy4Or5q6+ZDHfjSao/YtSytllXJIz
         nyQ9DI8Eeh+qlmQt8GIpzecaWGikKxf8dGZ0rnfXfNJkF2R1dNB7Qfy+Kr9T91LyDbBu
         pSGw==
X-Gm-Message-State: APjAAAVYXZFNib1+VfZ1OE49fd6DqGIvZGSQ+ZPsCUoqcJl57PLBPkUZ
        2JjH/+q2ZNorvyq5ciIXcy8=
X-Google-Smtp-Source: APXvYqz/Ezd9URUh89YoPoTLhfjbKvH2w8BeaqzLhf6Ytef+gMrprqXH6viuB0Ude6vHzuzN3C5xZw==
X-Received: by 2002:a37:6fc2:: with SMTP id k185mr15119265qkc.175.1552156277384;
        Sat, 09 Mar 2019 10:31:17 -0800 (PST)
Received: from localhost.localdomain ([191.8.88.159])
        by smtp.gmail.com with ESMTPSA id f8sm558824qkl.11.2019.03.09.10.31.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Mar 2019 10:31:17 -0800 (PST)
From:   Guilherme Tadashi Maeoka <gui.maeoka@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Guilherme Tadashi Maeoka <gui.maeoka@gmail.com>
Subject: [PATCH 3/5] Staging: rtl8723bs: os_dep: Fix else to follow close brace
Date:   Sat,  9 Mar 2019 15:30:45 -0300
Message-Id: <20190309183047.10781-4-gui.maeoka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190309183047.10781-1-gui.maeoka@gmail.com>
References: <20190309183047.10781-1-gui.maeoka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix else not following close brace '}'.

Signed-off-by: Guilherme Tadashi Maeoka <gui.maeoka@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/osdep_service.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/osdep_service.c b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
index 5a58e1d40f7e..65921b946ff7 100644
--- a/drivers/staging/rtl8723bs/os_dep/osdep_service.c
+++ b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
@@ -81,8 +81,7 @@ static int openFile(struct file **fpp, char *path, int flag, int mode)
 	if (IS_ERR(fp)) {
 		*fpp = NULL;
 		return PTR_ERR(fp);
-	}
-	else {
+	} else {
 		*fpp = fp;
 		return 0;
 	}
@@ -135,8 +134,7 @@ static int isFileReadable(char *path)
 	fp = filp_open(path, O_RDONLY, 0);
 	if (IS_ERR(fp)) {
 		ret = PTR_ERR(fp);
-	}
-	else {
+	} else {
 		oldfs = get_fs(); set_fs(KERNEL_DS);
 
 		if (1 != readFile(fp, &buf, 1))
-- 
2.17.1

