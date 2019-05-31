Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBDCC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 19:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D3E26E48
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 19:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfEaTYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 15:24:16 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38541 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbfEaTXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 15:23:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id v11so4556955pgl.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 12:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=hoDa1EoVZiT7Wkw8tpQ8ZdnhUm/f8Zh3zGc2U04HgkQ=;
        b=KFWneBTdbmX0fwiOSCsAODsOeDEtS23sqL7ewaBpa+Ow7fw+hZrn2HZHJSze8QkXkF
         rNAXrrONonmt2+bbJ/yuivBSBNWENERoPmFa3NPWTqqLoQlDdLbUhbzGwHdKcdQo0aI9
         2eju54+8pGpRWQDnfgyYIFIZdmzNRMecM4DtkLgHN5Z25jalif4mEgPti0EmsnUTtthr
         mfwF2KGPtbDdrDLL8kBLhdvMGJsLHH6n6w43tBwOKprp/CuQg0WNOOONXHdP2wZDXD1N
         /wqdMy0phvhB55oimG3jfk5x4rQtIFmZ+AN4yXhJyvwRP/wdBRxOjToCfvcbBDt9M1Of
         SbFg==
X-Gm-Message-State: APjAAAVInDnpOLek/d1RciXTm6nz4XeBgNmViR39JoH/Uhd0i0ubj8hZ
        UNWwMYjmui55MN7n+4ObYSssfTChTgw=
X-Google-Smtp-Source: APXvYqwDdSFL7PzpLwvQOw94atoCEpoQ4xG/ZVsYwEVets4vEXAhhAUnBPue1jzZcGz3S4VsZQtyqQ==
X-Received: by 2002:a63:31d8:: with SMTP id x207mr10539257pgx.403.1559330630266;
        Fri, 31 May 2019 12:23:50 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id o2sm5753489pgm.51.2019.05.31.12.23.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2019 12:23:49 -0700 (PDT)
Subject: [PATCH 1/5] Non-functional cleanup of a "__user * filename"
Date:   Fri, 31 May 2019 12:12:00 -0700
Message-Id: <20190531191204.4044-2-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190531191204.4044-1-palmer@sifive.com>
References: <20190531191204.4044-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     linux-arch@vger.kernel.org, x86@kernel.org, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@sifive.com>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The next patch defines a very similar interface, which I copied from
this definition.  Since I'm touching it anyway I don't see any reason
not to just go fix this one up.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 include/linux/syscalls.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e446806a561f..396871b218f4 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -433,7 +433,7 @@ asmlinkage long sys_chdir(const char __user *filename);
 asmlinkage long sys_fchdir(unsigned int fd);
 asmlinkage long sys_chroot(const char __user *filename);
 asmlinkage long sys_fchmod(unsigned int fd, umode_t mode);
-asmlinkage long sys_fchmodat(int dfd, const char __user * filename,
+asmlinkage long sys_fchmodat(int dfd, const char __user *filename,
 			     umode_t mode);
 asmlinkage long sys_fchownat(int dfd, const char __user *filename, uid_t user,
 			     gid_t group, int flag);
-- 
2.21.0

