Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530E0C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D33D21D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfLRVpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:45:23 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45182 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfLRVpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:45:19 -0500
Received: by mail-qk1-f196.google.com with SMTP id x1so2869445qkl.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 13:45:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nmjx11JNpZwOQu39J70e+ulTg+U7qJn54nAaK/uJESw=;
        b=M284PsOGyltxB07027xLEXcgUus4y0UwTJi+W1xdSB/EO0ZOrFVn4ve0sjhDwu6j//
         AIq2Y35cWjW54V0lethEYfylDxgFzrvA2Y8F/bShnbVSTcRYT24+UflR4spWJeuUGzUv
         WgE/RH1w+3f+SrM/JV1dx/1OJ9nWtFEv0SMtDSBCxWvs7UKAG+uzPJDNxPv70npIMH94
         AWY+5fzvsUybz07nOGeqx8USJFf0XIUicBU6uqbExKqet17RaQsqZLvM/K15nwIfTnsf
         0pXZroexZtnR9VjVR+VxFze2gxYAGG6vQS2kHhzKyw88PluE8Uhd1uL0E2/s2HWx+cRX
         e9Qw==
X-Gm-Message-State: APjAAAWPV9PcphNHAkpo5eH9+MiT2Vet5UKbYGCDzwAB8rthkfpeHbbr
        WcaFvcFvSCQkJnWEkTiiVbs=
X-Google-Smtp-Source: APXvYqxPiOgckE4PfSZuDp76xYXnQCNrFghPP4ne6S+U+X//DMhtsRZ4O5JW0wf1n4T/fk1qu1Ecag==
X-Received: by 2002:a05:620a:78a:: with SMTP id 10mr5037263qka.392.1576705518289;
        Wed, 18 Dec 2019 13:45:18 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u4sm1059851qkh.59.2019.12.18.13.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:45:17 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/24] arch/nds32/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 16:44:55 -0500
Message-Id: <20191218214506.49252-14-nivedita@alum.mit.edu>
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
 arch/nds32/kernel/setup.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/nds32/kernel/setup.c b/arch/nds32/kernel/setup.c
index 31d29d92478e..a066efbe53c0 100644
--- a/arch/nds32/kernel/setup.c
+++ b/arch/nds32/kernel/setup.c
@@ -317,11 +317,6 @@ void __init setup_arch(char **cmdline_p)
 
 	unflatten_and_copy_device_tree();
 
-	if(IS_ENABLED(CONFIG_VT)) {
-		if(IS_ENABLED(CONFIG_DUMMY_CONSOLE))
-			conswitchp = &dummy_con;
-	}
-
 	*cmdline_p = boot_command_line;
 	early_trap_init();
 }
-- 
2.24.1

