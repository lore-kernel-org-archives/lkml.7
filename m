Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3157EC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 23:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73783206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 23:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjvkBbhe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388924AbfIEX37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 19:29:59 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35018 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732754AbfIEX36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 19:29:58 -0400
Received: by mail-pf1-f193.google.com with SMTP id 205so2958327pfw.2;
        Thu, 05 Sep 2019 16:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=jtjFrbgie1B8vmotFZj58YoVLg9kCTIeE4Vs+aG5yy8=;
        b=GjvkBbheJ20Oy02sUV3saiUzVXZKKF1U3bWFaz0/bwYzSt5iLGyB5m54e4TlykmKzo
         9R+kTu2YK/dX8keMqxuC4k0rLU5EuyoWwd+CzHbi63GuS0IYBRZ7+TQ2BrieCyKMSjvh
         WPXo/Byln+FM4SQ70G1sW0jEK1/MTSCmBhYbqh7qdJBGxc0/8O38ZGbuI7heP/utaxKI
         Cz2flVZ0QavcT5olP8BXIBg8uj9iUMaPVy639ZwnYj+1YYhKFuhCUEML3tTJFnf3iaQL
         bGJIevkUPwyjxW/qGiWEVldVj2KL+ZLPNDOdMsT872DnDJsFHQBDMhZjPm4nW65VUCyv
         ek4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jtjFrbgie1B8vmotFZj58YoVLg9kCTIeE4Vs+aG5yy8=;
        b=U7KfonW/qKcw3T8tJDK49byclLmKf3lQ1K4e6sgNFWG38zJWaF/oHYtQk9uSVNVz6x
         lBiDd5C9kBa3qVPWkbOYy12CVGVqk1QG6KyERu6r8UlZNtj+unW1/ByznpLRq8KH0fSc
         hw9ZZo6CI5UorkMr07/yD5egLNc876yh/TDB8ENVhS8UYsu0TpY8PvEZirZf7ifO22x/
         zHVPJsUj3pUNg1FKe9hAC+rpZ0D/De6qCoKetrh4G0K2UIVYT7zIrF70Zup43J1tTkxD
         R785X+4jF/y5tMUmvlUn8K0UDyvG5AEe+g3g+fF++FhYKtn3HlygXf9cNOeoO5IYoJvr
         l6Qg==
X-Gm-Message-State: APjAAAWqxg7jSCqc+NWtk/PJ2MNt7WoOyZVT2r5aOJl8N+Ceb980B/fU
        jsSxVt7CJzz0CDyq/XfDWu0=
X-Google-Smtp-Source: APXvYqykDQgAMzPg7C//IqDAwj/aIIU2bV6z0vPnH6n0eclhrgVl5yyjHFf0Nj2yvspE2c57zxIrYg==
X-Received: by 2002:a17:90a:6302:: with SMTP id e2mr6578753pjj.34.1567726197490;
        Thu, 05 Sep 2019 16:29:57 -0700 (PDT)
Received: from LGEARND20B15 ([27.122.242.75])
        by smtp.gmail.com with ESMTPSA id v27sm8198814pgn.76.2019.09.05.16.29.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 16:29:57 -0700 (PDT)
Date:   Fri, 6 Sep 2019 08:29:51 +0900
From:   Austin Kim <austindh.kim@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org
Cc:     dvhart@infradead.org, andy@infradead.org, hpa@zytor.com,
        x86@kernel.org, gregkh@linuxfoundation.org, allison@lohutok.net,
        armijn@tjaldur.nl, kjlu@umn.edu,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/platform/uv: move kmalloc() NULL check routine
Message-ID: <20190905232951.GA28779@LGEARND20B15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The result of kmalloc should have been checked ahead of below statement:
	pqp = (struct bau_pq_entry *)vp;

Move BUG_ON(!vp) before above statement.

Signed-off-by: Austin Kim <austindh.kim@gmail.com>
---
 arch/x86/platform/uv/tlb_uv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/platform/uv/tlb_uv.c b/arch/x86/platform/uv/tlb_uv.c
index 20c389a..5f0a96bf 100644
--- a/arch/x86/platform/uv/tlb_uv.c
+++ b/arch/x86/platform/uv/tlb_uv.c
@@ -1804,9 +1804,9 @@ static void pq_init(int node, int pnode)
 
 	plsize = (DEST_Q_SIZE + 1) * sizeof(struct bau_pq_entry);
 	vp = kmalloc_node(plsize, GFP_KERNEL, node);
-	pqp = (struct bau_pq_entry *)vp;
-	BUG_ON(!pqp);
+	BUG_ON(!vp);
 
+	pqp = (struct bau_pq_entry *)vp;
 	cp = (char *)pqp + 31;
 	pqp = (struct bau_pq_entry *)(((unsigned long)cp >> 5) << 5);
 
-- 
2.6.2

