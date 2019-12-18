Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369C7C2D0BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B39227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfLRVpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:45:14 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42942 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfLRVpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:45:11 -0500
Received: by mail-qk1-f196.google.com with SMTP id z14so1648441qkg.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 13:45:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RCSQ5QsujeKqOofk/5e8tL3S0uOIr5Ub3kx5O5FWQpQ=;
        b=W/ephZCcLv5EVUiHrwKQTUOoes/NHU0oQWIbBAwdo7w999Ku6LcNh2occFrbsHQHu9
         dhamImfybF6IE7foUxdn0uO5y+nkQMFrLuVnJSc9akLD/MwOn78LHIz8LbwARThM/Rsi
         QKnjsdi0MUGMEJ94xlnCkg2/WehtX87QAZjIE5hlxYSq9sY63vLs6FCM2/P/n4trlYch
         y6KayH41kJiUbfep4xXeXkJDDudoSoJ2f62epPV2TIzv4k+Ry8njqcoa/esIBhfrYvWb
         lehOcYWPhUtNFc+S+hRCKU+DNr2Podg94he6NtE4u9ytJCZcRw4lNjuUwM+GZB83+SQi
         7zmQ==
X-Gm-Message-State: APjAAAXGkbf9+xT+/hRmxCnryk/EUYHA0byTfpZhOx5zDpfR9Jzu7VKh
        dXtrcCpd2ZLBUa3O3NJIILM=
X-Google-Smtp-Source: APXvYqz75a9XHj08lXokfRYEBPAs6ZOwgE+oknDeAUXYdsfS9MK2j6Ehig8fXeZhrqKdxC+EQCJIRQ==
X-Received: by 2002:a05:620a:16bb:: with SMTP id s27mr5148837qkj.368.1576705509773;
        Wed, 18 Dec 2019 13:45:09 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u4sm1059851qkh.59.2019.12.18.13.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:45:09 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/24] arch/alpha/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 16:44:45 -0500
Message-Id: <20191218214506.49252-4-nivedita@alum.mit.edu>
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
 arch/alpha/kernel/setup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
index 5d4c76a77a9f..f19aa577354b 100644
--- a/arch/alpha/kernel/setup.c
+++ b/arch/alpha/kernel/setup.c
@@ -655,8 +655,6 @@ setup_arch(char **cmdline_p)
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)
 	conswitchp = &vga_con;
-#elif defined(CONFIG_DUMMY_CONSOLE)
-	conswitchp = &dummy_con;
 #endif
 #endif
 
-- 
2.24.1

