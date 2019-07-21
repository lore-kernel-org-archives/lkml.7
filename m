Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA61C76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 08:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE85206DD
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 08:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=utam0k-jp.20150623.gappssmtp.com header.i=@utam0k-jp.20150623.gappssmtp.com header.b="jZwGcCEV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfGUIyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 04:54:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46818 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfGUIyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 04:54:15 -0400
Received: by mail-pf1-f196.google.com with SMTP id c73so15952946pfb.13
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 01:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=utam0k-jp.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=V9yPYUFeJ7DKQ9cJ8nNTZGwsCUGiBz+5nuXCYu0lOO0=;
        b=jZwGcCEVUoizg9W4+RIJUKDwS4OCd6xsGucJk50KXDpevy3cIP5ga7qdnAUTQNYeyp
         upsnvJfu41yFqIEPSRKNKceRUIL2iHWUb7S2VdRrwnF73lEQTFiQ48nKHP2uTYrG/gUY
         QMQEInFMQ0OwU3Q+IzbO8/qFWj/5VkTNRMg/x/BA336degHO3rATFMNdKaKzaSdEk+Mh
         hJvaX94FjBWFv6uxOHtU5vIP9HGeJu4InsrwZLCvJfGrNaxJ9bTTabpUkF7wXoNUgjyW
         1p57dfVwdi0ngOUiwQNfl6KuV4ELHvGYSx4vP46LOEnpMBEVwzTAE0+OL3EFxZcdxqI9
         AKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=V9yPYUFeJ7DKQ9cJ8nNTZGwsCUGiBz+5nuXCYu0lOO0=;
        b=qUXG9aK1Zi3PTbSdzM+KTE93SwKTJr5NtcTnx5d3xWjaw3z5jovCHN+5iM4s6DaEHB
         Dmam4GO1pXWMOVubEkMQ3YqdmX5f7qRTM6MxEqaK4kDjEd7nAzwZF5oCVCC6guOjTEHl
         tY/xagyXtZ11y/pyD/o+nB1eIPm0gQ2CymTGqlk/Cve3IoH5vXIuKn3JuOr/iNs2E5u8
         8eNzqW7HxS4N41uA81GswNs/durFJZqJaTw8VOsJs05E2Vlq27AtDqR0F74dHjezbE9p
         cDDRzeYjRJseegZF9Q3n+TH6aGTtyhzBWastbAOlwb97w4KazIFXnj80mVU9msUaLqir
         8xXQ==
X-Gm-Message-State: APjAAAXpxi1RGqndxRmHlmF+STJYCMM9YO4CMQZS2eb8HuCkWqN+qZ4L
        FPuqKrQ5JkOGPdp1XQKKsYVg/quISzeZZQ==
X-Google-Smtp-Source: APXvYqwZYUsbj8s8fxcoULAWSIRI7vWq1NQL1sBfeCZOQj3jgRLd+UKpj+6pwnFM/Y7ClQ6zV9wdeQ==
X-Received: by 2002:a17:90a:2768:: with SMTP id o95mr69971094pje.37.1563699254413;
        Sun, 21 Jul 2019 01:54:14 -0700 (PDT)
Received: from localhost.localdomain (124x37x165x227.ap124.ftth.ucom.ne.jp. [124.37.165.227])
        by smtp.gmail.com with ESMTPSA id v13sm44051653pfe.105.2019.07.21.01.54.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 21 Jul 2019 01:54:13 -0700 (PDT)
From:   Toru Komatsu <k0ma@utam0k.jp>
To:     linux-kernel@vger.kernel.org
Cc:     yamada.masahiro@socionext.com, clang-built-linux@googlegroups.com,
        Toru Komatsu <k0ma@utam0k.jp>
Subject: [PATCH] .gitignore: Add compilation database files
Date:   Sun, 21 Jul 2019 17:54:09 +0900
Message-Id: <20190721085409.24499-1-k0ma@utam0k.jp>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file is used by clangd to use language server protocol.
It can be generated at each compile using scripts/gen_compile_commands.py.
Therefore it is different depending on the environment and should be
ignored.

Signed-off-by: Toru Komatsu <k0ma@utam0k.jp>
---
 .gitignore | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitignore b/.gitignore
index 8f5422cba6e2..025d887f64f1 100644
--- a/.gitignore
+++ b/.gitignore
@@ -142,3 +142,6 @@ x509.genkey
 
 # Kdevelop4
 *.kdev4
+
+# Clang's compilation database files
+/compile_commands.json
-- 
2.17.1

