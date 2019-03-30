Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F54C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8032082C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCYpiYSG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731043AbfC3SaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 14:30:13 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40516 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730675AbfC3SaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 14:30:12 -0400
Received: by mail-lj1-f193.google.com with SMTP id q66so4662132ljq.7
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 11:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Vo7WP4LmAWMjcqmOIdpRol4bf0P8ZM1Pto+rf6Pgo44=;
        b=LCYpiYSGtObHkRWUY+CU7vylwz1O7Ip7Y+oFokxJ5O1yC7dW7cAfaMovPjvmaqAbFr
         XfQN4NK/rkuXYDq3RHhdTifIFIwoUiEkL9Ax58rEfCXEZCazCLmW/yz1EH9LYikg1bjH
         x+ysSsUXtjno18ceoYH9Q9NYgfiB58VmYV0co03sUcGAmMSDHYGfcm7E8dmsTrL3ct3G
         ohGZv2HN6OuNGawqHKmUBViXvh5HWHrBc6xpkSdDfxqbiygJYjq/ngYV/HrLktcn40Sw
         Xz3hvAwVl7I50mkHzjrInTmvP4iUOHU18IVbk84ALBTO/IpAkE1bgAGr+L59CECFi59N
         xBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Vo7WP4LmAWMjcqmOIdpRol4bf0P8ZM1Pto+rf6Pgo44=;
        b=adV/+JRAmjNPqTedcUeeA7jsmuvP35xm+Yad53DmKPbKwc8GOSlt4JNmEdokshbj06
         GsLTr0MT8EEakVxEGOuudXnfcd7pwHflAdx+ghEeyEpb2aShU25YTfUtxPX9SLmEsMtL
         VQdU7nZEyJ5aUkvCG/Igxf1t27yB/pwqsq01+APAds2vAKC5OAHcDt4JMWnuYqn8jNDV
         +0GoN+Hq4DpOyfbTXLJ2E/mJ9jMMFYDoHNogmlhFwQbugvqHNwbzdFp25Ja6m/pL3BWS
         7muSUvZutnZOu+oOUZ/y9H92dsLSoK8rewx9eesSe/Ii6Jn4qxmL0l/Po9ErYqPpi216
         1WGA==
X-Gm-Message-State: APjAAAUdjDVVCTubdoDy/l5hzF5VmqPRoroARDlSzLNP+Bd2jEWAy2Qz
        vULtAgCHJXs0EDeuXogrW97j6aPS
X-Google-Smtp-Source: APXvYqywNZrQTCU9mtKBRu+2m14Mv3VUt5bYKrQcD4+MG2/LDevZ+rRx5tTumDj/E/2DL7rTNRPM7g==
X-Received: by 2002:a2e:3e18:: with SMTP id l24mr20681124lja.68.1553970610352;
        Sat, 30 Mar 2019 11:30:10 -0700 (PDT)
Received: from localhost.localdomain (v902-731.aalto.fi. [130.233.10.238])
        by smtp.gmail.com with ESMTPSA id o7sm1060058ljj.23.2019.03.30.11.30.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 11:30:09 -0700 (PDT)
From:   Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH 2/7] rslib: Fix decoding of shortened codes
Date:   Sat, 30 Mar 2019 20:29:42 +0200
Message-Id: <20190330182947.8823-3-ferdinand.blomqvist@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190330182947.8823-1-ferdinand.blomqvist@gmail.com>
References: <20190330182947.8823-1-ferdinand.blomqvist@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The decoder is broken. It only works with full length codes.

Signed-off-by: Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
---
 lib/reed_solomon/decode_rs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/reed_solomon/decode_rs.c b/lib/reed_solomon/decode_rs.c
index 1db74eb098d0..3313bf944ff1 100644
--- a/lib/reed_solomon/decode_rs.c
+++ b/lib/reed_solomon/decode_rs.c
@@ -99,9 +99,9 @@
 	if (no_eras > 0) {
 		/* Init lambda to be the erasure locator polynomial */
 		lambda[1] = alpha_to[rs_modnn(rs,
-					      prim * (nn - 1 - eras_pos[0]))];
+					prim * (nn - 1 - (eras_pos[0] + pad)))];
 		for (i = 1; i < no_eras; i++) {
-			u = rs_modnn(rs, prim * (nn - 1 - eras_pos[i]));
+			u = rs_modnn(rs, prim * (nn - 1 - (eras_pos[i] + pad)));
 			for (j = i + 1; j > 0; j--) {
 				tmp = index_of[lambda[j - 1]];
 				if (tmp != nn) {
-- 
2.17.2

