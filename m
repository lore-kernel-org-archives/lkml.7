Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B306CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74282222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UJ9qXKVQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504988AbfJRII5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 04:08:57 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:40817 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504975AbfJRIIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:08:54 -0400
Received: by mail-il1-f196.google.com with SMTP id o16so4730698ilq.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 01:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JHZwkf7dJQb2ueiE6rWLqpiW0jn7hN3I7C8kvdgIRA4=;
        b=UJ9qXKVQp7oql8AsQGguKjXwT+hTgLgDIaxyocAICcWHqufSo5Rl6505mDxQF976/s
         JKA/0J3m3ItmfvNsvc4uMXi+eAYwwnCc7zOHv9Rr6YTiH62/vznrFmuwEbsJo5uV2vIn
         0dDo/aPaJ/LXpDH9AfPOZrlHCbFOhEwP3NO2XGxuTaI0D+rz4zlV9iEEb1frmiUqzPCH
         iBysNeitcop6mNpjpejximJj50shmGyWN24oSn20H9EwULK0nC3f7IxB89hS9ffBMjpS
         jwZi01tMUlo+Uo50Ly0E2Xyo2MJsgKbdPearbArqq55ymINO2jCJGEO6VZ9PDDNK3LvK
         8YYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JHZwkf7dJQb2ueiE6rWLqpiW0jn7hN3I7C8kvdgIRA4=;
        b=gQjiDra0ZHISAYNgq3wD2ceWGvvJAG8nSF3elgeE/LjMIUJ96V/CAsYSP6JdE23MOp
         XUdDlIFvDwE53ypcMhmf6TRbcbdG5mQmcFO0uiKdROyaWwvomtMfyo00mJFRh0ULryQ0
         zRQGMmuP+bbMutT85lhV8Yt7jpDGiAE0dfiezepaW2ZGub7uR3xExO5QdtURQTNQ6aGo
         bOfUZducWV3NdNRcUYIurIaUrP9Pf2JwZCgiec+DwhPMpR8mpr4dSIa6QpA4CnUL7Z1I
         GCfT604zwgMVzK7K6xRoCfPNRGwj9bhOmZG1V555u6NLeBlscJQT/kNtVM1e1OlVYk5Q
         teMA==
X-Gm-Message-State: APjAAAVIhCAt93L42xGD+z6We0UodR079SGm8fNQLLeoFpdKB0EyMhTT
        g0WV2wUM1IRBz4uDxZdDnkH5rgwHqFE=
X-Google-Smtp-Source: APXvYqypnTHKh+VT4ykjNOiCGrkCEsaEqLiYx6kyKUi/C2fkT1SJiPurMENiBjDLOPtFVR6QBRrW7A==
X-Received: by 2002:a92:1507:: with SMTP id v7mr8013435ilk.37.1571386134093;
        Fri, 18 Oct 2019 01:08:54 -0700 (PDT)
Received: from viisi.Home ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id z86sm2121026ilf.73.2019.10.18.01.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 01:08:53 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 3/8] riscv: init: merge split string literals in preprocessor directive
Date:   Fri, 18 Oct 2019 01:08:36 -0700
Message-Id: <20191018080841.26712-4-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191018080841.26712-1-paul.walmsley@sifive.com>
References: <20191018080841.26712-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparse complains loudly when string literals associated with
preprocessor directives are split into multiple, separately quoted
strings across different lines:

arch/riscv/mm/init.c:341:9: error: Expected ; at the end of type declaration
arch/riscv/mm/init.c:341:9: error: got "not use absolute addressing."
arch/riscv/mm/init.c:358:9: error: Trying to use reserved word 'do' as identifier
arch/riscv/mm/init.c:358:9: error: Expected ; at end of declaration
[ ... ]

Existing Linux practice is simply to use a single long line.  So, fix
by concatenating the strings.

This patch should have no functional impact.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Link: https://lore.kernel.org/linux-riscv/CAAhSdy2nX2LwEEAZuMtW_ByGTkHO6KaUEvVxRnba_ENEjmFayQ@mail.gmail.com/T/#mc1a58bc864f71278123d19a7abc083a9c8e37033
---
 arch/riscv/mm/init.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index fa8748a74414..fe68e94ea946 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -339,8 +339,7 @@ static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t size)
  */
 
 #ifndef __riscv_cmodel_medany
-#error "setup_vm() is called from head.S before relocate so it should "
-	"not use absolute addressing."
+#error "setup_vm() is called from head.S before relocate so it should not use absolute addressing."
 #endif
 
 asmlinkage void __init setup_vm(uintptr_t dtb_pa)
-- 
2.23.0

