Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC783C4CED2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 12:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A49220665
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 12:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568637783;
	bh=K7ooNtpMkYczuDJOrXLJKZt7aUOd75YkoCuXoI/tgkI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Kr7EEdHy76FPeoFhRcrgoKzSLhnmzlmF6G2LjPELXbBVXL++TSsA1ud2V/K/7rmrm
	 pRRRhE/E5sOeCv7ouw0DLpyjpK+WhGiSQdL4Y3cPOSstXixR94qeVzVPgm7qGqsp8h
	 Gqm95cF+mXqWk+zN+KGhoerzQ0EQbnzYT2ImXHu0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732735AbfIPMnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 08:43:02 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40274 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbfIPMnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 08:43:01 -0400
Received: by mail-wm1-f65.google.com with SMTP id b24so1823279wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 05:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=67+FUeyx+CkTYJMuIWRL3nrU/B8l3e6Q1tQhkGctwSM=;
        b=OjGxdoLq4A6RhcwfmWHeaRJ3cuAhlYdlImV0WpZ5Fr0WVq+ydfcB9THjLKtkPK1Dxc
         C2WflSUCofusQ7xYvmm9g6a5N814WMR9/dDiG3ZjEl3C5zsZHX6MGQ7Rehcaa8/Jh2FZ
         xgNGnnNFeIa2rk46pcKBy37kNpIo8gltqvOjSdr4+bPd18cYy6q7qor4/52zd9jQItTh
         Vdx4KsPKowHQqF39VZTDIoXo6o64u0km+gv8Oam/UPdjHyfkJkp1yfkPJxhri+M3d/IU
         /XjPDHajcBkH7oERz6ljddkh61h5+cPzdtyafISnJooH+IzGdlK8pF2+gKFyxPXgpTM+
         kILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=67+FUeyx+CkTYJMuIWRL3nrU/B8l3e6Q1tQhkGctwSM=;
        b=P78QsgCowQ4RhYP23wsXhTdM5QNTW724d8c9K9WAG3d/TTd8d8g/LdhdGTiENE4N8d
         9Q5RNTQULwvFn7/C1FbB5HFuOvSDJDut/3L9hluOc0+r5wcaxCMWxD8fIo+tCNgt5TMp
         tGhnlMWJj8gHeuEOeD1P1rCoZE2bivou5rcBKZ5Qwa3Dz0tmQYdKnyfy61ORIceamKos
         05E8Ftg//CZQTqDiGYK5l1/DwINBwn8jzpUhlEE2SsuaWrTSC6vpm+xaLQrTutjjk1UA
         kTSNhVtUuarwZzv2xsX3hJqe67H+72+4Mtetu2NeW50OKQHMFCnWqJ/ZmjCuNScl5fHF
         Loeg==
X-Gm-Message-State: APjAAAX+de6RL1Us6gOMJJeBhRSyMkf1HzJ7WMp9267lf5ZRQWp9bBxl
        PEni3zzW7Hoo5kkpqHVX4Fwj1ujS
X-Google-Smtp-Source: APXvYqxB/RpfATJuINHHIfveaakRvr7BcwGbL51xXvz6ymZVVN27WfmXqOhnWXbS2koFwGVizxPeUw==
X-Received: by 2002:a1c:3b06:: with SMTP id i6mr6531102wma.6.1568637779054;
        Mon, 16 Sep 2019 05:42:59 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 189sm28721326wma.6.2019.09.16.05.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 05:42:58 -0700 (PDT)
Date:   Mon, 16 Sep 2019 14:42:56 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/build change for v5.4
Message-ID: <20190916124256.GA9811@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-build-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-for-linus

   # HEAD: 701010532164eaacd415ec5683717da03f4b822d x86/build: Remove unneeded uapi asm-generic wrappers

A single change that removes unnecessary asm-generic wrappers.

 Thanks,

	Ingo

------------------>
Masahiro Yamada (1):
      x86/build: Remove unneeded uapi asm-generic wrappers


 arch/x86/include/uapi/asm/errno.h    | 1 -
 arch/x86/include/uapi/asm/fcntl.h    | 1 -
 arch/x86/include/uapi/asm/ioctl.h    | 1 -
 arch/x86/include/uapi/asm/ioctls.h   | 1 -
 arch/x86/include/uapi/asm/ipcbuf.h   | 1 -
 arch/x86/include/uapi/asm/param.h    | 1 -
 arch/x86/include/uapi/asm/resource.h | 1 -
 arch/x86/include/uapi/asm/termbits.h | 1 -
 arch/x86/include/uapi/asm/termios.h  | 1 -
 arch/x86/include/uapi/asm/types.h    | 7 -------
 10 files changed, 16 deletions(-)
 delete mode 100644 arch/x86/include/uapi/asm/errno.h
 delete mode 100644 arch/x86/include/uapi/asm/fcntl.h
 delete mode 100644 arch/x86/include/uapi/asm/ioctl.h
 delete mode 100644 arch/x86/include/uapi/asm/ioctls.h
 delete mode 100644 arch/x86/include/uapi/asm/ipcbuf.h
 delete mode 100644 arch/x86/include/uapi/asm/param.h
 delete mode 100644 arch/x86/include/uapi/asm/resource.h
 delete mode 100644 arch/x86/include/uapi/asm/termbits.h
 delete mode 100644 arch/x86/include/uapi/asm/termios.h
 delete mode 100644 arch/x86/include/uapi/asm/types.h

diff --git a/arch/x86/include/uapi/asm/errno.h b/arch/x86/include/uapi/asm/errno.h
deleted file mode 100644
index 4c82b503d92f..000000000000
--- a/arch/x86/include/uapi/asm/errno.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/errno.h>
diff --git a/arch/x86/include/uapi/asm/fcntl.h b/arch/x86/include/uapi/asm/fcntl.h
deleted file mode 100644
index 46ab12db5739..000000000000
--- a/arch/x86/include/uapi/asm/fcntl.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/fcntl.h>
diff --git a/arch/x86/include/uapi/asm/ioctl.h b/arch/x86/include/uapi/asm/ioctl.h
deleted file mode 100644
index b279fe06dfe5..000000000000
--- a/arch/x86/include/uapi/asm/ioctl.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/ioctl.h>
diff --git a/arch/x86/include/uapi/asm/ioctls.h b/arch/x86/include/uapi/asm/ioctls.h
deleted file mode 100644
index ec34c760665e..000000000000
--- a/arch/x86/include/uapi/asm/ioctls.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/ioctls.h>
diff --git a/arch/x86/include/uapi/asm/ipcbuf.h b/arch/x86/include/uapi/asm/ipcbuf.h
deleted file mode 100644
index 84c7e51cb6d0..000000000000
--- a/arch/x86/include/uapi/asm/ipcbuf.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/ipcbuf.h>
diff --git a/arch/x86/include/uapi/asm/param.h b/arch/x86/include/uapi/asm/param.h
deleted file mode 100644
index 965d45427975..000000000000
--- a/arch/x86/include/uapi/asm/param.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/param.h>
diff --git a/arch/x86/include/uapi/asm/resource.h b/arch/x86/include/uapi/asm/resource.h
deleted file mode 100644
index 04bc4db8921b..000000000000
--- a/arch/x86/include/uapi/asm/resource.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/resource.h>
diff --git a/arch/x86/include/uapi/asm/termbits.h b/arch/x86/include/uapi/asm/termbits.h
deleted file mode 100644
index 3935b106de79..000000000000
--- a/arch/x86/include/uapi/asm/termbits.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/termbits.h>
diff --git a/arch/x86/include/uapi/asm/termios.h b/arch/x86/include/uapi/asm/termios.h
deleted file mode 100644
index 280d78a9d966..000000000000
--- a/arch/x86/include/uapi/asm/termios.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/termios.h>
diff --git a/arch/x86/include/uapi/asm/types.h b/arch/x86/include/uapi/asm/types.h
deleted file mode 100644
index df55e1ddb0c9..000000000000
--- a/arch/x86/include/uapi/asm/types.h
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_TYPES_H
-#define _ASM_X86_TYPES_H
-
-#include <asm-generic/types.h>
-
-#endif /* _ASM_X86_TYPES_H */
