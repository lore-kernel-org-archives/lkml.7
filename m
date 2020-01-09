Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DA6C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BECC206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AsXwwFs6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733286AbgAIQI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:08:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24899 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729201AbgAIQI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:08:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578586136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nKlTXFTfOxenRUeVQ8l+ODGGfg+92uyxs/gH2lHca/E=;
        b=AsXwwFs6cwpZFPPEYlTXzyZKjxe+z4jcmj1WfnFs4stizlmB04nosat2pIiP5q0+el4bLs
        8vFlmu+gd8CySH2ZV07RCJfDBjl2Hc/5AvJnlA/J3NFegIfcUlJUyX71OJzfFI5thjqFDT
        XlhA6LQizEQ+n8FFhQwjt3SX3Kj9IFQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-ovdaeeBpP6Gr0TEfgEsAzw-1; Thu, 09 Jan 2020 11:08:55 -0500
X-MC-Unique: ovdaeeBpP6Gr0TEfgEsAzw-1
Received: by mail-wm1-f70.google.com with SMTP id p2so1105481wma.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:08:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nKlTXFTfOxenRUeVQ8l+ODGGfg+92uyxs/gH2lHca/E=;
        b=ezCC2pRCRNRujzTgH/Uj0Dnc1yeMm3mVl6wSrjdgu+SSHK5RZJ0fsNLSP2k0xK7UDm
         hN6bbETbyC76PImaWbVDx0MDjrk5404GhWs+vSv03/rpfccH38xxEWs8klHPDGQQNjyk
         xDJp6ZkXO+ekbm0XV8HkvXgRcpksHDnQ+AluetBv8juirtQPgs9y/qv/H0XozwhZj1ae
         AhH0uvP0nQwkcpbLUP9cMLd85XpHdTrBOtWMvC6KQsoc7g709gWIVjJj0T9BD+BtGq3M
         iRZpabn2RuqoaKj+r+fdnVnsiOWvjPGUSTYbOYj63KiRnkjTIKIPJNawVej65a/0R2KY
         f+Pw==
X-Gm-Message-State: APjAAAUa9ihT73uAwqPE0aVBlQsrT97qiwnZwz8v9sUVSgvQmPNtfUdl
        zAHBMPp4aYapMjeyZvYssCz9kRXrhl4n1cBVz+2ikusx39n5fxrVHSDLKma7uo0y4q0j8KrPquW
        rrg1eu3ErTbm0wGqNTswGUt5p
X-Received: by 2002:a05:600c:1050:: with SMTP id 16mr6102358wmx.20.1578586134582;
        Thu, 09 Jan 2020 08:08:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqw0602eGGyf/C/0ZAZHC7ZuC4fFVco9svxXb/Fu4KTSXEyS2X/xvzMklpTy/CP9FpmVgXMdeQ==
X-Received: by 2002:a05:600c:1050:: with SMTP id 16mr6102340wmx.20.1578586134441;
        Thu, 09 Jan 2020 08:08:54 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id v8sm8403505wrw.2.2020.01.09.08.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:08:53 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 45/57] objtool: arm64: Enable stack validation for arm64
Date:   Thu,  9 Jan 2020 16:02:48 +0000
Message-Id: <20200109160300.26150-46-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raphael Gault <raphael.gault@arm.com>

Add build option to run stack validation at compile time.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a7b2116d5d13..60a17af19aba 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -165,6 +165,7 @@ config ARM64
 	select HAVE_RCU_TABLE_FREE
 	select HAVE_RSEQ
 	select HAVE_STACKPROTECTOR
+	select HAVE_STACK_VALIDATION
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
-- 
2.21.0

