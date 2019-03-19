Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D59EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B95920700
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Slkwqg7f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfCSCUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:20:06 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:54000 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfCSCUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 22:20:06 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 93440A17
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 02:20:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id t4QjWDyWUGax for <linux-kernel@vger.kernel.org>;
        Mon, 18 Mar 2019 21:20:04 -0500 (CDT)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 587A2B1F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 21:20:04 -0500 (CDT)
Received: by mail-it1-f198.google.com with SMTP id j18so16240992itl.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 19:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=9W52cXT2P/upkKG0T45kqWWLssbY/hTBA2QeHMIJ5hA=;
        b=Slkwqg7fWvGHQB0WemSu/3j+mZLmrmKFtl0t5l4jQSgAtRZslQ1AHNUbS5cttxl9Wh
         3qvyKVOI2Sirg/RrfhPybkbFN14ogBGjV3G3Rq72029GQV4sQuBU2Wb6xaQjGbWe4lec
         M42LfUmb7tq0ciN7ksP7PjMzVgINgne7uDWKbNEwQJxZ7PpQw9TiQSjkN4q0Ka1bSkzA
         ayxD9qkO50llpOvCW+9Iv6SpoOfnSDiKElJzlHe85BAjFegeyP5FIMMDDVUKHUYAqzKu
         twp4uTsSYXqknDjxeMbKCEU/DhVERTFkNS7SlsqXItgcEJR+m+9Tt7EdroQwek99FiAG
         mu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9W52cXT2P/upkKG0T45kqWWLssbY/hTBA2QeHMIJ5hA=;
        b=X3xBxkDGDHdZ6rJzqgF4bm2KKOZGD7oJmeLltEG1rJb/YtMlxoCiBp0MfX9hl28m33
         3FE9CMsvh2mhoFx6t8e7K+90ifsRB9+jbxDD8vVRpj7HA1C/4KJ91xR7fo4qPlHn/yXL
         42hcmYBr0aDsPZNIVrTu+48Uo1OHtqXvb5QljvKcX6y+PFTvD4InChi9TdXh/QlNKG9N
         gNCDYkitAo+vEJ3Ilt/Mnx11UJSpF608ZOkC9oSoFP+3zJfgH+zjBIAUyeVTcQddKT/a
         pWzH4qktf2lFEp4rp3NekSLgOsvbu1AwXhJLiBfZASqRvWUayiqJvVIp1JZe5xsJoiCH
         Rukw==
X-Gm-Message-State: APjAAAX7sVPnYZaKldqZMe7IBezjT/yEVjwtmLN0J1P8y33CFEWLI1jD
        HLulrjcfQ4MOjASOikLRzWyXwvrN7aex7xykP9MU15eQDxVWjRV/LmCHPhVB5esw9u8MeXx2gZi
        9xoafoVHr6BKPdxPmw3gNpr+j2sNw
X-Received: by 2002:a5e:950f:: with SMTP id r15mr37362ioj.88.1552962003975;
        Mon, 18 Mar 2019 19:20:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx+0uNJVInI0ew+Mgf4ttEth9kcjD0Bq+1zeLTo661Aj3GZ65H0z6eGee9caQgj3Ok2OxB2VA==
X-Received: by 2002:a5e:950f:: with SMTP id r15mr37347ioj.88.1552962003767;
        Mon, 18 Mar 2019 19:20:03 -0700 (PDT)
Received: from lenovo-1.hsd1.mn.comcast.net (c-73-242-25-233.hsd1.mn.comcast.net. [73.242.25.233])
        by smtp.googlemail.com with ESMTPSA id v133sm346065ita.2.2019.03.18.19.20.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 19:20:03 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Kees Cook <keescook@chromium.org>,
        Joe Perches <joe@perches.com>,
        Nicolai Stange <nstange@suse.de>,
        Roland Dreier <roland@purestorage.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86: hpet: Fix to avoid potential NULL pointer dereference
Date:   Mon, 18 Mar 2019 21:19:56 -0500
Message-Id: <20190319021958.17275-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hpet_virt_address may be NULL when ioremap_nocache fails. The patch
checks for such a scenario and avoids NULL pointer dereference.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 arch/x86/kernel/hpet.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index dfd3aca82c61..fb32925a2e62 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -905,6 +905,8 @@ int __init hpet_enable(void)
 		return 0;
 
 	hpet_set_mapping();
+	if (!hpet_virt_address)
+		return 0;
 
 	/*
 	 * Read the period and check for a sane value:
-- 
2.17.1

