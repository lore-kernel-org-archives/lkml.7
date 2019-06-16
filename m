Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B0EC31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 14:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4727920870
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 14:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8AS+ePD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfFPOME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 10:12:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33593 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfFPOME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 10:12:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id k187so4293510pga.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 07:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=2yTMoNXKzXMWdudb1PzOAnHo6IMVaDeOAaH4Nko8H6w=;
        b=N8AS+ePDA+KF6qhqx3QAjXOGfTCQre7kXYW15czLhbwLW//VoplpVkaviQhzX5/7hv
         f5aBAYZAb1Zlh3zVZJ5EAFB0qjMkszODLHkohNcddJ+6zT8umAm5g/SdlFPz4fIhTsqs
         ZDg+VSVNLe3/LYewGzw3zDszbNe+67f+jAANspx9BPLnKJvfyj18GnZlMjxqDapne8Q8
         Rh166a4E6HshSfNWSlC1rCMStM5KbaCPD/t4qEcUrNG1Z6pZg9+8Hqxx6PwmANjq72xg
         qOD6dNeMruNv2B1CdgV6J532k3H8jVrwE/gfvly4aYfjjUwHWmXxKTo6J5zTzNltNweU
         yb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=2yTMoNXKzXMWdudb1PzOAnHo6IMVaDeOAaH4Nko8H6w=;
        b=FFN7uEZ7NNcx86NUz9mM0B3oeVqp9F7wo4ImC8dqxGxNBlWiNQdSIDlNpCEEUnEb6q
         D6KJ9crU8zXqIz8xCNTHux+NGHBxH7s5d+lgL0+IgnzSzyHBDpeAgw1jvlrk5glT/MDy
         2uxvsZx7o/vDXutKP22Y1WR/gZm5ErSsSGNoNRL8/PkISRvno+fwqD9iYVng9L8s7rBo
         Z2zzXk/V+xlSxKiMsAfUR7yepLmN/bM0AYvSIWJQGPh475dHv2VSCJgKMTYAXntJj0Gp
         kmLtR8nzLViufloGpguq7oXTxGJeq+vaNtTzRQc0otc6yxTnOJCcT1yauesW8DFHxaZq
         IAow==
X-Gm-Message-State: APjAAAUJjXZ7BJWmj1Yhf1r9RAoLKPhPhZKbo2db1IhLSJoYpsnkMCHK
        Xr6KU6xiP03JJXh/onrGri8=
X-Google-Smtp-Source: APXvYqyPTT3jKxvMrCABytIVzOTFeK2fIbZALHPVJmo8opcf8A6W+9z22enuomkAeRtPGDHkGNr5fQ==
X-Received: by 2002:a62:1a8e:: with SMTP id a136mr70251031pfa.22.1560694323768;
        Sun, 16 Jun 2019 07:12:03 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a3sm9237771pfi.63.2019.06.16.07.12.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jun 2019 07:12:03 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Cc:     linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] xtensa/PCI: Remove unused variable
Date:   Sun, 16 Jun 2019 07:12:01 -0700
Message-Id: <1560694321-31380-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc reports:

arch/xtensa/kernel/pci.c:40:32: warning:
	'pci_ctrl_tail' defined but not used

which is indeed the case.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/xtensa/kernel/pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/xtensa/kernel/pci.c b/arch/xtensa/kernel/pci.c
index 8b823f94e568..e0235e34e1ba 100644
--- a/arch/xtensa/kernel/pci.c
+++ b/arch/xtensa/kernel/pci.c
@@ -37,7 +37,6 @@
  */
 
 static struct pci_controller *pci_ctrl_head;
-static struct pci_controller **pci_ctrl_tail = &pci_ctrl_head;
 
 static int pci_bus_count;
 
-- 
2.7.4

