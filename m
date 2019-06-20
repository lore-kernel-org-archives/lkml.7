Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1A5C48BE1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6794D2085A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rlzLgjdh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfFTSiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:38:50 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35208 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfFTSit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:38:49 -0400
Received: by mail-pf1-f193.google.com with SMTP id d126so2157007pfd.2;
        Thu, 20 Jun 2019 11:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bkG79tXJS8BQ8axbZNY2AitSYAHH4g1Q7wXNHiD9B4E=;
        b=rlzLgjdhlLurI68T3D1XEzFJCnZdj0RyOtmRyc4tE0cY+5VekBWQocVVzUQRH/tMII
         K8WQTt7eHPWjzmA1FJCj6htxmStLF3W77MuyvOCQpK2txyiHBTYX8I7xSeLlDM0EFdx/
         0qJsvulMGJ73Cj43ZjcAjbL73cw8zLRiNrItZC+mEvsc1PO2iEw5SwahqXMcaHwiT8uo
         aHMWpBwanTyy/HAm8dVVFRSA1VEDP0pBB+gGfILXYdEhG18P2NUXYPNpDWkhWW4PvoIf
         YxwqLUDQmZwua5+7YbSeiOmas52pJeneqRJKZENkIs2L96ikNh4031lwWnjcpwXeRZeo
         ZrOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bkG79tXJS8BQ8axbZNY2AitSYAHH4g1Q7wXNHiD9B4E=;
        b=hKGZzcB6M9n8q3p0zknBON8owiFyxBkvbOp39iWWiBvmFWFIfnDzgOsOOKG7LTnjKX
         eX1JlphbwpO1zxuAUSLd5M4rhp/N6VQh7F41R3iZait3sar0Ju/LUtyBsFw9UUIj1z0A
         4FP849wLvZT/xmGAQ/OMloAWom1hy27evWs21F37tBvU7gSFoldt8j+a/qCJGmjMvqqt
         5ay559qtChJwea4B5e4RIwoUOkcMLTAzhZqQz9VQkA8RO5OD5sBbLafHJtItrK5Mv0So
         fICtOd/kgtCWgLHv2UXfISdke9rdnvtYH4LBn6t7LFeaVhUK9SttegsT1YlnPhBUMtfA
         WBqQ==
X-Gm-Message-State: APjAAAXqhYzNrgmdG1wYtX6uNpjQPsuU8riZdNk49scSNeCEQ18pVxc6
        +UwvhXLGxJODiqq+56hMpG4=
X-Google-Smtp-Source: APXvYqzYAntk/VNNv48T3x3QRxz76F1oMX/KguqhjnIKahO+YAXoSMVIspjknKUmlRT1f+C8aNn6tA==
X-Received: by 2002:a17:90a:ac14:: with SMTP id o20mr1123136pjq.114.1561055928794;
        Thu, 20 Jun 2019 11:38:48 -0700 (PDT)
Received: from localhost.localdomain ([112.196.181.13])
        by smtp.googlemail.com with ESMTPSA id z22sm311472pgu.28.2019.06.20.11.38.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 11:38:48 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Cezary Jackiewicz <cezary.jackiewicz@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Subject: [PATCH v2] Documentation: platform: Delete x86-laptop-drivers.txt
Date:   Fri, 21 Jun 2019 00:08:27 +0530
Message-Id: <20190620183827.23704-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The list of laptops supported by drivers in PDx86 subsystem is quite
big and growing. x86-laptop-drivers.txt contains details of very few
laptop models. Remove it because it does not  serve any purpose.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 Documentation/platform/x86-laptop-drivers.txt | 18 ------------------
 1 file changed, 18 deletions(-)
 delete mode 100644 Documentation/platform/x86-laptop-drivers.txt

diff --git a/Documentation/platform/x86-laptop-drivers.txt b/Documentation/platform/x86-laptop-drivers.txt
deleted file mode 100644
index 01facd2590bb..000000000000
--- a/Documentation/platform/x86-laptop-drivers.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-compal-laptop
-=============
-List of supported hardware:
-
-by Compal:
-	Compal FL90/IFL90
-	Compal FL91/IFL91
-	Compal FL92/JFL92
-	Compal FT00/IFT00
-
-by Dell:
-	Dell Vostro 1200
-	Dell Mini 9 (Inspiron 910)
-	Dell Mini 10 (Inspiron 1010)
-	Dell Mini 10v (Inspiron 1011)
-	Dell Mini 1012 (Inspiron 1012)
-	Dell Inspiron 11z (Inspiron 1110)
-	Dell Mini 12 (Inspiron 1210)
-- 
2.21.0

