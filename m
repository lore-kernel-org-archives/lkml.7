Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA71C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 09:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8398B218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 09:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQBhzVW8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfJBJyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 05:54:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51281 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfJBJyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 05:54:17 -0400
Received: by mail-wm1-f67.google.com with SMTP id 7so6474758wme.1;
        Wed, 02 Oct 2019 02:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=agKbsf4oTKtJk9MDbyaTih7yTM3kVDJIjSHNfaZ4OSE=;
        b=dQBhzVW8nJFrZ0a/WmbRtxRsTpSjayY31YVv8a/ZpKkkb1qmRaEYFWAZZX07C4ZXt6
         kDhWqwKZ+U5epahSOUyqQ6bufSv+iELT2S4aow8npwPKdE26OwzMiQDwQ+znxmwOk+3r
         +hSyTWaxXxzmljC2FjUWZy+Dm8AdDxuXAfsLmfhgEaTK4/0A4GPQtqWg1HHVf0ehrudU
         TR0b5X77wHQtmGOyc7jsWmhKgbBIZ/D/YNSGzXy1vMgLt547futUlkNyND8Z/uiv3EhQ
         mTdihHPlEt0pNzOFActoRaaSkBt55gOtSpH9LUT/CNL5pzyjLTc5yFGKBnw/fVYulfCH
         JpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=agKbsf4oTKtJk9MDbyaTih7yTM3kVDJIjSHNfaZ4OSE=;
        b=fR2OmoRAJj5WQKtG6owLfj72Dt9kSaTWxAtCv/EegSVHAP5dGPIqiJWbnmxg1RcNX3
         ZcGAq/zPGg2F5dxMabb2dRVP2pT0Pgf3a5Dq+9vP83Z8fGdg7NJ/eAamo8zFjSL32pst
         U9GWloZoDX9HGehvCgMsq8VileK9wb/pH89baAJcEUkjUzYXJQ3l3utqjVsOghnb2NVO
         Kf72jwDzGDdq79QdUJWoLWAYNPxmlr6/KfO7ezdTVRx7H7ru06OvmLxup04V7acLK0KL
         Zhav08tn6phg189AwHYvPjspE4NEaQUd1K7U5SWLTyTkGxetovbFsk88P+vcQp2JPFtd
         /UEg==
X-Gm-Message-State: APjAAAX4UPD8paWOlCWhbxij4wUf/oXlTbE0K+VYPhf34g9p6aSSpy4T
        BZiuOaa9y/c/ZNDnP7fvPXE=
X-Google-Smtp-Source: APXvYqz0tYZwuKqd09YKMAOMI2tGhhBxqp2e1NOteuy14YTD5+tPWvNTLyja32hCOLodOEs9l86Pgg==
X-Received: by 2002:a7b:c744:: with SMTP id w4mr2067060wmk.11.1570010055061;
        Wed, 02 Oct 2019 02:54:15 -0700 (PDT)
Received: from LHFYY6Y2.criteois.lan ([91.199.242.236])
        by smtp.gmail.com with ESMTPSA id y13sm28459042wrg.8.2019.10.02.02.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 02:54:14 -0700 (PDT)
From:   Jeremy MAURO <jeremy.mauro@gmail.com>
X-Google-Original-From: Jeremy MAURO <j.mauro@criteo.com>
To:     j.mauro@criteo.com
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION SCRIPTS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] scripts/sphinx-pre-install: Add a new path for the debian package "fonts-noto-cjk"
Date:   Wed,  2 Oct 2019 11:54:06 +0200
Message-Id: <20191002095406.9918-1-j.mauro@criteo.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <j.mauro@criteo.com>
References: <j.mauro@criteo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The latest debian version "bullseye/sid" has changed the path of the file
"notoserifcjk-regular.ttc", with the previous change and this change we
keep the backward compatibility and add the latest debian version

Signed-off-by: Jeremy MAURO <j.mauro@criteo.com>
---
 scripts/sphinx-pre-install | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index b5077ae63a4b..b5da4202155b 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -348,7 +348,8 @@ sub give_debian_hints()
 		check_missing_file(["/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf"],
 				   "fonts-dejavu", 2);
 
-		check_missing_file(["/usr/share/fonts/noto-cjk/NotoSansCJK-Regular.ttc"],
+		check_missing_file(["/usr/share/fonts/noto-cjk/NotoSansCJK-Regular.ttc",
+			"/usr/share/fonts/opentype/noto/NotoSerifCJK-Regular.ttc"],
 				   "fonts-noto-cjk", 2);
 	}
 
-- 
2.23.0

