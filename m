Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBCCC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0AD2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557146419;
	bh=0WZ5m/hI9ht1JgwBW9Bs/jdn55WP1IMFhu8S8OuNGF0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=mqp/oCucSUJIArepoovP2Mo0bH0ri5PwCefDb5f3lhiYpizKAvFFbfAOumIvZlR8e
	 SPpQiAAwz1la02OYme1/yNmLd88FUBXXQQ58z1taZl0kCzC4HDg4PaaTOpJ0YATBdD
	 DZZJH3hfmoLGoSxAVRRJHcEh4fZMJfsVovlATA6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfEFMkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 08:40:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:58984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbfEFMkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 08:40:17 -0400
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D01B20830;
        Mon,  6 May 2019 12:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557146417;
        bh=0WZ5m/hI9ht1JgwBW9Bs/jdn55WP1IMFhu8S8OuNGF0=;
        h=From:To:Cc:Subject:Date:From;
        b=T1AKWa9dN8KvyAEOWZD2bYOThQ0RwF7JLJNQlV6bUZmz2d4sQ0oVetaB3R8lvDQbl
         2XpBPqllDm8rKUHwT/JVrxUbPiGHzHBQDTAeq/CUkhO9oJauOnzW+BEVc9aUG672C2
         lfo44+UGq5w42LZBwPlxuiQqNqDNmiv+qqz2VRFA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Jessica Yu <jeyu@kernel.org>
Subject: [PATCH] kbuild: Fix cross compile link with ccache
Date:   Mon,  6 May 2019 14:40:00 +0200
Message-Id: <1557146400-12269-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix calling objcopy in case of cross compile environments:

	ARCH="arm" CROSS_COMPILE="ccache arm-linux-gnueabi-" make
	scripts/link-vmlinux.sh: line 211: ccache arm-linux-gnueabi-objcopy: command not found

Fixes: 6a26793a7891 ("moduleparam: Save information about built-in modules in separate file")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 scripts/link-vmlinux.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 62b9fc561af7..42ea6f9264ef 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -208,7 +208,7 @@ modpost_link vmlinux.o
 ${MAKE} -f "${srctree}/scripts/Makefile.modpost" vmlinux.o
 
 info MODINFO modules.builtin.modinfo
-"${OBJCOPY}" -j .modinfo -O binary vmlinux.o modules.builtin.modinfo
+${OBJCOPY} -j .modinfo -O binary vmlinux.o modules.builtin.modinfo
 
 kallsymso=""
 kallsyms_vmlinux=""
-- 
2.7.4

