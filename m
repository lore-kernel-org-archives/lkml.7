Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66E6C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3390218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfLRUlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:41:11 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36070 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbfLRUkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:40:12 -0500
Received: by mail-qt1-f195.google.com with SMTP id q20so3065319qtp.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 12:40:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o/ruuOHK8troRwOu7XsfiPt3gKMUOl0EWbM1B7FCdGE=;
        b=Pu6z08/KvpHH+koIdnY62te8MciJzibulcRouRlcPwT1L89EKhFppde98mTL+VvlPV
         00oXV/g0yqAqr6ZWrTMOVKJtj4SLO2Mn5u9xTF8ynJS/XUjX2i4mbW9js4gUjzQQ2/x2
         gALJbj/aciT+OtvJ6mdS2sFK+J7dXdy1z27cjPEuwP4pE/5fDAgDH3bBAVH1MLJZBFR2
         IOCDxc1avIVbF0SbmhtVA7rtVQE2Rg1SlB+AEy31E62G4GWxFFI3zNpPsU8gpzsmgLkX
         ZEjB9++esTEs20klw9a95IU+C8ikK4EWpjhgrVlyxvhzv0ja+Kuw61WR87yAQfX5r/lj
         8tMA==
X-Gm-Message-State: APjAAAV5s6O+Algu78hE0dsm/uvrntndWvEMxP0eHxkvRMlvGgsXYEw7
        vnnVs1lRkGp3jgZebOvEpwk=
X-Google-Smtp-Source: APXvYqyhkgR8Jr9cXHXPtnYW3hOY72e00pv60cs92UKVdLi5fDqExvtE7bFVHMBDyv8MDfDVzey+8A==
X-Received: by 2002:ac8:604:: with SMTP id d4mr4028676qth.303.1576701611570;
        Wed, 18 Dec 2019 12:40:11 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t7sm993347qkm.136.2019.12.18.12.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 12:40:11 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 09/24] arch/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 15:39:47 -0500
Message-Id: <20191218204002.30512-10-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218204002.30512-1-nivedita@alum.mit.edu>
References: <20191218204002.30512-1-nivedita@alum.mit.edu>
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
 arch/ia64/kernel/setup.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
index c49fcef754de..4009383453f7 100644
--- a/arch/ia64/kernel/setup.c
+++ b/arch/ia64/kernel/setup.c
@@ -608,9 +608,6 @@ setup_arch (char **cmdline_p)
 
 #ifdef CONFIG_VT
 	if (!conswitchp) {
-# if defined(CONFIG_DUMMY_CONSOLE)
-		conswitchp = &dummy_con;
-# endif
 # if defined(CONFIG_VGA_CONSOLE)
 		/*
 		 * Non-legacy systems may route legacy VGA MMIO range to system
-- 
2.24.1

