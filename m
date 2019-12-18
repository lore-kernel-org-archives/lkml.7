Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69E0C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9021421D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfLRVqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:46:06 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36458 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfLRVpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:45:19 -0500
Received: by mail-qk1-f195.google.com with SMTP id a203so3265725qkc.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 13:45:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EVS8C1CmVe0PF737qzOV4edJfMDPYHvKPgJECzGTAu0=;
        b=PyPdp21owd7DhKZhVUyjvDM9Ccu5wwRATxt8GhfhZomMwhzX7kNKGTaJo8+Oa51sb2
         hx3BwfCmuEFPNREtZytg6O5yzuB+9qLXiAYBGQGVSQA3kZw6weJxI63xRXp93p1fh7+1
         69x3Vz16TykpPMLMbnHDUEBK7D96YxUKxcHxNotr2KPEjzco1PlBqisGQnQmffdin2Kb
         wp1KkRlQeLwk72+HptGVI1SkAAi0e7jgNjORVYJyfgUSHx608Y7mkuxXezySkkkDyGbE
         RJfZSKyvelIujP0pSqeWLXeb/sbcMQExlqjMtvRzohbfE2vGy2a1jyYUFi8CEprsmLPz
         m1LA==
X-Gm-Message-State: APjAAAWazwwVyg0R6tWCvno/WRI36AAa18rCuQRW39DeHvICWp1k8Brp
        G9T5K01JzHAytsUuekfJmk4=
X-Google-Smtp-Source: APXvYqy9Nizq1CBnLc06xTbeFaqSU4auDjXoemKbxG8Sw2o6W/UPwxlVjzIL1eJ1J8WNYhZP6kyOZw==
X-Received: by 2002:a37:27cf:: with SMTP id n198mr4995971qkn.188.1576705518991;
        Wed, 18 Dec 2019 13:45:18 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u4sm1059851qkh.59.2019.12.18.13.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:45:18 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/24] arch/nios2/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 16:44:56 -0500
Message-Id: <20191218214506.49252-15-nivedita@alum.mit.edu>
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
 arch/nios2/kernel/setup.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/nios2/kernel/setup.c b/arch/nios2/kernel/setup.c
index 4cf35b09c0ec..3c6e3c813a0b 100644
--- a/arch/nios2/kernel/setup.c
+++ b/arch/nios2/kernel/setup.c
@@ -196,8 +196,4 @@ void __init setup_arch(char **cmdline_p)
 	 * get kmalloc into gear
 	 */
 	paging_init();
-
-#if defined(CONFIG_VT) && defined(CONFIG_DUMMY_CONSOLE)
-	conswitchp = &dummy_con;
-#endif
 }
-- 
2.24.1

