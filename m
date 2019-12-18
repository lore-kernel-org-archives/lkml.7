Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE46C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC41621D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfLRVpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:45:18 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43220 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbfLRVpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:45:10 -0500
Received: by mail-qt1-f195.google.com with SMTP id d18so515713qtj.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 13:45:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xuC0KnENGlHSh4OuNtX5fMwiXIkT6SBdyZ81CX+59Kg=;
        b=T93v3megvYJ4FMk/fji8WVowgkH0INgpnLXvwByt+5U6mKMrZGj8WLsCCcVbwa0Czg
         LSfgdycjiZe0PNiPaSo5p4qERIfUBZg4JNhvRgaeFc6ZHJefPsT5rfoPgcnqiRtOZzuo
         qox4VK2eXGM/HuVyO0rbw3cgAoKTwrwV1R42yxwsur7NQTD3iSHGDhECZutZPvEC69w+
         B5k40i1RPO/4bKeJtOzv6XAmXmATRa6MztOz8OTW/oK4OBZ2sSUh5J9fBk66Vtn9HXhi
         ze2mT4PDUSPRQQfY3+3btoDc3cM7muerQUZhNMXSMG6zVfEoP4ZdVVHKHhvhgcVG5IYO
         W74A==
X-Gm-Message-State: APjAAAX3umkVAHVZixP8vlmQqOkPU0MLMDwzktKUGNklBd/1KAUv1FuL
        bBRqRxUmL/8M6FTnphWdtX0=
X-Google-Smtp-Source: APXvYqxKyEcKWE+L/p7ePtQcbGMkiVTRVCSDHB1rwYrT10bCrMmsD+KGQL9qHlSHrH9ZX5nv2M3DUg==
X-Received: by 2002:ac8:835:: with SMTP id u50mr4315410qth.15.1576705508944;
        Wed, 18 Dec 2019 13:45:08 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u4sm1059851qkh.59.2019.12.18.13.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:45:08 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/24] vt: Initialize conswitchp to dummy_con if unset
Date:   Wed, 18 Dec 2019 16:44:44 -0500
Message-Id: <20191218214506.49252-3-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218214506.49252-1-nivedita@alum.mit.edu>
References: <20191218211231.GA918900@kroah.com>
 <20191218214506.49252-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the arch setup code hasn't initialized conswitchp yet, set it to
dummy_con in con_init. This will allow us to drop the dummy_con
initialization that's done in almost every architecture.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/tty/vt/vt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 34aa39d1aed9..2456afaf1c61 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3326,8 +3326,9 @@ static int __init con_init(void)
 
 	console_lock();
 
-	if (conswitchp)
-		display_desc = conswitchp->con_startup();
+	if (!conswitchp)
+		conswitchp = &dummy_con;
+	display_desc = conswitchp->con_startup();
 	if (!display_desc) {
 		fg_console = 0;
 		console_unlock();
-- 
2.24.1

