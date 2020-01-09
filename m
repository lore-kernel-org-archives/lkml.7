Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55240C33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B86B20721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DXCePTCW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732837AbgAIQDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:03:21 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25934 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732830AbgAIQDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:03:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578585799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IEmOZ+3NX8EHnBrXs7JpcZGqiWky8RDzrGpjGW3JhOk=;
        b=DXCePTCWInDtAxsKhXGtfOlVWTgK8CsFnNwGv8PdBMrdqlO43gk59ESidIZCOC4KZ285RK
        EuR7cprxUeM3UW6epbHV6aSPYQwX4swFrfm+HbdIufoaB2n4RUCE5sxwVWkGky8T1D6SmL
        RadKqu7KAyGS7pDD+U647XLSygjPWiA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-xvrP_q_nMJ-feEtbshWW6A-1; Thu, 09 Jan 2020 11:03:17 -0500
X-MC-Unique: xvrP_q_nMJ-feEtbshWW6A-1
Received: by mail-wr1-f72.google.com with SMTP id v17so3033461wrm.17
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:03:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IEmOZ+3NX8EHnBrXs7JpcZGqiWky8RDzrGpjGW3JhOk=;
        b=bbs8hKrIzyvPRU7Ip3cAGiTSPg4B1bzmrNRXdtnwPjqMLI5QTW9LJbZ9NLfiwkhd2U
         nbZSPptbcyWn4chcmcPei/6jsdyXGD+rlfiBjSZtzvUxEbY/ON881dKJPsiUDm88zh8X
         WW+NdinvfBdYdKc8rGIwupAepWATwG06B/e8gWSwnZ2YtqUpwjVNPEM+qo5ZYYoezSiZ
         tl0z6bYsEyKwEyDjXB31vb4cxnzicrzSFw97SueLSX/H7AFv0L90+VllT+14CZ/TF4Tk
         dbm7OLeC9meoBcqeIVy9wnQrmdD5o+FQTgXaic1+0gE71k1aYvAso1usMYbWVZnv1MsY
         bvig==
X-Gm-Message-State: APjAAAXmIGV41/Bp1ycfF4HcpXvflmm5BL/GjhJEgp7my7dmB5kYiJx8
        tqhrgxWhU8f2DiBwKm6H0vgVTiZYaHgZ/EBJkTUfzzdfaEfgp8S0/CIQQS1KGRBWdKh8n/qAUed
        I2dgULSGK6M+euP8GPBXWf8r3
X-Received: by 2002:adf:806e:: with SMTP id 101mr12284641wrk.300.1578585795601;
        Thu, 09 Jan 2020 08:03:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqxhJw7oN3KdrwJWeebHQd7OtKE/MeC5SWWnNta8sWE9upFVwuTQwP5gOrTZf1dc7nb4l3igCQ==
X-Received: by 2002:adf:806e:: with SMTP id 101mr12284536wrk.300.1578585794619;
        Thu, 09 Jan 2020 08:03:14 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id z21sm3258969wml.5.2020.01.09.08.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:03:14 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 03/57] objtool: check: Use arch specific values in restore_reg()
Date:   Thu,  9 Jan 2020 16:02:06 +0000
Message-Id: <20200109160300.26150-4-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial register state is set up by arch specific code. Use the value
the arch code has set when restoring registers from the stack.

Suggested-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/check.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4784f0f6a3ae..5968e6f08891 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1437,8 +1437,8 @@ static void save_reg(struct insn_state *state, unsigned char reg, int base,
 
 static void restore_reg(struct insn_state *state, unsigned char reg)
 {
-	state->regs[reg].base = CFI_UNDEFINED;
-	state->regs[reg].offset = 0;
+	state->regs[reg].base = initial_func_cfi.regs[reg].base;
+	state->regs[reg].offset = initial_func_cfi.regs[reg].offset;
 }
 
 /*
-- 
2.21.0

