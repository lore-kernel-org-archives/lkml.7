Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B59C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 08:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 812C721582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 08:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLksOQyi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfLRIsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 03:48:08 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38115 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfLRIsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 03:48:07 -0500
Received: by mail-wr1-f65.google.com with SMTP id y17so1319381wrh.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 00:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yaG+oMd4gi7zP4mz5z7EHKsmoy3fZzIJMA/I7rfBMDo=;
        b=XLksOQyij2bqKFaP3kJv3LCTxtA0gwK4VkT/nP1+JoLVzqS3ZrcHhUHe3SyROsL8yl
         Z7mZ5s4l54fd5fOYNaVm9qWA1Afh6gnJ9YpiJfS14FlGrKHnWmK1asfSZsv6hQ5ulYtG
         rRYO43iOhTfwA5Lzf15/OtV85ksLsJhXhOprZ8seP7yOj59yKNDmxIL1swQj+ilQdHVw
         HAYZ3DzGLgwf08Z9scf2gtHRQbxZMDTfKElk9Yd6iFsPEDKAA1AZRjbQdQ3hXhwLcrGy
         xUbEJjZvjPHz0+rzgDXWTkanIsXQc7RyyIpSa2REGBCGkoJQrvwryrlqzZncPGzPANFJ
         BzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yaG+oMd4gi7zP4mz5z7EHKsmoy3fZzIJMA/I7rfBMDo=;
        b=HN1Iw5GLZOipKaPy0Vq/dth0zPvHexbhkM2tlNKAW/yYF9W6iNDP/HRknHGjOop06q
         Ef5HeZ87tdcrGJc5qT/XNvWtwCw11eMjlF6fvu9OIDGUbmvGUhl1LO2lh+afgAKKczg2
         KJpA+AcrYSnnkxxlzgIxGovFv2xaMw9/pofLElnkaY/H2dsVNDXbhnaxLg5nZa/6JVCo
         aRSSfCyrs7nIvL9xF5ScgFTIahcXq6v0PVGeumU9GplQwgFLGkp7hYVvYAC4lvZTjTES
         M5PZhw6f5I+VBh3ll3Awc9hzDS+2KHGUxyZOLc3TJxOrceeLEam2983qIUJq2IgiBqzP
         ngxA==
X-Gm-Message-State: APjAAAXWIDzTLGHGkpkQDs8eytoukIlwYjI7+vx2n35xQjwrgMnn/nmk
        5NRzVaCQ8kYr3o7Gw4DWWjY=
X-Google-Smtp-Source: APXvYqwzQr73+H1pnvdEfcVdXui7/DNx4znwqvuycyoJkS7uGWF785qxUNpJgwQ0jTQq41H6f4fD1A==
X-Received: by 2002:a5d:52c4:: with SMTP id r4mr1342304wrv.368.1576658885608;
        Wed, 18 Dec 2019 00:48:05 -0800 (PST)
Received: from localhost.localdomain (78-63-27-146.static.zebra.lt. [78.63.27.146])
        by smtp.gmail.com with ESMTPSA id f207sm1885138wme.9.2019.12.18.00.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 00:48:05 -0800 (PST)
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
X-Google-Original-From: David Abdurachmanov <david.abdurachmanov@sifive.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        Kees Cook <keescook@chromium.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bin Meng <bmeng.cn@gmail.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     david.abdurachmanov@gmail.com
Subject: [PATCH] riscv: reject invalid syscalls below -1
Date:   Wed, 18 Dec 2019 10:47:56 +0200
Message-Id: <20191218084757.904971-1-david.abdurachmanov@sifive.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running "stress-ng --enosys 4 -t 20 -v" showed a large number of kernel oops
with "Unable to handle kernel paging request at virtual address" message. This
happens when enosys stressor starts testing random non-valid syscalls.

I forgot to redirect any syscall below -1 to sys_ni_syscall.

With the patch kernel oops messages are gone while running stress-ng enosys
stressor.

Signed-off-by: David Abdurachmanov <david.abdurachmanov@sifive.com>
Fixes: 5340627e3fe0 ("riscv: add support for SECCOMP and SECCOMP_FILTER")
---
 arch/riscv/kernel/entry.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index a1349ca64669..e163b7b64c86 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -246,6 +246,7 @@ check_syscall_nr:
 	 */
 	li t1, -1
 	beq a7, t1, ret_from_syscall_rejected
+	blt a7, t1, 1f
 	/* Call syscall */
 	la s0, sys_call_table
 	slli t0, a7, RISCV_LGPTR
-- 
2.24.1

