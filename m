Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB07FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 14:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A83420659
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 14:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fj1xYv2Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfKHOOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 09:14:00 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:41960 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfKHON7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 09:13:59 -0500
Received: by mail-pf1-f202.google.com with SMTP id j2so5040150pfa.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 06:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=kvgCLct7rYR3LjviNWyKbkLaMi+v4J1t5e+g4Yg8dBw=;
        b=fj1xYv2YIp+6FKUgb9IjR8d45c21xEvKM//6IKKFbj62T3JCHayAL+rKMP8MbJT7VY
         Wcgl6NNb3zf8BoTYsT8kG0bomi1igkS9HrByHZ5IgANW14yHoFHuji2q8589jbuKR7el
         tRyzxfYa8bNTzXFssUr3uNFx8fMEHE7PFkDYQbjwLdtGMfNmcBuF6+vEQMLQ/qKMWKIe
         ltbTnDUOloCrjecz2IakZnAA5ORdF7Dv9MDL7E6L7Bpaowl437bPyA6zy3cqSiDVJf8E
         Pfr8MobtKN6Y+1v1Qa5aTew5BaVMSj43pOEtq68mdNR8/c4NaMCXmiUTZ+WlOUmNcgTz
         CLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=kvgCLct7rYR3LjviNWyKbkLaMi+v4J1t5e+g4Yg8dBw=;
        b=jmQT7z2E74V5S8b/6uJHqkrM/LC9WMRDTwtClIMVgeX9ic2eTsSglZp5WLBmnqr1bm
         jf/fWMlrHyDtSii+U8E6wk+baPeebbgEZhajZJm0iXTgSudDY9w889Axe3aCmf4UC6T/
         MH78V+CwJBXf0kTFnCwm6ugFASuow9kzlHT/lK1Fk7XQJWAk1gnuxk9l458AHMaB0BBF
         a1Upvs2x73QkGoNwT4h/Z8TaqH6rdkhHCT3YahtUbt4GvyJPa8Z7v5xVWErcbI9G/5Vy
         JLjAggyycOswN/1kLbENvTJQK1i93k1WlI3SCnk7tEwLTgR3TOuMDZbG1B7c6jma1lt4
         puRA==
X-Gm-Message-State: APjAAAXiXYoScs//IGWRta8acI/T2/v3yKXu6Kzl7wNOa3luzAnVEOyj
        8JlEDSdwOgkp/Lh38rCwq1sgwk69NNPcGg==
X-Google-Smtp-Source: APXvYqxFBt6XH1gMUdr5UvZBnUd3gHu6PSrrU8imy14sIcyFWas9uy6U69tND+J6NhD4sOeXgc31jMonPkadIg==
X-Received: by 2002:a63:e801:: with SMTP id s1mr4537856pgh.213.1573222438819;
 Fri, 08 Nov 2019 06:13:58 -0800 (PST)
Date:   Fri,  8 Nov 2019 06:13:53 -0800
Message-Id: <20191108141353.193961-1-edumazet@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH] powerpc: add const qual to local_read() parameter
From:   Eric Dumazet <edumazet@google.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A patch in net-next triggered a compile error on powerpc.

This seems reasonable to relax powerpc local_read() requirements.

Fixes: 316580b69d0a ("u64_stats: provide u64_stats_t type")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: kbuild test robot <lkp@intel.com>
Cc:	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:	Paul Mackerras <paulus@samba.org>
Cc:	Michael Ellerman <mpe@ellerman.id.au>
Cc:	linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/include/asm/local.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/local.h b/arch/powerpc/include/asm/local.h
index fdd00939270bf08113b537a090d6a6e34a048361..bc4bd19b7fc235b80ec1132f44409b6fe1057975 100644
--- a/arch/powerpc/include/asm/local.h
+++ b/arch/powerpc/include/asm/local.h
@@ -17,7 +17,7 @@ typedef struct
 
 #define LOCAL_INIT(i)	{ (i) }
 
-static __inline__ long local_read(local_t *l)
+static __inline__ long local_read(const local_t *l)
 {
 	return READ_ONCE(l->v);
 }
-- 
2.24.0.432.g9d3f5f5b63-goog

