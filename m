Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6CFC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC45E2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfLRVpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:45:14 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34074 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfLRVpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:45:11 -0500
Received: by mail-qt1-f194.google.com with SMTP id 5so3222323qtz.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 13:45:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UeBf/VpWa9gYAtz/T4azpaJTgSpTj/SRdru/GVfph8M=;
        b=LeGKyex+iEfl7lGdGBYEcpH4/972LotFBX1HNVAxJRYrgSG20MvE4peQi8XuWa40OX
         aGVZr5/YZ8JmWlDippqujuElnneDCWZF+CpWYxpo5e2M+M5yjuGXnIQrJm8DLo/ax1Ny
         I3Zn91zwJApfk2lR6v41MUOMQoDmcL0neBc82BlkO4I9gWmkyqW/rHw/LZMQGsMTBOiw
         8KrcIPHirUYmxQwB6wO/YBqy5EnSUQ8lJE1ybPmG/GaXjA8yv2w2LyHkDFzBt365nJt1
         jpZHfSq8WgtCetdPNHmoi8Bo31jO2G3ROZc7Y7i+PxHUje7KPj2BKBg1j0B3NWYGD3hB
         Lhxw==
X-Gm-Message-State: APjAAAVvabgGJiVcCLcTWBEQzlgcxnx7N95yDckv4XhB3aG43yDiDUP6
        QT1CQcsskCvEMIqG+XJo7e1me0nY
X-Google-Smtp-Source: APXvYqxSpGo7WIU2fULWM1JbwoVpwdcBpTzHYSIKmuyaWHHodnYB3cn036OYq4/R6UnIq+cXVfBODQ==
X-Received: by 2002:ac8:21fd:: with SMTP id 58mr4106596qtz.90.1576705510698;
        Wed, 18 Dec 2019 13:45:10 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u4sm1059851qkh.59.2019.12.18.13.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:45:10 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/24] arch/arc/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 16:44:46 -0500
Message-Id: <20191218214506.49252-5-nivedita@alum.mit.edu>
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
 arch/arc/kernel/setup.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index 7ee89dc61f6e..e1c647490f00 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -572,10 +572,6 @@ void __init setup_arch(char **cmdline_p)
 	 */
 	root_mountflags &= ~MS_RDONLY;
 
-#if defined(CONFIG_VT) && defined(CONFIG_DUMMY_CONSOLE)
-	conswitchp = &dummy_con;
-#endif
-
 	arc_unwind_init();
 }
 
-- 
2.24.1

