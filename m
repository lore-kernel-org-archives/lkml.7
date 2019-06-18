Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFE0C31E5C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 02:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ECA32085A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 02:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuXeWKdL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbfFRCDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 22:03:25 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35751 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfFRCDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 22:03:24 -0400
Received: by mail-ed1-f66.google.com with SMTP id p26so19136437edr.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 19:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9rGyx5MyzqUL3hNOygIg5vXHZRw+5lYUo6VLZDjttNw=;
        b=FuXeWKdL8BGiWJGtyC1PFvRLq9ViMtGSDNMZ/pJDkbqRcio+YVUMdElG6Di7415wdI
         qfxUDnvTcOB6yhMLtyTaser6XGh1uusGV61345rBFjLQ0KP+UxI/IDjZhffIDwigL2VK
         krtnJwix6O7swFlFuLZ9mRI4+x9V0p39n9DPsp3m6kCuNtmufnm+TQnpYJm1YFIJrlwS
         wDuUPeyHGNFoBu5f5zUOODtc1W0httU5ogD0rYvWMSRIKmC5oHgPbkWabGogSgAZYqmg
         yG8JriQByBXHNBj/jg6nC+hV7bEMmt5qqvXWnrjiFgT4ogF4ukZmrE8Iucvh/ROy+n4M
         W10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9rGyx5MyzqUL3hNOygIg5vXHZRw+5lYUo6VLZDjttNw=;
        b=OBC7ejJGVfRh/QZlJt2eR1jmsnaKmFu+nfGHgYKZqBPbbE4pLvCEUldLGwa31lGaE/
         +lSeUUQ3YK9JhapfXzx8GHTk6kq0hqqbV3O5OlRj8SgobvtL5pl4nEhlydr0OdpcQWkT
         55A+LryDtTMBO3di77II8eyo2hpHOJRA7YkehFT8FLgCK28vdQa99LTmFxpkLqnueWL1
         7k5PFJgk1dmZNtN3R8Ss7Elci3SeWSBNhkZ9G0feHiyI6nAcRF3SqqrolS1c7uhRgLKG
         nbH39YQ4p24sQODpQoc2GOYsru2HhRDjI/3HOrwNnVgfVRPmhH2GDguytkqav7Jr6uaC
         vHhg==
X-Gm-Message-State: APjAAAU5cgbFERaWZLj3tsptEPmwbcMv5PYPn+JNr1sJ930r4HjEym1D
        /awUPreRQlayRHkvKXyVNvQ=
X-Google-Smtp-Source: APXvYqzDHRpAsPfkhKUBRLTrZfx0UP4jc2Zkvevn7yj3F7lbulQ9X6QesXd9j9EMj7CbXGXPKAwt3g==
X-Received: by 2002:a17:906:52d8:: with SMTP id w24mr81993966ejn.269.1560823402807;
        Mon, 17 Jun 2019 19:03:22 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id m3sm4052155edi.33.2019.06.17.19.03.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 19:03:22 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH] ARM: iop13xx: Simplify iop13xx_atu{e,x}_pci_status checks
Date:   Mon, 17 Jun 2019 19:03:07 -0700
Message-Id: <20190618020307.50917-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang warns:

arch/arm/mach-iop13xx/pci.c:292:7: warning: logical not is only applied
to the left hand side of this comparison [-Wlogical-not-parentheses]
                if (!iop13xx_atux_pci_status(1) == 0)
                    ^                           ~~
arch/arm/mach-iop13xx/pci.c:439:7: warning: logical not is only applied
to the left hand side of this comparison [-Wlogical-not-parentheses]
                if (!iop13xx_atue_pci_status(1) == 0)
                    ^                           ~~

!func() == 0 is equivalent to func(), which clears up this warning and
makes the code more readable.

Link: https://github.com/ClangBuiltLinux/linux/issues/543
Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/arm/mach-iop13xx/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-iop13xx/pci.c b/arch/arm/mach-iop13xx/pci.c
index 46ea06e906cc..94d30bc7bba1 100644
--- a/arch/arm/mach-iop13xx/pci.c
+++ b/arch/arm/mach-iop13xx/pci.c
@@ -289,7 +289,7 @@ iop13xx_atux_write_config(struct pci_bus *bus, unsigned int devfn, int where,
 
 	if (size != 4) {
 		val = iop13xx_atux_read(addr);
-		if (!iop13xx_atux_pci_status(1) == 0)
+		if (iop13xx_atux_pci_status(1))
 			return PCIBIOS_SUCCESSFUL;
 
 		where = (where & 3) * 8;
@@ -436,7 +436,7 @@ iop13xx_atue_write_config(struct pci_bus *bus, unsigned int devfn, int where,
 
 	if (size != 4) {
 		val = iop13xx_atue_read(addr);
-		if (!iop13xx_atue_pci_status(1) == 0)
+		if (iop13xx_atue_pci_status(1))
 			return PCIBIOS_SUCCESSFUL;
 
 		where = (where & 3) * 8;
-- 
2.22.0

