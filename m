Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F5BC4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 21:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766AB20656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 21:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eiq/zgNY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfF0VdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 17:33:24 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34399 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfF0VdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 17:33:23 -0400
Received: by mail-pg1-f196.google.com with SMTP id p10so1600651pgn.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 14:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PZGYipUyd0OlxHfS8UkofkYjMsM1+ZdDLnbfUznJ73w=;
        b=Eiq/zgNYvuYsTc+BJ/I589PAFh3f4hL6NiOSVV7grwZJde+ytgdcZiTW0oWETZLd0c
         z1PcdwG6kjRnYDdS+KZ6VCrPsag/QMseoN/R0VnAwUlUFpWcs9/kR/tDy/6I7U3a2g4H
         ki9zHH0wvDrf/VkRgAfOLiiz5Srl8uhUbpF42vU8gBbuPXEDwPHw6W5H+u2CYLmz9LTp
         IPGdhuUkeZZCQg1QSJDTpfb6ZILNraVHxGvFf1KYr7asBN9d6RqpYJ6E0CgmKYRa23wR
         PfHsEjo5h4M8ncI0HWqB81jd3PZ3DgseeNWy9lHHijRZvbQTBrEuriQa1wMVBhAPfMqQ
         1REA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PZGYipUyd0OlxHfS8UkofkYjMsM1+ZdDLnbfUznJ73w=;
        b=URmt3gVLYgIe/pQvlyUDepUxPRLDBnmmWJ7q4LcDPYg4urVrr6W6Np99s7JCkp1FOp
         RZoTfWDV8RPE30Sj7FI+pd88f85mydOuI4gGR0/2Si+aaoa30bpnwuFFnX7Ca13acva3
         sOJykA1hra71DJFTpeiu01fTf3TQIFEuoCf6TxVo3v4g4I0OA3F9yAsCwThvLrELJq4O
         X6UkcUMO8T4oE+1vdHPdfsa8cuc1HKqN/WltCtE19TrTDcxB8mxPx9u3UUv2bQbqr1hL
         8zXORYy7dCHOyRwIFPrRu6f0x+3q7Qp6HZuOsAm6uY8nmWgzZFF+14dut1kDjTT5y7Z7
         saRg==
X-Gm-Message-State: APjAAAUwluKXhHAqeBmTW1EhYn2hGOXwyarow9nEa2NhUue1VZKsgZqZ
        MCkHgm0VewHSDjtbDi7vTTVh+wqS
X-Google-Smtp-Source: APXvYqygAgpdlhMUf0iJGc41fnT4h96RI4dGVHLFQHhK06uF/Xp9dkOpgaUN+KTq57ZE5aV3XyAZ0g==
X-Received: by 2002:a63:1645:: with SMTP id 5mr5722563pgw.175.1561671203119;
        Thu, 27 Jun 2019 14:33:23 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id k197sm96223pgc.22.2019.06.27.14.33.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Jun 2019 14:33:22 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Laura Abbott <labbott@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Peng Fan <peng.fan@nxp.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, Doug Berger <opendmb@gmail.com>
Subject: [PATCH] ARM: mm: only adjust sections of valid mm structures
Date:   Thu, 27 Jun 2019 14:32:48 -0700
Message-Id: <1561671168-29896-1-git-send-email-opendmb@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A timing hazard exists when an early fork/exec thread begins
exiting and sets its mm pointer to NULL while a separate core
tries to update the section information.

This commit ensures that the mm pointer is not NULL before
setting its section parameters. The arguments provided by
commit 11ce4b33aedc ("ARM: 8672/1: mm: remove tasklist locking
from update_sections_early()") are equally valid for not
requiring grabbing the task_lock around this check.

Fixes: 08925c2f124f ("ARM: 8464/1: Update all mm structures with section adjustments")
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 arch/arm/mm/init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index be0b42937888..bdc70dff477b 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -616,7 +616,8 @@ static void update_sections_early(struct section_perm perms[], int n)
 		if (t->flags & PF_KTHREAD)
 			continue;
 		for_each_thread(t, s)
-			set_section_perms(perms, n, true, s->mm);
+			if (s->mm)
+				set_section_perms(perms, n, true, s->mm);
 	}
 	set_section_perms(perms, n, true, current->active_mm);
 	set_section_perms(perms, n, true, &init_mm);
-- 
2.7.4

