Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8EAC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 00:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B200221734
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 00:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=utam0k-jp.20150623.gappssmtp.com header.i=@utam0k-jp.20150623.gappssmtp.com header.b="YEwHNXJS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfGXAWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 20:22:42 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39337 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfGXAWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 20:22:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id u17so20228507pgi.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 17:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=utam0k-jp.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=uHxS5AMH+Wz69m/TIgooeYligyzUaqkm/QtujdnH6do=;
        b=YEwHNXJSv9fvlWnjgCDA5uFHgdFZxDvSS1DDFSOl4HJFyno/2j6CiJmxUKuFq2l8Lj
         XoKQfFRI/G+YVjvT2zAdopCq7tlf2gGub7ef3kCGd+XhdM5C3al5pQAkCbde5vxvvBGO
         dcUKsGgqMNI6ytAlYMezqw23QIEwMxHHfjS1CxuFN7BgfbBByJDW/lrbpfA/PzmZ6isY
         oiVLo+hQxUwr7Ayi1Uj6jH+jeqp/43HL/kFZvfp/1NeButXeejkr4B4smuGEFfDohHKo
         f2rdn5ucmI8vR7/agT8nNPzoAL4s60VmTU3nNzNIjrjkvXqlCfNlCTtR7ZQ/KIZYnB5M
         33DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uHxS5AMH+Wz69m/TIgooeYligyzUaqkm/QtujdnH6do=;
        b=Z1K8TfNYe19VITNzhNoUXu5LmTMEzUjzbwEAuUC2HmJuplgJqXetddk50gqo7JjxyL
         rLUID670gLcJbM3GSJMiTXHMlfkB6TnbPbo/V08UPIGLZX+UlrlhocYzO2Mx8quUp3Ca
         HgRSrG0VwnskiqxsmdnjYzDPVXVYNAl/fcyxaHisWCqeflpGw9D18Ctx6FezlAi4F/ZH
         j2hRf5cCyWPDdsnqBiGHLTpnHKQQcEaSay6hUOBkUFXGv3BMn0+b/VmCRq7dX1Ec352A
         ouRhYvGVcByOOuRSCaxTBsNEl++Vm0DG3g78z1rsKbrTZUDhtrXEqi61hEt94T6oW09H
         0pzw==
X-Gm-Message-State: APjAAAUESgQkMf688zFLcCInRGu3wH98scOLG0c76INJeQFomNlLCerl
        /95DXOg/cGMSVvsu2dwHAqG90GwD1jBmEmo8
X-Google-Smtp-Source: APXvYqzBpGunOYr0AMfKw4sAzDjJI1QnTaUwMrlTUn9eDUDVXxl3ptxLTxzCdvp7MgVdSvZLac9hRQ==
X-Received: by 2002:a63:ff65:: with SMTP id s37mr37336173pgk.102.1563927761125;
        Tue, 23 Jul 2019 17:22:41 -0700 (PDT)
Received: from localhost.localdomain (124x37x165x227.ap124.ftth.ucom.ne.jp. [124.37.165.227])
        by smtp.gmail.com with ESMTPSA id f72sm64651906pjg.10.2019.07.23.17.22.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 17:22:40 -0700 (PDT)
From:   Toru Komatsu <k0ma@utam0k.jp>
To:     linux-kernel@vger.kernel.org
Cc:     yamada.masahiro@socionext.com, clang-built-linux@googlegroups.com,
        ndesaulniers@google.com, Toru Komatsu <k0ma@utam0k.jp>
Subject: [PATCH v2] .gitignore: Add compilation database file
Date:   Wed, 24 Jul 2019 09:22:33 +0900
Message-Id: <20190724002233.9813-1-k0ma@utam0k.jp>
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
index 8f5422cba6e2..2030c7a4d2f8 100644
--- a/.gitignore
+++ b/.gitignore
@@ -142,3 +142,6 @@ x509.genkey
 
 # Kdevelop4
 *.kdev4
+
+# Clang's compilation database file
+/compile_commands.json
-- 
2.17.1

