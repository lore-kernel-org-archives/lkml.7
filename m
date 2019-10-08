Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07456C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D085F206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="A/lNeYcx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbfJHKYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 06:24:43 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37440 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730008AbfJHKYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 06:24:42 -0400
Received: by mail-wm1-f65.google.com with SMTP id f22so2544041wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 03:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=sjfFuDwqO1AuvoKSjvoaPz/4rXLLUzUv8rusbSInkFk=;
        b=A/lNeYcxz2GnaQ18zAN30eHxaW1n3Ev9eqdPPE7xK4n9GPDyv8I1vtoQS9b6wBkc0g
         79dSvRzCae7vnTglys8XqD5qgjI5BjUNP2VCRFVasU31Fg0ksElKTob41oY/VhJuXPIN
         DGx7b2uEOrrtJzc+Qi1U0OGRUBYtbkEsEXqB9x8fPduJMQcmEVGQ1AHisWeJaNt9z8JO
         /rg9Ai7t/0OAAU19q5Flzrxa2mZXgvPbT4CILF0fkkn9fozTSfN6hsiAerk1U8k915Kn
         ZxFyaSKQG0XVR+7f0Nk1zCY9ClLy1orPM2IEIDMzMmcH06UGIdNpQEnmiAI8NZm87N9X
         NRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=sjfFuDwqO1AuvoKSjvoaPz/4rXLLUzUv8rusbSInkFk=;
        b=VeENG6SW+tOIMU194QSb9dBaoWZiVSjWBE2oMEy6ST0TPDcJ0QgYFmAwTnDljzrpZP
         Lcp7+YkNwTDyUAj5evhmcGzJqDrGsihJhTq0gqJwHV6m6McfosTg3b0b5cjgBzfytN9m
         lIBTXDM+obPA7nglvzHQkWgj94MnzSeyeqjbVqODX0BMxTKk26r07JIo5fbnsfSIi2Lq
         gj2yzGavJtR2KfC7qXLDOTul4C++iVOTeivNaoWANR7lbKEh9Pk614533ZELKsTUyscx
         +Ql99/wX1UAEhMyTVWxudz3BhGO2Xf51wvTOQs/wswpVF9E0k7P/S7A10E5cFvAQjo35
         Q+5g==
X-Gm-Message-State: APjAAAVI2m+/i2clddNgeyFs+jI2qkcTZtmvNG11RPE6peqf/+huE7/S
        rPJWV2bnV5LtqY3xigpimoQH+6yI5tnO9pHf
X-Google-Smtp-Source: APXvYqwuRA/6MX6a7YgFLjdBZKhtPkTr1LdeM2uUSxLL4Wht9iFeHb+QYy234AceMwqVl+9VaPks4A==
X-Received: by 2002:a1c:f714:: with SMTP id v20mr3284424wmh.55.1570530280651;
        Tue, 08 Oct 2019 03:24:40 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id r27sm53397272wrc.55.2019.10.08.03.24.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Oct 2019 03:24:39 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Siva Durga Prasad Paladugu <siva.durga.paladugu@xilinx.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <james.morris@microsoft.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] microblaze: Increase max dtb size to 64K from 32K
Date:   Tue,  8 Oct 2019 12:24:37 +0200
Message-Id: <051fa6cf19fac4ae7029ac9e85fe12caa29b4011.1570530267.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Siva Durga Prasad Paladugu <siva.durga.paladugu@xilinx.com>

This patch increases max dtb size to 64K from 32K. This fixes the issue  of
kernel hang with larger dtb of size greater than 32KB.

Signed-off-by: Siva Durga Prasad Paladugu <siva.durga.paladugu@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/microblaze/kernel/head.S        | 2 +-
 arch/microblaze/kernel/vmlinux.lds.S | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/microblaze/kernel/head.S b/arch/microblaze/kernel/head.S
index f264fdcf152a..7d2894418691 100644
--- a/arch/microblaze/kernel/head.S
+++ b/arch/microblaze/kernel/head.S
@@ -99,7 +99,7 @@ big_endian:
 _prepare_copy_fdt:
 	or	r11, r0, r0 /* incremment */
 	ori	r4, r0, TOPHYS(_fdt_start)
-	ori	r3, r0, (0x8000 - 4)
+	ori	r3, r0, (0x10000 - 4)
 _copy_fdt:
 	lw	r12, r7, r11 /* r12 = r7 + r11 */
 	sw	r12, r4, r11 /* addr[r4 + r11] = r12 */
diff --git a/arch/microblaze/kernel/vmlinux.lds.S b/arch/microblaze/kernel/vmlinux.lds.S
index e1f3e8741292..71072c5cf61f 100644
--- a/arch/microblaze/kernel/vmlinux.lds.S
+++ b/arch/microblaze/kernel/vmlinux.lds.S
@@ -46,7 +46,7 @@ SECTIONS {
 	__fdt_blob : AT(ADDR(__fdt_blob) - LOAD_OFFSET) {
 		_fdt_start = . ;		/* place for fdt blob */
 		*(__fdt_blob) ;			/* Any link-placed DTB */
-	        . = _fdt_start + 0x8000;	/* Pad up to 32kbyte */
+	        . = _fdt_start + 0x10000;	/* Pad up to 64kbyte */
 		_fdt_end = . ;
 	}
 
-- 
2.17.1

