Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A6EC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 06:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC2120863
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 06:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haAJq5jY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388450AbfEXGDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 02:03:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37237 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387622AbfEXGDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 02:03:43 -0400
Received: by mail-pf1-f194.google.com with SMTP id a23so4656141pff.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 23:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dgk22vNOFVTdl15VCCSR/tsBKmUZl95JwAuWXbL3XM4=;
        b=haAJq5jYQY/oHcN77oKF7B9I+jJBdfhZl03i0p38il8WSfQC1Dxf8A8jaPEgrNn9Mc
         CxUkRBfjZCaishIQst8qhzUqXO2S5Hq1QqmUsNs0qxEob+yPExPrC5wOX89FmT9LFkeS
         X48xvBEdt/z2Q8qKG46Pty2n3LOJtaTGE4E0zFDim2Jepeh6lMYO4LVNSOVRRDfNPCvQ
         fLU4rxM50AI+lWYdpHKwPTk3J/xe0zTCi9U6kL8QXoViA3oNyc0gVePHptCZTRjflu8Q
         GgwmbwQS02CBk3SsPZVuF9hH2+kePIgtWUpbQmJEYia/e0LWA4tZI2Abdci0WgE/Imrq
         fHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dgk22vNOFVTdl15VCCSR/tsBKmUZl95JwAuWXbL3XM4=;
        b=sc/sV/p7gX+rCMQny9zt94LPDTb5N4iTECuac6zoeW9rDsXacyts/qMIeKWuL4WleZ
         aZxNLjlleHT2ZBPLdGUsYvFnCRJa3xYxvsQ95dHpHYYRAGI+Iq8ysDlWSXx2IRjK6FQB
         Gld94NOrRKsEuxX5ybJDvpXuyxi2nngCuJGfv5otfxA+YhYJpEoBsaL3N7fy6CY1LCRP
         SD7FMYRtuhR2ryx8nPVdwk1lgVgLiomXfn3vPRZrxfksb84NTULYVZuByN4WKwgbBTbt
         yY8SfIgFVdYeMxvRzDERbZHmkxfjTKTGsrGnlf+p0OXCJzAtF/tun9r8LVvHj1QDwBh9
         wOPw==
X-Gm-Message-State: APjAAAXOA1uY3p3O5n5mU3q1rx47qHpZdJP9fClyqQTI1SscNM662CGf
        ejBmY9lIs02DnWs+YIVZqPU=
X-Google-Smtp-Source: APXvYqyIb39LWo6daB+rzJC6BkUxi08RKGYIbWTC445D2ECXSZn9XWhpoKUxddYv2qQWH9DTy0Bkjg==
X-Received: by 2002:a17:90a:c696:: with SMTP id n22mr6541804pjt.24.1558677822477;
        Thu, 23 May 2019 23:03:42 -0700 (PDT)
Received: from localhost.localdomain ([110.225.17.212])
        by smtp.gmail.com with ESMTPSA id t25sm2264100pfq.91.2019.05.23.23.03.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 23:03:41 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     gregkh@linuxfoundation.org, thesven73@gmail.com, hofrat@osadl.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] staging: fieldbus: anybuss: Remove variables
Date:   Fri, 24 May 2019 11:33:28 +0530
Message-Id: <20190524060328.3827-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The local variable cd, used in multiple functions, is immediately passed
to another function call, whose result is returned. As that is the only
use of cd, it can be replaced with its variable.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/staging/fieldbus/anybuss/host.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/fieldbus/anybuss/host.c b/drivers/staging/fieldbus/anybuss/host.c
index f69dc4930457..9679cd0b737b 100644
--- a/drivers/staging/fieldbus/anybuss/host.c
+++ b/drivers/staging/fieldbus/anybuss/host.c
@@ -1046,10 +1046,8 @@ EXPORT_SYMBOL_GPL(anybuss_start_init);
 
 int anybuss_finish_init(struct anybuss_client *client)
 {
-	struct anybuss_host *cd = client->host;
-
-	return _anybus_mbox_cmd(cd, CMD_END_INIT, false, NULL, 0,
-					NULL, 0, NULL, 0);
+	return _anybus_mbox_cmd(client->host, CMD_END_INIT, false, NULL, 0,
+				NULL, 0, NULL, 0);
 }
 EXPORT_SYMBOL_GPL(anybuss_finish_init);
 
@@ -1146,20 +1144,16 @@ EXPORT_SYMBOL_GPL(anybuss_send_msg);
 int anybuss_send_ext(struct anybuss_client *client, u16 cmd_num,
 		     const void *buf, size_t count)
 {
-	struct anybuss_host *cd = client->host;
-
-	return _anybus_mbox_cmd(cd, cmd_num, true, NULL, 0, NULL, 0,
-					buf, count);
+	return _anybus_mbox_cmd(client->host, cmd_num, true, NULL, 0, NULL, 0,
+				buf, count);
 }
 EXPORT_SYMBOL_GPL(anybuss_send_ext);
 
 int anybuss_recv_msg(struct anybuss_client *client, u16 cmd_num,
 		     void *buf, size_t count)
 {
-	struct anybuss_host *cd = client->host;
-
-	return _anybus_mbox_cmd(cd, cmd_num, true, NULL, 0, buf, count,
-					NULL, 0);
+	return _anybus_mbox_cmd(client->host, cmd_num, true, NULL, 0, buf,
+				count, NULL, 0);
 }
 EXPORT_SYMBOL_GPL(anybuss_recv_msg);
 
-- 
2.19.1

