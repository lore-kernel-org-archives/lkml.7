Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C16C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 19:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF59218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 19:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MkthKt8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbfC2TgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 15:36:08 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41101 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729939AbfC2TgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 15:36:08 -0400
Received: by mail-pf1-f194.google.com with SMTP id 188so1510788pfd.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 12:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=eaQYgam2OhiWX3e3BrBK9mv6im9GNB3cu0cjBIUnXqA=;
        b=MkthKt8TudrNjgTtcUbc61WG2hNg8bR8pHN15bdKe7C9ORksaaRkoh11O/vjW/1HYK
         8aMAvYoJ+fVszbF2qFzPe1w8t4isSvCB20VCGDzBOh2kH4tGQx8ytdASp//++ocFTef5
         laXdXFLMAi4y/OzxrTgXtXbhEGf/jJhSdfuBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=eaQYgam2OhiWX3e3BrBK9mv6im9GNB3cu0cjBIUnXqA=;
        b=edcveUPtkjWEp8ICGzTCUK9qVY4dB/GYkbCh91ViJ4LE0pG+YrKFmHTH79sCQUHGQe
         46R5swijWm30QVoe+jHEC1Izf1i9MXBaTHy1MeKVChpN//LTN807Q4kichD1pCFCrEME
         H2EYU0dDEQj7oBW/5JMaXumU0z7OJXuY/L/+oMdaZmyzFh48JtGaAG347SsRlYU9MVxe
         J2WzE/mY4L08fiqdV0zf/BnF493n8v+KJMx38lx9DGMOTbxaqhAg/9N7MlOeJHNgJduG
         4Zgi+LsfA8bIh8y2Ve4qHxZFOugYRf1I18Id30H2nXgyq00PscHS7p+qMQinV9yD4TI5
         X8Pw==
X-Gm-Message-State: APjAAAUU1jUyIC5YynQPyOc9mB21tFa3AmG6UypDZgXZOfBsNVpPwxoN
        /58XfbOHToOQEsbZXlvFHaW0xw==
X-Google-Smtp-Source: APXvYqy+wJ5AtzQLU16QLQ/zyXxNIt3epKDKwEqell/ReA5WdRsCUdENkOEhVJKOA2Va/Gk5+bK09w==
X-Received: by 2002:a63:5d04:: with SMTP id r4mr37740570pgb.117.1553888167186;
        Fri, 29 Mar 2019 12:36:07 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id a6sm4665336pfn.181.2019.03.29.12.36.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 12:36:05 -0700 (PDT)
Date:   Fri, 29 Mar 2019 12:36:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     James Morris <jmorris@namei.org>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] LSM: Revive CONFIG_DEFAULT_SECURITY_* for "make oldconfig"
Message-ID: <20190329193604.GA30908@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 70b62c25665f636c ("LoadPin: Initialize as ordered LSM") removed
CONFIG_DEFAULT_SECURITY_{SELINUX,SMACK,TOMOYO,APPARMOR,DAC} from
security/Kconfig and changed CONFIG_LSM to provide a fixed ordering as a
default value. That commit expected that existing users (upgrading from
Linux 5.0 and earlier) will edit CONFIG_LSM value in accordance with
their CONFIG_DEFAULT_SECURITY_* choice in their old kernel configs. But
since users might forget to edit CONFIG_LSM value, this patch revives
the choice (only for providing the default value for CONFIG_LSM) in order
to make sure that CONFIG_LSM reflects CONFIG_DEFAULT_SECURITY_* from their
old kernel configs.

Note that since TOMOYO can be fully stacked against the other legacy
major LSMs, when it is selected, it explicitly disables the other LSMs
to avoid them also initializing since TOMOYO does not expect this
currently.

Reported-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Fixes: 70b62c25665f636c ("LoadPin: Initialize as ordered LSM")
Co-developed-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/Kconfig | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/security/Kconfig b/security/Kconfig
index 1d6463fb1450..353cfef71d4e 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -239,8 +239,46 @@ source "security/safesetid/Kconfig"
 
 source "security/integrity/Kconfig"
 
+choice
+	prompt "First legacy 'major LSM' to be initialized"
+	default DEFAULT_SECURITY_SELINUX if SECURITY_SELINUX
+	default DEFAULT_SECURITY_SMACK if SECURITY_SMACK
+	default DEFAULT_SECURITY_TOMOYO if SECURITY_TOMOYO
+	default DEFAULT_SECURITY_APPARMOR if SECURITY_APPARMOR
+	default DEFAULT_SECURITY_DAC
+
+	help
+	  This choice is there only for converting CONFIG_DEFAULT_SECURITY
+	  in old kernel configs to CONFIG_LSM in new kernel configs. Don't
+	  change this choice unless you are creating a fresh kernel config,
+	  for this choice will be ignored after CONFIG_LSM has been set.
+
+	  Selects the legacy "major security module" that will be
+	  initialized first. Overridden by non-default CONFIG_LSM.
+
+	config DEFAULT_SECURITY_SELINUX
+		bool "SELinux" if SECURITY_SELINUX=y
+
+	config DEFAULT_SECURITY_SMACK
+		bool "Simplified Mandatory Access Control" if SECURITY_SMACK=y
+
+	config DEFAULT_SECURITY_TOMOYO
+		bool "TOMOYO" if SECURITY_TOMOYO=y
+
+	config DEFAULT_SECURITY_APPARMOR
+		bool "AppArmor" if SECURITY_APPARMOR=y
+
+	config DEFAULT_SECURITY_DAC
+		bool "Unix Discretionary Access Controls"
+
+endchoice
+
 config LSM
 	string "Ordered list of enabled LSMs"
+	default "yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor" if DEFAULT_SECURITY_SMACK
+	default "yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo" if DEFAULT_SECURITY_APPARMOR
+	default "yama,loadpin,safesetid,integrity,tomoyo" if DEFAULT_SECURITY_TOMOYO
+	default "yama,loadpin,safesetid,integrity" if DEFAULT_SECURITY_DAC
 	default "yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
 	help
 	  A comma-separated list of LSMs, in initialization order.
-- 
2.17.1


-- 
Kees Cook
