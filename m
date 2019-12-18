Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8791DC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64DDF21D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfLRVqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:46:35 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41224 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfLRVpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:45:12 -0500
Received: by mail-qt1-f194.google.com with SMTP id k40so3193011qtk.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 13:45:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rBoR9qFKudqjEn6RFPOy0vY1Hbe0MDRwH4FNr5Y5Tj0=;
        b=qhE6JMTwmR+0h8OR1x1QvGNE5/rHfuChvfHcRt9A7UQs3RP2MWegHlgUwFljqGScM9
         Ujsgeg3RHEZVS4ArR3ugHoNDQhzx2UAmM6GQM109BNenU5YlbajdY1mP1MOGKPLRKlqp
         lzllE6Bn6/IKLsxKTeG9/IQhg8dqscn/Aj1HsAdaYa1xqnAjKP+VXC50ZKTeQNacAtKB
         PrgUQI7Re/ygh+Z+gzCjuGlNpB+odQRdTEK/0dO3pNT/thuHSdSjvgJSVUa2uRJCUoXq
         E52MrtxTRWIx9lOEimGrQr/nxq4jww7m8YeuWc7HIVPQxMn8lkl8hdRyoGZNV+frSPyi
         gwJA==
X-Gm-Message-State: APjAAAVoWfFSx7i2FuyqIsrIdZ0q4Q3o/Lin9+vyuRE+luA4MScOuFpW
        1OgkbQGiuUEhiJv4VJAy9SGWl5ew
X-Google-Smtp-Source: APXvYqylv6WGGCTdH/s85/eLLCdb+IW+yvYs79KDEzTYgaiH2awawUQWJhpu7WI1IJN39X7MSgBvdg==
X-Received: by 2002:ac8:5206:: with SMTP id r6mr4057942qtn.214.1576705511502;
        Wed, 18 Dec 2019 13:45:11 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u4sm1059851qkh.59.2019.12.18.13.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:45:10 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/24] arch/arm/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 16:44:47 -0500
Message-Id: <20191218214506.49252-6-nivedita@alum.mit.edu>
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

con_init in tty/vt.c will now set conswitchp to dummy_con if it's unset.
Drop it from arch setup code.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/arm/kernel/setup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index d0a464e317ea..d8e18cdd96d3 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1164,8 +1164,6 @@ void __init setup_arch(char **cmdline_p)
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)
 	conswitchp = &vga_con;
-#elif defined(CONFIG_DUMMY_CONSOLE)
-	conswitchp = &dummy_con;
 #endif
 #endif
 
-- 
2.24.1

