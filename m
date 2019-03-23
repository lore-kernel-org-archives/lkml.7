Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC854C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 12:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7074A218A5
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 12:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ogGe84yo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfCWLz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 07:55:27 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42828 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfCWLz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 07:55:27 -0400
Received: by mail-pf1-f195.google.com with SMTP id r15so3267987pfn.9
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 04:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RlESmpsv2ljhB9iO6xOQeyqU82KV0cG5xI4JL4KTXiI=;
        b=ogGe84yoDt5u8+x90FaBvd4qu7mqWa8zswn9Mq5tyUb6EoILLjOUveLA0K6GE5qA5Z
         0jZVbBEJIjrl82V7/DBy43HMQvjne9szUt8heQgiv/yneHvHTiC2uLoKYMzsZe5uiWJC
         HvFnOo4x6h+bq9pYambTbdw6lHy0675ZuC0n/tjYmLXakf81ayjyOKq86DQF4gsJP3V8
         7tFlnRAzk4+gUEuRc3i+JrK/NaZeRR4p5qV+NbtOZP1URxW2Goi/3i/ZbMwwVh0oPo6p
         Q/6Wrk2OzALAiHoVpE1he4PdCfZWtUp1WVs5si2yVxBsh28jX5vA2hTb7L5e1rD++b2Z
         GQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RlESmpsv2ljhB9iO6xOQeyqU82KV0cG5xI4JL4KTXiI=;
        b=QZj5Xp21V4mniWNczSOpkXTBXgeMbj8BX3vL+0Ly+P0yDdkJopZakvsO1zwMqLZxv7
         kybkjGqKKZKo/4aKoOurbgbs730ecz9JkYD0Eil06KLRrfmNJJJ40ZjceI1AoUpKXuvC
         0Yi3n8L+pqZziXYC/ExbE1YBx4xc8N0Y7C9L+cwBE2wkJLVAfsQQTLiFcAVCgTtNJ/xq
         T0yMeDSIRdyDZ9CEDuQT0FGYxeii8hSpS4e+7npvaLCOlaSNogDbCmQxQOWpjfcpgxLA
         n9u2W7ROEPeTzFEczneeeI+B/2M2ltb+XA5WWCw7nqkQfduY6gDDtcLEC6sTKtc09mE/
         a5lA==
X-Gm-Message-State: APjAAAWwH/OZgCeEZJZQTSvjlbPDB03BAiyEfnT3NdDnNMC1Q7aCbSlS
        UklHiqrgq8kZs2+w6tzU/+o=
X-Google-Smtp-Source: APXvYqwSXXT/Qp3cWkfUaKMBEhtCD9u2FGzm4eUN8iTznVUnELZrXdS65ZpQwERo8yu4y/hOHjlS4Q==
X-Received: by 2002:a17:902:a714:: with SMTP id w20mr14913166plq.331.1553342126722;
        Sat, 23 Mar 2019 04:55:26 -0700 (PDT)
Received: from CentOS76.localdomain.localdomain ([49.205.222.128])
        by smtp.gmail.com with ESMTPSA id 14sm17185064pft.137.2019.03.23.04.55.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 04:55:25 -0700 (PDT)
From:   jagdsh.linux@gmail.com
To:     guoren@kernel.org, paul.burton@mips.com, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org,
        Jagadeesh Pagadala <jagdsh.linux@gmail.com>
Subject: [PATCH] arch:csky:mm/fault.c : Remove duplicate header
Date:   Sat, 23 Mar 2019 17:25:17 +0530
Message-Id: <1553342117-29968-1-git-send-email-jagdsh.linux@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>

Remove duplicate header which is included twice.

Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
---
 arch/csky/mm/fault.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
index d6f4b66..e1725f8 100644
--- a/arch/csky/mm/fault.c
+++ b/arch/csky/mm/fault.c
@@ -15,7 +15,6 @@
 #include <linux/smp.h>
 #include <linux/version.h>
 #include <linux/vt_kern.h>
-#include <linux/kernel.h>
 #include <linux/extable.h>
 #include <linux/uaccess.h>
 
-- 
1.8.3.1

