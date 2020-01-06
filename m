Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1124C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9382720731
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sRlsi32t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgAFUCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:02:13 -0500
Received: from mail-wr1-f73.google.com ([209.85.221.73]:36672 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbgAFUCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:02:12 -0500
Received: by mail-wr1-f73.google.com with SMTP id y7so27687845wrm.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 12:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=iqMEcoc9F5plBffOZF1F+Bz77zemJAbtQp1LiChIOwM=;
        b=sRlsi32tJjCrR38S9xgh4BAd5/EOjrLXJcnvlriD0YNhtV+U8locZ42odR7BocQUwY
         o+kBATxSfCDjW8DajNqGQPZ4mnHutU+E24iIMcsC2FHZ6yyp2aSi/wbtJe90rdL6y59O
         ldmHuKD7ZIPScH5FE/cfyta6gEhDITBX2gyj2gRVfeWaM8ed0wSsDGJ5Gy2+MvA76jvl
         j9DQGqvPnGn5EsYU5ZBG7DtmdO6MBeA/4dRblRv9BDwMigO8whi580KKjdLzOG8EwRHn
         +FXhNIq6yY6TY+GGro6irf21NFz0G2YiJDzOivlJY2Iph1zTS/TbixTT3ECGnaHl0oXP
         LcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=iqMEcoc9F5plBffOZF1F+Bz77zemJAbtQp1LiChIOwM=;
        b=os/sMjh8Xc/nYD/B6/o1lQ4ZC1BhGRiTnGn/SYL6vGR9b384Uy/Y9OwXFq6dPWxrDF
         4SMpWGlnOSlyblkVaRNcYJHu2Dqt387fcD4+pDQDWP7vswh5S0tvGv2ooGpIqaRwiTob
         mYEoUsINKfMrESh9yyqN5EJLO0CNSTmSUWSKgOLOviXoH4ngaxFZHVUM1lKsXCxs0H5Q
         56eCIJhNQ/a3/xQKPWp8kelWF9xlSFZxsHH8DgCVSYPyDk/WbcAJECABxCGnTkuy3JJo
         ax51t3QY0YY8PKGcAyhBY1o9t8fmARBMkRbO3Vw2sVe2t2B7UavSgVUQn1JQFi5hL8JF
         bWCQ==
X-Gm-Message-State: APjAAAXgqQgry7LPasj5nlw5kQ6r4wVAPDi2MvZ6y2qDlxl1rk0vVoI2
        XFPK6X1JoqWHqgszOkIt0OrvIWj+ng==
X-Google-Smtp-Source: APXvYqzufZgu/J6+10nna8VOUb9/7o9V7RDuj0Q8Mhg/Wh45mWnTfh/Duyfi4cd1r36NKS+sPIEvyN5eHw==
X-Received: by 2002:a5d:4044:: with SMTP id w4mr70483522wrp.322.1578340929806;
 Mon, 06 Jan 2020 12:02:09 -0800 (PST)
Date:   Mon,  6 Jan 2020 21:02:04 +0100
Message-Id: <20200106200204.94782-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH] x86/vdso: Enable sanitizers for vma.o
From:   Jann Horn <jannh@google.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, jannh@google.com
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vDSO makefile opts out of all sanitizers (and objtool validation);
however, vma.o is a normal kernel object file (and already has objtool
validation selectively enabled), so turn the sanitizers back on for that
file.

Signed-off-by: Jann Horn <jannh@google.com>
---

Notes:
    This should probably go on top of the locking/kcsan branch?

 arch/x86/entry/vdso/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 0f46273b4556..50a1c9008864 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -30,6 +30,9 @@ vobjs-y := vdso-note.o vclock_gettime.o vgetcpu.o
 
 # files to link into kernel
 obj-y				+= vma.o
+KASAN_SANITIZE_vma.o		:= y
+UBSAN_SANITIZE_vma.o		:= y
+KCSAN_SANITIZE_vma.o		:= y
 OBJECT_FILES_NON_STANDARD_vma.o	:= n
 
 # vDSO images to build
-- 
2.24.1.735.g03f4e72817-goog

