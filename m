Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3625DC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 096B2206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOtAPxnk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730957AbfG3Ik0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 04:40:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34458 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbfG3Ik0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 04:40:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so23462549pgc.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 01:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A6QIpcbQwJEsmdV9za/A3e+Q7a5KK84Ntv3twcinB6Q=;
        b=HOtAPxnkYxXPOgY+lRaNs+9k6CiAz/8Or0Rrz46RZ1Qiv+hUxY9scbqat3x6a+rhaF
         Tv8bZid99hhHpb+EpmHVuBNFXRHOb96f9TX7TZe65twC5I6dfnTM+5C0SNBVv3grvgY7
         /V0NqY/dwbrcIN9P8sQ4PJYh0Po7H16BJiSJ1ZRZf8MoSUKFu0lJFpZwQspSEIYaj9e9
         C4c6DG+VYpPYbu1hfHT/WcALz1SkylFMFTUgRE3ruRxp+TyVhMiM2VsEn3FeiU3/0YD2
         Z0jnfcHIPdubjm6LQswnzokSpBLQ8Ys/yv+E8fM19D1yxo914KN/gtaUdT7pdl+dAlgT
         IVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A6QIpcbQwJEsmdV9za/A3e+Q7a5KK84Ntv3twcinB6Q=;
        b=Q3H1zc187KMlECbaUYbTNBc0djjjuuNcUV+d9JY4AjWkthU6ovTFcpBKtuAGmY6kL9
         5SOxc/PtWu6++58IjDoIlq/x/uoknit3H8yEjIcd4jSkgnJqejnF+EvbI/9B9LPzc1yR
         y3kTJXBBgHjasjPVeISAlHeQWrlXnxnbe+IWMCAeTHzgA1/Z/rwXZjpQpH8KaHyiMELo
         m7B6vh8BvPUszGelGEpZhLQqEGoWhJ1OWegsPjjgyR7pTzxkeUdds92geIBrwaYXzKkI
         f2bZKYyzleEl6WvT9Vmw36wXC7B0XwD8Yr/uvxg2HfuyPOKrrDXX5ImldjzepGbSgd8B
         +eQA==
X-Gm-Message-State: APjAAAXY9ACHDlmNeoAxzsj9djUoJHvVfX+wvbo/v5CjaVjyhosYC7xl
        sXKXO2Q7/FFJSz4qSUvWH3jNRLHJw3Y=
X-Google-Smtp-Source: APXvYqx846L4dJKV9NpieH89XHKVIw0PbrrrQsksxQ/hAuMWP/nFjCRJJbu1hs4JJ8fzkfdoLasP5w==
X-Received: by 2002:a17:90a:a407:: with SMTP id y7mr116140568pjp.97.1564476025643;
        Tue, 30 Jul 2019 01:40:25 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id x65sm63854576pfd.139.2019.07.30.01.40.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 01:40:24 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Corentin Labbe <clabbe@baylibre.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] crypto: tool: getstat: Fix unterminated strncpy
Date:   Tue, 30 Jul 2019 16:40:18 +0800
Message-Id: <20190730084018.26374-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy(dest, src, strlen(src)) leads to unterminated
dest, which is dangerous.
Fix it by using strscpy.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 tools/crypto/getstat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/crypto/getstat.c b/tools/crypto/getstat.c
index 9e8ff76420fa..554ba08d9652 100644
--- a/tools/crypto/getstat.c
+++ b/tools/crypto/getstat.c
@@ -41,7 +41,7 @@ static int get_stat(const char *drivername)
 	req.n.nlmsg_type = CRYPTO_MSG_GETSTAT;
 	req.n.nlmsg_seq = time(NULL);
 
-	strncpy(req.cru.cru_driver_name, drivername, strlen(drivername));
+	strscpy(req.cru.cru_driver_name, drivername, strlen(drivername) + 1);
 
 	sd =  socket(AF_NETLINK, SOCK_RAW, NETLINK_CRYPTO);
 	if (sd < 0) {
-- 
2.20.1

