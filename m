Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5B7C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72FD121920
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GHJrn0r8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfJKAHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 20:07:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33165 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbfJKAG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 20:06:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id i76so4704655pgc.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 17:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/BlCq1vuoPK6b90i9+3dEN0gsbsUxI5XzRVDtU+Y9n4=;
        b=GHJrn0r8p4QDRypis6WzxDqJLjyLzu0c9DD31onEhaU6MLFCbVj+PFhPVkLaKrLr36
         6/jJ7OuoXZWX6LGkizVGzJHGBfhDDMvBdX6JasWlhwE3Pz+fa+29g8GSrJ2HxibXscDy
         XREgc77JYPHoKnPPc/FC6vHKtCm5+OUHsSdmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/BlCq1vuoPK6b90i9+3dEN0gsbsUxI5XzRVDtU+Y9n4=;
        b=Suld5EZfX03ym2Na1KtjUped111ewRx1kbtrtTc6UjaMatwUbQXVi5socfPmeEJxoj
         X39W5dmiCyW2VpFWKawhweHLps06rlPlQohsRK9vtf+FvUWb5JsAE1goeJy/QenK/C53
         +x30uBx8KbmqojbWy2bvGmWJXX5cbki0X5brMtFuuwhUpgicN77QNwCQqBMFh/HrE99t
         8t9ipi5kaCKpDSs3Lil60fL3b7fkO59qdXntUdRc+HRq9ZG85HBVnPHtIDF0qtPKuEDX
         sl9BIVD3Uh/7LneA3F6rL3fX4Vi5yYFrVO0fjBakCIwYYfUVDIax9B1T7sxDUs2bxJ3J
         3nbA==
X-Gm-Message-State: APjAAAUcVYltwGct++O96IPq5UBR5ec7Bl1xoApxdVxFcShgIeEp6DYv
        r8bul4C38zD0luPldNRN8W2h1w==
X-Google-Smtp-Source: APXvYqxm1QyOZv5u+41ebuDjigq/RdhkNKyMk/fjtAY65tjxQi2WIaaeC50vP1uynwiInzpzpev47Q==
X-Received: by 2002:a63:5c07:: with SMTP id q7mr13867865pgb.294.1570752386631;
        Thu, 10 Oct 2019 17:06:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h2sm7642311pfq.108.2019.10.10.17.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 17:06:24 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/29] x86: Restore "text" Program Header with dummy section
Date:   Thu, 10 Oct 2019 17:05:47 -0700
Message-Id: <20191011000609.29728-8-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011000609.29728-1-keescook@chromium.org>
References: <20191011000609.29728-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a linker script, if once places a section in one or more segments using
":PHDR", then the linker will place all subsequent allocatable sections,
which do not specify ":PHDR", into the same segments. In order to have
the NOTES section in both PT_LOAD (":text") and PT_NOTE (":note"), both
segments are marked, and the only way to to undo this to keep subsequent
sections out of PT_NOTE is to mark the following section with just the
single desired PT_LOAD (":text").

In preparation for having a common NOTES macro, perform the segment
assignment use a dummy section (as done by other architectures).

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/vmlinux.lds.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index e2feacf921a0..788e78978030 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -147,8 +147,9 @@ SECTIONS
 	} :text = 0x9090
 
 	NOTES :text :note
+	.dummy : { *(.dummy) } :text
 
-	EXCEPTION_TABLE(16) :text = 0x9090
+	EXCEPTION_TABLE(16)
 
 	/* .text should occupy whole number of pages */
 	. = ALIGN(PAGE_SIZE);
-- 
2.17.1

