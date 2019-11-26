Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4503DC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 22:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB802064B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 22:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHJk/ldM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfKZWPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 17:15:36 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33811 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfKZWPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 17:15:35 -0500
Received: by mail-wr1-f66.google.com with SMTP id t2so24356583wrr.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 14:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vl+xiVOCP31NCupx53lgh8che5gXgCpStVYYfmUwlzQ=;
        b=ZHJk/ldMYEF8IqTbqKMJFr47VB14Z3sSzlUpmoezWaWCQYu9uY/RKAdc+K2d4gK7k2
         vsjLScu5OEN/kDFpqKov7wFsDSjVhyYzz53mgtNM7iUnz+55Q4yB/uBr7Z6aWgR1U46z
         pQGiJ9JsCQz3HKnpBbvEqaAlkOKlg+R/90is/hzMBrsi34KfZTkHQcfT003yBfSW2uEz
         o7gkuji4L7cVH97nbrDqMRTKOcBKHe2oXDV/ZJeC16b6D7JBzxK8L9+S6Fhad+IFIbZz
         zfg+g13Xggr0CAAkzyKPXalwKByI/1B7yFrmvcRULquEAozcPklrRWXm+Ssu6XxZ9T1d
         WC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vl+xiVOCP31NCupx53lgh8che5gXgCpStVYYfmUwlzQ=;
        b=lUrVbVxUSNpp5JwVHDGlwrq2UVf/+ccl5I2i648U7zKfNjkTKFQ+EQDvpgpdfcyucS
         8lve1v/r+wYD4z+4E+e3v+MCKosdcebcM9A8vtT5+7HK1cXJ93HWiuokSW7fMkw1donV
         Mpz+nF/4Q3geyF715mlsiM9pCd0NqPdK9V+XYY0287eJBxpOd/HAAYggp4e2XZPwj/Hs
         AsuJIzB2YdZ1gITajwB5vAn871RFMuDdyX3aL4YYrWaF0HpFo0aYIFKE4zXtj+4zmXxQ
         aauVu8HFXPsWwz3M0pJeHGH8yjsmFitn4xNnBTy4nZrpdWbD2+KIsTo1KvfAGntwciIR
         xsgQ==
X-Gm-Message-State: APjAAAU9x89DeoMXfPsoRsx+yvcyhK0+cUaRLO7jID3cdqsq+zeV5hy1
        UGNE4rsYmPt+YbvDEzZPiw==
X-Google-Smtp-Source: APXvYqxUMtoGLK6BsIYr5HYNtuhTKo1zpeEthD1WN3f6WLXojMh5ZotVCww0h9kdbbRiaF7gsHO35g==
X-Received: by 2002:a5d:674a:: with SMTP id l10mr34089842wrw.223.1574806532880;
        Tue, 26 Nov 2019 14:15:32 -0800 (PST)
Received: from ninjahub.lan (host-2-102-12-67.as13285.net. [2.102.12.67])
        by smtp.googlemail.com with ESMTPSA id z64sm3449005wmg.30.2019.11.26.14.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 14:15:32 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     bp@alien8.de
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        hpa@zytor.com, mingo@redhat.com,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH] cpu: microcode: Add comma to 0
Date:   Tue, 26 Nov 2019 22:15:19 +0000
Message-Id: <20191126221519.167145-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ","  after 0
Because memory for the struct is being cleared
and elements after "," are missing on purpose
 as they are being cleared to

Recommended by Boris Petkov

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 arch/x86/kernel/cpu/microcode/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index a0e52bd00ecc..04ee649f4acb 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -418,7 +418,7 @@ static int __apply_microcode_amd(struct microcode_amd *mc)
 static bool
 apply_microcode_early_amd(u32 cpuid_1_eax, void *ucode, size_t size, bool save_patch)
 {
-	struct cont_desc desc = { 0 };
+	struct cont_desc desc = { 0, };
 	u8 (*patch)[PATCH_MAX_SIZE];
 	struct microcode_amd *mc;
 	u32 rev, dummy, *new_rev;
-- 
2.23.0

