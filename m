Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636F4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B7F2083D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257024;
	bh=cDO9xhpK2tN8k8LIh0gndMuJjmAO93kUql2gZQCwyHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qYGJUQXfk2t1NmXWBzB6fYCPqfGQDZoy5k9EsZVvNxohDNKCcJWpDCv3jxX/j6d4I
	 1Ix9gIsjUjN5osz4F19J5cpwgbnyN/y4WAb8cZVn34QoI8zlLCywwx7iWUX+oE4y1M
	 V6eMm05QmGbdF5l3rLjBrA4dyjRISAoBQKKSk3+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390316AbfCVMRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:17:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390309AbfCVMQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:16:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B36F2192C;
        Fri, 22 Mar 2019 12:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257019;
        bh=cDO9xhpK2tN8k8LIh0gndMuJjmAO93kUql2gZQCwyHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ht9nEA1ejEpZ5OJitKRKwaybQfT09kfz3t5weBbEMq3eE684MECn80V5c+vRb+Ivd
         0pC5gzbw38nAZ7UP1bOdElyHlH/Cu5TAeXO0r1LlfCa9DxsdNnTP6UvgNpdfQ394O0
         Y7irF9QQadbSRagBQU5EJhwGJ5Ul8+XD6ylI1PcI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Finn Thain <fthain@telegraphics.com.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 5.0 090/238] m68k: Add -ffreestanding to CFLAGS
Date:   Fri, 22 Mar 2019 12:15:09 +0100
Message-Id: <20190322111303.894843300@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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
@@ -58,7 +58,10 @@ cpuflags-$(CONFIG_M5206e)	:= $(call cc-o
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


