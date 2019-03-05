Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A39C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2708820675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="eVJQ7BLC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbfCEWRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 17:17:38 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:57056 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbfCEWRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 17:17:38 -0500
Received: from zyt.lan (unknown [IPv6:2a02:169:3465:0:5054:ff:fe4f:85bd])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id BE9695C08B1;
        Tue,  5 Mar 2019 23:17:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1551824256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p+eboShcgvztnnZso7ULbf4ZTfxu3Hs1q35ka2VmUpE=;
        b=eVJQ7BLCsz9I4ilF1ARylQYujjZmGeBWrNHc0cy95Q/0QmvhkpDdL0/qiQ66QXTmRXrwIy
        PwFkTDiXMZH77xAHNb2X2BJVUsAdFJxYWs8Avk0RwGaU35jnmUSPRbw4H4O/MtHty7+8ZD
        03w0jCImMh9RXrZpHQVErQDBdHMbvuY=
From:   Stefan Agner <stefan@agner.ch>
To:     linux@armlinux.org.uk
Cc:     will.deacon@arm.com, ndesaulniers@google.com,
        natechancellor@gmail.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
        nicolas.pitre@linaro.org, thierry.reding@gmail.com,
        julien.thierry@arm.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 2/2] ARM: drop -mauto-it
Date:   Tue,  5 Mar 2019 23:18:27 +0100
Message-Id: <7b70b64738db468ab3b830c503524058163b5c3f.1551824161.git.stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <13835555f8ef44b21d1b7ddfe1c4203d0981f77e.1551824161.git.stefan@agner.ch>
References: <13835555f8ef44b21d1b7ddfe1c4203d0981f77e.1551824161.git.stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The assembler option -mauto-it is no longer a valid option. It has
been removed from the documentation in July 2009, which is well
before the release date of the currently supported binutils version
2.20.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 9561325c5201..ebf67bebe73d 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -113,8 +113,7 @@ CFLAGS_ABI	+=-funwind-tables
 endif
 
 ifeq ($(CONFIG_THUMB2_KERNEL),y)
-AFLAGS_AUTOIT	:=$(call as-option,-Wa$(comma)-mimplicit-it=always,-Wa$(comma)-mauto-it)
-CFLAGS_ISA	:=-mthumb $(AFLAGS_AUTOIT)
+CFLAGS_ISA	:=-mthumb -Wa$(comma)-mimplicit-it=always
 AFLAGS_ISA	:=$(CFLAGS_ISA) -Wa$(comma)-mthumb
 # Work around buggy relocation from gas if requested:
 ifeq ($(CONFIG_THUMB2_AVOID_R_ARM_THM_JUMP11),y)
-- 
2.20.1

