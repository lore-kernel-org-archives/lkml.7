Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B9EC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24D4218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfLRUkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:40:10 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39659 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbfLRUkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:40:06 -0500
Received: by mail-qt1-f196.google.com with SMTP id e5so3055948qtm.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 12:40:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xuC0KnENGlHSh4OuNtX5fMwiXIkT6SBdyZ81CX+59Kg=;
        b=MXmFL7uqVsnOIzXbdpVsLnz4t8Ed18k7qAiFMRuzJb8WqCUdM6Ulp3sX7xmrblR8aD
         Bx7NfcXWMQrVBRAb0r3H1DbJt5eKNx4nGThBNq2xkoegjYVQ/7w3Ko4GuIiwrMzVHlee
         jZG9a1WlBKXEO+WjKp7/f0prjPNAicQsPkPJTRImvArmjatX4+8ZAt5SpaX3NLsfQSIG
         xx8gq6MO2f28xtI7vOJ4vqqslH3yz7JoKD+cdeI2FHq7GO3J6Kb+AO0XJspiZO0kNE/x
         WNpgKnRBlLijqHRSGoFYbKa/JNgg72k85WOTEQKwcynsijOrczLZpYO8b2W+6s/wtCN9
         vLfw==
X-Gm-Message-State: APjAAAW/FfV44sLONXR18pRldtxfr8ragwUtLbwUEu3ZIW2r74tIqpo3
        Udl0DAs/7t9zQng0iy7evY8=
X-Google-Smtp-Source: APXvYqyauJueZCK5IwnG4crXFSgetR+R06CV0pByYUl+l/bjpphLDYXDZ69L0JMnIG6W9yp2y5apkg==
X-Received: by 2002:ac8:195d:: with SMTP id g29mr4000603qtk.65.1576701605403;
        Wed, 18 Dec 2019 12:40:05 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t7sm993347qkm.136.2019.12.18.12.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 12:40:04 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 02/24] vt: Initialize conswitchp to dummy_con if unset
Date:   Wed, 18 Dec 2019 15:39:40 -0500
Message-Id: <20191218204002.30512-3-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218204002.30512-1-nivedita@alum.mit.edu>
References: <20191218204002.30512-1-nivedita@alum.mit.edu>
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

