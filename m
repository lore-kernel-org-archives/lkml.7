Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25E6C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB1821783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHeoiCZE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfJBNfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 09:35:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32796 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfJBNfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 09:35:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id b9so19724575wrs.0;
        Wed, 02 Oct 2019 06:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yDFkyFKnVVaJETawxGl6c7iecqMKmXo2RrVQG6D/yyI=;
        b=dHeoiCZEEsJwLZnPG7X/nHAejwZNzrWNsP7lSKya/PBsnq8H2/6ycrAvNiQfvLJ8yt
         1duTd6VxbUkgLC7X1nhxGIrS5yWDeO1ipyHlqIBf5YK6NpNq6OP+dn0JE/HycJJ1z8PR
         heXXMFEWo3kJEGZGxef+B+iMAKF1ECaVc2UAxA6KkJwgdm5HJ/+M/cFE+bQn1J5Ki9Nk
         N2b3LZWMegQPBUak65Dv7IFsRuGOLJW+sbaqCPHMMKsSwBv6dKp+eHx645odfVbuikWb
         BVxNpuuIPYr63AYPotoThhoM4hb/Frx3p6nDjv1guqWeXEv96dpDxknnhcTx5o6O1XkK
         c9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yDFkyFKnVVaJETawxGl6c7iecqMKmXo2RrVQG6D/yyI=;
        b=A8lt+t6dG53OOve3VfIk6Kr2L/RuVqgN6P/6VXiSkeoTVPESEKZI2CSE0eaudbPKv8
         Zgsi/VhWmRoRW/cTF/R4HtgFy0wRIxThxmuZtH89bVDQ2KLl9amZzBNHCOIs0uL/goEQ
         ENueDMtkPIhVWCbrLQSlJi60Xu3spXLcDDCczzomxGiYxy9+A2N7BykY9vmHzEReFUM7
         UEZRhsZSLw/bCw+Jdtv/FmePZnwY4wXPc0mg96gFfX2SbB7PW770x3mgoVBMfBU90lRC
         Y0lcyk1hJJIxNCtpCck15INDpkEKil1kpp3KjgaII3huUtkitEGuY4tNPFDfQIeZDRMQ
         vFLw==
X-Gm-Message-State: APjAAAU7ekh2fBCxqmpBgi8qtBoLWiAMC15nU/956rK1ylcvT4wDcTQy
        ijH/IuzeeF2TIulXy9sl+/m6AiXWkzWkqg==
X-Google-Smtp-Source: APXvYqz8O+xytzH/baIb52dgiSm4SWi2QiBbV80z3zT8PbZpCYll6apIuFtJwlPyKbZDxJJw7YojTw==
X-Received: by 2002:a5d:6108:: with SMTP id v8mr2690374wrt.28.1570023350712;
        Wed, 02 Oct 2019 06:35:50 -0700 (PDT)
Received: from LHFYY6Y2.criteois.lan ([91.199.242.236])
        by smtp.gmail.com with ESMTPSA id z142sm11597952wmc.24.2019.10.02.06.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 06:35:50 -0700 (PDT)
From:   Jeremy MAURO <jeremy.mauro@gmail.com>
X-Google-Original-From: Jeremy MAURO <j.mauro@criteo.com>
Cc:     j.mauro@criteo.com, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION SCRIPTS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/2] scripts/sphinx-pre-install: Add a new path for the debian package "fonts-noto-cjk"
Date:   Wed,  2 Oct 2019 15:35:42 +0200
Message-Id: <20191002133543.10909-1-j.mauro@criteo.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191002073636.68ad85de@coco.lan>
References: <20191002073636.68ad85de@coco.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The latest debian version "bullseye/sid" has changed the path of the file
"notoserifcjk-regular.ttc", with the previous change and this change we
keep the backward compatibility and add the latest debian version

Signed-off-by: Jeremy MAURO <j.mauro@criteo.com>
---
Changes in V2:
- Align all lines

 scripts/sphinx-pre-install | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index b5077ae63a4b..1f9285274587 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -348,7 +348,8 @@ sub give_debian_hints()
 		check_missing_file(["/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf"],
 				   "fonts-dejavu", 2);
 
-		check_missing_file(["/usr/share/fonts/noto-cjk/NotoSansCJK-Regular.ttc"],
+		check_missing_file(["/usr/share/fonts/noto-cjk/NotoSansCJK-Regular.ttc",
+				   "/usr/share/fonts/opentype/noto/NotoSerifCJK-Regular.ttc"],
 				   "fonts-noto-cjk", 2);
 	}
 
-- 
2.23.0

