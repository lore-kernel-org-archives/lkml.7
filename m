Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF820C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89422176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfLRVpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:45:19 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41227 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfLRVpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:45:13 -0500
Received: by mail-qt1-f195.google.com with SMTP id k40so3193058qtk.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 13:45:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0dV63FGKurbHicTv4fkFntFqg9okeIkli05F9bbXIFo=;
        b=svUUMkb9vwJjVf0TBCSPZA6aBmn9tSW4iuf96rdMaTUAuBy4uc5tRrfis4gfocQoMs
         Uu1MCVJoJOGOAceKt3Z+gkjDwccWlBInEtmlZG7sFUGRBRyHUc77AOdq+k3thLX7/8JW
         LhiVuNax28hJTQTWHcDHRyWvZSEhPRITxM1tgykNvk1QdYSq6Dk3FlByEnbWqqaVBiBE
         zql2L4CHMwC6iaPAKrSVkeDcJNhgEsBDcuR60cDw0t42q68GPFb9MqYLDXP7AWUVbCj2
         bKb2HhwFuLat2RtlZetUkcvDfv18ahOHoiwlXp/zu/m9PDfQmJskuBnPmiJ7VkqNHo9V
         h9RQ==
X-Gm-Message-State: APjAAAUfKobRwglK4ULK/oNWLtgN6ALYkl3PQvWkZ8HIQiWFgekP6qHc
        x47diNsmMkZgW3pZOdzlaTE=
X-Google-Smtp-Source: APXvYqw+P+NB9w+0f/Kdlto4kjT9cvy+QJqHxVzSdEQw5q8337Le1jdJ6sPjdMWwuUoYSaD32xb6ZQ==
X-Received: by 2002:ac8:6053:: with SMTP id k19mr4306619qtm.348.1576705512569;
        Wed, 18 Dec 2019 13:45:12 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u4sm1059851qkh.59.2019.12.18.13.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:45:11 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/24] arch/arm64/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 16:44:48 -0500
Message-Id: <20191218214506.49252-7-nivedita@alum.mit.edu>
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
 arch/arm64/kernel/setup.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 56f664561754..2a86676b693a 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -353,9 +353,6 @@ void __init setup_arch(char **cmdline_p)
 	init_task.thread_info.ttbr0 = __pa_symbol(empty_zero_page);
 #endif
 
-#ifdef CONFIG_VT
-	conswitchp = &dummy_con;
-#endif
 	if (boot_args[1] || boot_args[2] || boot_args[3]) {
 		pr_err("WARNING: x1-x3 nonzero in violation of boot protocol:\n"
 			"\tx1: %016llx\n\tx2: %016llx\n\tx3: %016llx\n"
-- 
2.24.1

