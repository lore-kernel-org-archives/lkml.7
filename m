Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50570C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C78F2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254677;
	bh=seM9QVf3DJG6qN8V/SWs7haUcZfQGTlnRjpQOzeGDbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YF8+whI0NzeAfuMA6tW8AJt99Dh1MFAekLJiKKmpO5deK0LwlZbFZf2+vASwPVMeF
	 1Yn3NRCuw5xBVVFMYnO/38tAGVNXTUYOdyu93qA04UmQYg00PRsFkreCm4Nj7qFSt/
	 x0kTBszagPFbseq9N+T7aBtmmZiBv1qDYbT3gpM4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbfCVLhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:37:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:39282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730306AbfCVLhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:37:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD3B8218B0;
        Fri, 22 Mar 2019 11:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254665;
        bh=seM9QVf3DJG6qN8V/SWs7haUcZfQGTlnRjpQOzeGDbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yB6GToI0jQLJJDbtkPXJMjZDgCFLLVWMKjQt98nX3Yv55db/1QqwVhTtYXX0srx7o
         YClirvHDU77CcDZ/stcT5yBwWTr6ndsAGsRBXCxKKDBBqToZ2rtCkxUzLBqc4qWwlV
         Wz9jl6CpmHDKme2QrynWOXnYc8+QF6V86aZiRegI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Finn Thain <fthain@telegraphics.com.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 4.4 189/230] m68k: Add -ffreestanding to CFLAGS
Date:   Fri, 22 Mar 2019 12:15:27 +0100
Message-Id: <20190322111250.061091267@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Finn Thain <fthain@telegraphics.com.au>

commit 28713169d879b67be2ef2f84dcf54905de238294 upstream.

This patch fixes a build failure when using GCC 8.1:

/usr/bin/ld: block/partitions/ldm.o: in function `ldm_parse_tocblock':
block/partitions/ldm.c:153: undefined reference to `strcmp'

This is caused by a new optimization which effectively replaces a
strncmp() call with a strcmp() call. This affects a number of strncmp()
call sites in the kernel.

The entire class of optimizations is avoided with -fno-builtin, which
gets enabled by -ffreestanding. This may avoid possible future build
failures in case new optimizations appear in future compilers.

I haven't done any performance measurements with this patch but I did
count the function calls in a defconfig build. For example, there are now
23 more sprintf() calls and 39 fewer strcpy() calls. The effect on the
other libc functions is smaller.

If this harms performance we can tackle that regression by optimizing
the call sites, ideally using semantic patches. That way, clang and ICC
builds might benfit too.

Cc: stable@vger.kernel.org
Reference: https://marc.info/?l=linux-m68k&m=154514816222244&w=2
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/m68k/Makefile |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/arch/m68k/Makefile
+++ b/arch/m68k/Makefile
@@ -59,7 +59,10 @@ cpuflags-$(CONFIG_M5206e)	:= $(call cc-o
 cpuflags-$(CONFIG_M5206)	:= $(call cc-option,-mcpu=5206,-m5200)
 
 KBUILD_AFLAGS += $(cpuflags-y)
-KBUILD_CFLAGS += $(cpuflags-y) -pipe
+KBUILD_CFLAGS += $(cpuflags-y)
+
+KBUILD_CFLAGS += -pipe -ffreestanding
+
 ifdef CONFIG_MMU
 # without -fno-strength-reduce the 53c7xx.c driver fails ;-(
 KBUILD_CFLAGS += -fno-strength-reduce -ffixed-a2


